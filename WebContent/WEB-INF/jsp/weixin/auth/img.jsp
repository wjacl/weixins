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
	<style>
		.upimg{
			width:79px;
			height:79px;
			display:inline;
			margin-right:5px;
		}
	</style>
</head>
<body ontouchstart="">
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">认证信息填写</h2>
    </div>	
	<!-- 工厂信息填写  -->
    <div class="page__bd">
      <form action="" method="post" id="form">
		<div class="weui-cells weui-cells_form" style="margin-top:5px">    	
            <div class="weui-cell" id="uploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">证件：身份证正反面、营业执照图片上传</p>
                            <div class="weui-uploader__info"><span id="uploadCount"></span></div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            <c:forTokens items="${fi.certificates }" var="it" delims=";">
                            	<img class="upimg" src="${ctx}/wx/web/upload/get/${it }" data-id="${it }" />
                            </c:forTokens>
                            </ul>
                            <div class="weui-uploader__input-box" id="uploadInput">
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			<input type="hidden" name="certificates">
        <div class="weui-cell no-top-line weui-btn-area_inline">
            <a class="weui-btn weui-btn_primary" href="category" id="cc2Pre">上一步</a>
            <!-- <a class="weui-btn weui-btn_primary" href="javascript:" id="toBrand">下一步</a> -->
            <a class="weui-btn weui-btn_primary" href="javascript:void(0);" id="formSubmitBtn">下一步</a>
        </div>
    </div>
    </form>
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<%@ include file="/WEB-INF/jsp/weixin/js_sdk_config.jsp" %>
<script type="text/javascript" src="${ctx }/js/app/weixin/wx_js_sdk_img_upload.js"></script>
<script>

	$(function(){
		var imup1 = new WXImgUploader(3,1,"uploadInput","uploadCount","uploaderFiles");
		$("#formSubmitBtn").on("click",function(){
			
			if(imup1.upload()){
				var xx = 1;
				function ccck(){
					if(imup1.uploadOk.length < imup1.localIds.length && xx < 10){
						xx++;
						setTimeout(ccck,300);
					}
					else{
						weui.loading().hide();
						if(imup1.uploadOk.length == imup1.localIds.length){
							/* $("input[name='certificates']").val(imgUploader.getUploadedFileNameStr());
							var loading = weui.loading('提交中...');
							//将文件加入到表单中提交
							$('#form').submit(); */
							
							alert(JSON.stringify(imup1.uploadedServerIds));
						}
						else {
							weui.alert('请检查一下图片是否都已上传，待都完成上传后，再点击 下一步');
						}
					}
				}
				setTimeout(ccck,300);
			}
		})
	})
</script>
</html>