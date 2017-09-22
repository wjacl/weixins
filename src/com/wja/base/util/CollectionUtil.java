package com.wja.base.util;

import java.util.Collection;
import java.util.Map;

public class CollectionUtil
{
    /**
     * 
     * 判断数组是否为null或长度为0
     * 
     * @param array
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static boolean isEmpty(Object[] array)
    {
        return array == null || array.length == 0;
    }
    
    public static boolean isNotEmpty(Object[] array)
    {
        return array != null && array.length > 0;
    }
    
    /**
     * 
     * 判断集合是否为null或长度为0
     * 
     * @param array
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static boolean isEmpty(Collection<?> col)
    {
        return col == null || col.isEmpty();
    }
    
    public static boolean isNotEmpty(Collection<?> col)
    {
        return col != null && col.size() > 0;
    }
    
    /**
     * 
     * 判断Map是否为null或长度为0
     * 
     * @param array
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static boolean isEmpty(Map<?, ?> map)
    {
        return map == null || map.isEmpty();
    }
    
    public static boolean isNotEmpty(Map<?, ?> map)
    {
        return map != null && !map.isEmpty();
    }
}
