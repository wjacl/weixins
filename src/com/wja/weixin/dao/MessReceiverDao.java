package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.MessReceiver;

@Repository
public interface MessReceiverDao extends CommRepository<MessReceiver, String>
{
}
