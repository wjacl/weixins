package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.wja.base.common.CommConstants;

@Entity
@Table(name = "t_wx_follwers")
public class Follwer
{
    public static final int SUBSCRIBE = 1;
    
    public static final int UN_SUBSCRIBE = 0;
    
    private int subscribe;// 用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号，拉取不到其余信息。
    
    @Id
    @Column(length = 40)
    private String openId;// 用户的标识，对当前公众号唯一
    
    @Column(length = 40)
    private String nickName;// 用户的昵称
    
    private int sex;// 用户的性别，值为1时是男性，值为2时是女性，值为0时是未知
    
    @Column(length = 60)
    private String city;// 用户所在城市
    
    @Column(length = 60)
    private String country;// 用户所在国家
    
    @Column(length = 60)
    private String province;// 用户所在省份
    
    @Column(columnDefinition = "varchar(10)")
    private String language;// 用户的语言，简体中文为zh_CN
    
    @Column(length = 400)
    private String headimgUrl;// 用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空。若用户更换头像，原有头像URL将失效。
    
    @Column(length = 20)
    private String subscribeTime;// 用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间
    
    @Column(length = 40)
    private String unionId;// 只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。详见：获取用户个人信息（UnionID机制）
    
    @Column(length = 40)
    private String remark;// 公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注
    
    @Column(length = 40)
    private int groupId;// 用户所在的分组ID
    
    /**
     * 数据删除标识
     * 
     * @see CommConstants.DATA_VALID
     */
    @Column(length = 1)
    private byte valid = CommConstants.DATA_VALID;
    
    public int getSubscribe()
    {
        return subscribe;
    }
    
    public void setSubscribe(int subscribe)
    {
        this.subscribe = subscribe;
    }
    
    public String getOpenId()
    {
        return openId;
    }
    
    public void setOpenId(String openId)
    {
        this.openId = openId;
    }
    
    public String getNickName()
    {
        return nickName;
    }
    
    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }
    
    public int getSex()
    {
        return sex;
    }
    
    public void setSex(int sex)
    {
        this.sex = sex;
    }
    
    public String getCity()
    {
        return city;
    }
    
    public void setCity(String city)
    {
        this.city = city;
    }
    
    public String getCountry()
    {
        return country;
    }
    
    public void setCountry(String country)
    {
        this.country = country;
    }
    
    public String getProvince()
    {
        return province;
    }
    
    public void setProvince(String province)
    {
        this.province = province;
    }
    
    public String getLanguage()
    {
        return language;
    }
    
    public void setLanguage(String language)
    {
        this.language = language;
    }
    
    public String getHeadimgUrl()
    {
        return headimgUrl;
    }
    
    public void setHeadimgUrl(String headimgUrl)
    {
        this.headimgUrl = headimgUrl;
    }
    
    public String getSubscribeTime()
    {
        return subscribeTime;
    }
    
    public void setSubscribeTime(String subscribeTime)
    {
        this.subscribeTime = subscribeTime;
    }
    
    public String getUnionId()
    {
        return unionId;
    }
    
    public void setUnionId(String unionId)
    {
        this.unionId = unionId;
    }
    
    public String getRemark()
    {
        return remark;
    }
    
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    
    public int getGroupId()
    {
        return groupId;
    }
    
    public void setGroupId(int groupId)
    {
        this.groupId = groupId;
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
