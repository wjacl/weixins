package com.wja.weixin.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_brand_hot")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class HotBrand extends CommEntity
{
    @OneToOne
    @JoinColumn(name = "brand_id")
    private Brand brand;
    
    private Date startTime;
    
    private Date endTime;
    
    private int orderno;
    
    @Column(length = 500)
    private String remark;
    
    public Brand getBrand()
    {
        return brand;
    }
    
    public void setBrand(Brand brand)
    {
        this.brand = brand;
    }
    
    public Date getStartTime()
    {
        return startTime;
    }
    
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }
    
    public Date getEndTime()
    {
        return endTime;
    }
    
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }
    
    public int getOrderno()
    {
        return orderno;
    }
    
    public void setOrderno(int orderno)
    {
        this.orderno = orderno;
    }
    
    public String getRemark()
    {
        return remark;
    }
    
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    
}
