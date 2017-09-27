package com.wja.weixin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.sword.wechat4j.jsapi.JsApiManager;

@Controller
@RequestMapping("/weixin/comm")
public class CommonController
{
    
    @RequestMapping("getJsApiSignature")
    @ResponseBody
    public Object getJsApiSignature(String url)
    {
        return JsApiManager.signature(url);
    }
}
