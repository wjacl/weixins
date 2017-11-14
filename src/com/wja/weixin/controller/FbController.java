package com.wja.weixin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.GzService;

@Controller
@RequestMapping("/wx/web/fb")
public class FbController
{
    @Autowired
    private FollwerInfoService follwerInfoService;
    
    @Autowired
    private GzService gzService;
    
    @RequestMapping("mess")
    public String fx(Model model)
    {
        return "weixin/fb/mess";
    }
    
}
