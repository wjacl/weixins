package com.wja.weixin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.util.Page;
import com.wja.weixin.dao.ProductDao;
import com.wja.weixin.entity.Product;

@Service
public class ProductService extends CommService<Product>
{
    
    @Autowired
    private ProductDao productDao;
    
    @Autowired
    private FollwerInfoService follweInfoService;
    
    public Product saveProduct(Product p)
    {
        return this.productDao.save(p);
    }
    
    /**
     * 查询我的历史发布
     * @param params
     * @param page
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Page<Product> query(Map<String, Object> params, Page<Product> page){
        return page.setPageData(
            this.productDao.findAll(new CommSpecification<Product>(params), page.getPageRequest()));
    }
}
