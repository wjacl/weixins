package com.wja.weixin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.sword.wechat4j.user.User;

import com.wja.base.common.service.CommService;
import com.wja.base.util.BeanUtil;
import com.wja.weixin.dao.FollwerDao;
import com.wja.weixin.entity.Follwer;

@Service
public class FollwerService extends CommService<Follwer>
{
    
    @Autowired
    private FollwerDao follwerDao;
    
    public Follwer subscribe(User u)
    {
        Follwer wu = new Follwer();
        BeanUtil.copyProperties(u, wu);
        wu.setLanguage(u.getLanguage().name());
        return this.follwerDao.save(wu);
    }
    
    public void unSubscribe(String openId)
    {
        Follwer wu = this.follwerDao.getOne(openId);
        if (wu != null)
        {
            if (wu != null)
            {
                wu.setSubscribe(Follwer.UN_SUBSCRIBE);
            }
            this.follwerDao.save(wu);
        }
    }
}
