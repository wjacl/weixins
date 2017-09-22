package com.wja.base.system.entity;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_sys_role")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Role extends CommEntity
{
    /**
     * 类别：s:系统内置角色
     */
    public static final String TYPE_S = "s";
    
    /**
     * 类别：u:用户定义的角色
     */
    public static final String TYPE_U = "u";
    
    @Column(length = 20, nullable = false)
    private String name;
    
    /**
     * 角色说明
     */
    @Column(length = 100)
    private String remark;
    
    @Column(length = 1)
    private String type = TYPE_U;
    
    /**
     * 角色拥有的权限
     */
    @ManyToMany
    @JoinTable(name = "t_sys_role_priv", joinColumns = {@JoinColumn(name = "r_id")}, inverseJoinColumns = {
        @JoinColumn(name = "pr_id")})
    private Set<Privilege> privs;
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getRemark()
    {
        return remark;
    }
    
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
    }
    
    public Set<Privilege> getPrivs()
    {
        return privs;
    }
    
    public void setPrivs(Set<Privilege> privs)
    {
        this.privs = privs;
    }
    
}
