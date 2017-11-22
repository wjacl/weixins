package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;
import com.wja.base.util.SetValue;

@Entity
@Table(name = "t_wx_use_worker")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class UseWorker extends CommEntity
{ 
    /**
     * 发布作者ID
     */
    @Column(length = 40)
    private String pubId;
    
    /**
     * 安装师傅
     */
    @Column(name="worker_id",length = 40)
    private String workerId;
    
    @Transient
    @SetValue(clazz = FollwerInfo.class, id = "workerId", field = "name")
    private String workerName;
    
    /**
     * 派单次数
     */
    @Column(name="use_times",length = 8)
    private int useTimes;

    public String getPubId()
    {
        return pubId;
    }

    public void setPubId(String pubId)
    {
        this.pubId = pubId;
    }

    public String getWorkerId()
    {
        return workerId;
    }

    public void setWorkerId(String workerId)
    {
        this.workerId = workerId;
    }

    public int getUseTimes()
    {
        return useTimes;
    }

    public void setUseTimes(int useTimes)
    {
        this.useTimes = useTimes;
    }

    public String getWorkerName()
    {
        return workerName;
    }

    public void setWorkerName(String workerName)
    {
        this.workerName = workerName;
    }
    
}
