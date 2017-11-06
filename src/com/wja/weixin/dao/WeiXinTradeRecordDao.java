package com.wja.weixin.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.wja.weixin.entity.WeiXinTradeRecord;

@Repository
public interface WeiXinTradeRecordDao
    extends JpaRepository<WeiXinTradeRecord, String>, JpaSpecificationExecutor<WeiXinTradeRecord>
{
    WeiXinTradeRecord findByPrepayId(String prepayId);
}
