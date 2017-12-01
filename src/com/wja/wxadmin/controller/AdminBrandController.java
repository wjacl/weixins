package com.wja.wxadmin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.BeanUtil;
import com.wja.base.util.Page;
import com.wja.weixin.entity.Brand;
import com.wja.weixin.entity.HotBrand;
import com.wja.weixin.service.BrandService;
import com.wja.weixin.service.HotBrandService;

@Controller
@RequestMapping("/admin")
public class AdminBrandController {

    @Autowired 
    private BrandService brandService;
    
    @Autowired
    private HotBrandService hotBrandService;
    
    @RequestMapping("brand/query")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<Brand> page)
    {
        this.brandService.query(params, page);
        BeanUtil.setCollFieldValues(page.getRows());
        return page;
    }
    
    @RequestMapping("brand/manage")
    public String manage(){
        return "admin/brand";
    }
    
    @RequestMapping("hotBrand/manage")
    public String hotManage(){
        return "admin/brand_hot";
    }
    
    @RequestMapping("hotBrand/query")
    @ResponseBody
    public Object hotBrandQuery(@RequestParam Map<String, Object> params, Page<HotBrand> page)
    {
        this.hotBrandService.query(params, page);
        BeanUtil.setCollFieldValues(page.getRows());
        return page;
    }
}
