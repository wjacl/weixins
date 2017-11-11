package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.HotBrand;

@Repository
public interface HotBrandDao extends CommRepository<HotBrand, String>
{
}
