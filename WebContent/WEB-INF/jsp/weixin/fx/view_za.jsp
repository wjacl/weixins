<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>${fi.name }</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<style type="text/css">
		.title{
			font-size:17px;
			font-weight: 700;
			line-height: 25px;
		}
		.info {	
			line-height: 20px;
			font-size:14px;
		}
	</style>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__bd">
    	<div style="padding:10px;">
    		<div style="display:inline-block;height:80px;width:70px;">
    			<img src="${ctx }/images/shili.jpg" height="75" width="70">
    		</div>
    		<div style="display:inline-block;height:80px;width:270px;">
    			<p class="title">张三李四王五</p>
    			<p class="info">厂家</p>
    			<p class="info">地址：湖南省长沙市岳麓区金星中路麓山名园A区1栋610</p>
    			<p class="info">电话：13333333333  微信：66666666</p>
    		</div>
    	</div>
    	<div class="weui-cell" style="padding:10px;">
    		<div class=weui-cell__hd">
    			<img src="${ctx }/images/shili.jpg" height="75" width="70">
    		</div>
    		<div class="weui-cell__bd" style="margin-left:5px;">
    			<p class="title">张三李四王五</p>
    			<p class="info">厂家</p>
    			<p class="info">地址：湖南省长沙市岳麓区金星中路麓山名园A区1栋610</p>
    			<p class="info">电话：13333333333  微信：66666666</p>
    		</div>
    	</div>
    	<div class="weui-cell" style="padding:10px;">
    		<div class=weui-cell__hd" style="padding-top:7px;">
    			<img src="${ctx }/images/shili.jpg" height="78" width="70">
    		</div>
    		<div class="weui-cell__bd" style="margin-left:5px;">
    			<p class="title">张三李四王五</p>
    			<p class="info">厂家</p>
    			<p class="info">地址：湖南省长沙市岳麓区金星中路麓山名园A区1栋610</p>
    			<p class="info">电话：13333333333  微信：66666666</p>
    		</div>
    	</div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>

</script>
</html>