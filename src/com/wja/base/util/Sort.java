package com.wja.base.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;

public class Sort
{
    public static final String ASC = "ASC";
    
    public static final String DESC = "DESC";
    
    private String sort;
    
    private String order;
    
    public Sort()
    {
    }
    
    public Sort(String sort, String order)
    {
        this.sort = sort;
        this.order = order;
    }
    
    public static final Sort asc(String property)
    {
        return new Sort(property, ASC);
    }
    
    public static final Sort desc(String property)
    {
        return new Sort(property, DESC);
    }
    
    public String getSort()
    {
        return sort;
    }
    
    public void setSort(String sort)
    {
        this.sort = sort;
    }
    
    public String getOrder()
    {
        return order;
    }
    
    public void setOrder(String order)
    {
        this.order = order;
    }
    
    public org.springframework.data.domain.Sort getSpringSort()
    {
        List<Order> list = null;
        
        if (StringUtils.isNotBlank(sort))
        {
            String[] ss = sort.split(",");
            String[] os = new String[ss.length];
            if (StringUtils.isNotBlank(order))
            {
                String[] ods = order.split(",");
                for (int i = 0; i < os.length && i < ods.length; i++)
                {
                    os[i] = ods[i];
                }
            }
            
            list = new ArrayList<>();
            
            for (int i = 0; i < ss.length; i++)
            {
                String p = ss[i].trim();
                if (StringUtils.isNotBlank(p))
                {
                    String o = os[i];
                    Direction d = Direction.ASC;
                    if (StringUtils.isNotBlank(o))
                    {
                        try
                        {
                            d = Direction.valueOf(os[i].trim().toUpperCase());
                        }
                        catch (Exception e)
                        {
                            Log.LOGGER.error("排序处理异常", e);
                        }
                    }
                    
                    list.add(new Order(d, p));
                }
            }
        }
        
        org.springframework.data.domain.Sort st = null;
        
        if (list != null && !list.isEmpty())
        {
            st = new org.springframework.data.domain.Sort(list);
        }
        
        return st;
    }
}
