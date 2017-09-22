package com.wja.base.common;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Component;

@Component
public class CommDao
{
    
    @PersistenceContext
    private EntityManager em;
    
    public void save(Object o)
    {
        if (o != null)
        {
            em.persist(o);
        }
    }
    
    public <T> T update(T obj)
    {
        if (obj != null)
        {
            return em.merge(obj);
        }
        return null;
    }
    
    public <T> T get(Class<T> clazz, Serializable id)
    {
        if (id == null)
        {
            return null;
        }
        return em.find(clazz, id);
    }
    
    public <T> void delete(T obj)
    {
        if (obj == null)
        {
            return;
        }
        
        Class clazz = obj.getClass();
        try
        {
            Method m = clazz.getMethod("setValid", Byte.class);
            if (m != null)
            {
                m.invoke(obj, CommConstants.DATA_INVALID);
                em.merge(obj);
            }
        }
        catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException
            | InvocationTargetException e)
        {
            em.remove(obj);
        }
    }
    
    public <T> void delete(Class<T> clazz, Serializable id)
    {
        if (id != null)
        {
            T obj = em.find(clazz, id);
            delete(obj);
        }
    }
    
}
