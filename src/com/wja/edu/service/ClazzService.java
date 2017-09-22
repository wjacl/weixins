package com.wja.edu.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Page;
import com.wja.edu.dao.ClazzDao;
import com.wja.edu.entity.Clazz;

@Service
public class ClazzService extends CommService<Clazz>
{
    @Autowired
    private ClazzDao clazzDao;
    
    public void save(Clazz c)
    {
        if (c.getId() != null)
        {
            Clazz dbc = this.clazzDao.getOne(c.getId());
            BeanUtil.copyPropertiesIgnoreNull(c, dbc);
            c = dbc;
        }
        
        this.clazzDao.save(c);
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            this.clazzDao.logicDeleteInBatch(ids);
        }
    }
    
    public Page<Clazz> pageQuery(Map<String, Object> params, Page<Clazz> page)
    {
        return page.setPageData(this.clazzDao.findAll(new CommSpecification<Clazz>(params), page.getPageRequest()));
    }
}
