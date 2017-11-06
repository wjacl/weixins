package com.wja.weixin.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.sword.wechat4j.pay.H5PayParam;
import org.sword.wechat4j.pay.PayManager;
import org.sword.wechat4j.pay.protocol.pay_result_notify.PayResultNotifyResponse;
import org.sword.wechat4j.pay.protocol.unifiedorder.UnifiedorderRequest;
import org.sword.wechat4j.pay.protocol.unifiedorder.UnifiedorderResponse;
import org.sword.wechat4j.util.RandomStringGenerator;

import com.wja.base.common.service.IDService;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.Log;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.dao.AccountDao;
import com.wja.weixin.dao.TradeRecordDao;
import com.wja.weixin.dao.WeiXinTradeRecordDao;
import com.wja.weixin.entity.Account;
import com.wja.weixin.entity.TradeRecord;
import com.wja.weixin.entity.WeiXinTradeRecord;

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
     * 
     * 获得一个新的统一下单请求对象
     * 
     * @param userIp
     * @param amount
     * @param body
     * @return
     * @see [类、类#方法、类#成员]
     */
    public UnifiedorderRequest getAnUnifiedorderRequest(String userIp, BigDecimal amount, String attach, String body,
        String detail)
    {
        UnifiedorderRequest request = new UnifiedorderRequest();
        request.setNonce_str(RandomStringGenerator.generate());
        request.setBody(body);
        request.setDetail(detail);
        request.setAttach(attach);
        request.setOut_trade_no(idService.getAnYMDHMSid());
        request.setTotal_fee(amount.multiply(new BigDecimal(100)).intValue());
        request.setSpbill_create_ip(userIp);
        request.setNotify_url(AppContext.getSysParam("wx.pay.notify_url"));
        request.setTime_start(this.sdf.format(new Date()));
        request.setOpenid(RequestThreadLocal.openId.get());
        return request;
    }
    
    public H5PayParam generateJsPayParam(String userIp, BigDecimal amount, String attach, String body, String detail)
        throws Exception
    {
        // 生成交易数据
        UnifiedorderRequest request = this.getAnUnifiedorderRequest(userIp, amount, attach, body, detail);
        UnifiedorderResponse response = PayManager.unifiedorder(request);
        H5PayParam param = PayManager.buildH5PayConfig(System.currentTimeMillis() / 1000 + "",
            request.getNonce_str(),
            response.getPrepay_id());
        // 保存微信交易订单数据
        WeiXinTradeRecord wtr = new WeiXinTradeRecord();
        BeanUtil.copyPropertiesIgnoreNull(request, wtr);
        wtr.setPrepayId(response.getPrepay_id());
        this.wxtrDao.save(wtr);
        return param;
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
