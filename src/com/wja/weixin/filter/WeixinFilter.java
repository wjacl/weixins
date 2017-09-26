package com.wja.weixin.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class WeixinFilter
 */
@WebFilter("/weixin/*")
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
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException
    {
        // 为方便调试加入这个参数，并放到session中，开发完成后需去掉
        String openId = request.getParameter("openId");
        if (openId != null)
        {
            ((HttpServletRequest)request).getSession().setAttribute("openId", openId);
        }
        chain.doFilter(request, response);
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
