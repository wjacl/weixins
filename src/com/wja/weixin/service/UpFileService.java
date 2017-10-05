package com.wja.weixin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.service.CommService;
import com.wja.weixin.dao.UpFileDao;
import com.wja.weixin.entity.UpFile;

@Service
public class UpFileService extends CommService<UpFile>
{
    
    @Autowired
    private UpFileDao upFileDao;
    
    public UpFile save(UpFile f)
    {
        return this.upFileDao.save(f);
    }
    
}
