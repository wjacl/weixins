package com.wja.base.system.dao;

import java.util.List;

import org.springframework.data.repository.Repository;

import com.wja.base.system.entity.Param;

@org.springframework.stereotype.Repository
public interface ParamDao extends Repository<Param, String>
{
    List<Param> findAll();
    
    Param save(Param param);
    
    Param findOne(String id);
}
