package com.wja.weixin.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.Message;
import com.wja.weixin.entity.Product;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.GzService;
import com.wja.weixin.service.MessageService;
import com.wja.weixin.service.ProductService;

@Controller
@RequestMapping("/wx/web/fb")
public class FbController
{
    @Autowired
    private FollwerInfoService follwerInfoService;
    
    @Autowired
    private GzService gzService;
    
    @Autowired
    private MessageService messageService;
    
    @Autowired
    private ProductService productService;
    
    @RequestMapping("mess")
    public String fb(Model model)
    {
        model.addAttribute("mpf", AppContext.getSysParam(WXContants.SysParam.MessPlatFee));
        return "weixin/fb/mess";
    }
    
    @RequestMapping("messfb")
    @ResponseBody
    public Object messFb(Message m)
    {
        String openId = RequestThreadLocal.openId.get();
        m.setPubId(openId);
        return this.messageService.saveMessage(m);
    }
    
    @RequestMapping("prodfb")
    @ResponseBody
    public Object prodFb(Product p, String trange)
    {
        String openId = RequestThreadLocal.openId.get();
        p.setPubId(openId);
        p = this.productService.saveProduct(p, trange);
        
        // 消息推送
        Message m = new Message();
        m.setPubId(openId);
        m.setTitle("新产品!" + p.getTitle());
        if (StringUtils.isNotBlank(p.getImg()))
        {
            m.setImg(p.getImg().split(";")[0]);
        }
        m.setTrange(trange);
        m.setMtype(Message.Mtype.Product);
        m.setLinkId(p.getId());
        
        return this.messageService.saveMessage(m);
        
    }
}
