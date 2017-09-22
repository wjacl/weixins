package com.wja.base.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wja.base.system.entity.User;

public class RequestThreadLocal
{
    public static ThreadLocal<HttpServletRequest> request = new ThreadLocal<>();
    
    public static ThreadLocal<HttpServletResponse> response = new ThreadLocal<>();
    
    public static ThreadLocal<User> currUser = new ThreadLocal<>();
}
