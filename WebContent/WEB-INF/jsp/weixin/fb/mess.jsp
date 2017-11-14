<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>发布信息</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_css.jsp" %>
</head>
<body ontouchstart="">
<div class="page">	
    <div class="page__bd"> 	
    	<div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item weui-bar__item_on" data-for="mess">
					信息
                </div>
                <div class="weui-navbar__item" data-for="prod">
			                    产品
                </div>
            </div>
	    	<div class="weui-tab__panel" id="mess" style="padding-top:30px;">
		      <form action="../saveIntro" method="post" id="form">
					<div class="weui-cells weui-cells_form no-top-line">  
						<div class="weui-cell">
							<div class="weui-cell__hd"><label class="weui-label">标题：</label></div>
			                <div class="weui-cell__bd">
			                    <input class="weui-input" type="text" name="title" required maxlength="30"
			                    	placeholder="请输入标题" emptyTips="请输入标题" 
			                    	notMatchTips="标题长度不能超过30个字符"/>
			                </div>
						</div>  	
			            <div class="weui-cell" id="uploader">
			                <div class="weui-cell__bd">
			                    <div class="weui-uploader">
			                        <div class="weui-uploader__hd">
			                            <p class="weui-uploader__title">首图：</p>
			                            <div class="weui-uploader__info"><span id="uploadCount"></span></div>
			                        </div>
			                        <div class="weui-uploader__bd">
			                            <ul class="weui-uploader__files" id="uploaderFiles">
			                            <c:if test="${not empty fi.logo }">
			                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/pubget${fi.logo })" data-id="${fi.logo }"></li>
			                            </c:if>
			                            </ul>
			                            <div class="weui-uploader__input-box">
			                                <input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple/>
			                            </div>
			                        </div>
			                    </div>
			                </div>
						</div>
			            <div class="weui-cell">
			                <div class="weui-cell__bd">
			                	<p>内容：</p>
			                	<div>
			                    <textarea name="intro" id="intro">		                         
			                    </textarea>
			                    </div>
			                </div>
			            </div>			      
		            <div class="weui-cell weui-cell_select weui-cell_select-after">
		                <div class="weui-cell__hd">
		                    <label for="" class="weui-label">发送范围：</label>
		                </div>
		                <div class="weui-cell__bd">
		                    <select class="weui-select" name="range">
		                        <option value="1">全平台(5元/条)</option>
		                        <option value="2">关注者(免费)</option>
		                    </select>
		                </div>
					</div>      
			        <div class="weui-cell no-top-line weui-btn-area_inline">
						<input type="hidden" name="id" value="${openId }">
						<input type="hidden" name="logo" >
			            <a class="weui-btn weui-btn_primary" href="javascript:" id="formSubmitBtn">发布</a>
			        </div>
			    </div>
			    </form>
		    </div>
		    <div class="weui-tab__panel" id="prod" style="display:none;padding-top:30px;">
				<form action="../saveIntro" method="post" id="form">
					<div class="weui-cells weui-cells_form no-top-line"> 			
						<div class="weui-cell">
							<div class="weui-cell__hd"><label class="weui-label">产品名称：</label></div>
			                <div class="weui-cell__bd">
			                    <input class="weui-input" type="text" name="title" required maxlength="30"
			                    	placeholder="请输入名称" emptyTips="请输入名称" 
			                    	notMatchTips="名称长度不能超过30个字符"/>
			                </div>
						</div> 			
						<div class="weui-cell">
							<div class="weui-cell__hd"><label class="weui-label">单价：</label></div>
			                <div class="weui-cell__bd">
			                    <input class="weui-input" type="number" name="price" maxlength="10"
			                    	placeholder="请输入单价（元）" 
			                    	notMatchTips="单价长度不能超过10位"/>
			                </div>
			                <div class="weui-cell__ft"><label class="weui-label">元</label></div>
						</div>   			
						<div class="weui-cell">
							<div class="weui-cell__hd"><label class="weui-label">单位：</label></div>
			                <div class="weui-cell__bd">
			                    <input class="weui-input" type="text" name="unit" maxlength="10"
			                    	placeholder="请输入产品单价单位" 
			                    	notMatchTips="单位长度不能超过10个字符"/>
			                </div>
						</div> 	
			            <div class="weui-cell" id="productUploader">
			                <div class="weui-cell__bd">
			                    <div class="weui-uploader">
			                        <div class="weui-uploader__hd">
			                            <p class="weui-uploader__title">产品介绍图片：</p>
			                            <div class="weui-uploader__info"><span id="productUploaderCount"></span></div>
			                        </div>
			                        <div class="weui-uploader__bd">
			                            <ul class="weui-uploader__files" id="productUploaderFiles">
			                            <c:if test="${not empty fi.logo }">
			                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/pubget${fi.logo })" data-id="${fi.logo }"></li>
			                            </c:if>
			                            </ul>
			                            <div class="weui-uploader__input-box">
			                                <input id="productUploaderInput" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple/>
			                            </div>
			                        </div>
			                    </div>
			                </div>
						</div>
			            <div class="weui-cell">
			                <div class="weui-cell__bd">
			                	<p>产品介绍：</p>
			                	<div>
			                    <textarea name="intro" id="prodIntro">
			                    </textarea>
			                    </div>
			                </div>
			            </div>
		            <div class="weui-cell weui-cell_select weui-cell_select-after">
		                <div class="weui-cell__hd">
		                    <label for="" class="weui-label">推送范围：</label>
		                </div>
		                <div class="weui-cell__bd">
		                    <select class="weui-select" name="range">
		                        <option value="1">全平台(5元/条)</option>
		                        <option value="2">关注者(免费)</option>
		                    </select>
		                </div>
					</div> 
			        <div class="weui-cell no-top-line weui-btn-area_inline">
						<input type="hidden" name="openId" value="${fi.openId }">
						<input type="hidden" name="logo" value="${fi.logo }">
			            <a class="weui-btn weui-btn_primary" href="javascript:;">发布</a>
			        </div>
			    </div>
			    </form>
            </div>
    	</div>    
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script type="text/javascript" src="${ctx }/js/app/weixin/form.js"></script>
<script type="text/javascript" src="${ctx }/js/app/weixin/img_upload.js"></script>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_js.jsp" %>

