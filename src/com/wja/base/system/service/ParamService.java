package com.wja.base.system.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.system.dao.ParamDao;
import com.wja.base.system.entity.Param;

@Service
public class ParamService
{
    @Autowired
    private ParamDao dao;
    
    public List<Param> findAll()
    {
        return this.dao.findAll();
    }
    
    public Param get(String id)
    {
        return this.dao.findOne(id);
    }
    
    public void save(Param p)
    {
        if (p == null || StringUtils.isBlank(p.getId()))
        {
            return;
        }
        Param p1 = this.get(p.getId());
        if (p1 != null)
        {
            p1.setValue(p.getValue());
            this.dao.save(p1);
        }
    }
    
    public void saveValue(String id, String value)
    {
        if (StringUtils.isBlank(id) || StringUtils.isBlank(value))
        {
            return;
        }
        Param p1 = this.get(id);
        if (p1 != null)
        {
            p1.setValue(value);
            this.dao.save(p1);
        }
    }
}
