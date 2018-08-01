package com.wja.wxadmin.controller;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.Page;
import com.wja.weixin.entity.Product;
import com.wja.weixin.service.ProductService;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController
{
    
    @Autowired
    private ProductService productService;
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<Product> page)
    {
        this.productService.query(params, page);
        BeanUtil.setCollFieldValues(page.getRows());
        return page;
    }
    
    @RequestMapping("manage")
    public String manage()
    {
        return "admin/product";
    }
    
    @RequestMapping({"add", "update"})
    @ResponseBody
    public OpResult doSave(Product obj)
    {
        if (StringUtils.isBlank(obj.getId()))
        {
            return OpResult.addOk(this.productService.saveProduct(obj));
        }
        else
        {
            Product db = this.productService.get(Product.class, obj.getId());
            
            BeanUtil.copyPropertiesIgnoreNull(obj, db);
            return OpResult.updateOk(this.productService.update(db));
        }
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public OpResult delete(String[] id)
    {
        this.productService.delete(Product.class, id);
        return OpResult.deleteOk();
    }
    
}
