package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_wx_work_order")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class WorkOrder extends CommEntity
{
    /**
     * 工单号
     */
    @Column(length = 30)
    private String wno;
    
    /**
     * 安装师傅
     */
    @Column(length = 300)
    private String worker;
    
    /**
     * 图片
     */
    @Column(length = 1000)
    private String img;
    
    /**
     * 语音
     */
    @Column(length = 4000)
    private String voices;
    
    /**
     * 工单说明
     */
    @Column(length = 2000)
    private String content;
    
    /**
     * 发布作者ID
     */
    @Column(length = 40)
    private String pubId;
    
    public String getWno()
    {
        return wno;
    }
    
    public void setWno(String wno)
    {
        this.wno = wno;
    }
    
    public String getWorker()
    {
        return worker;
    }
    
    public void setWorker(String worker)
    {
        this.worker = worker;
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
    
    public String getVoices()
    {
        return voices;
    }
    
    public void setVoices(String voices)
    {
        this.voices = voices;
    }
    
}
