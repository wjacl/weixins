package com.wja.base.web;

import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.wja.base.system.entity.Param;
import com.wja.base.system.service.ParamService;

/**
 * 应用上下文获取工具类
 * 
 * @author ok
 *         
 */
public class AppContext implements ServletContextListener
{
    
    private static WebApplicationContext springContext;
    
    private static ServletContext servletContext;
    
    private static WebApplicationContext springMvcContext;
    
    @Override
    public void contextDestroyed(ServletContextEvent arg0)
    {
        springContext = null;
    }
    
    @Override
    public void contextInitialized(ServletContextEvent event)
    {
        servletContext = event.getServletContext();
        springContext = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
    }
    
    public static <T> T getBean(Class<T> c)
    {
        T b = AppContext.springContext.getBean(c);
        if (b == null)
        {
            b = AppContext.getSpringMvcContext().getBean(c);
        }
        
        return b;
    }
    
    public static WebApplicationContext getWebApplicationContext()
    {
        return springContext;
    }
    
    public static ServletContext getServletContext()
    {
        return servletContext;
    }
    
    /**
     * 获取国际化信息
     * 
     * @param code 国际化代码
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static String getMessage(String code)
    {
        return getMessage(code, null);
    }
    
    /**
     * 
     * 获取国际化信息
     * 
     * @param code 国际化代码
     * @param args 信息中的替换参数
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static String getMessage(String code, Object[] args)
    {
        HttpServletRequest req = RequestThreadLocal.request.get();
        Locale locale = (Locale)req.getSession().getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
        
        return getSpringMvcContext().getMessage(code, args, locale == null ? req.getLocale() : locale);
    }
    
    private static WebApplicationContext getSpringMvcContext()
    {
        if (springMvcContext == null)
        {
            
            springMvcContext = (WebApplicationContext)servletContext
                .getAttribute(FrameworkServlet.SERVLET_CONTEXT_PREFIX + "dispatcher");
        }
        
        if (springMvcContext == null)
        {
            springMvcContext = springContext;
        }
        
        return springMvcContext;
    }
    
    private static ParamService ps = null;
    
    /**
     * 
     * 获取系统参数
     * 
     * @param name 参数名，对应参数表中id
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static String getSysParam(String name)
    {
        if (ps == null)
        {
            ps = springContext.getBean(ParamService.class);
        }
        Param p = ps.get(name);
        return p == null ? null : p.getValue();
    }
    
    /**
     * 
     * 获取整形系统参数
     * 
     * @param name 参数名，对应参数表中id
     * @return 没有配置则返回 Integer.MAX_VALUE
     * @see [类、类#方法、类#成员]
     */
    public static int getIntSysParam(String name)
    {
        int v = Integer.MAX_VALUE;
        String value = getSysParam(name);
        if (StringUtils.isNotBlank(value))
        {
            v = Integer.parseInt(value.trim());
        }
        
        return v;
    }
}
