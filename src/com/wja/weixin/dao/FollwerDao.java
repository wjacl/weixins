package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.Follwer;

@Repository
public interface FollwerDao extends CommRepository<Follwer, String>
{

}
