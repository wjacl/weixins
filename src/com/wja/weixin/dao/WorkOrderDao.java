package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.WorkOrder;

@Repository
public interface WorkOrderDao extends CommRepository<WorkOrder, String>
{
}
