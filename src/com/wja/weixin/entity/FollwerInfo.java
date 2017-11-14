package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;

@Entity
@Table(name = "t_wx_follwer_info")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class FollwerInfo
{
    public static final int STATUS_NEED_AUDIT = 0;
    
    public static final int STATUS_CATEGORY_OK = 1;
    
    public static final int STATUS_INFO_OK = 2;
    
    public static final int STATUS_INTRO_OK = 3;
    
    public static final int STATUS_BRAND_OK = 4;
    
    public static final int STATUS_CERT_OK = 5;
    
    public static final int STATUS_AUDIT_PASS = 6;
    
    @Id
    @Column(length = 40)
    private String openId;// 用户的标识，对当前公众号唯一
    
    /**
     * 经营类别
     */
    @Column(length = 1)
    private String category;
    
    /**
     * 名称
     */
    @Column(length = 30)
    private String name;
    
    /**
     * 名称拼音首字母
     */
    @Column(length = 30)
    private String pinyin;
    
    /**
     * 法人名称
     */
    @Column(length = 30)
    private String fname;
    
    /**
     * 地址
     */
    @Column(length = 200)
    private String address;
    
    /**
     * 纬度
     */
    @Column(length = 20)
    private String lat;
    
    /**
     * 经度
     */
    @Column(length = 20)
    private String lng;
    
    /**
     * 手机号
     */
    @Column(length = 20)
    private String mphone;
    
    /**
     * 微信号
     */
    @Column(length = 20)
    private String wechat;
    
    /**
     * 证件图片地址
     */
    @Column(length = 500)
    private String certificates;
    
    /**
     * 简介
     */
    @Column(length = 10000)
    private String intro;
    
    /**
     * logo头像
     */
    @Column(length = 200)
    private String logo;
    
    // 品牌信息
    /**
     * 品牌类别：1自有品牌，2代理，3、无
     */
    @Column(length = 1)
    private String brandType;
    
    /**
     * 品牌名称
     */
    @Column(length = 200)
    private String brands;
    
    /**
     * 品牌授权图片
     */
    @Column(length = 1000)
    private String brandAuthors;
    
    /**
     * 认证状态：1完成经营类别选择，2、信息填写完成，3、简介完成，4、品牌完成，5、保证金支付完成，6审核通过，0审核未通过
     */
    @Column(length = 2)
    private int status = 0;
    
    /**
     * 被关注数
     */
    @Column(length = 8)
    private int bgzs;
    
    /**
     * 数据删除标识
     * 
     * @see CommConstants.DATA_VALID
     */
    @Column(length = 1)
    private byte valid = CommConstants.DATA_VALID;
    
    public String getOpenId()
    {
        return openId;
    }
    
    public void setOpenId(String openId)
    {
        this.openId = openId;
    }
    
    public String getCategory()
    {
        return category;
    }
    
    public void setCategory(String category)
    {
        this.category = category;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getPinyin()
    {
        return pinyin;
    }
    
    public void setPinyin(String pinyin)
    {
        this.pinyin = pinyin;
    }
    
    public String getFname()
    {
        return fname;
    }
    
    public void setFname(String fname)
    {
        this.fname = fname;
    }
    
    public String getAddress()
    {
        return address;
    }
    
    public void setAddress(String address)
    {
        this.address = address;
    }
    
    public String getLat()
    {
        return lat;
    }
    
    public void setLat(String lat)
    {
        this.lat = lat;
    }
    
    public String getLng()
    {
        return lng;
    }
    
    public void setLng(String lng)
    {
        this.lng = lng;
    }
    
    public String getMphone()
    {
        return mphone;
    }
    
    public void setMphone(String mphone)
    {
        this.mphone = mphone;
    }
    
    public String getWechat()
    {
        return wechat;
    }
    
    public void setWechat(String wechat)
    {
        this.wechat = wechat;
    }
    
    public String getCertificates()
    {
        return certificates;
    }
    
    public void setCertificates(String certificates)
    {
        this.certificates = certificates;
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
    
    public String getBrandType()
    {
        return brandType;
    }
    
    public void setBrandType(String brandType)
    {
        this.brandType = brandType;
    }
    
    public String getBrands()
    {
        return brands;
    }
    
    public void setBrands(String brands)
    {
        this.brands = brands;
    }
    
    public String getBrandAuthors()
    {
        return brandAuthors;
    }
    
    public void setBrandAuthors(String brandAuthors)
    {
        this.brandAuthors = brandAuthors;
    }
    
    public int getStatus()
    {
        return status;
    }
    
    public void setStatus(int status)
    {
        this.status = status;
    }
    
    public int getBgzs()
    {
        return bgzs;
    }
    
    public void setBgzs(int bgzs)
    {
        this.bgzs = bgzs;
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
