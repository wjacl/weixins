package com.wja.weixin.dao;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.Account;

@Repository
public interface AccountDao extends CommRepository<Account, String>
{
    @Modifying
    @Query("update Account u set u.balance = u.balance + ?1 where u.openId = ?2 ")
    void balanceAdd(BigDecimal amount, String openId);
    
    @Modifying
    @Query("update Account u set u.balance = u.balance - ?1 where u.openId = ?2 ")
    void balanceSub(BigDecimal amount, String openId);
    
    @Modifying
    @Query("update Account u set u.bzj = u.bzj + ?1 where u.openId = ?2 ")
    void bzjAdd(BigDecimal amount, String openId);
}
