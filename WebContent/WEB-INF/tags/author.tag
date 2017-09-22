<%@ tag language="java" pageEncoding="UTF-8" import="com.wja.base.common.CommConstants" %>
<%@ tag import="java.util.Set" %>
<%@ attribute name="path" required="true" type="java.lang.String" %>
<%
	if(!path.startsWith("http://")){
	    path = request.getContextPath() + (path.startsWith("/")? "" : "/") + path;
	}
	
	if(((Set<String>)session.getAttribute(CommConstants.SESSION_USER_PRIV_PATHS)).contains(path)){
%>
	<jsp:doBody></jsp:doBody>
<%
	}
%>