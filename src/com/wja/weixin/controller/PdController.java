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
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.Message;
import com.wja.weixin.entity.NeedDownloadFile;
import com.wja.weixin.entity.UseWorker;
import com.wja.weixin.entity.WorkOrder;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.GzService;
import com.wja.weixin.service.MessageService;
import com.wja.weixin.service.NeedDownloadFileService;
import com.wja.weixin.service.UseWorkerService;
import com.wja.weixin.service.WorkOrderService;

@Controller
@RequestMapping("/wx/web/pd")
public class PdController
{
    @Autowired
    private FollwerInfoService follwerInfoService;
    
    @Autowired
    private GzService gzService;
    
    @Autowired
    private WorkOrderService workOrderService;
    
    @Autowired
    private UseWorkerService useWorkerService;
    
    @Autowired
    private MessageService messageService;
    
    @Autowired
    private NeedDownloadFileService needDownloadFileService;
    
    @RequestMapping("view/{id}")
    public String view(@PathVariable("id") String id, Model model)
    {
        WorkOrder m = this.workOrderService.get(WorkOrder.class, id);
        if (m == null)
        {
            return "weixin/not_exist"; // 不存在
        }
        
        String openId = RequestThreadLocal.openId.get();
        if (!m.getPubId().equals(openId) && !m.getWorker().contains(openId))
        {
            return "weixin/no_autho"; // 无权浏览
        }
        
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
        
        model.addAttribute("me", m);
        model.addAttribute("fi", this.follwerInfoService.get(FollwerInfo.class, m.getPubId()));
        return "weixin/fb/pd_view";
    }
    
    @RequestMapping("pd")
    public String toPd(Model model)
    {
        String openId = RequestThreadLocal.openId.get();
        Page<UseWorker> page = new Page<>();
        page.setSort("lastModifyTime");
        page.setOrder("desc");
        Map<String, Object> params = new HashMap<>();
        params.put("pubId", openId);
        this.useWorkerService.query(params, page);
        model.addAttribute("useWorkers", page.getRows());
        return "weixin/fb/pd";
    }
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(WorkOrder w)
    {
        String openId = RequestThreadLocal.openId.get();
        w.setPubId(openId);
        w = this.workOrderService.addWorkWorder(w);
        
        if (StringUtils.isNotBlank(w.getImg()))
        {
            // 下载图片
            this.needDownloadFileService
                .addNeeddownloadFile(w.getId(), w.getImg(), NeedDownloadFile.Type.WORK_ORDER_IMG);
        }
        
        // 异步下载语音
        this.needDownloadFileService
            .addNeeddownloadFile(w.getId(), w.getVoices(), NeedDownloadFile.Type.WORK_ORDER_VOICE);
        
        // 消息推送
        Message m = new Message();
        m.setPubId(w.getPubId());
        String prefix = AppContext.getSysParam(WXContants.SysParam.MESS_PD_TITLE_PREFIX);
        if (prefix == null)
        {
            prefix = "";
        }
        m.setTitle(prefix + w.getWno());
        m.setTrange(Message.Range.GR);
        m.setMtype(Message.Mtype.WorkOrder);
        m.setToIds(w.getWorker());
        m.setLinkId(w.getId());
        
        return this.messageService.saveMessage(m);
    }
}
