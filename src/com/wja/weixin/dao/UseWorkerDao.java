package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.UseWorker;

@Repository
public interface UseWorkerDao extends CommRepository<UseWorker, String>
{
    UseWorker findByPubIdAndWorkerId(String pubId,String workerId);
}
