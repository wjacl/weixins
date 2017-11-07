package com.wja.weixin.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.TradeRecord;

@Repository
public interface TradeRecordDao extends CommRepository<TradeRecord, String>
{
    @Query("select to_char(creatTime,'yyyy-MM'),sum(case ioType when 'i' then amount end case),"
        + " sum(case ioType when 'o' then amount end case) " + " from TradeRecord where valid = '1' "
        + " and openId = ?1 and creatTime >= ?2 and createTime < ?3 group by to_char(creatTime,'yyyy-MM')")
    List<?> queryMonthTongJi(String openId, Date smonth, Date emonth);
}
