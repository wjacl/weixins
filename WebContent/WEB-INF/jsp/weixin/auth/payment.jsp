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
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">保证金支付</h2>
    </div>
    <div class="page__bd">
		<div class="weui-cells weui-cells_form" style="margin-top:5px">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <label>厂家 (有实体店、有工厂等)</label>
                </div>
                <div>
                    <span>${bzjs1 }元</span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <label>商家 (有店铺、附有小型工厂等)</label>
                </div>
                <div>
                    <span>${bzjs2 }元</span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <label>专家 (行业专家)</label>
                </div>
                <div>
                    <span>${bzjs3 }元</span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <label>安装工 (有专业技能等)</label>
                </div>
                <div>
                    <span>${bzjs4 }元</span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <label>个人 (以自然人身份)</label>
                </div>
                <div>
                    <span>${bzjs5 }元</span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <label>其他</label>
                </div>
                <div>
                    <span>${bzjs6 }元</span>
                </div>
            </div>
        </div>
        <div class="weui-cell">
        	<div class="weui-cell__bd">
        		<p style="font-weight: 700">保证金说明：</p>
	        	<div>
	        		<p>保证金说明：</p><p>保证金说明：</p><p>保证金说明：</p>
	        	</div>
        	</div>
        </div>  
        
       	<div>
       		<input type="checkBox" name="agree">
       		<a href="" style="color:red">同意平台服务认证协议（点击查看）</a>
       	</div>     
        <div class="weui-btn-area_inline">
           	<a class="weui-btn weui-btn_primary" href="javascript:;" id="cc1Pre">微信支付</a>
        </div>
        <p>&nbsp;</p>
        <div class="weui-btn-area_inline">
           	<a class="weui-btn weui-btn_primary" href="brand" id="cc2Pre">上一步</a>
        </div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
	var formData = {category : '${fi.category}',openId:'${fi.openId}'};
	if(!formData.category){
		$("#cc1Pre").hide();
	}
	$("input[name='category']").on("click",function(){
		$("#cc1Pre").hide();
		var cval = $(this).val();
		if(formData.category != cval){
			formData.category = cval;
			$.ajax({url:ctx + "/wx/web/auth/saveCategory",
				type:"POST",
				data:formData,
				dataType:"json",
				async: false,
				success:function(data){
					if(data.status == 200){
						location.href = ctx + "/wx/web/auth/to/info";
					}
				}
			});
		}
		else {
			location.href = ctx + "/wx/web/auth/to/info";
		}
	});
	
</script>
</html>