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
        
    }
}
