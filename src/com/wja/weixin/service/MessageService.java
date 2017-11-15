package com.wja.weixin.service;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.OpResult;
import com.wja.base.common.service.CommService;
import com.wja.base.web.AppContext;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.dao.MessReceiverDao;
import com.wja.weixin.dao.MessageDao;
import com.wja.weixin.entity.Message;

@Service
public class MessageService extends CommService<Message>
{
    
    @Autowired
    private MessageDao messageDao;
    
    @Autowired
    private MessReceiverDao messRecevierDao;
    
    @Autowired
    private FollwerInfoService follweInfoService;
    
    @Autowired
    private TradeService tradeService;
    
    public OpResult saveMessage(Message m)
    {
        if (Message.Range.Platform.equals(m.getRange()))
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
            m.setRange(Message.Range.GZZ);
        }
        
        m = this.messageDao.save(m);
        
        // 推送微信消息 交给消息推送线程池来推送
        
        return OpResult.ok();
    }
    
}
