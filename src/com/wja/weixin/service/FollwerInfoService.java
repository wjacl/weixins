package com.wja.weixin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.Page;
import com.wja.weixin.dao.AuditRecordDao;
import com.wja.weixin.dao.FollwerInfoDao;
import com.wja.weixin.entity.AuditRecord;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.Message;

@Service
public class FollwerInfoService extends CommService<FollwerInfo>
{
    
    @Autowired
    private FollwerInfoDao follwerInfoDao;
    
    @Autowired
    private AuditRecordDao auditRecordDao;
    
    @Autowired
    private MessageService messageService;
    
    public Page<FollwerInfo> query(Map<String, Object> params, Page<FollwerInfo> page)
    {
        return page.setPageData(
            this.follwerInfoDao.findAll(new CommSpecification<FollwerInfo>(params), page.getPageRequest()));
    }
    
    public void saveAudit(AuditRecord r){
        this.auditRecordDao.save(r);
        FollwerInfo fi = this.follwerInfoDao.getOne(r.getBid());
        fi.setStatus(r.getResult());
        this.follwerInfoDao.save(fi);
        
        Message m = new Message();
        m.setPubId(r.getAid());
        m.setToIds(r.getBid());
        m.setTitle("认证审核通知！审核结果：" + (r.getResult() == FollwerInfo.STATUS_AUDIT_PASS ? "通过":"未通过"));
        m.setContent(r.getMess());
        m.setMtype(Message.Mtype.Normal);
        this.messageService.saveMessage(m);
    }
}
