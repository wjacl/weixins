package com.wja.base.common.service;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommDao;

@Service
public class CommService<T>
{
    
    @Autowired
    protected CommDao commDao;
    
    public void add(T obj)
    {
        this.commDao.save(obj);
    }
    
    public T update(T obj)
    {
        return this.commDao.update(obj);
    }
    
    public T get(Class<T> clazz, Serializable id)
    {
        return this.commDao.get(clazz, id);
    }
    
    public void delete(T obj)
    {
        this.commDao.delete(obj);
    }
    
    public void delete(Class<T> clazz, Serializable id)
    {
        this.commDao.delete(clazz, id);
    }
    
    public void delete(Class<T> clazz, Serializable[] ids)
    {
        if (ids != null && ids.length > 0)
        {
            for (Serializable id : ids)
            {
                this.commDao.delete(clazz, id);
            }
        }
    }
}
