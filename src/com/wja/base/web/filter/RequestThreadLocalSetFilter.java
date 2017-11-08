package com.wja.base.web.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.wja.base.common.CommConstants;
import com.wja.base.system.entity.User;
import com.wja.base.util.DateUtil;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;

/**
 * Servlet Filter implementation class RequestThreadLocalSetFilter
 */
@WebFilter("/*")
public class RequestThreadLocalSetFilter implements Filter
{
    private Map<String, String> langResources = new HashMap<>();
    
    private String default_lang = "zh_CN";
    
    private boolean servletContextAttributeInited = false;
    
    /**
     * Default constructor.
     */
    public RequestThreadLocalSetFilter()
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
        // 将请求、响应、当前用户放入线程本地变量，以供后端代码直接获取
        HttpServletRequest httpRequest = (HttpServletRequest)request;
        RequestThreadLocal.request.set(httpRequest);
        RequestThreadLocal.response.set((HttpServletResponse)response);
        RequestThreadLocal.currUser.set((User)httpRequest.getSession().getAttribute(CommConstants.SESSION_USER));
        
        // 设置引用上下文属性
        httpRequest.setAttribute("ctx", httpRequest.getContextPath());
        // 设置版权年份
        httpRequest.setAttribute("copyRightYear", DateUtil.getCurrYear());
        // 设置当前系统时间
        httpRequest.setAttribute("currDate", DateUtil.getNowDateStr());
        httpRequest.setAttribute("currDateTime", DateUtil.getNowStr());
        
        if (!this.servletContextAttributeInited)
        {
            ServletContext sc = httpRequest.getServletContext();
            sc.setAttribute("publicUploadUrl", AppContext.getSysParam("wx.upload.public.url"));
            sc.setAttribute("publicDownloadUrl", AppContext.getSysParam("wx.download.public.url"));
            this.servletContextAttributeInited = true;
        }
        
        // 设置语言属性
        if (httpRequest.getSession().getAttribute(CommConstants.SESSION_LANG) == null)
        {
            String lang = httpRequest.getLocale().getLanguage();
            if (StringUtils.isNotBlank(httpRequest.getLocale().getCountry()))
            {
                lang += "_" + httpRequest.getLocale().getCountry();
            }
            String realLang = this.langResources.get(lang);
            if (realLang == null)
            {
                if (this.getClass().getClassLoader().getResource("i18n/message_" + lang + ".properties") == null)
                {
                    realLang = this.default_lang;
                }
                else
                {
                    realLang = lang;
                }
                this.langResources.put(lang, realLang);
            }
            
            httpRequest.setAttribute(CommConstants.SESSION_LANG, realLang);
        }
        
        // pass the request along the filter chain
        chain.doFilter(request, response);
    }
    
    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig fConfig)
        throws ServletException
    {
        String dlang = fConfig.getServletContext().getInitParameter("default_lang");
        if (StringUtils.isNotBlank(dlang))
        {
            this.default_lang = dlang;
        }
    }
    
}
