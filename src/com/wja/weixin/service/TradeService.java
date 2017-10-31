package com.wja.weixin.service;

import java.math.BigDecimal;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.weixin.dao.AccountDao;
import com.wja.weixin.dao.TradeRecordDao;
import com.wja.weixin.entity.Account;
import com.wja.weixin.entity.TradeRecord;

@Service
public class TradeService
{
    @Autowired
    private AccountDao accountDao;
    
    @Autowired
    private TradeRecordDao tradeRecordDao;
    
    public Account getAccount(String openId)
    {
        return this.accountDao.findOne(openId);
    }
    
    public void saveBaoZhengJinAdd(String openId, BigDecimal amount)
    {
        if (amount == null || StringUtils.isBlank(openId))
        {
            return;
        }
        
        Account account = this.getAccount(openId);
        TradeRecord tr = new TradeRecord();
        tr.setAmount(amount);
        tr.setOpenId(openId);
        tr.setBusiType(TradeRecord.BusiType.BZJ);
        tr.setIoType(TradeRecord.IOType.IN);
        tr.setInfo("保证金支付");
        
        this.tradeRecordDao.save(tr);
        
        if (account == null)
        {
            account = new Account();
            account.setBalance(new BigDecimal(0));
            account.setBzj(amount);
            account.setOpenId(openId);
            this.accountDao.save(account);
        }
        else
        {
            this.accountDao.bzjAdd(amount, openId);
        }
    }
}
