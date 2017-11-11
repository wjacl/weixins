package com.wja.weixin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.Page;
import com.wja.weixin.dao.FollwerInfoDao;
import com.wja.weixin.entity.FollwerInfo;

@Service
public class FollwerInfoService extends CommService<FollwerInfo>
{
    
    @Autowired
    private FollwerInfoDao follwerInfoDao;
    
    public Page<FollwerInfo> query(Map<String, Object> params, Page<FollwerInfo> page)
    {
        return page.setPageData(
            this.follwerInfoDao.findAll(new CommSpecification<FollwerInfo>(params), page.getPageRequest()));
    }
}
