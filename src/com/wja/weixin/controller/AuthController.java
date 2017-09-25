package com.wja.weixin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.sword.wechat4j.oauth.OAuthException;
import org.sword.wechat4j.oauth.OAuthManager;
import org.sword.wechat4j.oauth.protocol.get_access_token.GetAccessTokenRequest;
import org.sword.wechat4j.oauth.protocol.get_access_token.GetAccessTokenResponse;

import com.wja.base.util.Log;

@Controller
@RequestMapping("/weixin/my")
public class AuthController
{
    
    @RequestMapping("auth")
    public String auth(HttpServletRequest request, HttpSession session, String code)
    {
        String openId = (String)session.getAttribute("openId");
        
        if (StringUtils.isBlank(openId))
        {
            if (StringUtils.isBlank(code))
            {
                String redUrl = OAuthManager.generateRedirectURI(request.getScheme() + "://" + request.getServerName()
                    + request.getContextPath() + "/weixin/my/auth", "snsapi_base", "aa");
                Log.LOGGER.info(redUrl);
                return "redirect:" + redUrl;
            }
            else
            {
                try
                {
                    GetAccessTokenResponse tr = OAuthManager.getAccessToken(new GetAccessTokenRequest(code));
                    openId = tr.getOpenid();
                    session.setAttribute("openId", openId);
                }
                catch (OAuthException e)
                {
                    Log.LOGGER.error("网页获取用户的openId异常!", e);
                    return "weixin/error";
                }
            }
        }
        return "weixin/auth1";
    }
}
