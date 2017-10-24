package com.wja.weixin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.Page;
import com.wja.weixin.dao.BrandDao;
import com.wja.weixin.entity.Brand;

@Service
public class BrandService extends CommService<Brand>
{
    
    @Autowired
    private BrandDao brandDao;
    
    public Brand addOne(Brand b)
    {
        return this.brandDao.save(b);
    }
    
    public Brand getByName(String name)
    {
        return this.brandDao.findByName(name);
    }
    
    public Page<Brand> query(Map<String, Object> params, Page<Brand> page)
    {
        return page.setPageData(this.brandDao.findAll(new CommSpecification<Brand>(params), page.getPageRequest()));
    }
}
