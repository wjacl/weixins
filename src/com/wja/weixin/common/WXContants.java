package com.wja.weixin.common;

public interface WXContants
{
    interface Dict
    {
        String PID_BZJ_STANDARD = "baoZhengjin.standard";
    }
    
    interface Category
    {
        String FACTORY = "1";
        
        String SHOP = "2";
        
        String EXPERT = "3";
        
        String WORKER = "4";
    }
    
    interface KG {
        int OPEN = 1;
        int CLOSE = 0;
    }
    
    interface SysParam
    {
        String MessPlatFee = "mess.fb.plat.fee";
        /**
         * 消息留存天数
         */
        String MESS_RELAY_DAYS = "mess.relay.days";
        
        /**
         * 产品推送消息的标题前缀
         */
        String MESS_PROD_TITLE_PREFIX = "mess.prod.title.prefix";
        
        /**
         * 派单消息的标题前缀
         */
        String MESS_PD_TITLE_PREFIX = "mess.pd.title.prefix";
        
        /**
         * 直购电话
         */
        String ZHI_GOU_PHONE = "zhi.gou.phone";
        
        /**
         * 审核者id
         */
        String AUDIT_ID = "audit_id";
        
        /**
         * 认证-通知审核模板信息ID
         */
        String AUTH_NOTIFY_AUDIT_TEMPLATE_ID = "auth.audit.template.id";
        
        /**
         * 认证-通知审核模板信息url
         */
        String AUTH_NOTIFY_AUDIT_TEMPLATE_URL = "auth.audit.template.url";
        
        /**
         * 工单通知模板信息ID
         */
        String WORK_ORDER_TEMPLATE_ID = "work.order.template.id";
        
        /**
         * 工单通知模板信息url
         */
        String WORK_ORDER_TEMPLATE_URL = "work.order.template.url";
        
        /**
         * 产品发布是否发送模板消息开关参数
         */
        String PROD_FB_SEND_TEMPLATE = "prod.fb.send.template";
        
        /**
         * 产品发布模板信息ID
         */
        String PROD_FB_SEND_TEMPLATE_ID = "prod.template.id";
        
        /**
         * 产品发布模板信息url
         */
        String PROD_FB_SEND_TEMPLATE_URL = "prod.template.url";

        /**
         * 信息发布是否发送模板消息开关参数
         */
        String MESS_FB_SEND_TEMPLATE = "mess.fb.send.template";
        
        /**
         * 信息通知模板信息ID
         */
        String MESS_FB_SEND_TEMPLATE_ID = "mess.template.id";
        
        /**
         * 信息通知模板信息url
         */
        String MESS_FB_SEND_TEMPLATE_URL = "mess.template.url";
        
    }
}
