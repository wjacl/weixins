package com.wja.weixin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.service.CommService;
import com.wja.weixin.dao.FollwerInfoDao;
import com.wja.weixin.entity.FollwerInfo;

@Service
public class FollwerInfoService extends CommService<FollwerInfo>
{
    
    @Autowired
    private FollwerInfoDao follwerInfoDao;
    
}
