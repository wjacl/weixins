package com.wja.weixin.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Page;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.Brand;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.GzRecord;
import com.wja.weixin.entity.HotBrand;
import com.wja.weixin.entity.RecomExpert;
import com.wja.weixin.entity.ViewRecord;
import com.wja.weixin.service.BrandService;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.GzService;
import com.wja.weixin.service.HotBrandService;
import com.wja.weixin.service.RecomExpertService;
import com.wja.weixin.service.ViewRecordService;

@Controller
@RequestMapping("/wx/web/fx")
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
    
    @Autowired
    private GzService gzService;
    
    @Autowired
    private ViewRecordService viewRecordService;
    
    @RequestMapping("fx")
    public String fx(Model model)
    {
        return "weixin/fx/fx";
    }
    
    @RequestMapping("gz")
    @ResponseBody
    public Object gz(String bgzid, String op)
    {
        String openId = RequestThreadLocal.openId.get();
        GzRecord r = new GzRecord();
        r.setGzid(openId);
        r.setBgzid(bgzid);
        
        if ("gz".equals(op))
        {
            this.gzService.saveGz(r);
        }
        else
        {
            this.gzService.saveQxgz(r);
        }
        
        return OpResult.ok();
    }
    
    @RequestMapping("view/{id}")
    public String view(@PathVariable("id") String id, Model model)
    {
        FollwerInfo fi = follwerInfoService.get(FollwerInfo.class, id);
        
        if (fi != null)
        {
            model.addAttribute("fi", fi);
            String openId = RequestThreadLocal.openId.get();
            if (StringUtils.isNotBlank(openId))
            {
                model.addAttribute("gz", this.gzService.getByGzidAndBgzid(openId, fi.getOpenId()));
            }
            
            if(openId != null) {
                //记录浏览记录
                this.viewRecordService.saveRecord(new ViewRecord(id,fi.getName(),ViewRecord.Otype.FOLLWER,openId));
            }
            
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
        params.put("status_eq_intt", FollwerInfo.STATUS_AUDIT_PASS);
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
        params.put("status_eq_intt", FollwerInfo.STATUS_AUDIT_PASS);
        this.follwerInfoService.query(params, page);
        return this.follwerInfoTrans(page);
    }
    
    @RequestMapping("brand")
    public String brandDiscovery(Model model)
    {
        Page<HotBrand> page = new Page<>(1, 1000);
        page.setSort("orderno");
        page.setOrder("asc");
        
        Map<String, Object> params = new HashMap<>();
        Date d = new Date();
        params.put("startTime_lte_date", d);
        params.put("endTime_gte_date", d);
        
        page = this.hotBrandService.query(params, page);
        BeanUtil.setCollFieldValues(page.getRows());
        model.addAttribute("hots",page.getRows());
        
        return "weixin/fx/brand";
    }
    
    @RequestMapping("brandView/{id}")
    public String viewBrand(@PathVariable("id") String id, Model model)
    {
        Brand b = this.brandService.get(Brand.class, id);
        
        if (b != null)
        {

            String openId = RequestThreadLocal.openId.get();
            if(openId != null) {
                //记录浏览记录
                this.viewRecordService.saveRecord(new ViewRecord(id,b.getName(),ViewRecord.Otype.BRAND,openId));
            }
            model.addAttribute("b", b);
            return "weixin/fx/brand_view";
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
