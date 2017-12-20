<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>认证</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<style type="text/css">
		.zhuozhong {
			color:red;
			font-weight:800;
			font-size:20px;
		}
	</style>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">保证金支付</h2>
    </div>
    <div class="page__bd">
		<div class="weui-cells weui-cells_form" style="margin-top:5px">
            <div class="weui-cell ${fi.category == '1' ? 'zhuozhong' : '' }">
                <div class="weui-cell__bd">
                    <label>厂家 (有实体店、有工厂等)</label>
                </div>
                <div>
                    <span>${bzjs1 }元</span>
                </div>
            </div>
            <div class="weui-cell ${fi.category == '2' ? 'zhuozhong' : '' }">
                <div class="weui-cell__bd">
                    <label>商家 (有店铺、附有小型工厂等)</label>
                </div>
                <div>
                    <span>${bzjs2 }元</span>
                </div>
            </div>
            <div class="weui-cell ${fi.category == '3' ? 'zhuozhong' : '' }">
                <div class="weui-cell__bd">
                    <label>专家 (行业专家)</label>
                </div>
                <div>
                    <span>${bzjs3 }元</span>
                </div>
            </div>
            <div class="weui-cell ${fi.category == '4' ? 'zhuozhong' : '' }">
                <div class="weui-cell__bd">
                    <label>安装工 (有专业技能等)</label>
                </div>
                <div>
                    <span>${bzjs4 }元</span>
                </div>
            </div>
            <div class="weui-cell ${fi.category == '5' ? 'zhuozhong' : '' }">
                <div class="weui-cell__bd">
                    <label>个人 (以自然人身份)</label>
                </div>
                <div>
                    <span>${bzjs5 }元</span>
                </div>
            </div>
            <div class="weui-cell ${fi.category == '6' ? 'zhuozhong' : '' }">
                <div class="weui-cell__bd">
                    <label>其他</label>
                </div>
                <div>
                    <span>${bzjs6 }元</span>
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
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">已交金额：</label>
                </div>
                <div class="weui-cell__bd">
                	<label>${bzjyj }元</label>
                </div>
            </div> 
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">支付金额：</label>
                </div>
                <div class="weui-cell__bd">
        		<form action="../bzjPay" method="Post" id="xform">
                	<input class="weui-input" type="number" name="amount" value="${not empty bzjce ? bzjce : currBzj }" required  
                		placeholder="请输入支付金额" emptyTips="请输入支付金额">
        		</form> 
                </div>
            </div> 
        </div>        
        <div class="weui-cell no-top-line weui-btn-area_inline">
           	<a class="weui-btn weui-btn_primary" href="javascript:;" id="xsubmit">微信支付</a>
        </div>
        <p>&nbsp;</p>
        <div class="weui-cell no-top-line weui-btn-area_inline">
           	<a class="weui-btn weui-btn_primary" href="brand" id="cc2Pre">上一步</a>
        </div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script type="text/javascript" src="${ctx }/js/jquery.form.min.js"></script>
<%@ include file="/WEB-INF/jsp/weixin/js_sdk_config.jsp" %>
<script>
	$(function(){
		$("#xsubmit").on("click",function(){
			var amount = $("input[name='amount']").val();
			if(amount == "" || amount == 0){
				weui.alert("请输入支付金额！");
				return;
			}
			// $("#xform").submit();
			var loading = weui.loading('提交中...');
			//将文件加入到表单中提交
			//$('#xform').ajaxSubmit({dataType:"json",success:function(data){
			$.getJSON(ctx + "/wx/web/auth/bzjPay",{amount:amount,timeStamp:jsApiConfig.timestamp,nonceStr:jsApiConfig.nonceStr},function(data){
				loading.hide();
				if(Constants.ResultStatus_Ok == data.status){
					var dd = data.data;
					wx.chooseWXPay({
						appId:dd.appId,
						timestamp: dd.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
						nonceStr: dd.nonceStr, // 支付签名随机串，不长于 32 位
						package: dd.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
						signType: dd.signType, // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
						paySign: dd.paySign, // 支付签名
						success: function (res) {
					        // 支付成功后的回调函数
					        //查询后台结果
					        $.getJSON(ctx + "wx/web/trade/check?" + data.data.package,function(res){
					        	if(Constants.ResultStatus_Ok == res.status){
					        		location.href=ctx + "wx/web/auth/bzjPayOk";
					        	}
					        	else {
					        		weui.alert(res.mess);
					        	}
					        });
					    },
					    fail: function(res) {
				            //接口调用失败时执行的回调函数。
				            alert(JSON.stringify(res));
				        }
					});
				}
				else{
					if(data.mess == "amountError"){
						weui.toast('保证金金额变更了，即将刷新获取最新金额！', {
						    duration: 2000,
						    callback: function(){ window.location.reload(); }
						});
					}
					else if(data.mess){
						weui.alert(data.mess);
					}
					else{
						weui.alert("提交失败，请重试！");
					}
				}
			});
		})
	})
	
	
	
</script>
</html>