package com.wja.weixin.controller;

import java.util.ArrayList;
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
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.MessReceiveRecord;
import com.wja.weixin.entity.Message;
import com.wja.weixin.entity.NeedDownloadFile;
import com.wja.weixin.entity.Product;
import com.wja.weixin.entity.ViewRecord;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.GzService;
import com.wja.weixin.service.MessageService;
import com.wja.weixin.service.NeedDownloadFileService;
import com.wja.weixin.service.ProductService;
import com.wja.weixin.service.ViewRecordService;

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
    
    @Autowired
    private ViewRecordService viewRecordService;
    
    @Autowired
    private NeedDownloadFileService needDownloadFileService;
    
    @RequestMapping("mess")
    public String fb(Model model)
    {
        model.addAttribute("mpf", AppContext.getSysParam(WXContants.SysParam.MessPlatFee));
        return "weixin/fb/mess";
    }
    
    @RequestMapping("messfb")
    @ResponseBody
    public Object messFb(Message m)
        throws Exception
    {
        String openId = RequestThreadLocal.openId.get();
        m.setPubId(openId);
        if (StringUtils.isNotBlank(m.getImg()))
        {
            m.setImg(this.needDownloadFileService.commonDownLoadFile(m.getImg(), NeedDownloadFile.Type.MESSAGE_IMG));
        }
        return this.messageService.saveMessage(m);
    }
    
    @RequestMapping("prodfb")
    @ResponseBody
    public Object prodFb(Product p, String trange)
        throws Exception
    {
        String openId = RequestThreadLocal.openId.get();
        p.setPubId(openId);
        p = this.productService.saveProduct(p);
        
        // 消息推送
        Message m = new Message();
        m.setPubId(openId);
        String prefix = AppContext.getSysParam(WXContants.SysParam.MESS_PROD_TITLE_PREFIX);
        if (prefix == null)
        {
            prefix = "";
        }
        m.setTitle(prefix + p.getTitle());
        if (StringUtils.isNotBlank(p.getImg()))
        {
            String firstImg = p.getImg().split(";")[0];
            if (StringUtils.isNotBlank(firstImg))
            {
                m.setImg(this.needDownloadFileService.commonDownLoadFile(firstImg, NeedDownloadFile.Type.MESSAGE_IMG));
            }
            // 下载产品图片
            this.needDownloadFileService.addNeeddownloadFile(p.getId(), p.getImg(), NeedDownloadFile.Type.PRODUCT_IMG);
        }
        m.setTrange(trange);
        m.setMtype(Message.Mtype.Product);
        m.setLinkId(p.getId());
        return this.messageService.saveMessage(m);
        
    }
    
    @RequestMapping("toMyMess")
    public String tomyMess()
    {
        return "weixin/fb/mess_my";
    }
    
    @RequestMapping("queryMyMess")
    @ResponseBody
    public Object queryMyMess(String title, Page<?> page)
    {
        String openId = RequestThreadLocal.openId.get();
        return this.messageService.queryMyMessage(openId, title, page);
    }
    
    @RequestMapping("toMyfb")
    public String tpMyFb()
    {
        return "weixin/fb/mess_fb";
    }
    
    @RequestMapping("queryMyfb")
    @ResponseBody
    public Page<Message> queryMyFb(@RequestParam Map<String, Object> params, Page<Message> page)
    {
        String openId = RequestThreadLocal.openId.get();
        params.put("pubId", openId);
        params.put("mtype_ne", Message.Mtype.AUDIT);
        return this.messageService.queryMyFb(params, page);
    }
    
    @RequestMapping("chehui")
    @ResponseBody
    public Object cheHui(String id)
    {
        String openId = RequestThreadLocal.openId.get();
        Message m = this.messageService.get(Message.class, id);
        if (m.getPubId().equals(openId))
        {
            this.messageService.delete(m);
            return OpResult.ok();
        }
        else
        {
            return OpResult.error("您不是发布者，无权撤回！", null);
        }
    }
    
    @RequestMapping("view/{id}")
    public String view(@PathVariable("id") String id, Model model)
    {
        Message m = this.messageService.get(Message.class, id);
        if (m == null)
        {
            return "weixin/not_exist"; // 不存在
        }
        String openId = RequestThreadLocal.openId.get();
        if (!m.getPubId().equals(openId) && !m.getTrange().equals(Message.Range.Platform))
        {
            if (m.getTrange().equals(Message.Range.GR))
            {
                if (StringUtils.isBlank(m.getToIds()) || !m.getToIds().contains(openId))
                {
                    return "weixin/no_autho"; // 无权浏览
                }
            }
            else
            {
                if (this.gzService.getByGzidAndBgzid(openId, m.getPubId()) == null)
                {
                    return "weixin/no_autho"; // 无权浏览
                }
            }
        }
        
        // 记录消息接收记录
        MessReceiveRecord mrr = new MessReceiveRecord();
        mrr.setMessId(m.getId());
        mrr.setRecId(openId);
        this.messageService.saveMessRec(mrr);
        
        switch (m.getMtype())
        {
            case Message.Mtype.Product:
                return "redirect:../../prod/view/" + m.getLinkId();
            case Message.Mtype.WorkOrder:
                return "redirect:../../pd/view/" + m.getLinkId();
            case Message.Mtype.AUDIT:
                return "redirect:../../auth/auditList";
            default:
                model.addAttribute("me", m);
                model.addAttribute("fi", this.follwerInfoService.get(FollwerInfo.class, m.getPubId()));
                // 加入语音，因语音数据格式复制，再界面不好处理，所以在此把数据构造好
                String voices = m.getVoices();
                if (StringUtils.isNotBlank(voices))
                {
                    String[] vs = voices.split(";");
                    List<Map<String, String>> vlist = new ArrayList<>();
                    for (String s : vs)
                    {
                        Map<String, String> vmap = new HashMap<>();
                        String[] ds = s.split("\\|\\|");
                        if (ds[0].startsWith("sid="))
                        {
                            vmap.put("sid", "true");
                            vmap.put("path", ds[0].substring(4));
                        }
                        else
                        {
                            vmap.put("path", ds[0]);
                        }
                        vmap.put("times", ds[1]);
                        vlist.add(vmap);
                    }
                    model.addAttribute("voices", vlist);
                }
                
                if (openId != null)
                {
                    // 记录浏览记录
                    this.viewRecordService
                        .saveRecord(new ViewRecord(id, m.getTitle(), ViewRecord.Otype.MESSAGE, openId));
                }
                return "weixin/fb/mess_view";
        }
    }
}
