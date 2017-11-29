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

import com.wja.base.web.AppContext;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.service.FollwerInfoService;

/**
 * Servlet Filter implementation class WeixinFilter
 */
public class NeedAuthedFilter implements Filter
{

    /**
     * 需要验证的地址模式
     */
    String[] exceptUriPatterns = null;
    
    /**
     * Default constructor.
     */
    public NeedAuthedFilter()
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
        if (openId != null)
        {       
            if(this.matchExcepts(request.getRequestURI())){
                FollwerInfoService fss = AppContext.getBean(FollwerInfoService.class);
                FollwerInfo fi = fss.get(FollwerInfo.class, openId);
                if(fi == null || fi.getStatus() != FollwerInfo.STATUS_AUDIT_PASS){
                    request.getRequestDispatcher("/need_auth.jsp").forward(request, response);
                    return;
                }
            }
            chain.doFilter(request, response);     
        }
        else
        {
            request.getRequestDispatcher("/no_autho.jsp").forward(request, response);
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
        
        String exceptUris = fConfig.getInitParameter("include-uri-patterns");
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
