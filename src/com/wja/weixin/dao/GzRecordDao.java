package com.wja.weixin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.GzRecord;

@Repository
public interface GzRecordDao extends CommRepository<GzRecord, String>
{
    List<GzRecord> findByGzidAndBgzid(String gzid, String bgzid);
}
