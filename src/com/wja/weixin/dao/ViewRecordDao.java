package com.wja.weixin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.ViewRecord;

@Repository
public interface ViewRecordDao extends CommRepository<ViewRecord, String>
{
    List<ViewRecord> findByOidAndVid(String oid, String vid);
}
