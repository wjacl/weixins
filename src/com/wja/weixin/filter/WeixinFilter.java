package com.wja.weixin.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.sword.wechat4j.oauth.OAuthException;
import org.sword.wechat4j.oauth.OAuthManager;
import org.sword.wechat4j.oauth.protocol.get_access_token.GetAccessTokenRequest;
import org.sword.wechat4j.oauth.protocol.get_access_token.GetAccessTokenResponse;

import com.wja.base.util.Log;
import com.wja.base.web.RequestThreadLocal;

/**
 * Servlet Filter implementation class WeixinFilter
 */
public class WeixinFilter implements Filter
{
    
    /**
     * Default constructor.
     */
    public WeixinFilter()
    {
        // TODO Auto-generated constructor stub
    }
    
    /**
     * @see Filter#destroy()
     */
    @Override
    public void destroy()
    {
        // TODO Auto-generated method stub
    }
    
    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
        throws IOException, ServletException
    {
        HttpServletRequest request = (HttpServletRequest)req;
        HttpServletResponse response = (HttpServletResponse)resp;
        String openId = (String)request.getSession().getAttribute("openId");
        
        if(openId == null) {
            openId = request.getParameter("openId");
            request.getSession().setAttribute("openId", openId);
        }
        if (openId != null)
        {
            RequestThreadLocal.openId.set(openId);
            chain.doFilter(request, response);
        }
        else
        {
            String code = request.getParameter("code");
            String state = request.getParameter("state");
            if (StringUtils.isNotBlank(code) && "aa".equals(state))
            {
                try
                {
                    GetAccessTokenResponse tr = OAuthManager.getAccessToken(new GetAccessTokenRequest(code));
                    openId = tr.getOpenid();
                    request.getSession().setAttribute("openId", openId);
                    RequestThreadLocal.openId.set(openId);
                    chain.doFilter(request, response);
                }
                catch (OAuthException e)
                {
                    Log.LOGGER.error("网页获取用户的openId异常!", e);
                    request.getRequestDispatcher("/error.jsp").forward(req, resp);
                }
                
            }
            else
            {
                StringBuffer reqUrl = request.getRequestURL();
                String reqStr = request.getQueryString();
                if (StringUtils.isNotBlank(reqStr))
                {
                    reqUrl.append("?" + reqStr);
                }
                String redUrl = OAuthManager.generateRedirectURI(reqUrl.toString(), "snsapi_base", "aa");
                Log.LOGGER.info(redUrl);
                response.sendRedirect(redUrl);
            }
        }   
    }
    
    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig fConfig)
        throws ServletException
    {
        // TODO Auto-generated method stub
    }
    
}
