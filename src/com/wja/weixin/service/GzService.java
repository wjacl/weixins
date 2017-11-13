package com.wja.weixin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Page;
import com.wja.base.util.Sort;
import com.wja.weixin.dao.GzRecordDao;
import com.wja.weixin.entity.GzRecord;

@Service
public class GzService extends CommService<GzRecord>
{
    
    @Autowired
    private GzRecordDao gzRecordDao;
    
    public GzRecord getByGzidAndBgzid(String gzid, String bgzid)
    {
        List<GzRecord> list = this.gzRecordDao.findByGzidAndBgzid(gzid, bgzid);
        if (CollectionUtil.isNotEmpty(list))
        {
            return list.get(0);
        }
        
        return null;
    }
    
    public GzRecord saveGz(GzRecord r)
    {
        GzRecord dbr = this.getByGzidAndBgzid(r.getGzid(), r.getBgzid());
        if (dbr == null)
        {
            return this.gzRecordDao.save(r);
        }
        else
        {
            return dbr;
        }
    }
    
    public void saveQxgz(GzRecord r)
    {
        List<GzRecord> list = this.gzRecordDao.findByGzidAndBgzid(r.getGzid(), r.getBgzid());
        if (CollectionUtil.isNotEmpty(list))
        {
            for (GzRecord a : list)
            {
                a.setValid(CommConstants.DATA_INVALID);
            }
            
            this.gzRecordDao.save(list);
        }
    }
    
    public List<GzRecord> list(Map<String, Object> params, Sort sort)
    {
        return this.gzRecordDao.findAll(new CommSpecification<GzRecord>(params), sort.getSpringSort());
    }
    
    public Page<GzRecord> query(Map<String, Object> params, Page<GzRecord> page)
    {
        return page
            .setPageData(this.gzRecordDao.findAll(new CommSpecification<GzRecord>(params), page.getPageRequest()));
    }
}
