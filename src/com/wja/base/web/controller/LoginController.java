package com.wja.base.web.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wja.base.common.CommConstants;
import com.wja.base.system.entity.Privilege;
import com.wja.base.system.entity.User;
import com.wja.base.system.service.UserService;
import com.wja.base.util.MD5;
import com.wja.base.web.AppContext;

/**
 * 
 * 登录退出控制器<br>
 * 提供登录、退出方法
 * 
 * @author wja
 * @version [v1.0, 2016年9月22日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
@Controller
public class LoginController {
    /**
     * 在session中记录登录尝试次数的key
     */
    private static final String LoginTryCountKey = "loginErrorTryCount";

    /**
     * 登录错误最大尝试次数默认值
     */
    private static Integer defalutMaxLoginErrorTryTimes = 6;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() {
	return "frame/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(String username, String password, Model model, HttpSession httpSession) {
	if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
	    model.addAttribute("error", AppContext.getMessage("login.error"));
	    return "frame/login";
	}

	User user = this.userService.getUserByUsername(username);
	// 错误尝试计数key
	String tryCountKey = LoginTryCountKey + username;
	// 用户名不存在或密码错误
	if (user == null || !MD5.encode(password).equals(user.getPassword())) {
	    if (user != null) {

		Integer tryCount = (Integer) httpSession.getAttribute(tryCountKey);
		if (tryCount == null) {
		    tryCount = 0;
		}

		tryCount++;
		httpSession.setAttribute(tryCountKey, tryCount);

		int MaxLoginErrorTryTimes = AppContext.getIntSysParam("login.try.max.times");
		if (MaxLoginErrorTryTimes == Integer.MAX_VALUE) {
		    MaxLoginErrorTryTimes = defalutMaxLoginErrorTryTimes;
		}

		if (tryCount >= MaxLoginErrorTryTimes) {
		    user.setStatus(User.STATUS_LOCK);
		    this.userService.updateUser(user);
		    return "frame/login_lock";
		} else {
		    int left = MaxLoginErrorTryTimes - tryCount;
		    if (left <= 3) {
			model.addAttribute("error",
				AppContext.getMessage("login.error.times", new Integer[] { left, left }));
		    } else {
			model.addAttribute("error", AppContext.getMessage("login.error"));
		    }
		}
	    } else {
		model.addAttribute("error", AppContext.getMessage("login.error"));
	    }
	    return "frame/login";
	} else {
	    // 账号被锁定则转到锁定页
	    if (User.STATUS_LOCK.equals(user.getStatus())) {
		return "frame/login_lock";
	    }

	    // 将用户对象放入会话中认证过滤
	    httpSession.setAttribute(CommConstants.SESSION_USER, user);

	    // 获取用户的权限
	    List<Privilege> privs = this.userService.getUserPrivileges(user.getId());

	    // 将权限放入model中供jsp中生成菜单用
	    httpSession.setAttribute("privs", privs);

	    // 对用户的权限进行处理，方便后续鉴权
	    Set<String> privPaths = new HashSet<>();

	    for (Privilege p : privs) {
		if (StringUtils.isNotBlank(p.getPath())) {
		    if (!p.getPath().startsWith("http://")) // http开头的当第三方系统的地址处理
		    {
			if (p.getPath().startsWith("/")) {
			    p.setPath(httpSession.getServletContext().getContextPath() + p.getPath());
			} else {
			    p.setPath(httpSession.getServletContext().getContextPath() + "/" + p.getPath());
			}

			privPaths.add(p.getPath());
		    }
		}

	    }
	    // 将权限数据放入session中
	    httpSession.setAttribute(CommConstants.SESSION_USER_PRIV_PATHS, privPaths);

	    // 登录成功，清除登录错误计数
	    httpSession.removeAttribute(tryCountKey);

	    return "redirect:index";
	}
    }

    @RequestMapping("/index")
    public String toIndex() {
	return "frame/index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession httpSession) {
	httpSession.invalidate();
	return "frame/login";
    }

    @RequestMapping("/unauthorized")
    public String unauthorized() {
	return "frame/unauthorized";
    }
}
