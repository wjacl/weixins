package com.wja.weixin.service;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.common.service.IDService;
import com.wja.base.util.Page;
import com.wja.weixin.dao.WorkOrderDao;
import com.wja.weixin.entity.UseWorker;
import com.wja.weixin.entity.WorkOrder;

@Service
public class WorkOrderService extends CommService<WorkOrder>
{
    
    @Autowired
    private WorkOrderDao workOrderDao;
    
    @Autowired
    private FollwerInfoService follweInfoService;
    
    @Autowired
    private IDService idService;
    
    @Autowired
    private UseWorkerService useWorkerService;
    
    public WorkOrder addWorkWorder(WorkOrder w){
        w.setWno(idService.getAnYMDHMSid());
        w = this.workOrderDao.save(w);
        
        //记录用工信息
        if(StringUtils.isNotBlank(w.getWorker())){
            String[] ws = w.getWorker().split(";");
            String pubId = w.getPubId();
            UseWorker uw = null;
            for(String s : ws){
                uw = this.useWorkerService.findByPubIdAndWorkerId(pubId, s);
                if(uw == null){
                    uw = new UseWorker();
                    uw.setPubId(pubId);
                    uw.setWorkerId(s);
                    this.useWorkerService.add(uw);
                }
                else{
                    uw.setUseTimes(uw.getUseTimes()+1);
                    this.useWorkerService.update(uw);
                }
            }
        }
        
        return w;
    }
    
    /**
     * 分页查询派单
     * @param params
     * @param page
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Page<WorkOrder> query(Map<String, Object> params, Page<WorkOrder> page){
        return page.setPageData(
            this.workOrderDao.findAll(new CommSpecification<WorkOrder>(params), page.getPageRequest()));
    }
}
