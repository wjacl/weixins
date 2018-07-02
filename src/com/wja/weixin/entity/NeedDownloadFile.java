package com.wja.weixin.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_wx_need_down_files")
public class NeedDownloadFile
{
    public static enum Type {
        
        AUTH_CRIED("auth",false),AUTH_LOGO("logo",false),BRAND_AUTHOR("auth/brand_author",false),
        BRAND_LOGO("brandLogo",false),MESSAGE_IMG("message_img",true),PRODUCT_IMG("product_img",true),
        WORK_ORDER_IMG("work_order_img",true);
        
        private String path;
        private boolean pathAddYYYYmmdd;
        
        private Type(String path,boolean pathAddYYYYmmdd) {
            this.path = path;
            this.pathAddYYYYmmdd = pathAddYYYYmmdd;
        }

        public String getPath()
        {
            return path;
        }

        public boolean isPathAddYYYYmmdd()
        {
            return pathAddYYYYmmdd;
        }
        
    }
    
    @Id
    @Column(name = "server_id", length = 200)
    private String serverId;
    
    @Column(name = "busi_id", length = 200)
    private String busiId;
    
    @Column(length = 20)
    private String type;
    
    @Column(name = "add_time")
    private Date addTime = new Date();
    
    public NeedDownloadFile()
    {
    }

    public NeedDownloadFile(String serverId, String busiId, String type)
    {
        super();
        this.serverId = serverId;
        this.busiId = busiId;
        this.type = type;
    }

    public String getServerId()
    {
        return serverId;
    }

    public void setServerId(String serverId)
    {
        this.serverId = serverId;
    }

    public String getBusiId()
    {
        return busiId;
    }

    public void setBusiId(String busiId)
    {
        this.busiId = busiId;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public Date getAddTime()
    {
        return addTime;
    }

    public void setAddTime(Date addTime)
    {
        this.addTime = addTime;
    }
    
}
