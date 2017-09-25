package com.wja.weixin.controller;

import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/weixin/my")
public class AuthController
{
    
    @RequestMapping("auth")
    public String auth(HttpServletRequest request)
    {
        System.out.println(request.getQueryString());
        for (Entry<String, String[]> e : request.getParameterMap().entrySet())
        {
            System.out.println(e.getKey() + " : " + e.getValue()[0]);
        }
        return "weixin/auth1";
    }
}
