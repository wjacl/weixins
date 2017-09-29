package com.wja.weixin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.web.RequestThreadLocal;

@Controller
@RequestMapping("/wx/web/auth")
public class AuthController
{
    
    @RequestMapping(value = {"auth", "toCategory"})
    public String auth()
    {
        String openId = RequestThreadLocal.openId.get();
        
        // 获得用户的category
        
        return "weixin/auth/auth1";
    }
    
    @RequestMapping("saveCategory")
    @ResponseBody
    public Object saveCategory(String openId, String category)
    {
        // 保存用户的经营类别
        
        // 跳转到对应的信息填写页
        return OpResult.ok();
    }
    
    @RequestMapping("toInfo")
    public String toInfo(String openId, String category)
    {
        // 保存用户的经营类别
        
        // 跳转到对应的信息填写页
        return "weixin/auth/info" + category;
    }
    
    @RequestMapping("saveInfo")
    public String saveInfo()
    {
        
        return "redirect:setBrand";
    }
    
    @RequestMapping("setBrand")
    public String setBrand(String openId)
    {
        // 保存用户的经营类别
        
        // 跳转到对应的信息填写页
        return "weixin/auth/brand";
    }
    
}
