package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_mess_rec")
// @Where(clause = " valid = " + CommConstants.DATA_VALID)
public class MessReceiveRecord extends CommEntity
{
    /**
     * 接收者ID
     */
    @Column(length = 32)
    private String recId;
    
    /**
     * 信息ID
     */
    @Column(length = 32)
    private String messId;
    
    public String getRecId()
    {
        return recId;
    }
    
    public void setRecId(String recId)
    {
        this.recId = recId;
    }
    
    public String getMessId()
    {
        return messId;
    }
    
    public void setMessId(String messId)
    {
        this.messId = messId;
    }
    
}