<script>
$(function(){
    $('.weui-navbar__item').on('click', function () {
        $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
    	var id = $(this).data("for");
    	if(id == "mess"){
    		$("#prod").hide();
    	}
    	else{
    		$("#mess").hide();
    	}
    	$("#" + id).show();
    });
});
</script>


<script>

	var imgUploader = new ImgUploader('uploader',ctx + '/wx/web/upload/comm',false,1,0,'uploadCount','uploaderFiles',{type:'message'});
	var productImgUploader = new ImgUploader('productUploader',ctx + '/wx/web/upload/comm',false,10,0,'productUploaderCount','productUploaderFiles',{type:'product'});
	
	function doFormSubmit(){
		var re = imgUploader.upload();
		if(re){
			var xx = 1;
			function ccck(){
				if(imgUploader.uploadedFileNames.length < imgUploader.uploadList.length && xx < 10){
					xx++;
					setTimeout(ccck,300);
				}
				else{
					if(imgUploader.uploadedFileNames.length == imgUploader.uploadCount){
						$("input[name='logo']").val(imgUploader.getUploadedFileNameStr());
						var loading = weui.loading('提交中...');
						//将文件加入到表单中提交
						$('#form').submit();
					}
					else {
						weui.alert('请检查一下图片是否都已上传，待都完成上传后，再点击 下一步');
					}
				}
			}
			setTimeout(ccck,300);
		}
	}
	
	$(function(){
		h5FichEditorAuthInroInit("intro");
		h5FichEditorAuthInroInit("prodIntro");
	});
</script>
</html>