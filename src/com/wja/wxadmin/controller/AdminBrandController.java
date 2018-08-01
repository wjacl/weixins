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
import com.wja.base.util.StringUtil;
import com.wja.weixin.entity.Brand;
import com.wja.weixin.entity.HotBrand;
import com.wja.weixin.service.BrandService;
import com.wja.weixin.service.HotBrandService;

@Controller
@RequestMapping("/admin")
public class AdminBrandController
{
    
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
    public String manage()
    {
        return "admin/brand";
    }
    
    @RequestMapping({"brand/add", "brand/update"})
    @ResponseBody
    public OpResult saveBrand(Brand brand)
    {
        if (StringUtils.isBlank(brand.getId()))
        {
            if (this.brandService.getByName(brand.getName()) != null)
            {
                return OpResult.error("该品牌名称已存在！", null);
            }
            brand.setPinyin(StringUtil.getPinYinHeadChar(brand.getName()));
            return OpResult.addOk(this.brandService.addOne(brand));
        }
        else
        {
            Brand db = this.brandService.get(Brand.class, brand.getId());
            if (!db.getName().equals(brand.getName()))
            {
                if (this.brandService.getByName(brand.getName()) != null)
                {
                    return OpResult.error("该品牌名称已存在！", null);
                }
                
                brand.setPinyin(StringUtil.getPinYinHeadChar(brand.getName()));
            }
            BeanUtil.copyPropertiesIgnoreNull(brand, db);
            return OpResult.updateOk(this.brandService.update(db));
        }
    }
    
    @RequestMapping("brand/delete")
    @ResponseBody
    public OpResult deleteBrand(String[] id)
    {
        this.brandService.delete(Brand.class, id);
        return OpResult.deleteOk();
    }
    
    @RequestMapping("hotBrand/manage")
    public String hotManage()
    {
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
    
    @RequestMapping({"hotBrand/add", "hotBrand/update"})
    @ResponseBody
    public OpResult saveHotBrand(HotBrand c)
    {
        HotBrand dbld = this.hotBrandService.findByBrandId(c.getBrandId());
        boolean add = StringUtils.isBlank(c.getId());
        if (add)
        {
            if (dbld != null)
            {
                return OpResult.addError("该品牌已存在，不能重复加热门，请进行修改！", c);
            }
            this.hotBrandService.add(c);
            return OpResult.addOk(c);
        }
        else
        {
            if (dbld != null && !dbld.getId().equals(c.getId()))
            {
                return OpResult.updateError("该品牌已存在，不能重复加热门，请修改！", c);
            }
            BeanUtil.copyPropertiesIgnoreNull(c, dbld);
            return OpResult.updateOk(this.hotBrandService.update(dbld));
        }
    }
    
    @RequestMapping("hotBrand/delete")
    @ResponseBody
    public OpResult deleteHotBrand(String[] id)
    {
        this.hotBrandService.delete(HotBrand.class, id);
        return OpResult.deleteOk();
    }
}
