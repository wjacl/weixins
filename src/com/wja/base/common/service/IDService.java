package com.wja.base.common.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.wja.base.util.IDGenerater;

@Service
public class IDService
{
    @Value("${id.prefix}")
    private String prefix;
    
    public String getAnYMDHMSid()
    {
        return IDGenerater.getAnYMDHMSid(prefix);
    }
}
