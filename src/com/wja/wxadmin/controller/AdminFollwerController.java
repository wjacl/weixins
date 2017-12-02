package com.wja.wxadmin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.Page;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.service.FollwerInfoService;

@Controller
@RequestMapping("/admin")
public class AdminFollwerController {

    @Autowired 
    private FollwerInfoService follwerInfoService;
    
    @RequestMapping("fuser/query")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<FollwerInfo> page)
    {
        this.follwerInfoService.query(params, page);
        
        return FollwerHandler.follwerInfoTrans(page);
    }
   
    
    
    @RequestMapping("fuser/manage")
    public String manage(){
        return "admin/fuser";
    }
    
    
}
