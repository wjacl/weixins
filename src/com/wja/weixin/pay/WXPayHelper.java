package com.wja.weixin.pay;

import java.util.Map;

import com.github.wxpay.sdk.WXPay;
import com.github.wxpay.sdk.WXPayConfigImpl;
import com.github.wxpay.sdk.WXPayConstants;
import com.wja.base.util.Log;

public class WXPayHelper
{
    private static WXPay wxpay;
    
    static {
        try{
            wxpay = new WXPay(WXPayConfigImpl.getInstance());
        }catch(Exception e){
            Log.error("初始化微信支付异常！", e);
        }
        Log.info("******************* 初始化微信支付完成。");
    }
    
    private static void checkWXPayInited() throws Exception {
        if(wxpay == null){
            throw new Exception("微信支付初始化未成功，不可调用");
        }
    }
    
    public static Map<String, String> doUnifiedOrder(Map<String, String> data) throws Exception {
        checkWXPayInited();       
        Map<String, String> r = wxpay.unifiedOrder(data);
        String RETURN_CODE = "return_code";
        if (r.get(RETURN_CODE).equals(WXPayConstants.FAIL)) {
            Log.error("微信支付通信异常: " + r);
            throw new Exception("微信支付通信异常，" + r.get("return_msg"));
        }
        
        if(r.get("result_code").equals(WXPayConstants.FAIL)){
            Log.error("微信支付异常：" + r);
            throw new Exception("微信支付异常[" + r.get("err_code_des") + " " + r.get("err_code_des") + "]");
        }
        
        return r;
    }
}
