package com.wja.base.system.dao;

import java.util.Set;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.base.system.entity.Role;

@Repository
public interface RoleDao extends CommRepository<Role, String>
{
    
    Set<Role> findByCreateUser(String userId);
}
