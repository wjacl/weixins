package com.wja.base.system.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.base.system.entity.Org;

@Repository
public interface OrgDao extends CommRepository<Org, String>
{
    Org findByPidAndName(String pid, String name);
}
