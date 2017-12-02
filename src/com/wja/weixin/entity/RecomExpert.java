package com.wja.weixin.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;
import com.wja.base.util.DateUtil;
import com.wja.base.util.SetValue;

@Entity
@Table(name = "t_wx_recom_expert")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class RecomExpert extends CommEntity
{
    @Column(name = "expert_id",length=40)
    private String expertId;
    
    @Column(name = "expert_name",length=30)
    private String expertName;
    
    @Transient
    @SetValue(clazz = FollwerInfo.class, id = "expertId", field = "logo")
    private String logo;
    
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date startTime;
    
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date endTime;
    
    private int orderno;
    
    @Column(length = 500)
    private String remark;
     
    public String getExpertId()
    {
        return expertId;
    }

    public void setExpertId(String expertId)
    {
        this.expertId = expertId;
    }

    public String getExpertName()
    {
        return expertName;
    }

    public void setExpertName(String expertName)
    {
        this.expertName = expertName;
    }

    public String getLogo()
    {
        return logo;
    }

    public void setLogo(String logo)
    {
        this.logo = logo;
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
