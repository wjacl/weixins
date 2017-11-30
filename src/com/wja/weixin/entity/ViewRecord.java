package com.wja.weixin.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Version;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.wja.base.common.CommConstants;
import com.wja.base.util.DateUtil;

@Entity
@Table(name = "t_wx_gz_record")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class ViewRecord
{
    public static interface Otype{
        String FOLLWER = "f";
        String PRODUCT = "p";
        String MESSAGE = "m";
        String BRAND = "b";
    }
    @Id
    @Column(name = "id", length = 32)
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    private String id;
    
    /**
     * 对象id
     */
    @Column(length = 40)
    private String oid;
    
    /**
     * 对象名称
     */
    @Column(length = 200)
    private String oname;
    
    /**
     * 对象名称
     */
    @Column(length = 1)
    private String otype;
    
    /**
     * 浏览者id
     */
    @Column(length = 40)
    private String vid;
    
    /**
     * 浏览时间
     */
    @DateTimeFormat(pattern = DateUtil.DATE_TIME)
    @JSONField(format = DateUtil.DATE_TIME)
    private Date vtime = new Date();
    
    /**
     * 版本、乐观锁
     */
    @Version
    private Integer version;
    
    /**
     * 数据删除标识
     * 
     * @see CommConstants.DATA_VALID
     */
    @Column(length = 1)
    private byte valid = CommConstants.DATA_VALID;
    
    public ViewRecord(){}
    
    public ViewRecord(String oid,String oname,String otype,String vid){
        this.oid = oid;
        this.oname = oname;
        this.otype = otype;
        this.vid = vid;
    }

    public String getId()
    {
        return id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public String getOid()
    {
        return oid;
    }

    public void setOid(String oid)
    {
        this.oid = oid;
    }

    public String getOname()
    {
        return oname;
    }

    public void setOname(String oname)
    {
        this.oname = oname;
    }

    public String getOtype()
    {
        return otype;
    }

    public void setOtype(String otype)
    {
        this.otype = otype;
    }

    public String getVid()
    {
        return vid;
    }

    public void setVid(String vid)
    {
        this.vid = vid;
    }

    public Date getVtime()
    {
        return vtime;
    }

    public void setVtime(Date vtime)
    {
        this.vtime = vtime;
    }

    public Integer getVersion()
    {
        return version;
    }

    public void setVersion(Integer version)
    {
        this.version = version;
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
