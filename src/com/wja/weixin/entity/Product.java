package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

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
    
}
