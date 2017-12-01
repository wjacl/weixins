<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>审核</title>
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
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">审核</h2>
    </div>
    <div class="page__bd">
    	<div class="weui-cells mtop5">
    	<div class="weui-cell" >
    		<c:if test="${not empty fi.logo }">
	    		<div class=weui-cell__hd" style="padding-top:8px;">
	    			<img src="${publicDownloadUrl}${fi.logo}" height="77" width="70">
	    		</div>
    		</c:if>
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
    			</div>
    			<p class="info">地址：${fi.address }</p>
    			<p class="info">电话：<a href="tel:${fi.mphone }" class="tel">${fi.mphone }</a>  微信：${fi.wechat }</p>
    		</div>
    	</div>
    	<c:if test="${fi.category == '1' or fi.category == '2' }">
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">法人姓名：</label></div>
                <div class="weui-cell__bd">
                    <label>${fi.fname }</label>
                </div>
            </div>
    	</c:if>
            <div class="weui-cell" id="uploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">证件：</p>
                            <div class="weui-uploader__info"><span id="uploadCount"></span></div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            <c:forTokens items="${fi.certificates }" var="it" delims=";">
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/web/upload/get/${it })" data-id="${it }"></li>
                            </c:forTokens>
                            </ul>
                        </div>
                    </div>
                </div>
			</div>
			<div class="weui-cell">
				<div class="weui-cell__bd">
					<p>简介</p>
			    	<div class="fr-view" style="padding:10px;">
				      ${fi.intro }
				    </div>
			    </div>
	    	</div>
			<div class="weui-cell">
				<div class="weui-cell__bd">
					<p>		
    					<c:choose>
    						<c:when test="${fi.brandType == '1' }">代理品牌</c:when>
    						<c:when test="${fi.brandType == '2' }">自有品牌</c:when>
    						<c:when test="${fi.brandType == '3' }">无品牌</c:when>
    					</c:choose>
					</p>		    	
			    	<div class="button-sp-area" id="finalChoosedBrand" style="padding:0px 10px;">
			    		<c:forTokens items="${fi.brands }" var="it" delims=";">
			    			<a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn">${it }</a>
			    		</c:forTokens>
			        </div>
			    </div>
	    	</div>
	    	<c:if test="${fi.brandType == '1' }">
	    	<div class="weui-cell" id="brandUploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">                  	
                            <p class="weui-uploader__title">品牌授权书</p>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="brandUploaderFiles">
                            <c:forTokens items="${fi.brandAuthors }" var="it" delims=";">
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/web/upload/get/${it })" data-id="${it }"></li>
                            </c:forTokens>
                            </ul>
                        </div>
                    </div>
                </div>
			</div>
			</c:if>	
			<div class="weui-cell">
                <div class="weui-cell__bd">
                	<p><label class="weui-label">审核说明：</label></p>
                    <textarea class="weui-textarea" placeholder="请输入说明" id="auditMess" name="content" rows="4"></textarea>
                </div>
			</div>
	        <div class="weui-cell no-top-line weui-btn-area_inline">
	            <a class="weui-btn weui-btn_primary" href="javascript:;" onclick="doAudit(8)">不通过</a>
	            <a class="weui-btn weui-btn_primary" href="javascript:;" onclick="doAudit(6)">通过</a>
	        </div>
	    </div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script type="text/javascript" src="${ctx }/js/app/weixin/img_upload.js"></script>
<script>

	var bid = '${fi.openId}';
	
	function doAudit(re){
		var mess = $("#auditMess").val();
		if(re == 0){
			if(mess == ""){
				weui.alert("请录入审核说明！");
				return;
			}
		}
		
		weui.confirm('您确定审核' + (re == 0 ? '不通过':'通过') + '？', function(){ 
				var loading = weui.loading('提交中...');
			$.getJSON("audit",{bid:'${fi.openId}',result:re,mess:mess},function(data){
				loading.hide();
				if(Constants.ResultStatus_Ok == data.status){
					weui.toast('操作成功！', 3000);
					setTimeout(location.href="auditList",4000);
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
		});
	}
	
	$(function(){
		var imgUploader = new ImgUploader('uploader','',false,3,2,'uploadCount','uploaderFiles');
		if('${fi.brandType}' == '1'){
			var brandUploader = new ImgUploader('brandUploader','',false,-1,2,'','brandUploaderFiles');
		}
	})

</script>
</html>