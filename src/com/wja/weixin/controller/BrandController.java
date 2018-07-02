package com.wja.weixin.controller;

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
import com.wja.weixin.entity.NeedDownloadFile;
import com.wja.weixin.service.BrandService;
import com.wja.weixin.service.NeedDownloadFileService;

@Controller
@RequestMapping("/wx/web/brand")
public class BrandController
{
    @Autowired
    private BrandService brandService;
    
    @Autowired
    private NeedDownloadFileService needDownloadFileService;
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<Brand> page)
    {
        this.brandService.query(params, page);
        return page;
    }
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(Brand brand,String newLogo) throws Exception
    {
        if(StringUtils.isNotBlank(newLogo)) {
            brand.setLogo(this.needDownloadFileService.commonDownLoadFile(newLogo, NeedDownloadFile.Type.BRAND_LOGO));
        }
        
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
    
    @RequestMapping("checkName")
    @ResponseBody
    public Object checkNameExist(String name)
    {
        Brand b = this.brandService.getByName(name);
        return b;
    }
}
