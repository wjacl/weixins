package com.wja.weixin.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.util.BeanUtil;
import com.wja.weixin.entity.Brand;
import com.wja.weixin.service.BrandService;

@Controller
@RequestMapping("/wx/web/brand")
public class BrandController
{
    @Autowired
    private BrandService brandService;
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(Brand brand)
    {
        if (StringUtils.isBlank(brand.getId()))
        {
            if (this.brandService.getByName(brand.getName()) != null)
            {
                return OpResult.error("该品牌名称已存在！", null);
            }
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
            }
            BeanUtil.copyPropertiesIgnoreNull(brand, db);
            return OpResult.updateOk(this.brandService.update(db));
        }
        
    }
    
    @RequestMapping("checkName")
    @ResponseBody
    public Object checkNameExist(String name)
    {
        Brand b = this.brandService.getByName(name);
        return b;
    }
}
