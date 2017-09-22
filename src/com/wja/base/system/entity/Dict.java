package com.wja.base.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

/**
 * 
 * 系统数据字典实例
 * 
 * @author wja
 * @version [v1.0, 2016年9月26日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
@Entity
@Table(name = "t_sys_dict")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Dict extends CommEntity
{
    public static final String ROOT_ID = "0";
    
    @Column(length = 20, nullable = false)
    private String name;
    
    @Column(length = 32)
    private String pid;
    
    @Column(length = 20, nullable = false)
    private String value;
    
    /**
     * 序号
     */
    private Integer ordno;
    
    /**
     * 字典类型:s系统字典，b业务字典
     */
    @Column(length = 1, nullable = false)
    private String type = "b";
    
    public String getValue()
    {
        return value;
    }
    
    public void setValue(String value)
    {
        this.value = value;
    }
    
    public Integer getOrdno()
    {
        return ordno;
    }
    
    public void setOrdno(Integer ordno)
    {
        this.ordno = ordno;
    }
    
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
    
}
