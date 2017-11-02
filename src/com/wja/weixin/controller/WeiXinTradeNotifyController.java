package com.wja.weixin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.sword.wechat4j.pay.PayManager;
import org.sword.wechat4j.pay.exception.PayApiException;
import org.sword.wechat4j.pay.exception.PayBusinessException;
import org.sword.wechat4j.pay.exception.SignatureException;
import org.sword.wechat4j.pay.protocol.pay_result_notify.PayResultNotifyResponse;

import com.wja.base.util.Log;
import com.wja.weixin.service.TradeService;

@Controller
public class WeiXinTradeNotifyController
{
    @Autowired
    private TradeService tradeService;
    
    @RequestMapping("/wx/comm/trade/notify")
    public void reciveNotify(HttpServletRequest request, HttpServletResponse response)
    {
        try
        {
            PayResultNotifyResponse prs = PayManager.parsePayResultNotify(request, response);
        }
        catch (SignatureException | PayApiException | PayBusinessException e)
        {
            Log.LOGGER.error("接收微信的交易通知异常! ", e);
        }
    }
}
