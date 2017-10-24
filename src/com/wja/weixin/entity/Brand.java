package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_brand")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Brand extends CommEntity
{
    @Column(length = 40)
    private String openId;// 用户的标识，对当前公众号唯一
    
    /**
     * 名称
     */
    @Column(length = 30, unique = true)
    private String name;
    
    /**
     * 名称拼音首字母
     */
    @Column(length = 30)
    private String pinyin;
    
    /**
     * logo图标
     */
    @Column(length = 100)
    private String logo;
    
    /**
     * 介绍
     */
    @Column(length = 20000)
    private String intro;
    
    public String getOpenId()
    {
        return openId;
    }
    
    public void setOpenId(String openId)
    {
        this.openId = openId;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getLogo()
    {
        return logo;
    }
    
    public void setLogo(String logo)
    {
        this.logo = logo;
    }
    
    public String getIntro()
    {
        return intro;
    }
    
    public void setIntro(String intro)
    {
        this.intro = intro;
    }
    
    public String getPinyin()
    {
        return pinyin;
    }
    
    public void setPinyin(String pinyin)
    {
        this.pinyin = pinyin;
    }
    
}
