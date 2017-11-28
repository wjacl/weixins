package com.wja.weixin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.AuditRecord;

@Repository
public interface AuditRecordDao extends CommRepository<AuditRecord, String>
{
    List<AuditRecord> findByBidOrderByCreateTimeDesc(String id);
}
