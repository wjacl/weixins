package com.wja.weixin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.Page;
import com.wja.weixin.dao.UseWorkerDao;
import com.wja.weixin.entity.UseWorker;

@Service
public class UseWorkerService extends CommService<UseWorker>
{
    
    @Autowired
    private UseWorkerDao useWorkerDao;
    
    public UseWorker findByPubIdAndWorkerId(String pubId,String workerId){
        return this.useWorkerDao.findByPubIdAndWorkerId(pubId, workerId);
    }
    
    /**
     * 查询派单用工记录
     * @param params
     * @param page
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Page<UseWorker> query(Map<String, Object> params, Page<UseWorker> page){
        page.setPageData(
            this.useWorkerDao.findAll(new CommSpecification<UseWorker>(params), page.getPageRequest()));
        BeanUtil.setCollFieldValues(page.getRows());
        return page;
    }
}
