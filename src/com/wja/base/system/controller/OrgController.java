package com.wja.base.system.controller;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.system.entity.Org;
import com.wja.base.system.service.OrgService;
import com.wja.base.util.Sort;

@Controller
@RequestMapping("/org")
public class OrgController
{
    @Autowired
    private OrgService os;
    
    @RequestMapping("manage")
    public String toMain()
    {
        return "system/org";
    }
    
    @RequestMapping("nameCheck")
    @ResponseBody
    public boolean nameCheck(String pid, String name)
    {
        return this.os.getByPidAndName(pid, name) == null;
    }
    
    @RequestMapping("setOrder")
    @ResponseBody
    public Object setOrder(String[] orgIds)
    {
        this.os.setOrder(orgIds);
        return OpResult.ok();
    }
    
    @RequestMapping("tree")
    @ResponseBody
    public List<Org> getTree()
    {
        return this.os.findAll();
    }
    
    @RequestMapping("query")
    @ResponseBody
    public List<Org> query(@RequestParam Map<String, Object> params, Sort sort)
    {
        return this.os.findAll(params, sort);
    }
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(Org org)
    {
        boolean add = StringUtils.isBlank(org.getId());
        org = this.os.save(org);
        if (add)
        {
            return OpResult.addOk(org);
        }
        else
        {
            return OpResult.updateOk(org);
        }
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public Object delete(String[] ids)
    {
        this.os.delete(ids);
        return OpResult.deleteOk();
    }
}
