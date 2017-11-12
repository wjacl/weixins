package com.wja.weixin.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
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
    
    @RequestMapping("fx")
    public String fx(Model model)
    {
        return "weixin/fx/fx";
    }
    
    @RequestMapping("view")
    public String view(String id, Model model)
    {
        FollwerInfo fi = follwerInfoService.get(FollwerInfo.class, id);
        
        if (fi != null)
        {
            model.addAttribute("fi", fi);
            switch (fi.getCategory())
            {
                case WXContants.Category.FACTORY:
                case WXContants.Category.SHOP:
                    return "weixin/fx/view_fs";
                default:
                    return "weixin/fx/view_za";
            }
        }
        else
        {
            return "weixin/fx/view_not_exits";
        }
    }
    
    @RequestMapping("fxQuery")
    @ResponseBody
    public Object fxQuery(@RequestParam Map<String, Object> params, Page<FollwerInfo> page)
    {
        this.follwerInfoService.query(params, page);
        return this.follwerInfoTrans(page);
    }
    
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
        return this.follwerInfoTrans(page);
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
    
    @RequestMapping("brandView")
    public String viewBrand(String id, Model model)
    {
        Brand b = this.brandService.get(Brand.class, id);
        
        if (b != null)
        {
            model.addAttribute("b", b);
            return "weixin/fx/view_brand";
        }
        else
        {
            return "weixin/fx/view_brand_not_exits";
        }
    }
    
    @RequestMapping("brandQuery")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<Brand> page)
    {
        this.brandService.query(params, page);
        return page;
    }
    
    private Page<Fvo> follwerInfoTrans(Page<FollwerInfo> page)
    {
        List<Fvo> rows = this.follwerInfoTrans(page.getRows());
        Page<Fvo> p = new Page<>();
        p.setPageNum(page.getPageNum());
        p.setSize(page.getSize());
        p.setTotal(page.getTotal());
        p.setRows(rows);
        return p;
    }
    
    private List<Fvo> follwerInfoTrans(List<FollwerInfo> list)
    {
        List<Fvo> dlist = new ArrayList<>();
        if (CollectionUtil.isNotEmpty(list))
        {
            Fvo vo = null;
            for (FollwerInfo f : list)
            {
                vo = new Fvo();
                BeanUtil.copyPropertiesIgnoreNull(f, vo);
                vo.setId(f.getOpenId());
                dlist.add(vo);
            }
        }
        
        return dlist;
    }
    
    /**
     * 数据传递用实体（加强数据安全）
     * 
     * @author wja
     * @version [版本号, 2017年11月12日]
     * @see [相关类/方法]
     * @since [产品/模块版本]
     */
    private class Fvo
    {
        String id;
        
        String name;
        
        String mphone;
        
        String pinyin;
        
        String lat;
        
        String lng;
        
        String address;
        
        String category;
        
        String wechart;
        
        String logo;
        
        public String getId()
        {
            return id;
        }
        
        public void setId(String id)
        {
            this.id = id;
        }
        
        public String getName()
        {
            return name;
        }
        
        public void setName(String name)
        {
            this.name = name;
        }
        
        public String getMphone()
        {
            return mphone;
        }
        
        public void setMphone(String mphone)
        {
            this.mphone = mphone;
        }
        
        public String getPinyin()
        {
            return pinyin;
        }
        
        public void setPinyin(String pinyin)
        {
            this.pinyin = pinyin;
        }
        
        public String getLat()
        {
            return lat;
        }
        
        public void setLat(String lat)
        {
            this.lat = lat;
        }
        
        public String getLng()
        {
            return lng;
        }
        
        public void setLng(String lng)
        {
            this.lng = lng;
        }
        
        public String getAddress()
        {
            return address;
        }
        
        public void setAddress(String address)
        {
            this.address = address;
        }
        
        public String getCategory()
        {
            return category;
        }
        
        public void setCategory(String category)
        {
            this.category = category;
        }
        
        public String getWechart()
        {
            return wechart;
        }
        
        public void setWechart(String wechart)
        {
            this.wechart = wechart;
        }
        
        public String getLogo()
        {
            return logo;
        }
        
        public void setLogo(String logo)
        {
            this.logo = logo;
        }
        
    }
}
