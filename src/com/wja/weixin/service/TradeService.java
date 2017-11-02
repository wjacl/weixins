package com.wja.weixin.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.sword.wechat4j.pay.H5PayParam;
import org.sword.wechat4j.pay.PayManager;
import org.sword.wechat4j.pay.protocol.unifiedorder.UnifiedorderRequest;
import org.sword.wechat4j.pay.protocol.unifiedorder.UnifiedorderResponse;
import org.sword.wechat4j.util.RandomStringGenerator;

import com.wja.base.util.BeanUtil;
import com.wja.base.util.IDGenerater;
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
        request.setOut_trade_no(IDGenerater.getAnYMDHMSid());
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
        wtr.setPrepay_id(response.getPrepay_id());
        this.wxtrDao.save(wtr);
        return param;
    }
    
    public Account getAccount(String openId)
    {
        return this.accountDao.findOne(openId);
    }
    
    public void saveBaoZhengJinAdd(String openId, BigDecimal amount)
    {
        if (amount == null || StringUtils.isBlank(openId))
        {
            return;
        }
        
        Account account = this.getAccount(openId);
        TradeRecord tr = new TradeRecord();
        tr.setAmount(amount);
        tr.setOpenId(openId);
        tr.setBusiType(TradeRecord.BusiType.BZJ);
        tr.setIoType(TradeRecord.IOType.IN);
        tr.setInfo("保证金支付");
        
        this.tradeRecordDao.save(tr);
        
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
}
