package com.wja.base.system.controller;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.CommConstants;
import com.wja.base.common.OpResult;
import com.wja.base.system.dao.PrivilegeDao;
import com.wja.base.system.dao.RoleDao;
import com.wja.base.system.entity.Privilege;
import com.wja.base.system.entity.Role;
import com.wja.base.util.Page;

@Controller
@RequestMapping("/role")
public class RoleController
{
    @Autowired
    private RoleDao dao;
    
    @Autowired
    private PrivilegeDao privDao;
    
    @RequestMapping("manage")
    public String manage()
    {
        return "system/role";
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(Page<Role> page)
    {
        
        return page.setPageData(this.dao.findAll(null, page.getPageRequest()));
    }
    
    @RequestMapping("get")
    @ResponseBody
    public Object get(String id)
    {
        return this.dao.getOne(id);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public Object delete(String[] id)
    {
        List<Role> list = this.dao.findAll(id);
        if (list != null && list.size() > 0)
        {
            for (Role r : list)
            {
                r.setPrivs(null);
                r.setValid(CommConstants.DATA_INVALID);
            }
            this.dao.save(list);
        }
        return OpResult.deleteOk();
    }
    
    @RequestMapping("add")
    @ResponseBody
    public OpResult add(Role role, String privIds)
    {
        this.save(role, privIds);
        return OpResult.addOk(role.getId());
    }
    
    private void save(Role role, String privIds)
    {
        if (StringUtils.isNotBlank(privIds))
        {
            String[] privId = privIds.split(",");
            role.setPrivs(new HashSet<Privilege>(this.privDao.findAll(Arrays.asList(privId))));
        }
        this.dao.save(role);
    }
    
    @RequestMapping("update")
    @ResponseBody
    public OpResult update(Role role, String privIds)
    {
        this.save(role, privIds);
        return OpResult.updateOk(role);
    }
    
}
