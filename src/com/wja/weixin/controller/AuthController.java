package com.wja.weixin.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.common.service.SmsService;
import com.wja.base.system.entity.Dict;
import com.wja.base.system.service.DictService;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.Log;
import com.wja.base.util.Page;
import com.wja.base.util.StringUtil;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.common.WXContants;
import com.wja.weixin.entity.Account;
import com.wja.weixin.entity.AuditRecord;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.Message;
import com.wja.weixin.entity.TradeRecord;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.MessageService;
import com.wja.weixin.service.TradeService;

@Controller
@RequestMapping("/wx/web/auth")
public class AuthController
{
    @Autowired
    private FollwerInfoService follwerInfoService;
    
    @Autowired
    private SmsService smsService;
    
    @Autowired
    private DictService ds;
    
    @Autowired
    private TradeService tradeService;
    
    @Autowired
    private MessageService messageService;
    
    @RequestMapping("auth")
    public String auth(Model model){
        String openId = RequestThreadLocal.openId.get();
        FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, openId);
        if(fi == null){
            return "redirect:to/category";
        }
        switch(fi.getStatus()){
            case FollwerInfo.STATUS_NEED_EDIT:
                return "redirect:to/category";
            case FollwerInfo.STATUS_CATEGORY_OK:
                return "redirect:to/info";
            case FollwerInfo.STATUS_INFO_OK:
                return "redirect:to/intro";
            case FollwerInfo.STATUS_INTRO_OK:
                return "redirect:to/brand";
            case FollwerInfo.STATUS_BRAND_OK:
                return "redirect:to/payment";
            case FollwerInfo.STATUS_CERT_OK: 
                return "weixin/auth/submit";
            case FollwerInfo.STATUS_AUDIT_NOT_PASS:
                //查询审批意见
                model.addAttribute("ads", this.follwerInfoService.queryAuditRecord(openId));
        }
        model.addAttribute("fi", fi);
        return "weixin/auth/view";
    }
    
    @RequestMapping("submitAudit")
    public String submitAudit(){
        String openId = RequestThreadLocal.openId.get();
        FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, openId);
        fi.setStatus(FollwerInfo.STATUS_NEED_AUDIT);
        this.follwerInfoService.update(fi);
        
        //发送通知消息
        Message m = new Message();
        m.setTitle("认证待审核");
        m.setContent(fi.getName());
        m.setPubId(openId);
        m.setMtype(Message.Mtype.AUDIT);
        m.setTrange(Message.Range.GR);
        m.setToIds(AppContext.getSysParam(WXContants.SysParam.AUDIT_ID));
        
        this.messageService.saveMessage(m);
        
        return "redirect:to/over";
    }
    
    @RequestMapping("to/{page}")
    public String to(Model model, @PathVariable("page") String page)
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
        
        // 去保证金支付
        if ("payment".equals(page))
        {

            List<Dict> list = this.ds.getByPid(WXContants.Dict.PID_BZJ_STANDARD);
            BigDecimal bzjs = null;
            for (Dict d : list)
            {
                model.addAttribute(d.getId(), d.getValue());
                if (("bzjs" + fi.getCategory()).equals(d.getId()))
                {
                    model.addAttribute("currBzj", d.getValue());
                    bzjs = new BigDecimal(d.getValue());
                }
            }
            // 判断是否已交足保证金
            Account a = this.tradeService.getAccount(openId);
            if (bzjs.compareTo(new BigDecimal(0))  == 1 && (a == null || a.getBzj() == null || a.getBzj().compareTo(bzjs) == -1))
            {
                if(a != null && a.getBzj() != null){
                    model.addAttribute("bzjce", bzjs.subtract(a.getBzj()));
                }
                model.addAttribute("bzjyj", (a == null || a.getBzj() == null) ? 0 : a.getBzj());
            }
            else
            {
                page = "submit";
            }
        }
        
        return "weixin/auth/" + page;
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
            
            return OpResult.ok().setData(this.smsService.getAuthTimeoutMinute());
        }
        
        return OpResult.error("验证码发送失败，请检查手机号是否正确，然后重试!", null);
    }
    
    @RequestMapping("checkVcode")
    @ResponseBody
    public Object checkPhoneNumber(String phoneNumbers, String vcode, HttpSession session)
    {
        if (StringUtils.isBlank(phoneNumbers) || StringUtils.isBlank(vcode))
        {
            return OpResult.error("请输入手机号和验证码", null);
        }
        
        String phoneAuthNumbers = (String)session.getAttribute("phoneAuthNumbers");
        String phoneAuthCode = (String)session.getAttribute("phoneAuthCode");
        Long startTime = (Long)session.getAttribute("phoneAuthStartTime");
        
        if (StringUtils.isBlank(phoneAuthNumbers) || StringUtils.isBlank(phoneAuthCode) || startTime == null)
        {
            return OpResult.error("请先获取验证码！", null);
        }
        
        if (System.currentTimeMillis() - startTime > Long.parseLong(this.smsService.getAuthTimeoutMinute()) * 60 * 1000)
        {
            return OpResult.error("请重新获取验证码", "again");
        }
        
        if (phoneAuthNumbers.equals(phoneNumbers) && phoneAuthCode.equals(vcode))
        {
            return OpResult.ok();
        }
        else
        {
            return OpResult.error("验证码错误，请重新输入！如还是不正确，请重新获取验证码！", "reinput");
        }
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
    
    @RequestMapping("saveInfo")
    public String saveInfo(FollwerInfo fi)
    {
        fi.setStatus(FollwerInfo.STATUS_INFO_OK);
        this.doSave(fi);
        return "redirect:to/intro";
    }
    
    @RequestMapping("saveIntro")
    public String saveIntro(FollwerInfo fi)
    {
        fi.setStatus(FollwerInfo.STATUS_INFO_OK);
        this.doSave(fi);
        return "redirect:to/brand";
    }
    
    @RequestMapping("saveBrand")
    public String saveBrand(FollwerInfo fi, String saveType)
    {
        fi.setStatus(FollwerInfo.STATUS_BRAND_OK);
        if ("zancun".equals(saveType))
        {
            fi.setStatus(FollwerInfo.STATUS_INTRO_OK);
        }
        this.doSave(fi);
        return "redirect:auth";
    }
    
    private void doSave(FollwerInfo fi)
    {
        FollwerInfo dfi = this.follwerInfoService.get(FollwerInfo.class, fi.getOpenId());
        BeanUtil.copyPropertiesIgnoreNull(fi, dfi);
        dfi.setPinyin(StringUtil.getPinYinHeadChar(dfi.getName()));
        this.follwerInfoService.update(dfi);
    }
    
    @RequestMapping("bzjPay")
    @ResponseBody
    public Object bzjPay(BigDecimal amount, HttpServletRequest req)
    {
        /*String openId = RequestThreadLocal.openId.get();
        FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, openId);
        Dict dt = this.ds.get(Dict.class, "bzjs" + fi.getCategory());
        if (!dt.getValue().equals(amount.toPlainString()))
        {
            return OpResult.error("amountError", null);
        }*/
        if(amount == null || amount.compareTo(new BigDecimal(0)) != 1){
            return OpResult.error("支付金额不正确", null);
        }
        
        try
        {
            return OpResult.ok().setData(this.tradeService.generateJsPayParam(req.getRemoteAddr(),
                amount,
                TradeRecord.BusiType.BZJ,
                AppContext.getSysParam("bzj.pay.body"),
                null));
        }
        catch (Exception e)
        {
            Log.LOGGER.error("调用微信接口生成订单异常", e);
            return OpResult.error("调用微信接口生成订单异常", e.getMessage());
        }
    }
    
    @RequestMapping("bzjPayOk")
    public String bjzPayOk()
    {
        String openId = RequestThreadLocal.openId.get();
        FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, openId);
        List<Dict> list = this.ds.getByPid(WXContants.Dict.PID_BZJ_STANDARD);
        BigDecimal bzjs = null;
        for (Dict d : list)
        {
            if (("bzjs" + fi.getCategory()).equals(d.getId()))
            {
                bzjs = new BigDecimal(d.getValue());
                break;
            }
        }
        
        Account a = this.tradeService.getAccount(openId);
        if (a != null && a.getBzj() != null && a.getBzj().compareTo(bzjs) != -1)
        {
            fi.setStatus(FollwerInfo.STATUS_CERT_OK);
            this.follwerInfoService.update(fi);
            return "redirect:auth";
        }
        else
        {
            return "redirect:to/payment";
        }
    }
    
    @RequestMapping("auditList")
    public String toAuditList(){
        if(this.hasAuditPrivilege()){
            return "weixin/auth/audit_list";
        }
        else{
            return "weixin/no_autho";   //无权浏览
        }
    }
    
    @RequestMapping("queryAuditList")
    @ResponseBody
    public Object queryNeedAuditList(@RequestParam Map<String, Object> params, Page<FollwerInfo> page){
        if(this.hasAuditPrivilege()){
            params.put("status_eq_intt", FollwerInfo.STATUS_NEED_AUDIT);
            return this.follwerInfoService.query(params, page);
        }
        else {
            return null;
        }
    }
    
    @RequestMapping("toAudit")
    public String toAudit(String id,Model model){
        if(this.hasAuditPrivilege()){
            FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, id);
            if(fi.getStatus() == FollwerInfo.STATUS_AUDIT_PASS || fi.getStatus() == FollwerInfo.STATUS_AUDIT_NOT_PASS){
                return "weixin/auth/audited";
            }
            else if(fi.getStatus() != FollwerInfo.STATUS_NEED_AUDIT){
                return "weixin/auth/editing";
            }
            model.addAttribute("fi", fi);
            return "weixin/auth/audit";
        }
        else{
            return "weixin/no_autho";   //无权浏览
        }
    }
    
    @RequestMapping("audit")
    @ResponseBody
    public Object queryNeedAuditList(AuditRecord r){
        if(this.hasAuditPrivilege()){
            String openId = RequestThreadLocal.openId.get();
            r.setAid(openId);
            this.follwerInfoService.saveAudit(r);
            return OpResult.ok();
        }
        else {
            return OpResult.error("无权操作!", null);
        }
    }
    
    private boolean hasAuditPrivilege(){
        String openId = RequestThreadLocal.openId.get();
        String auditIds = AppContext.getSysParam(WXContants.SysParam.AUDIT_ID);
        if(StringUtils.isBlank(openId) || StringUtils.isBlank(auditIds)){
            return false;
        }
        else {
            String[] ids = auditIds.split(";");
            for(String id : ids){
                if(id.equals(openId)){
                    return true;
                }
            }
        }
        
        return false;
    }
}
