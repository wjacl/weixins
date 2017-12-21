package com.wja.weixin.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.sword.wechat4j.common.Config;
import org.sword.wechat4j.pay.protocol.pay_result_notify.PayResultNotifyResponse;

import com.github.wxpay.sdk.WXPayConstants;
import com.github.wxpay.sdk.WXPayUtil;
import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.IDService;
import com.wja.base.util.Log;
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.dao.AccountDao;
import com.wja.weixin.dao.TradeRecordDao;
import com.wja.weixin.dao.WeiXinTradeRecordDao;
import com.wja.weixin.entity.Account;
import com.wja.weixin.entity.TradeRecord;
import com.wja.weixin.entity.WeiXinTradeRecord;
import com.wja.weixin.pay.WXPayHelper;

@Service
public class TradeService
{
    @Autowired
    private AccountDao accountDao;
    
    @Autowired
    private TradeRecordDao tradeRecordDao;
    
    @Autowired
    private WeiXinTradeRecordDao wxtrDao;
    
    @Autowired
    private IDService idService;
    
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
    
    /**
     * 扣费
     * 
     * @param openId
     * @param amount
     * @param info
     * @return
     * @see [类、类#方法、类#成员]
     */
    public boolean saveKouFei(String openId, BigDecimal amount, String info)
    {
        Account a = this.getAccount(openId);
        if (a == null || a.getBalance().compareTo(amount) == -1)
        {
            return false;
        }
        
        TradeRecord tr = new TradeRecord();
        tr.setBusiType(TradeRecord.BusiType.XF);
        tr.setIoType(TradeRecord.IOType.OUT);
        tr.setOpenId(openId);
        tr.setAmount(amount);
        tr.setInfo(info);
        
        this.tradeRecordDao.save(tr);
        this.accountDao.balanceSub(amount, openId);
        
        return true;
    }
    
    public Page<TradeRecord> tradePageQuery(Map<String, Object> params, Page<TradeRecord> page)
    {
        return page.setPageData(
            this.tradeRecordDao.findAll(new CommSpecification<TradeRecord>(params), page.getPageRequest()));
    }
    
    public List<?> queryMonthTongji(String openId, Date smonth, Date emonth)
    {
        return this.tradeRecordDao.queryMonthTongJi(openId, smonth, emonth);
    }
    
    /*
     * public int queryAfterCount(String openId, Date month) { return this.tradeRecordDao.queryAfterCount(openId,
     * month); }
     */
    
    /**
     * 
     * 获得一个新的统一下单请求对象
     * 
     * @param userIp
     * @param amount
     * @param body
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Map<String, String> getAnUnifiedorderRequest(String userIp, BigDecimal amount, String attach, String body,
        String detail)
    {

        HashMap<String, String> data = new HashMap<String, String>();
        data.put("body", body);
        if(detail != null){
            data.put("detail", detail);
        }
        data.put("attach", attach);
        data.put("out_trade_no", idService.getAnYMDHMSid());
        data.put("fee_type", "CNY");
        data.put("total_fee", amount.multiply(new BigDecimal(100)).intValue() + "");
        data.put("spbill_create_ip", userIp);
        data.put("notify_url", AppContext.getSysParam("wx.pay.notify_url"));
        data.put("trade_type", "JSAPI");
        data.put("openid", RequestThreadLocal.openId.get());
        data.put("time_start", this.sdf.format(new Date()));

        return data;
    }
    
    public  Map<String, String> generateJsPayParam(String userIp, BigDecimal amount, String attach, String body, String detail, String timeStamp,String nonceStr)
        throws Exception
    {
        // 生成交易数据
        Map<String, String> request = this.getAnUnifiedorderRequest(userIp, amount, attach, body, detail);
        Map<String, String> response = WXPayHelper.doUnifiedOrder(request);
        
        String prepayid = response.get("prepay_id");
        /*H5PayParam param = PayManager.buildH5PayConfig(System.currentTimeMillis() / 1000 + "",
            request.get("nonce_str"),prepayid);*/
        
        // 保存微信交易订单数据
        WeiXinTradeRecord wtr = new WeiXinTradeRecord();
        wtr.setAttach(request.get("attach"));
        wtr.setOpenid(request.get("openid"));
        wtr.setOut_trade_no(request.get("out_trade_no"));
        wtr.setTime_start(request.get("time_start"));
        wtr.setTotal_fee(Integer.parseInt(request.get("total_fee")));
        wtr.setPrepayId(prepayid);
        this.wxtrDao.save(wtr);
        //return param;

