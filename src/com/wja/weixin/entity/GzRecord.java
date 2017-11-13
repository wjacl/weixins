package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_gz_record")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class GzRecord extends CommEntity
{
    /**
     * 关注者id
     */
    @Column(length = 40)
    private String gzid;
    
    /**
     * 被关注者id
     */
    @Column(length = 40)
    private String bgzid;
    
    public String getGzid()
    {
        return gzid;
    }
    
    public void setGzid(String gzid)
    {
        this.gzid = gzid;
    }
    
    public String getBgzid()
    {
        return bgzid;
    }
    
    public void setBgzid(String bgzid)
    {
        this.bgzid = bgzid;
    }
    
}
