package com.wja.weixin.controller;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.FollwerInfo;
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
        p = this.productService.saveProduct(p);
        
        // 消息推送
        Message m = new Message();
        m.setPubId(openId);
        String prefix = AppContext.getSysParam(WXContants.SysParam.MESS_PROD_TITLE_PREFIX);
        if(prefix == null){
            prefix = "";
        }
        m.setTitle(prefix + p.getTitle());
        if (StringUtils.isNotBlank(p.getImg()))
        {
            m.setImg(p.getImg().split(";")[0]);
        }
        m.setTrange(trange);
        m.setMtype(Message.Mtype.Product);
        m.setLinkId(p.getId());
        
        return this.messageService.saveMessage(m);
        
    }
       
    @RequestMapping("toMyMess")
    public String tomyMess(){
        return "weixin/fb/mess_my";
    }
    
    @RequestMapping("queryMyMess")
    @ResponseBody
    public Object queryMyMess(String title,Page<?> page)
    {
        String openId = RequestThreadLocal.openId.get();
        return this.messageService.queryMyMessage(openId, title, page);
    }
 
    @RequestMapping("toMyfb")
    public String tpMyFb(){
        return "weixin/fb/mess_fb";
    }
    
    @RequestMapping("queryMyfb")
    @ResponseBody
    public Page<Message> queryMyFb(@RequestParam Map<String, Object> params, Page<Message> page)
    {
        String openId = RequestThreadLocal.openId.get();
        params.put("pubId", openId);
        return this.messageService.queryMyFb(params, page);
    }
    
    @RequestMapping("chehui")
    @ResponseBody
    public Object cheHui(String id)
    {
        String openId = RequestThreadLocal.openId.get();
        Message m = this.messageService.get(Message.class, id);
        if(m.getPubId().equals(openId)){
            this.messageService.delete(m);
            return OpResult.ok();
        }
        else {
            return OpResult.error("您不是发布者，无权撤回！", null);
        }
    }
    
    @RequestMapping("view")
    public String view(String id,Model model){
        Message m = this.messageService.get(Message.class, id);
        if(m == null){
            return "weixin/not_exist";   //不存在
        }
        
        switch(m.getMtype()){
            case Message.Mtype.Product:
                return "redirect:../prod/view?id=" + m.getLinkId();
            case Message.Mtype.WorkOrder:
                return "redirect:../worder/view?id=" + m.getLinkId();
            default:
                String openId = RequestThreadLocal.openId.get();
                if(!m.getPubId().equals(openId) && !m.getTrange().equals(Message.Range.Platform)){
                    if(this.gzService.getByGzidAndBgzid(openId, m.getPubId()) == null){
                        return "weixin/no_autho";   //无权浏览
                    }
                }
                model.addAttribute("me", m);
                model.addAttribute("fi", this.follwerInfoService.get(FollwerInfo.class, m.getPubId()));
                return "weixin/fb/mess_view";
        }
    }
}
