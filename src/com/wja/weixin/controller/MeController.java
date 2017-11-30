package com.wja.weixin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.ViewRecord;
import com.wja.weixin.service.GzService;
import com.wja.weixin.service.ViewRecordService;

@Controller
@RequestMapping("/wx/web/me")
public class MeController
{
    @Autowired
    private GzService gzService;

    @Autowired
    private ViewRecordService viewRecordService;
    
    @RequestMapping("zg")
    public String tozg(Model model)
    {
        model.addAttribute("zgdh", AppContext.getSysParam(WXContants.SysParam.ZHI_GOU_PHONE));
        return "weixin/me/zg";
    }
    
    @RequestMapping("mygz")
    public String toMygz()
    {
        return "weixin/me/my_gz";
    }
    
    @RequestMapping("queryMyGz")
    @ResponseBody
    public Page<?> queryMyGz(@RequestParam Map<String, String> params, Page<?> page){

        String openId = RequestThreadLocal.openId.get();
        return this.gzService.queryMyGz(openId, params, page);
    }
    

    @RequestMapping("myview")
    public String toMyview()
    {
        return "weixin/me/my_view";
    }
    
    @RequestMapping("queryMyView")
    @ResponseBody
    public Page<ViewRecord> queryMyView(@RequestParam Map<String, Object> params, Page<ViewRecord> page){

        String openId = RequestThreadLocal.openId.get();
        params.put("vid", openId);
        return this.viewRecordService.query(params, page);
    }
}
