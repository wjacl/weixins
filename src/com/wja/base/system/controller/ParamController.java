package com.wja.base.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.system.entity.Param;
import com.wja.base.system.service.ParamService;

@Controller
@RequestMapping("/param")
public class ParamController
{
    @Autowired
    private ParamService service;
    
    @RequestMapping("manage")
    public String toMain()
    {
        return "system/param";
    }
    
    @RequestMapping("query")
    @ResponseBody
    public List<Param> query()
    {
        return this.service.findAll();
    }
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(Param p)
    {
        this.service.save(p);
        return OpResult.updateOk(p);
    }
    
}
