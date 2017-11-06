package com.wja.weixin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.sword.wechat4j.pay.PayCode;
import org.sword.wechat4j.pay.PayManager;
import org.sword.wechat4j.pay.exception.PayApiException;
import org.sword.wechat4j.pay.exception.PayBusinessException;
import org.sword.wechat4j.pay.exception.SignatureException;
import org.sword.wechat4j.pay.protocol.orderquery.OrderqueryRequest;
import org.sword.wechat4j.pay.protocol.orderquery.OrderqueryResponse;
import org.sword.wechat4j.pay.protocol.pay_result_notify.PayResultNotifyResponse;
import org.sword.wechat4j.util.RandomStringGenerator;

import com.wja.base.common.OpResult;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.Log;
import com.wja.weixin.entity.WeiXinTradeRecord;
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
            this.tradeService.saveWeiXinTradeNotify(prs);
        }
        catch (SignatureException | PayApiException | PayBusinessException e)
        {
            Log.LOGGER.error("接收微信的交易通知异常! ", e);
            // 短信通知
        }
    }
    
    @RequestMapping("/wx/web/trade/check")
    @ResponseBody
    public Object checkTradeResult(String prepay_id)
    {
        if (StringUtils.isNotBlank(prepay_id))
        {
            WeiXinTradeRecord r = this.tradeService.getWeiXinTradeRecordByPrepayId(prepay_id);
            if (r != null)
            {
                if (StringUtils.isNotBlank(r.getTransaction_id()))
                {
                    return OpResult.ok();
                }
                else
                {
                    // 查询订单
                    OrderqueryRequest qr = new OrderqueryRequest();
                    qr.setOut_trade_no(r.getOut_trade_no());
                    qr.setNonce_str(RandomStringGenerator.generate());
                    try
                    {
                        OrderqueryResponse res = PayManager.orderquery(qr);
                        if (PayCode.SUCCESS.equals(res.getTrade_state()))
                        {
                            PayResultNotifyResponse prs = new PayResultNotifyResponse();
                            BeanUtil.copyPropertiesIgnoreNull(res, prs);
                            this.tradeService.saveWeiXinTradeNotify(prs);
                            return OpResult.ok();
                        }
                        else
                        {
                            return OpResult.error("支付为完成", res.getTrade_state());
                        }
                    }
                    catch (SignatureException | PayApiException | PayBusinessException e)
                    {
                        Log.LOGGER.error("查询微信支付订单[out_trade_no=" + r.getOut_trade_no() + "]异常! ", e);
                        return OpResult.error("查询微信支付订单异常", null);
                    }
                }
            }
        }
        
        return OpResult.error("订单号不存在", null);
    }
}
