<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>认证</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart="">
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">简介信息填写</h2>
    </div>	
	<!-- 工厂信息填写  -->
    <div class="page__bd">
      <form action="saveInfo" method="post" id="form">
		<div class="weui-cells weui-cells_form" style="margin-top:5px">    	
            <div class="weui-cell" id="uploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">Logo/头像：公司、商家Logo/个人头像</p>
                            <div class="weui-uploader__info"><span id="uploadCount">0</span>/1</div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            <c:if test="${not empty fi.logo }">
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/web/upload/get/${fi.logo })" data-id="${fi.logo }"></li>
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
                	<p>简介</p>
                	<div>
                    <textarea name="intro">
                    	${fi.intro }
                    </textarea>
                    </div>
                </div>
            </div>
			<input type="hidden" name="openId" value="${fi.openId }">
        <div class="weui-btn-area_inline">
            <a class="weui-btn weui-btn_primary" href="toCategory" id="cc2Pre">上一步</a>
            <!-- <a class="weui-btn weui-btn_primary" href="javascript:" id="toBrand">下一步</a> -->
            <a class="weui-btn weui-btn_primary" href="javascript:" id="formSubmitBtn">下一步</a>
        </div>
    </div>
    </form>
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<%@ include file="/WEB-INF/jsp/weixin/js_sdk_config.jsp" %>
<script type="text/javascript" src="${ctx }/js/app/weixin/form.js"></script>
<script type="text/javascript" src="${ctx }/js/app/weixin/img_upload.js"></script>
<script>
	var formData = {};
	$("#cc2Pre").on("click",function(){
		location.href = ctx + "/wx/web/auth/toCategory?category=" + formData.category;
	});

	var imgUploader = new ImgUploader('uploader',ctx + '/wx/web/upload/auth',false,1,0,'uploadCount','uploaderFiles');
	
	function doFormSubmit(){
		if($("input[name='smsAuthCode']").attr("checkOk") != $("input[name='mphone']").val()){
			weui.alert("请获取验证码，验证手机号！");
			return;
		}
		
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
						$("input[name='certificates']").val(imgUploader.getUploadedFileNameStr());
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
</script>
</html>