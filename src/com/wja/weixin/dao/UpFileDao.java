package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.UpFile;

@Repository
public interface UpFileDao extends CommRepository<UpFile, String>
{

}