        /*
         appId, timeStamp, nonceStr, package, signType
         */
        Map<String, String> hparam = new HashMap<>();
        hparam.put("appId", Config.instance().getAppid());
        hparam.put("timeStamp", System.currentTimeMillis() / 1000 + "");
        hparam.put("nonceStr", WXPayUtil.generateNonceStr());
        hparam.put("package", "prepay_id=" + prepayid);
        hparam.put("signType", WXPayConstants.MD5);
        //hparam.put("paySign", WXPayUtil.generateMD5Signature(hparam));
        hparam.put("paySign", WXPayUtil.generateSignature(hparam, Config.instance().getMchKey()));
        Log.info(hparam.toString());
        return hparam;
    }
    
    public WeiXinTradeRecord getWeiXinTradeRecordByPrepayId(String prepayId)
    {
        return this.wxtrDao.findByPrepayId(prepayId);
    }
    
    /**
     * 
     * 处理微信交易通知
     * 
     * @param prs
     * @see [类、类#方法、类#成员]
     */
    public void saveWeiXinTradeNotify(PayResultNotifyResponse prs)
    {
        synchronized (this.getClass())
        {
            // 判断是否已处理
            WeiXinTradeRecord r = this.getWeiXinTradeRecord(prs.getOut_trade_no());
            
            if (r != null)
            {
                if (r.getTransaction_id() == null)
                { // 第一次收到
                    if (r.getTotal_fee() != prs.getTotal_fee())
                    {
                        // 通知的金额不对
                        Log.LOGGER.error("收到的微信交易通知的金额不对：" + prs.toString() + "。系统中的值为：" + r.getTotal_fee());
                        // 短信通知平台维护人员
                        
                    }
                    else
                    {
                        r.setTransaction_id(prs.getTransaction_id());
                        r.setTime_end(prs.getTime_end());
                        r.setOpenid(prs.getOpenid());
                        this.wxtrDao.save(r);
                        TradeRecord tr = new TradeRecord();
                        tr.setId(r.getOut_trade_no());
                        tr.setOpenId(r.getOpenid());
                        tr.setBusiType(r.getAttach());
                        tr.setIoType(TradeRecord.IOType.IN);
                        tr.setAmount(new BigDecimal(r.getTotal_fee() / 100.00));
                        switch (r.getAttach())
                        {
                            case TradeRecord.BusiType.BZJ:
                                tr.setInfo(AppContext.getSysParam("bzj.pay.body"));
                                this.saveBaoZhengJinAdd(tr.getOpenId(), tr.getAmount());
                                break;
                            case TradeRecord.BusiType.CZ:
                                tr.setInfo(AppContext.getSysParam("cz.pay.body"));
                                this.saveChongZhi(tr.getOpenId(), tr.getAmount());
                                break;
                        }
                        
                        this.tradeRecordDao.save(tr);
                    }
                }
            }
            else
            {
                Log.LOGGER.error("收到不存在的微信交易通知：" + prs.toString());
            }
            
        }
        
    }
    
    private void saveBaoZhengJinAdd(String openId, BigDecimal amount)
    {
        if (amount == null || StringUtils.isBlank(openId))
        {
            return;
        }
        
        Account account = this.getAccount(openId);
        
        if (account == null)
        {
            account = new Account();
            account.setBalance(new BigDecimal(0));
            account.setBzj(amount);
            account.setOpenId(openId);
            this.accountDao.save(account);
        }
        else
        {
            this.accountDao.bzjAdd(amount, openId);
        }
    }
    
    private void saveChongZhi(String openId, BigDecimal amount)
    {
        if (amount == null || StringUtils.isBlank(openId))
        {
            return;
        }
        
        Account account = this.getAccount(openId);
        
        if (account == null)
        {
            account = new Account();
            account.setBalance(amount);
            account.setBzj(new BigDecimal(0));
            account.setOpenId(openId);
            this.accountDao.save(account);
        }
        else
        {
            this.accountDao.balanceAdd(amount, openId);
        }
    }
    
    public WeiXinTradeRecord getWeiXinTradeRecord(String id)
    {
        return this.wxtrDao.findOne(id);
    }
    
    public void saveWeiXinTradeTecord(WeiXinTradeRecord r)
    {
        this.wxtrDao.save(r);
    }
    
    public Account getAccount(String openId)
    {
        return this.accountDao.findOne(openId);
    }
}
