package com.wja.weixin.service;

import org.springframework.stereotype.Service;

@Service
public class CommBaseService
{
    /**
     * 校验openId是否认证通过
     * 
     * @param openId
     * @return true：已认证通过，false：未认证通过
     * @see [类、类#方法、类#成员]
     */
    public boolean checkOpenIdAuthOk(String openId)
    {
        // TODO
        return true;
    }
}
