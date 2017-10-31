package com.wja.weixin.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;

@Entity
@Table(name = "t_wx_account")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Account
{
    @Id
    @Column(length = 40)
    private String openId;// 用户的标识，对当前公众号唯一
    
    private BigDecimal bzj;
    
    private BigDecimal balance;
    
    /**
     * 数据删除标识
     * 
     * @see CommConstants.DATA_VALID
     */
    @Column(length = 1)
    private byte valid = CommConstants.DATA_VALID;
    
    public String getOpenId()
    {
        return openId;
    }
    
    public void setOpenId(String openId)
    {
        this.openId = openId;
    }
    
    public BigDecimal getBzj()
    {
        return bzj;
    }
    
    public void setBzj(BigDecimal bzj)
    {
        this.bzj = bzj;
    }
    
    public BigDecimal getBalance()
    {
        return balance;
    }
    
    public void setBalance(BigDecimal balance)
    {
        this.balance = balance;
    }
    
    public byte getValid()
    {
        return valid;
    }
    
    public void setValid(byte valid)
    {
        this.valid = valid;
    }
    
}
