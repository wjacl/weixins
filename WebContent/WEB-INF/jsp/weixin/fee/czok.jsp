<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>认证</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__bd">
		<div class="weui-msg">
        <div class="weui-msg__icon-area"><i class="weui-icon-success weui-icon_msg"></i></div>
        <div class="weui-msg__text-area">
            <h2 class="weui-msg__title">充值成功！</h2>
        </div>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="cz" class="weui-btn weui-btn_primary">继续充值</a>
            </p>
        </div>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="view" class="weui-btn weui-btn_primary">浏览充值记录</a>
            </p>
        </div>
    </div>

	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
</html>