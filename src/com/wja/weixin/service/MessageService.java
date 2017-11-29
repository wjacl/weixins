package com.wja.weixin.service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.sword.wechat4j.message.TemplateMsg;
import org.sword.wechat4j.message.template.TemplateMsgBody;
import org.sword.wechat4j.message.template.TemplateMsgData;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.OpResult;
import com.wja.base.common.service.AsynchTaskService;
import com.wja.base.common.service.CommService;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.DateUtil;
import com.wja.base.util.Log;
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.dao.MessReceiveRecordDao;
import com.wja.weixin.dao.MessageDao;
import com.wja.weixin.dao.MessageQueryDao;
import com.wja.weixin.entity.GzRecord;
import com.wja.weixin.entity.MessReceiveRecord;
import com.wja.weixin.entity.Message;

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
    private TradeService tradeService;
    
    @Autowired
    private AsynchTaskService asynchTaskService;
    
    @Autowired
    private GzService gzService;
    
    @Autowired
    private FollwerInfoService follwerInfoService;
    
    public void saveMessRec(MessReceiveRecord mr){
       List<MessReceiveRecord> list = this.messRecevieDao.findByRecIdAndMessId(mr.getRecId(), mr.getMessId());
       if(CollectionUtil.isEmpty(list)){
           this.messRecevieDao.save(mr);
       }
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
        /*else
        {
            m.setTrange(Message.Range.GZZ);
        }*/
        
        m = this.messageDao.save(m);
        
        // 推送微信消息 交给消息推送线程池来推送
        sendTemplateMess(m);
        
        return OpResult.ok();
    }
    
    private void sendTemplateMess(Message m){
        switch(m.getMtype()){
            case Message.Mtype.AUDIT:
                this.asynchTaskService.execute(new AuditNotify(m));
                break;
            case Message.Mtype.WorkOrder:
                this.asynchTaskService.execute(new WorkOrderNotify(m));
                break;
            case Message.Mtype.Product:
                if(AppContext.getIntSysParam(WXContants.SysParam.PROD_FB_SEND_TEMPLATE) == WXContants.KG.OPEN){
                    this.asynchTaskService.execute(new ProdFbNotify(m));
                }
                break;
            case Message.Mtype.Normal:
                if(AppContext.getIntSysParam(WXContants.SysParam.MESS_FB_SEND_TEMPLATE) == WXContants.KG.OPEN){
                    this.asynchTaskService.execute(new MessFbNotify(m));
                }
                break;
        }
    }
    
    private class AuditNotify implements Runnable{
        private Message m;
        public AuditNotify(Message m){
            this.m = m;
        }
        @Override
        public void run()
        {
            try {
                TemplateMsgBody msg = new TemplateMsgBody();
                msg.setTemplateId(AppContext.getSysParam(WXContants.SysParam.AUTH_NOTIFY_AUDIT_TEMPLATE_ID));
                msg.setUrl(AppContext.getSysParam(WXContants.SysParam.AUTH_NOTIFY_AUDIT_TEMPLATE_URL));
                List<TemplateMsgData> data = new ArrayList<>();
                msg.setData(data);
                TemplateMsgData d = new TemplateMsgData();
                d.setName("name");
                d.setValue(m.getContent());
                data.add(d);
                String[] toIds = m.getToIds().split(";");
                for(String id : toIds){
                    msg.setTouser(id);
                    TemplateMsg tm = new TemplateMsg();
                    tm.send(msg);
                }
            }catch(Exception e){
                Log.error("异步发送认证模板通知异常", e);
            }
        }     
    }
    
    private class WorkOrderNotify implements Runnable{
        private Message m;
        public WorkOrderNotify(Message m){
            this.m = m;
        }
        @Override
        public void run()
        {
            try {
                TemplateMsgBody msg = new TemplateMsgBody();
                msg.setTemplateId(AppContext.getSysParam(WXContants.SysParam.WORK_ORDER_TEMPLATE_ID));
                msg.setUrl(AppContext.getSysParam(WXContants.SysParam.WORK_ORDER_TEMPLATE_URL));
                List<TemplateMsgData> data = new ArrayList<>();
                TemplateMsgData d = new TemplateMsgData();
                d.setName("workOrder");
                d.setValue(m.getTitle());
                data.add(d);
                msg.setData(data);
                String[] toIds = m.getToIds().split(";");
                for(String id : toIds){
                    msg.setTouser(id);
                    TemplateMsg tm = new TemplateMsg();
                    tm.send(msg);
                }
            }catch(Exception e){
                Log.error("异步发送派单模板通知异常", e);
            }
        }     
    }
    
    private class ProdFbNotify implements Runnable{
        private Message m;
        
        public ProdFbNotify(Message m){
            this.m = m;
        }
        @Override
        public void run()
        {
            try {
                TemplateMsgBody msg = new TemplateMsgBody();
                msg.setTemplateId(AppContext.getSysParam(WXContants.SysParam.PROD_FB_SEND_TEMPLATE_ID));
                msg.setUrl(AppContext.getSysParam(WXContants.SysParam.PROD_FB_SEND_TEMPLATE_URL));
                List<TemplateMsgData> data = new ArrayList<>();
                TemplateMsgData d = new TemplateMsgData();
                d.setName("prod");
                d.setValue(m.getTitle());
                data.add(d);
                msg.setData(data);
                rangeSend(m,msg);
            }catch(Exception e){
                Log.error("异步发送认证产品发布通知异常", e);
            }
        }     
    }
    
    private class MessFbNotify implements Runnable{
        private Message m;
        
        public MessFbNotify(Message m){
            this.m = m;
        }
        @Override
        public void run()
        {
            try {
                TemplateMsgBody msg = new TemplateMsgBody();
                msg.setTemplateId(AppContext.getSysParam(WXContants.SysParam.MESS_FB_SEND_TEMPLATE_ID));
                msg.setUrl(AppContext.getSysParam(WXContants.SysParam.MESS_FB_SEND_TEMPLATE_URL));
                List<TemplateMsgData> data = new ArrayList<>();
                TemplateMsgData d = new TemplateMsgData();
                d.setName("title");
                d.setValue(m.getTitle());
                data.add(d);
                msg.setData(data);
                rangeSend(m,msg);
            }catch(Exception e){
                Log.error("异步发送消息模板通知异常", e);
            }
        }     
    }
    
    private void rangeSend(Message m,TemplateMsgBody msg){
        switch(m.getTrange()){
            case Message.Range.GR:
                String[] toIds = m.getToIds().split(";");
                for(String id : toIds){
                    msg.setTouser(id);
                    TemplateMsg tm = new TemplateMsg();
                    tm.send(msg);
                }
                break;
            case Message.Range.GZZ:
                Map<String,Object> params = new HashMap<>();
                params.put("bgzz", m.getPubId());
                List<GzRecord> list = gzService.list(params, null);
                for(GzRecord r : list){
                    msg.setTouser(r.getGzid());
                    TemplateMsg tm = new TemplateMsg();
                    tm.send(msg);
                }
                break;
            case Message.Range.Platform:
                List<String> ids = follwerInfoService.queryIds();
                for(String id : ids){
                    msg.setTouser(id);
                    TemplateMsg tm = new TemplateMsg();
                    tm.send(msg);
                }
                break;
        }
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
    public Page<?> queryMyMessage(String openId,String title,Page<?> page){
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
