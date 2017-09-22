package com.wja.base.util;

import java.util.List;

import org.springframework.data.domain.PageRequest;

public class Page<T>
{
    
    // 默认的页大小
    private static int DEFAULT_PAGE_SIZE = 10;
    
    // 默认的页码（第几页）
    private static int DEFAULT_PAGE_NUM = 1;
    
    // 页大小
    private int size = DEFAULT_PAGE_SIZE;
    
    // 当前是第几页
    private int pageNum = DEFAULT_PAGE_NUM;
    
    // 总数据条数
    private Long total;
    
    // 当前页的数据集
    private List<T> rows;
    
    private String sort;
    
    private String order;
    
    public Page()
    {
    
    }
    
    /**
     * 构造方法
     * 
     * @param pageNum
     * @param pageSize
     */
    public Page(int pageNum, int pageSize)
    {
        if (pageNum > 0)
        {
            this.pageNum = pageNum;
        }
        
        if (pageSize > 0)
        {
            this.size = pageSize;
        }
    }
    
    public int getSize()
    {
        return size;
    }
    
    public void setSize(int size)
    {
        this.size = size;
    }
    
    public int getPageNum()
    {
        return pageNum;
    }
    
    public void setPageNum(int pageNum)
    {
        this.pageNum = pageNum;
    }
    
    public Long getTotal()
    {
        return total;
    }
    
    public void setTotal(Long total)
    {
        this.total = total;
    }
    
    public List<T> getRows()
    {
        return rows;
    }
    
    public void setRows(List<T> rows)
    {
        this.rows = rows;
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
    
    /**
     * 获取页的起始行号
     * 
     * @return
     */
    public int getStartNum()
    {
        return this.size * (this.pageNum - 1) + 1;
    }
    
    /**
     * 获取页的结束行号
     * 
     * @return
     */
    public int getEndNum()
    {
        return this.size * this.pageNum;
    }
    
    public PageRequest getPageRequest()
    {
        return new PageRequest(this.pageNum - 1, this.size, new Sort(this.sort, this.order).getSpringSort());
    }
    
    public Page<T> setPageData(org.springframework.data.domain.Page<T> p)
    {
        this.total = p.getTotalElements();
        this.rows = p.getContent();
        return this;
    }
}
