<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>费用</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">微信充值</h2>
    </div>	
    <div class="page__bd">
		<div class="weui-cells mtop5">
			<div class="weui-cell">
				<div class="weui-cell__bd weui-btn-area_inline">
					<c:forEach items="${opts }" var="d">						
						<a href="javascript:;" data="a" onclick="chooseAmount(this,${d.value })" class="weui-btn weui-btn_mini weui-btn_plain-primary">${d.value }元</a>
					</c:forEach>
				</div>
			</div>
			<div class="weui-cell no-top-line">
				<div class="weui-cell__hd">
					<label>其他金额：</label>
				</div>
				<div class="weui-cell__bd">
				<form id="xform">
					<input class="weui-input" type="number" name="amount" step="0.01" pattern="^\d{1,6}(\\.\\d{1,2})?$"
                    	placeholder="请输入充值金额" />
                </form>
				</div>
				<div class="weui-cell__ft">
					<label>元</label>
				</div>
			</div>        
	        <div class="weui-cell no-top-line weui-btn-area_inline">
	           	<a class="weui-btn weui-btn_primary" href="javascript:;" id="xsubmit">微信支付</a>
	        </div>
		</div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<%@ include file="/WEB-INF/jsp/weixin/js_sdk_config.jsp" %>
<script>
	var choosedAmount = 0;
	function chooseAmount(obj,amount){
		$("a.weui-btn_warn").addClass("weui-btn_plain-primary");
		$("a.weui-btn_warn").removeClass("weui-btn_warn");
		$(obj).addClass("weui-btn_warn");
		$(obj).removeClass("weui-btn_plain-primary");
		choosedAmount = amount;
		$("input[name='amount']").val("");
	}
	

	var reg = /(^[1-9]([0-9]{1,5})?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	
	$("input[name='amount']").on("blur",function(){
		var v = $("input[name='amount']").val();
		if(v != ""){
			$("a.weui-btn_warn").addClass("weui-btn_plain-primary");
			$("a.weui-btn_warn").removeClass("weui-btn_warn");	
			choosedAmount = 0;
			if(reg.test(v)){
				choosedAmount = v/1;
			}
		}
	});
	
	$("#xsubmit").on("click",function(){
		if(choosedAmount > 0 && choosedAmount <= 999999.99){
			var loading = weui.loading('提交中...');
			$.getJSON(ctx + "/wx/web/fee/docz",{amount:choosedAmount},function(data){
				loading.hide();
				if(Constants.ResultStatus_Ok == data.status){
					wx.chooseWXPay(
							$.extend({},data.data,{
							    success: function (res) {
							        // 支付成功后的回调函数
							        //查询后台结果
							        $.getJSON(ctx + "wx/web/trade/check?" + data.data.package,function(res){
							        	if(Constants.ResultStatus_Ok == res.status){
							        		location.href=ctx + "wx/web/fee/czok";
							        	}
							        	else {
							        		weui.alert(res.mess);
							        	}
							        });
							    }
					}));
				}
				else{
					if(data.mess){
						weui.alert(data.mess);
					}
					else{
						weui.alert("提交失败，请重试！");
					}
				}
			});
		}
		else{
			weui.alert("请选择或输入金额,0.01-999999.99！");
		}
	})
</script>
</html>