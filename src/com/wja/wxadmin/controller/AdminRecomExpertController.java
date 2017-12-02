package com.wja.wxadmin.controller;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.Page;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.RecomExpert;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.RecomExpertService;

@Controller
@RequestMapping("/admin")
public class AdminRecomExpertController {

    @Autowired 
    private FollwerInfoService follwerInfoService;
    
    @Autowired
    private RecomExpertService recomExpertService;
    
    @RequestMapping("expert/query")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<FollwerInfo> page)
    {
        this.follwerInfoService.query(params, page);
        
        return FollwerHandler.follwerInfoTrans(page);
    }   
    
    @RequestMapping("recomExpert/manage")
    public String manage(){
        return "admin/recom_expert";
    }
    
    @RequestMapping("recomExpert/query")
    @ResponseBody
    public Object recomExpertQuery(@RequestParam Map<String, Object> params, Page<RecomExpert> page)
    {
        this.recomExpertService.query(params, page);
        BeanUtil.setCollFieldValues(page.getRows());
        return page;
    }
    
    @RequestMapping({"recomExpert/add", "recomExpert/update"})
    @ResponseBody
    public OpResult save(RecomExpert c)
    {
        RecomExpert dbo = this.recomExpertService.findByExpertId(c.getExpertId());
        boolean add = StringUtils.isBlank(c.getId());
        if (add)
        {
            if (dbo != null)
            {
                return OpResult.addError("该专家已存在，不能重复加推荐，请进行修改！", c);
            }
            this.recomExpertService.add(c);
            return OpResult.addOk(c);
        }
        else
        {
            if (dbo != null && !dbo.getId().equals(c.getId()))
            {
                return OpResult.updateError("该专家已存在，不能重复加推荐，请修改！", c);
            }
            BeanUtil.copyPropertiesIgnoreNull(c, dbo);
            return OpResult.updateOk(this.recomExpertService.update(dbo));
        }
    }
    
    @RequestMapping("recomExpert/delete")
    @ResponseBody
    public OpResult delete(String[] id)
    {
        this.recomExpertService.delete(RecomExpert.class, id);
        return OpResult.deleteOk();
    }
}
