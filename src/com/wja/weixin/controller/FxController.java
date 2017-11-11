package com.wja.weixin.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.Page;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.Brand;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.HotBrand;
import com.wja.weixin.entity.RecomExpert;
import com.wja.weixin.service.BrandService;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.HotBrandService;
import com.wja.weixin.service.RecomExpertService;

@Controller
@RequestMapping("/wx/pub/fx")
public class FxController
{
    @Autowired
    private HotBrandService hotBrandService;
    
    @Autowired
    private BrandService brandService;
    
    @Autowired
    private RecomExpertService recomExportService;
    
    @Autowired
    private FollwerInfoService follwerInfoService;
    
    @RequestMapping("zj")
    public String fxZj(Model model)
    {
        Page<RecomExpert> page = new Page<>(1, 100);
        page.setSort("orderno");
        page.setOrder("asc");
        
        Map<String, Object> params = new HashMap<>();
        Date d = new Date();
        params.put("startTime_lte_date", d);
        params.put("endTime_gte_date", d);
        
        model.addAttribute("hots", this.recomExportService.query(params, page).getRows());
        
        return "weixin/fx/zj";
    }
    
    @RequestMapping("zjQuery")
    @ResponseBody
    public Object zjQuery(@RequestParam Map<String, Object> params, Page<FollwerInfo> page)
    {
        params.put("category", WXContants.Category.EXPERT);
        this.follwerInfoService.query(params, page);
        return page;
    }
    
    @RequestMapping("brand")
    public String brandDiscovery(Model model)
    {
        Page<HotBrand> page = new Page<>(1, 100);
        page.setSort("orderno");
        page.setOrder("asc");
        
        Map<String, Object> params = new HashMap<>();
        Date d = new Date();
        params.put("startTime_lte_date", d);
        params.put("endTime_gte_date", d);
        
        model.addAttribute("hots", this.hotBrandService.query(params, page).getRows());
        
        return "weixin/fx/brand";
    }
    
    @RequestMapping("brandQuery")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<Brand> page)
    {
        this.brandService.query(params, page);
        return page;
    }
}
