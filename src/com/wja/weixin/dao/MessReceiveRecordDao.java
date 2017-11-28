package com.wja.weixin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.MessReceiveRecord;

@Repository
public interface MessReceiveRecordDao extends CommRepository<MessReceiveRecord, String>
{
    List<MessReceiveRecord> findByRecIdAndMessId(String recId,String messId);
}
