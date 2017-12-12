package com.wja.wxadmin.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;

import com.alibaba.fastjson.annotation.JSONField;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.DateUtil;
import com.wja.base.util.Page;
import com.wja.weixin.entity.FollwerInfo;

public class FollwerHandler
{
    
    public static Page<Fvo> follwerInfoTrans(Page<FollwerInfo> page)
    {
        List<Fvo> rows = FollwerHandler.follwerInfoTrans(page.getRows());
        Page<Fvo> p = new Page<>();
        p.setPageNum(page.getPageNum());
        p.setSize(page.getSize());
        p.setTotal(page.getTotal());
        p.setRows(rows);
        return p;
    }
    
    
    public static List<Fvo> follwerInfoTrans(List<FollwerInfo> list)
    {
        List<Fvo> dlist = new ArrayList<>();
        if (CollectionUtil.isNotEmpty(list))
        {
            Fvo vo = null;
            for (FollwerInfo f : list)
            {
                vo = new Fvo();
                BeanUtil.copyPropertiesIgnoreNull(f, vo);
                vo.setId(f.getOpenId());
                dlist.add(vo);
            }
        }
        
        return dlist;
    }
}


/**
 * 数据传递用实体（加强数据安全）
 * 
 * @author wja
 * @version [版本号, 2017年11月12日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
class Fvo
{
    String id;
    
    String name;
    
    String mphone;
    
    String pinyin;
    
    String lat;
    
    String lng;
    
    String address;
    
    String category;
    
    String wechat;
    
    String logo;
    
    /**
     * 认证状态：1完成经营类别选择，2、信息填写完成，3、简介完成，4、品牌完成，5、保证金支付完成，6审核通过，7待审核，0审核未通过
     */
    @Column(length = 2)
    private int status = 0;
    
    @JSONField(format = DateUtil.DATE_TIME)
    private Date createTime;
    
    /**
     * 被关注数
     */
    @Column(length = 8)
    private int bgzs;
    
    
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
    
    public String getMphone()
    {
        return mphone;
    }
    
    public void setMphone(String mphone)
    {
        this.mphone = mphone;
    }
    
    public String getPinyin()
    {
        return pinyin;
    }
    
    public void setPinyin(String pinyin)
    {
        this.pinyin = pinyin;
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
    
    public String getAddress()
    {
        return address;
    }
    
    public void setAddress(String address)
    {
        this.address = address;
    }
    
    public String getCategory()
    {
        return category;
    }
    
    public void setCategory(String category)
    {
        this.category = category;
    }
    
    public String getWechat()
    {
        return wechat;
    }

    public void setWechat(String wechat)
    {
        this.wechat = wechat;
    }

    public String getLogo()
    {
        return logo;
    }
    
    public void setLogo(String logo)
    {
        this.logo = logo;
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

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }
    
}
