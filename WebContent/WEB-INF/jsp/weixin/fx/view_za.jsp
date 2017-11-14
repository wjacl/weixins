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
	<link href="${ctx }/js/froala-editor/css/froala_style.min.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.title{
			font-size:17px;
			font-weight: 700;
			line-height: 25px;
			display:inline-block;
		}
		.info {	
			line-height: 20px;
			font-size:14px;
		}
		.categ {
			margin-left:10px;
			font-size:12px;
		}
		.tel{
			color:black;
		}
		.gz_button {
			line-height:25px;padding:0 5px;float:right;
		}
	</style>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__bd">
    	<div class="weui-cell" style="padding:10px;border-bottom: 1px solid #e5e5e5;">
    		<div class=weui-cell__hd" style="padding-top:8px;">
    			<img src="${ctx }/images/shili.jpg" height="77" width="70">
    		</div>
    		<div class="weui-cell__bd" style="margin-left:5px;">
    			<div>
    				<p class="title">${fi.name }</p>
    				<span class="categ">
    					<c:choose>
    						<c:when test="${fi.category == '1' }">厂家</c:when>
    						<c:when test="${fi.category == '2' }">商家</c:when>
    						<c:when test="${fi.category == '3' }">专家</c:when>
    						<c:when test="${fi.category == '4' }">安装师傅</c:when>
    						<c:when test="${fi.category == '5' }">自然人</c:when>
    						<c:when test="${fi.category == '6' }">其他</c:when>
    					</c:choose>
    				</span>
    				<c:if test="${fi.openId != openId }">
	    				<c:choose>
	    					<c:when test="${not empty gz }">
	    						<a href="javascript:;" data-op="qx" onclick="dogz('${fi.openId}',this)" class="weui-btn weui-btn_mini weui-btn_warn gz_button">取消关注</a>
	    					</c:when>
	    					<c:otherwise>
	    						<a href="javascript:;" data-op="gz" onclick="dogz('${fi.openId}',this)" class="weui-btn weui-btn_mini weui-btn_plain-primary gz_button">+关注</a>
	    					</c:otherwise>
	    				</c:choose>
    				</c:if>
    			</div>
    			<p class="info">地址：${fi.address }</p>
    			<p class="info">电话：<a href="tel:${fi.mphone }" class="tel">${fi.mphone }</a>  微信：${fi.wechat }</p>
    		</div>
    	</div>
    	<div class="fr-view" style="padding:10px;">
	      ${fi.intro }
	    </div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
	function dogz(id,obj){
		var op = $(obj).data("op");
		$.getJSON("gz",{bgzid:id,op:op},function(data){
			if(Constants.ResultStatus_Ok == data.status){
				if(op == "gz"){
					weui.toast('关注成功', 2000);
					$(obj).html("取消关注");
					$(obj).removeClass("weui-btn_plain-primary");
					$(obj).addClass("weui-btn_warn");
					$(obj).data("op","qx");
				}
				else{
					weui.toast('取消关注成功', 2000);
					$(obj).html("+关注");
					$(obj).removeClass("weui-btn_warn");
					$(obj).addClass("weui-btn_plain-primary");
					$(obj).data("op","gz");
				}
			}
			else{
				if(data.mess){
					weui.alert(data.mess);
				}
				else{
					weui.alert("操作失败，请重试！");
				}
			}
		});
	}
</script>
</html>