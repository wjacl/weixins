<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>首页</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">欢迎！</h2>
    </div>
    <div class="page__bd">
		<div class="weui-cells" style="margin-top:5px">    
		
	        	<p>信息</p>     
	        <div class="weui-cell no-top-line weui-btn-area_inline">
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/fb/toMyMess">收信息</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/fb/mess">发信息</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/pd/pd">派单</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/fb/toMyfb">历史发布</a>
	        </div>
	        	<p>发现</p>     
	        <div class="weui-cell no-top-line weui-btn-area_inline">
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/fx/fx" >附近</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/fx/brand" >品牌</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/fx/zj" >专家</a>
	        </div>
	        	<p>我</p>     
	        <div class="weui-cell no-top-line weui-btn-area_inline">
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/auth/auth" >认证</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/fee/view" >费用</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/me/gz" >我的关注</a>
	            <a class="weui-btn weui-btn_primary" href="/weixins/wx/web/me/zg" >直购</a>
	        </div>
        </div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
</html>