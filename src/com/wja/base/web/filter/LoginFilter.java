package com.wja.base.web.filter;

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

import com.wja.base.common.CommConstants;

/**
 * 登录认证过滤器，判断用户是否已登录
 */
public class LoginFilter implements Filter
{
    private static final String XHR_OBJECT_NAME = "XMLHttpRequest";
    
    private static final String HEADER_REQUEST_WITH = "x-requested-with";
    
    String loginPageUri = "/login";
    
    String loginUri = "/login";
    
    /**
     * 排除的地址模式
     */
    String[] exceptUriPatterns = null;
    
    /**
     * Default constructor.
     */
    public LoginFilter()
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
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException
    {
        HttpServletRequest hrequest = (HttpServletRequest)request;
        HttpServletResponse hresponse = (HttpServletResponse)response;
        
        String uri = hrequest.getRequestURI();
        
        if (this.loginPageUri.equals(uri) || this.loginUri.equals(uri) || matchExcepts(uri))
        {
            chain.doFilter(request, response);
        }
        else
        {
            
            if (hrequest.getSession().getAttribute(CommConstants.SESSION_USER) == null)
            {
                if (XHR_OBJECT_NAME.equals(hrequest.getHeader(HEADER_REQUEST_WITH)))
                {// ajax请求
                    hresponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    hresponse.getWriter().append(this.loginPageUri);
                }
                else
                {
                    hresponse.sendRedirect(this.loginPageUri);
                }
            }
            else
            { // 放行
                chain.doFilter(request, response);
            }
        }
    }
    
    private boolean matchExcepts(String uri)
    {
        if (this.exceptUriPatterns != null)
        {
            for (String pattern : this.exceptUriPatterns)
            {
                if (uri.matches(pattern))
                {
                    return true;
                }
            }
        }
        return false;
    }
    
    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig fConfig)
        throws ServletException
    {
        String cpath = fConfig.getServletContext().getContextPath();
        
        this.loginPageUri = cpath + this.loginPageUri;
        
        String tempLoginPageUri = fConfig.getInitParameter("login-page-uri");
        if (StringUtils.isNotBlank(tempLoginPageUri))
        {
            tempLoginPageUri = tempLoginPageUri.replaceAll("\\s", "");
            if (!"".equals(tempLoginPageUri))
            {
                String str = "";
                if (!tempLoginPageUri.startsWith("/"))
                {
                    str = "/";
                }
                this.loginPageUri = cpath + str + tempLoginPageUri;
            }
        }
        
        this.loginUri = cpath + this.loginUri;
        
        String tempLoginUri = fConfig.getInitParameter("login-uri");
        if (StringUtils.isNotBlank(tempLoginUri))
        {
            tempLoginUri = tempLoginUri.replaceAll("\\s", "");
            if (!"".equals(tempLoginUri))
            {
                String str = "";
                if (!tempLoginPageUri.startsWith("/"))
                {
                    str = "/";
                }
                this.loginUri = cpath + str + tempLoginUri;
            }
        }
        
        String exceptUris = fConfig.getInitParameter("except-uri-patterns");
        if (StringUtils.isNotBlank(exceptUris))
        {
            exceptUris = exceptUris.replaceAll("\\s", "");
            
            if (StringUtils.isNotBlank(exceptUris))
            {
                this.exceptUriPatterns = exceptUris.split(";");
                for (int i = 0; i < this.exceptUriPatterns.length; i++)
                {
                    this.exceptUriPatterns[i] =
                        cpath + (this.exceptUriPatterns[i].startsWith("/") ? "" : "/") + this.exceptUriPatterns[i];
                }
            }
        }
    }
    
}
