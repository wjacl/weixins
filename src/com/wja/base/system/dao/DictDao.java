package com.wja.base.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.base.system.entity.Dict;

@Repository
public interface DictDao extends CommRepository<Dict, String>
{
    List<Dict> findByPidOrderByOrdnoAsc(String pid);
    
    Dict findByValueAndPid(String value, String pid);
}
