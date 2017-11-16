package com.wja.weixin.entity;

import java.util.Date;

public class MessageVo extends Message
{
    /**
     * 发布者名称
     */
    private String pubName;
    
    /**
     * 阅读时间
     */
    private Date readTime;

    public String getPubName()
    {
        return pubName;
    }

    public void setPubName(String pubName)
    {
        this.pubName = pubName;
    }

    public Date getReadTime()
    {
        return readTime;
    }

    public void setReadTime(Date readTime)
    {
        this.readTime = readTime;
    }
   
}
