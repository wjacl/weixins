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
    }
}
