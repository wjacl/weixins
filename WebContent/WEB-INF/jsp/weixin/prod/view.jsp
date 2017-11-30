<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>${p.title }</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<link href="${ctx }/js/froala-editor/css/froala_style.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${ctx }/css/weui.list.css"/>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">${p.title }</h2>
    </div>
    <div class="page__bd">
    	<div class="weui-cell" style="padding:10px;">
    		<div class="weui-cell__bd">
    		<c:if test="${not empty p.img }">
    			<div>
    				<c:forTokens items="${p.img }" delims=";" var="i">
    				<img src="${publicDownloadUrl}${i}" width="300px" style="margin:1px auto;display:block;"/>
    				</c:forTokens>
    			</div>
    		</c:if>
    			
		    	<div class="fr-view">
			      ${p.content }
			    </div>
			    
    			<div>   				
    				<p>单价：${p.price }/${p.unit }</p>
    				<p class="title">发布者：${fi.name }</p>
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
						<a href="javascript:;" onclick="viewFollwer('${fi.openId}')" class="weui-btn weui-btn_mini weui-btn_plain-primary gz_button">浏览</a>
    				</c:if>
    			</div>
    			<p class="info">发布时间：<fmt:formatDate value="${p.createTime }" pattern="yyyy-MM-dd HH:mm"/></p>
    			<p class="info">联系电话：${fi.mphone } <a href="tel:${fi.mphone }" class="weui-btn weui-btn_mini weui-btn_primary gz_button">呼叫</a></p>
    			<p class="info">微信：${fi.wechat }</p>
    		</div>
    	</div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
	function viewFollwer(id){
		location.href= ctx + "/wx/web/fx/view/" + id;
	}
</script>
</html>