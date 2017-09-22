package com.wja.base.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;

/**
 * 权限实体
 * 
 * @author wja
 * @version v1.0
 * @since 2016.09.21
 */
@Entity
@Table(name = "t_sys_privilege")
@Where(clause = " valid =  " + CommConstants.DATA_VALID)
public class Privilege
{
    public static final String TYPE_BUTTON = "0";
    
    public static final String TYPE_PAGE = "1";
    
    public static final String TYPE_MENU = "2";
    
    @Id
    @Column(name = "pr_id", length = 32)
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    private String id;
    
    @Column(name = "pr_name", length = 20, nullable = false)
    private String name;
    
    @Column(name = "pr_type", length = 32, nullable = false)
    private String type;
    
    @Column(name = "path", length = 200)
    private String path;
    
    /**
     * 父菜单id
     */
    @Column(name = "p_pr_id", length = 32)
    private String pid;
    
    /**
     * 序号
     */
    @Column(name = "order_no")
    private int orderNo;
    
    @Column(name = "valid", length = 1)
    private byte valid = CommConstants.DATA_VALID;
    
    public String getId()
    {
        return id;
    }
    
    public void setId(String id)
    {
        this.id = id;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
    }
    
    public String getPath()
    {
        return path;
    }
    
    public void setPath(String path)
    {
        this.path = path;
    }
    
    public byte getValid()
    {
        return valid;
    }
    
    public void setValid(byte valid)
    {
        this.valid = valid;
    }
    
    public String getPid()
    {
        return pid;
    }
    
    public void setPid(String pid)
    {
        this.pid = pid;
    }
    
    public int getOrderNo()
    {
        return orderNo;
    }
    
    public void setOrderNo(int orderNo)
    {
        this.orderNo = orderNo;
    }
}
