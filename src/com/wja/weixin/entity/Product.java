package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;
import com.wja.base.system.entity.User;
import com.wja.base.util.SetValue;

@Entity
@Table(name = "t_wx_product")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Product extends CommEntity
{
    /**
     * 名称
     */
    @Column(length = 30)
    private String title;
    
    /**
     * 单价
     */
    @Column(length = 30)
    private String price;
    
    /**
     * 单位
     */
    @Column(length = 30)
    private String unit;
    
    /**
     * 图片
     */
    @Column(length = 1000)
    private String img;
    
    /**
     * 产品介绍
     */
    @Column(length = 5000)
    private String content;
    
    /**
     * 发布作者ID
     */
    @Column(length = 40)
    private String pubId;
    
    @Transient
    @SetValue(clazz = FollwerInfo.class, field = "name", id = "pubId")
    private String ownName;
    
    @Transient
    @SetValue(clazz = User.class, id = "createUser", field = "name")
    private String createUserName;
    
    public String getTitle()
    {
        return title;
    }
    
    public void setTitle(String title)
    {
        this.title = title;
    }
    
    public String getPrice()
    {
        return price;
    }
    
    public void setPrice(String price)
    {
        this.price = price;
    }
    
    public String getUnit()
    {
        return unit;
    }
    
    public void setUnit(String unit)
    {
        this.unit = unit;
    }
    
    public String getImg()
    {
        return img;
    }
    
    public void setImg(String img)
    {
        this.img = img;
    }
    
    public String getContent()
    {
        return content;
    }
    
    public void setContent(String content)
    {
        this.content = content;
    }
    
    public String getPubId()
    {
        return pubId;
    }
    
    public void setPubId(String pubId)
    {
        this.pubId = pubId;
    }
    
    public String getOwnName()
    {
        return ownName;
    }
    
    public void setOwnName(String ownName)
    {
        this.ownName = ownName;
    }
    
    public String getCreateUserName()
    {
        return createUserName;
    }
    
    public void setCreateUserName(String createUserName)
    {
        this.createUserName = createUserName;
    }
    
}
