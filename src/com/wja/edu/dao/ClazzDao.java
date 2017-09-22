package com.wja.edu.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.edu.entity.Clazz;

@Repository
public interface ClazzDao extends CommRepository<Clazz, String>
{

}
