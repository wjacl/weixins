package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.RecomExpert;

@Repository
public interface RecomExpertDao extends CommRepository<RecomExpert, String>
{
}
