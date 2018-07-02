package com.wja.wechat;

import org.sword.wechat4j.token.TokenProxy;

public class WechatConfig
{
    public static String getDomain(){
        return "api.weixin.qq.com";
    }
    
    public static String getAccessToken(){
        return TokenProxy.accessToken();
    }
}
