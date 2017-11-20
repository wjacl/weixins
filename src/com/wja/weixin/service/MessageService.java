package com.wja.weixin.service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.OpResult;
import com.wja.base.common.service.CommService;
import com.wja.base.util.DateUtil;
import com.wja.base.util.Log;
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.dao.MessReceiveRecordDao;
import com.wja.weixin.dao.MessageDao;
import com.wja.weixin.dao.MessageQueryDao;
import com.wja.weixin.entity.MessReceiveRecord;
import com.wja.weixin.entity.Message;
import com.wja.weixin.entity.MessageVo;

@Service
public class MessageService extends CommService<Message>
{
    
    @Autowired
    private MessageDao messageDao;
    
    @Autowired
    private MessageQueryDao messageQueryDao;
    
    @Autowired
    private MessReceiveRecordDao messRecevieDao;
    
    @Autowired
    private FollwerInfoService follweInfoService;
    
    @Autowired
    private TradeService tradeService;
    
    public MessReceiveRecord saveMessRec(MessReceiveRecord mr){
       return this.messRecevieDao.save(mr);
    }
    
    public OpResult saveMessage(Message m)
    {
        if (Message.Range.Platform.equals(m.getTrange()))
        {
            String fee = AppContext.getSysParam(WXContants.SysParam.MessPlatFee);
            BigDecimal amount = new BigDecimal(fee);
            if (amount.compareTo(new BigDecimal(0)) == 1)
            {
                // 扣费
                if (!this.tradeService.saveKouFei(m.getPubId(), amount, "发布消息：" + m.getTitle()))
                {
                    return OpResult.error("扣款失败，余额不足！", null);
                }
            }
            m.setFee(fee);
        }
        else
        {
            m.setTrange(Message.Range.GZZ);
        }
        
        m = this.messageDao.save(m);
        
        // TODO 推送微信消息 交给消息推送线程池来推送
        
        return OpResult.ok();
    }
    
    /**
     * 查询我的历史发布
     * @param params
     * @param page
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Page<Message> queryMyFb(Map<String, Object> params, Page<Message> page){
        return page.setPageData(
            this.messageDao.findAll(new CommSpecification<Message>(params), page.getPageRequest()));
    }
    
    /**
     * 
     * 查询我收到的信息
     * @param openId
     * @param title
     * @param page
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Page<MessageVo> queryMyMessage(String openId,String title,Page<MessageVo> page){
        int relayDays = AppContext.getIntSysParam(WXContants.SysParam.MESS_RELAY_DAYS);
        Date stime = new Date();
        if(relayDays == Integer.MAX_VALUE || relayDays <= 0){
            try
            {
                stime = DateUtil.DEFAULT_DF.parse("2017-10-01");
            }
            catch (ParseException e)
            {
                Log.LOGGER.error("时间字符串转时间异常", e);
            }
        }
        else {
            stime = DateUtil.getBeforeDate(relayDays);
        }
        
        return this.messageQueryDao.queryMyMessages(openId, title,stime, page);
    }
}
