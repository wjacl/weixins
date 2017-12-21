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
    @Query("select CONCAT(cast(year(createTime) as string),cast(month(createTime) as string)) as m,"
        + " sum(case ioType when 'i' then amount else 0 end)," + " sum(case ioType when 'o' then amount else 0 end) "
        + " from TradeRecord where valid = '1' "
        + " and openId = ?1 and createTime >= ?2 and createTime < ?3 group by CONCAT(cast(year(createTime) as string),cast(month(createTime) as string))"
        + " order by m desc")
    List<?> queryMonthTongJi(String openId, Date smonth, Date emonth);
    
    /*
     * @Query("select count(*) from TradeRecord where valid = '1' and openId = ?1 and createTime >= ?2") int
     * queryAfterCount(String openId, Date month);
     */
}
