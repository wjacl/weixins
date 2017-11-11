package com.wja.weixin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.Page;
import com.wja.weixin.dao.HotBrandDao;
import com.wja.weixin.entity.HotBrand;

@Service
public class HotBrandService extends CommService<HotBrand>
{
    
    @Autowired
    private HotBrandDao HotBrandDao;
    
    public Page<HotBrand> query(Map<String, Object> params, Page<HotBrand> page)
    {
        return page
            .setPageData(this.HotBrandDao.findAll(new CommSpecification<HotBrand>(params), page.getPageRequest()));
    }
}
