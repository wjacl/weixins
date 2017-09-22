package com.wja.base.common;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Version;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.wja.base.util.DateUtil;

/**
 * 业务实体基类<br>
 * 在该类定义了主键id、创建人、创建时间、最后修改人、最后修改时间、版本、删除标识属性。<br>
 * 这些属性不需在具体的业务类中操作
 * 
 * @author wja
 * @version [v1.0, 2016年9月22日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
@MappedSuperclass
public abstract class CommEntity
{
    
    @Id
    @Column(name = "id", length = 32)
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    private String id;
    
    @Column(name = "create_user", length = 32)
    private String createUser;
    
    @Column(name = "create_time")
    @DateTimeFormat(pattern = DateUtil.DATE_TIME)
    @JSONField(format = DateUtil.DATE_TIME)
    private Date createTime;
    
    @Column(name = "last_modify_user", length = 32)
    private String lastModifyUser;
    
    @Column(name = "last_modify_time")
    @DateTimeFormat(pattern = DateUtil.DATE_TIME)
    @JSONField(format = DateUtil.DATE_TIME)
    private Date lastModifyTime;
    
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
    
    public String getId()
    {
        return id;
    }
    
    public void setId(String id)
    {
        this.id = id;
    }
    
    public Date getCreateTime()
    {
        return createTime;
    }
    
    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }
    
    public String getCreateUser()
    {
        return createUser;
    }
    
    public void setCreateUser(String createUser)
    {
        this.createUser = createUser;
    }
    
    public String getLastModifyUser()
    {
        return lastModifyUser;
    }
    
    public void setLastModifyUser(String lastModifyUser)
    {
        this.lastModifyUser = lastModifyUser;
    }
    
    public void setValid(byte valid)
    {
        this.valid = valid;
    }
    
    public Date getLastModifyTime()
    {
        return lastModifyTime;
    }
    
    public void setLastModifyTime(Date lastModifyTime)
    {
        this.lastModifyTime = lastModifyTime;
    }
    
    public Integer getVersion()
    {
        return version;
    }
    
    public void setVersion(Integer version)
    {
        this.version = version;
    }
    
    public Byte getValid()
    {
        return valid;
    }
    
    public void setValid(Byte valid)
    {
        this.valid = valid;
    }
    
}
