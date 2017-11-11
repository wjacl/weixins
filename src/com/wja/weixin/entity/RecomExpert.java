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
@Table(name = "t_wx_recom_expert")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class RecomExpert extends CommEntity
{
    @OneToOne
    @JoinColumn(name = "follwer_id")
    private FollwerInfo expert;
    
    private Date startTime;
    
    private Date endTime;
    
    private int orderno;
    
    @Column(length = 500)
    private String remark;
    
    public FollwerInfo getExpert()
    {
        return expert;
    }
    
    public void setExpert(FollwerInfo expert)
    {
        this.expert = expert;
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
