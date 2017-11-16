package com.wja.weixin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.service.CommService;
import com.wja.weixin.dao.ProductDao;
import com.wja.weixin.entity.Product;

@Service
public class ProductService extends CommService<Product>
{
    
    @Autowired
    private ProductDao productDao;
    
    @Autowired
    private FollwerInfoService follweInfoService;
    
    public Product saveProduct(Product p, String trange)
    {
        return this.productDao.save(p);
    }
}
