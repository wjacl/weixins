package com.wja.base.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_sys_org")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Org extends CommEntity
{
    /**
     * 机构类别-公司
     */
    public static final String TYPE_COMPANY = "1";
    
    /**
     * 机构类别-子公司
     */
    public static final String TYPE_SUB_COMPANY = "2";
    
    /**
     * 机构类别-学校
     */
    public static final String TYPE_SCHOOL = "3";
    
    /**
     * 机构类别-部门
     */
    public static final String TYPE_DEPARTMENT = "4";
    
    @Column(length = 32, nullable = false)
    private String name;
    
    /**
     * 父结构id
     */
    @Column(length = 32)
    private String pid;
    
    /**
     * 机构类别
     */
    @Column(length = 10)
    private String type;
    
    /**
     * 序号
     */
    private Short ordno;
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getPid()
    {
        return pid;
    }
    
    public void setPid(String pid)
    {
        this.pid = pid;
    }
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
    }
    
    public Short getOrdno()
    {
        return ordno;
    }
    
    public void setOrdno(Short ordno)
    {
        this.ordno = ordno;
    }
    
}
