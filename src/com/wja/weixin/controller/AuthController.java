package com.wja.weixin.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.common.service.SmsService;
import com.wja.base.util.BeanUtil;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.service.FollwerInfoService;

@Controller
@RequestMapping("/wx/web/auth")
public class AuthController
{
    @Autowired
    private FollwerInfoService follwerInfoService;
    
    @Autowired
    private SmsService smsService;
    
    @RequestMapping(value = {"auth", "toCategory"})
    public String auth(Model model)
    {
        String openId = RequestThreadLocal.openId.get();
        
        // 获得用户的category
        FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, openId);
        if (fi == null)
        {
            fi = new FollwerInfo();
            fi.setOpenId(openId);
        }
        model.addAttribute("fi", fi);
        
        return "weixin/auth/auth1";
    }
    
    @RequestMapping("phoneAuth")
    @ResponseBody
    public Object sendPhoneNumbersAuthCode(String phoneNumbers, HttpSession session)
    {
        String code = this.smsService.sendPhoneNumberAuthSms(phoneNumbers);
        if (code != null)
        {
            session.setAttribute("phoneAuthCode", code);
            session.setAttribute("phoneAuthNumbers", phoneNumbers);
            session.setAttribute("phoneAuthStartTime", System.currentTimeMillis());
            
            return OpResult.ok();
        }
        
        return OpResult.error("验证码发送失败，请检查手机号是否正确，然后重试!", null);
    }
    
    @RequestMapping("saveCategory")
    @ResponseBody
    public Object saveCategory(String openId, String category)
    {
        // 保存用户的经营类别
        if (StringUtils.isNotBlank(openId) && StringUtils.isNotBlank(category))
        {
            // 获得用户的category
            FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, openId);
            if (fi == null)
            {
                fi = new FollwerInfo();
                fi.setOpenId(openId);
                fi.setCategory(category);
                fi.setStatus(FollwerInfo.STATUS_CATEGORY_OK);
                this.follwerInfoService.add(fi);
            }
            else
            {
                if (!fi.getCategory().equals(category))
                {
                    fi.setCategory(category);
                    this.follwerInfoService.update(fi);
                }
            }
            
            return OpResult.ok();
        }
        
        return OpResult.error("param invalid", null);
    }
    
    @RequestMapping("toInfo")
    public String toInfo(String openId, Model model)
    {
        // 获得用户的category
        FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, openId);
        model.addAttribute("fi", fi);
        
        // 跳转到对应的信息填写页
        return "weixin/auth/info";
    }
    
    @RequestMapping("saveInfo")
    public String saveInfo(FollwerInfo fi, HttpSession session)
    {
        FollwerInfo dfi = this.follwerInfoService.get(FollwerInfo.class, fi.getOpenId());
        
        BeanUtil.copyPropertiesIgnoreNull(fi, dfi);
        this.follwerInfoService.update(dfi);
        return "redirect:setBrand";
    }
    
    @RequestMapping("setBrand")
    public String setBrand()
    {
        // 跳转到对应的信息填写页
        return "weixin/auth/brand";
    }
    
    @RequestMapping("saveBrand")
    public String saveBrand(FollwerInfo fi)
    {
        FollwerInfo dfi = this.follwerInfoService.get(FollwerInfo.class, fi.getOpenId());
        BeanUtil.copyPropertiesIgnoreNull(fi, dfi);
        this.follwerInfoService.update(dfi);
        return "redirect:toPayment";
    }
    
    @RequestMapping("toPayment")
    public String toPayment(FollwerInfo fi)
    {
        return "weixin/auth/payment";
    }
    
}
