package com.wja.weixin.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_trade_record")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class TradeRecord extends CommEntity
{
    public static interface BusiType
    {
        /**
         * 保证金
         */
        String BZJ = "bzj";
        
        /**
         * 充值
         */
        String CZ = "cz";
        
        /**
         * 消费
         */
        String XF = "xf";
    }
    
    public static interface IOType
    {
        /**
         * 入账
         */
        String IN = "i";
        
        /**
         * 出账
         */
        String OUT = "o";
    }
    
    @Column(length = 40)
    private String openId;// 用户的标识
    
    /**
     * 交易业务类别
     */
    @Column(name = "busi_type", length = 20)
    private String busiType;
    
    /**
     * 出入账类别 i进账，o出账
     */
    @Column(name = "io_type", length = 1)
    private String ioType;
    
    /**
     * 交易时间
     */
    private Date time = new Date();
    
    /**
     * 交易金额
     */
    private BigDecimal amount;
    
    /**
     * 交易信息
     */
    @Column(length = 500)
    private String info;
    
    public String getOpenId()
    {
        return openId;
    }
    
    public void setOpenId(String openId)
    {
        this.openId = openId;
    }
    
    public String getBusiType()
    {
        return busiType;
    }
    
    public void setBusiType(String busiType)
    {
        this.busiType = busiType;
    }
    
    public String getIoType()
    {
        return ioType;
    }
    
    public void setIoType(String ioType)
    {
        this.ioType = ioType;
    }
    
    public Date getTime()
    {
        return time;
    }
    
    public void setTime(Date time)
    {
        this.time = time;
    }
    
    public BigDecimal getAmount()
    {
        return amount;
    }
    
    public void setAmount(BigDecimal amount)
    {
        this.amount = amount;
    }
    
    public String getInfo()
    {
        return info;
    }
    
    public void setInfo(String info)
    {
        this.info = info;
    }
    
}
