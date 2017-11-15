package com.wja.weixin.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.weixin.entity.Message;

@Repository
public interface MessageDao extends CommRepository<Message, String>
{
}
