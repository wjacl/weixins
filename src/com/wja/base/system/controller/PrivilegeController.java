package com.wja.base.system.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.OpResult;
import com.wja.base.system.dao.PrivilegeDao;
import com.wja.base.system.entity.Privilege;
import com.wja.base.system.service.PrivilegeService;

@Controller
@RequestMapping("/priv")
public class PrivilegeController
{
    
    @Autowired
    private PrivilegeService ps;
    
    @Autowired
    private PrivilegeDao dao;
    
    @RequestMapping("add")
    @ResponseBody
    public Object add(Privilege p)
    {
        this.dao.save(p);
        return OpResult.addOk(p);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public Object delete(String id)
    {
        this.dao.logicDelete(id);
        return OpResult.deleteOk();
    }
    
    @RequestMapping("get")
    @ResponseBody
    public Object get(String id)
    {
        return this.dao.getOne(id);
    }
    
    public Object getTree()
    {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("pid_isnull", null);
        return this.dao.findAll(new CommSpecification<Privilege>(paramMap));
    }
    
}
