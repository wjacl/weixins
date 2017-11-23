package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_message")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Message extends CommEntity
{
    /**
     * 信息类别 n普通信息，p产品推送信息，w工单信息
     */
    public static interface Mtype
    {
        String Normal = "n";
        
        String Product = "p";
        
        String WorkOrder = "w";
    }
    
    /**
     * 范围 1全平台，2关注者
     */
    public static interface Range
    {
        String Platform = "1";
        
        String GZZ = "2";
        
        /**
         * 定向的个人
         */
        String GR = "3";
    }
    
    /**
     * 标题
     */
    @Column(length = 30)
    private String title;
    
    /**
     * 图片
     */
    @Column(length = 100)
    private String img;
    
    /**
     * 内容
     */
    @Column(length = 4000)
    private String content;
    
    /**
     * 范围 1全平台，2关注者
     */
    @Column(length = 1)
    private String trange;
    
    /**
     * 费用
     */
    @Column(length = 10)
    private String fee;
    
    /**
     * 发布作者ID
     */
    @Column(length = 40)
    private String pubId;
    
    /**
     * 信息类别 n普通信息，p产品推送信息，w工单信息
     */
    @Column(length = 4)
    private String mtype = Mtype.Normal;
    
    /**
     * 信息类别关联业务ID
     */
    @Column(length = 32)
    private String linkId;
    
    /**
     * 接收者ID，派单时用到该字段
     */
    @Column(length = 400)
    private String toIds;
    
    public String getTitle()
    {
        return title;
    }
    
    public void setTitle(String title)
    {
        this.title = title;
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
    
    public String getTrange()
    {
        return trange;
    }

    public void setTrange(String trange)
    {
        this.trange = trange;
    }

    public String getFee()
    {
        return fee;
    }
    
    public void setFee(String fee)
    {
        this.fee = fee;
    }
    
    public String getPubId()
    {
        return pubId;
    }
    
    public void setPubId(String pubId)
    {
        this.pubId = pubId;
    }
    
    public String getMtype()
    {
        return mtype;
    }
    
    public void setMtype(String mtype)
    {
        this.mtype = mtype;
    }
    
    public String getLinkId()
    {
        return linkId;
    }
    
    public void setLinkId(String linkId)
    {
        this.linkId = linkId;
    }

    public String getToIds()
    {
        return toIds;
    }

    public void setToIds(String toIds)
    {
        this.toIds = toIds;
    }
    
}
