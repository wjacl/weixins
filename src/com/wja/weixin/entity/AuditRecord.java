package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_audit_record")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class AuditRecord extends CommEntity
{
    /**
     * 审核对象id
     */
    @Column(length = 40)
    private String bid;
    
    /**
     * 审核结果
     */
    @Column(length = 2)
    private Integer result;
    
    /**
     * 审核说明信息
     */
    @Column(length = 1000)
    private String mess;
    
    /**
     * 审核者id
     */
    @Column(length = 40)
    private String aid;

    public String getBid()
    {
        return bid;
    }

    public void setBid(String bid)
    {
        this.bid = bid;
    }

    public Integer getResult()
    {
        return result;
    }

    public void setResult(Integer result)
    {
        this.result = result;
    }

    public String getMess()
    {
        return mess;
    }

    public void setMess(String mess)
    {
        this.mess = mess;
    }

    public String getAid()
    {
        return aid;
    }

    public void setAid(String aid)
    {
        this.aid = aid;
    }
    
}
