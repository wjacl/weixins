package com.wja.weixin.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.FollwerInfo;

@Repository
public interface FollwerInfoDao extends CommRepository<FollwerInfo, String>
{
    @Query("select openId from FollwerInfo")
    List<String> findAllIds();
}
