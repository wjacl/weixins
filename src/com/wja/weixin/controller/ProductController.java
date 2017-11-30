package com.wja.weixin.controller;

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
import com.wja.base.util.Page;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.Product;
import com.wja.weixin.entity.ViewRecord;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.ProductService;
import com.wja.weixin.service.ViewRecordService;

@Controller
@RequestMapping("/wx/web/prod")
public class ProductController
{
    @Autowired
    private FollwerInfoService follwerInfoService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ViewRecordService viewRecordService;
    
    @RequestMapping("view/{id}")
    public String view(@PathVariable("id") String id,Model model)
    {
        if(StringUtils.isBlank(id)){
            return "weixin/not_exist";   //不存在
        }
        Product p = this.productService.get(Product.class, id);
        if(p == null){
            return "weixin/not_exist";   //不存在
        }
        model.addAttribute("p", p);
        model.addAttribute("fi", this.follwerInfoService.get(FollwerInfo.class, p.getPubId()));
        
        String openId = RequestThreadLocal.openId.get();
        if(openId != null){
            //记录浏览记录
            this.viewRecordService.saveRecord(new ViewRecord(id,p.getTitle(),ViewRecord.Otype.PRODUCT,openId));
        }
        
        return "weixin/prod/view";
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Page<Product> queryMyFb(@RequestParam Map<String, Object> params, Page<Product> page)
    {
        return this.productService.query(params, page);
    }
    
    @RequestMapping("edit/{id}")
    public String toUpdate(@PathVariable("id") String id,Model model){
        if(StringUtils.isBlank(id)){
            return "weixin/not_exist";   //不存在
        }
        Product p = this.productService.get(Product.class, id);
        if(p == null){
            return "weixin/not_exist";   //不存在
        }
        
        String openId = RequestThreadLocal.openId.get();
        if(!p.getPubId().equals(openId)){
            return "weixin/no_autho";   //无权操作
        }
        model.addAttribute("p", p);
        model.addAttribute("fi", this.follwerInfoService.get(FollwerInfo.class, p.getPubId()));
        return "weixin/prod/edit";
    }
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(Product p){
        Product dp = this.productService.get(Product.class, p.getId());
        BeanUtil.copyPropertiesIgnoreNull(p, dp);
        this.productService.saveProduct(dp);
        return OpResult.updateOk();
    }
    
    @RequestMapping("del")
    @ResponseBody
    public Object del(String id){
        Product p = this.productService.get(Product.class, id);

        String openId = RequestThreadLocal.openId.get();
        if(!p.getPubId().equals(openId)){
            return OpResult.deleteError("无权进行此项操作", null);
        }
        
        this.productService.delete(p);
        return OpResult.deleteOk();
    }
}
