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
            <h2 class="weui-msg__title">保证金支付完成</h2>
            <p class="weui-msg__desc">您现在可以提交审核了！提交后，我们将在48小时内完成审核。审核通过后，您就可以正常使用各项服务了，感谢您的合作！</p>
        </div>
	       	<label for="weuiAgree" class="weui-agree">
	            <input id="weuiAgree" name="xyAgree" type="checkbox" class="weui-agree__checkbox"/>
	            <span class="weui-agree__text">
	                	阅读并同意<a href="${ctx }/wx/web/auth/protocol">《平台服务认证协议》</a>
	            </span>
	        </label> 
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="javascript:;" onclick="dosubmit()" class="weui-btn weui-btn_primary">提交审核</a>
                <a href="${ctx }/wx/web/auth/to/brand" class="weui-btn weui-btn_primary">上一步</a>
            </p>
        </div>
    </div>

	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
	function dosubmit(){

		if(!$("#weuiAgree").is(":checked")){
			weui.alert("请阅读并同意《平台服务认证协议》！");
			return;
		}
		
		location.href = "${ctx }/wx/web/auth/submitAudit";
	}
</script>
</html>