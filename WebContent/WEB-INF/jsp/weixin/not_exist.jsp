<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>资源已不存在</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart="">
<div class="page">	
    <div class="page__bd"> 	
   	    <div class="weui-msg">
	        <div class="weui-msg__icon-area"><i class="weui-icon-warn weui-icon_msg"></i></div>
	        <div class="weui-msg__text-area">
	            <h2 class="weui-msg__title">您访问的资源已不存在！</h2>
	        </div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
</html>