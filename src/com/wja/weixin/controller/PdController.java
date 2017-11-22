package com.wja.weixin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.Message;
import com.wja.weixin.entity.UseWorker;
import com.wja.weixin.entity.WorkOrder;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.GzService;
import com.wja.weixin.service.MessageService;
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
    
    @RequestMapping("view")
    public String view(String id,Model model){
        WorkOrder m = this.workOrderService.get(WorkOrder.class, id);
        if(m == null){
            return "weixin/not_exist";   //不存在
        }
        
        String openId = RequestThreadLocal.openId.get();
        if(!m.getPubId().equals(openId) && !m.getWorker().contains(openId)){
            return "weixin/no_autho";   //无权浏览
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
        Map<String,Object> params = new HashMap<String,Object>();
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

        // 消息推送
        Message m = new Message();
        m.setPubId(w.getPubId());
        String prefix = AppContext.getSysParam(WXContants.SysParam.MESS_PD_TITLE_PREFIX);
        if(prefix == null){
            prefix = "";
        }
        m.setTitle(prefix + w.getWno());
        
        m.setMtype(Message.Mtype.WorkOrder);
        m.setLinkId(w.getId());
        
        return this.messageService.saveMessage(m);
    }
}
