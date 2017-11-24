<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>直购</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">平台直购</h2>
    </div>
    <div class="page__bd">
    	<div class="weui-cell" style="padding:30px;">
    		<div class="weui-cell__bd">
    			<div>
    				<p>直购电话：<span style="font-weight:700">${zgdh }</span>
    					<a href="tel:${zgdh }" class="weui-btn weui-btn_mini weui-btn_primary" style="line-height:25px;padding:0 10px;float:right;">呼叫</a>
    				</p>
    			</div>
    		</div>
    	</div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
</html>