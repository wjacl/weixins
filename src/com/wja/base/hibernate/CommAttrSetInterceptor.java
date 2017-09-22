package com.wja.base.hibernate;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.EmptyInterceptor;
import org.hibernate.type.Type;
import org.springframework.stereotype.Component;

import com.wja.base.web.RequestThreadLocal;

/**
 * 
 * 操作人、操作时间等公共属性设置拦截器，统一在此拦截器中设置通用属性值
 * 
 * @author wja
 * @version [v1.0, 2016年9月23日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
@Component
public class CommAttrSetInterceptor extends EmptyInterceptor
{
    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 1L;
    
    @Override
    public boolean onFlushDirty(Object entity, Serializable id, Object[] state, Object[] previousState,
        String[] propertyNames, Type[] types)
    {
        
        Date updtime = new Date();
        
        for (int i = 0; i < propertyNames.length; i++)
        {
            if ("lastModifyTime".equals(propertyNames[i]))
            {
                state[i] = updtime;
            }
            else if ("lastModifyUser".equals(propertyNames[i]))
            {
                if (RequestThreadLocal.currUser.get() != null)
                {
                    state[i] = RequestThreadLocal.currUser.get().getId();
                }
            }
        }
        
        return true;
    }
    
    @Override
    public boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types)
    {
        
        Date updtime = new Date();
        
        for (int i = 0; i < propertyNames.length; i++)
        {
            if ("createTime".equals(propertyNames[i]))
            {
                state[i] = updtime;
            }
            else if ("createUser".equals(propertyNames[i]))
            {
                if (RequestThreadLocal.currUser.get() != null)
                {
                    state[i] = RequestThreadLocal.currUser.get().getId();
                }
            }
        }
        
        return true;
    }
}
