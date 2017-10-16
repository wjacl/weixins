package com.wja.base.common.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.wja.base.util.Log;

@Service
public class SmsService
{
    // 产品名称:云通信短信API产品,开发者无需替换
    static final String product = "Dysmsapi";
    
    // 产品域名,开发者无需替换
    static final String domain = "dysmsapi.aliyuncs.com";
    
    @Value("${sms.access.key.id}")
    private String accessKeyId;
    
    @Value("${sms.access.key.secret}")
    private String accessKeySecret;
    
    @Value("${sms.signName}")
    private String signName;
    
    @Value("${sms.auth.template.code}")
    private String authTemplateCode;
    
    @Value("${sms.auth.timeout.minute}")
    private String authTimeoutMinute;
    
    public String getAuthTimeoutMinute()
    {
        return authTimeoutMinute;
    }
    
    private Random random = new Random();
    
    /**
     * 
     * 手机号验证的短信验证码发送方法。发送成功后将返回验证码，如发送不成功则返回null
     * 
     * @param phoneNumbers 手机号
     * @return String 发送成功后将返回验证码，如发送不成功则返回null
     */
    public String sendPhoneNumberAuthSms(String phoneNumbers)
    {
        int code = random.nextInt(10000);
        String templateParam = "{\"code\":\"" + code + "\"}";
        try
        {
            SendSmsResponse sendSmsResponse =
                this.sendSms(phoneNumbers, signName, authTemplateCode, templateParam, null);
            if (sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK"))
            {
                return code + "";
            }
            else
            {
                Log.LOGGER.error(
                    "发送验证码短信失败，返回信息：code=" + sendSmsResponse.getCode() + " message=" + sendSmsResponse.getMessage());
                return null;
            }
        }
        catch (Exception e)
        {
            Log.LOGGER.error("发送验证码短信异常", e);
            return null;
        }
    }
    
    public SendSmsResponse sendSms(String phoneNumbers, String signName, String templateCode, String templateParam,
        String outId)
            throws Exception
    {
        
        // 可自助调整超时时间
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");
        
        // 初始化acsClient,暂不支持region化
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
        DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
        IAcsClient acsClient = new DefaultAcsClient(profile);
        
        // 组装请求对象-具体描述见控制台-文档部分内容
        SendSmsRequest request = new SendSmsRequest();
        // 必填:待发送手机号
        request.setPhoneNumbers(phoneNumbers);
        // 必填:短信签名-可在短信控制台中找到
        request.setSignName(signName);
        // 必填:短信模板-可在短信控制台中找到
        request.setTemplateCode(templateCode);
        // 可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        request.setTemplateParam(templateParam);
        
        // 选填-上行短信扩展码(无特殊需求用户请忽略此字段)
        // request.setSmsUpExtendCode("90997");
        
        // 可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
        request.setOutId(outId);
        
        // hint 此处可能会抛出异常，注意catch
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
        
        return sendSmsResponse;
    }
}
