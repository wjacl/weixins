<%@ tag language="java" pageEncoding="UTF-8" import="com.wja.base.common.CommConstants" %>
<%@ tag import="java.util.Set" %>
<%@ attribute name="path" required="true" type="java.lang.String" %>
<%
	String[] paths = path.split(";");
	for(String p : paths) {
		if(!p.startsWith("http://")){
		    p = request.getContextPath() + (p.startsWith("/")? "" : "/") + p;
		}
	
		if(((Set<String>)session.getAttribute(CommConstants.SESSION_USER_PRIV_PATHS)).contains(p)){
%>
			<jsp:doBody></jsp:doBody>
<%
		break;
		}
	}
%>