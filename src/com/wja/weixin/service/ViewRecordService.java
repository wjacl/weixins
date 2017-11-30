package com.wja.weixin.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Page;
import com.wja.weixin.dao.ViewRecordDao;
import com.wja.weixin.entity.ViewRecord;

@Service
public class ViewRecordService extends CommService<ViewRecord>
{
    
    @Autowired
    private ViewRecordDao viewRecordDao;
    
    public ViewRecord getByOidAndVid(String oid, String vid)
    {
        List<ViewRecord> list = this.viewRecordDao.findByOidAndVid(oid, vid);
        if (CollectionUtil.isNotEmpty(list))
        {
            return list.get(0);
        }
        
        return null;
    }
    
    public ViewRecord saveRecord(ViewRecord r)
    {
        ViewRecord dbr = this.getByOidAndVid(r.getOid(), r.getVid());
        if (dbr == null)
        {
            return this.viewRecordDao.save(r);
        }
        else
        {
            dbr.setVtime(new Date());
            return this.viewRecordDao.save(dbr);
        }
    }

    
    public Page<ViewRecord> query(Map<String, Object> params, Page<ViewRecord> page)
    {
        return page
            .setPageData(this.viewRecordDao.findAll(new CommSpecification<ViewRecord>(params), page.getPageRequest()));
    }
}
