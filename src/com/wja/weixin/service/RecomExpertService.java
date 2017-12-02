package com.wja.weixin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.Page;
import com.wja.weixin.dao.RecomExpertDao;
import com.wja.weixin.entity.RecomExpert;

@Service
public class RecomExpertService extends CommService<RecomExpert>
{
    
    @Autowired
    private RecomExpertDao rcomExpertDao;
    
    public Page<RecomExpert> query(Map<String, Object> params, Page<RecomExpert> page)
    {
        return page
            .setPageData(this.rcomExpertDao.findAll(new CommSpecification<RecomExpert>(params), page.getPageRequest()));
    }
    
    public RecomExpert findByExpertId(String eid){
        return this.rcomExpertDao.findByExpertId(eid);
    }
}
