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
         <h2 style="text-align:center;vertical-align: middle;">认证信息填写</h2>
    </div>	
	<!-- 工厂信息填写  -->
    <div class="page__bd">
      <form action="saveInfo" method="post" id="form">
		<div class="weui-cells weui-cells_form" style="margin-top:5px">    	
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">名称：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="name" required maxlength="30" value="${fi.name }"
                    	placeholder="请输入公司/商家名称/个人姓名" emptyTips="请输入名称" 
                    	notMatchTips="名称长度不能超过30个字符"/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">法人姓名：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="fname" maxlength="30" 
                    	placeholder="请输入公司/商家法人姓名" emptyTips="请输入公司/商家法人姓名" 
                    	notMatchTips="法人姓名长度不能超过30个字符"  value="${fi.fname }"/>
                </div>
                <div class="weui-cell__ft">
                    <i class="weui-icon-warn"></i>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="" class="weui-label">地址：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="address" type="text" readOnly required value="${fi.address }" emptyTips="请地图选择地址" />
                </div>
                <div class="weui-cell__ft">
                	<input name="lat" type="hidden" value="${fi.lat }"/>
                	<input name="lng" type="hidden" value="${fi.lng }"/>
                    <a class="weui-vcode-btn" id="location-btn" href="javascript:;">地图选址</a>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">手机号：</label>
                </div>
                <div class="weui-cell__bd">
                	<input class="weui-input" type="tel" name="mphone" value="${fi.mphone }" required pattern="^\d{11}$" maxlength="11" placeholder="请输入你的手机号" emptyTips="请输入手机号" notMatchTips="请输入正确的手机号">
                </div>
                <div class="weui-cell__ft">
                    <a class="weui-vcode-btn" href="javascript:;" id="getVcode">获取验证码</a>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">短信验证码：</label>
                </div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="smsAuthCode" type="tel" placeholder="请输入短信验证码" />
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="" class="weui-label">微信号：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="wechat" type="text" value="${fi.wechat }" required placeholder="请输入你的微信号" emptyTips="请输入你的微信号"/>
                </div>
            </div>
            <div class="weui-cell" id="uploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">证件：身份证正反面、营业执照图片上传</p>
                            <div class="weui-uploader__info"><span id="uploadCount">0</span>/3</div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            <c:forTokens items="${fi.certificates }" var="it" delims=";">
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/web/upload/${it })" data-id="${it }"></li>
                            </c:forTokens>
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple/>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			<input type="hidden" name="certificates">
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
<iframe id="mapPage" width="100%" height="100%" frameborder=0 
    src="http://apis.map.qq.com/tools/locpicker?search=1&type=1&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp">
</iframe> 
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
	
	/* $("#toBrand").on("click",function(){

		$('#form').submit();
	}); */
	
	var uploadCountDom = document.getElementById("uploadCount");

	var imgUploader = new ImgUploader('uploader',ctx + '/wx/web/upload/auth',false,3,2,'uploadCount','uploaderFiles');
	
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
					if(imgUploader.uploadedFileNames.length == imgUploader.uploadList.length){
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
	
	
	$("#mapPage").hide();
	$("#location-btn").on("click",function(){
		$("#mapPage").show();
		$(".page").hide();
	});

    window.addEventListener('message', function(event) {
        // 接收位置信息，用户选择确认位置点后选点组件会触发该事件，回传用户的位置信息
        var loc = event.data;
        if (loc && loc.module == 'locationPicker') {//防止其他应用也会向该页面post信息，需判断module是否为'locationPicker'
          console.log('location', loc); 
			$("input[name='address']").val(loc.poiaddress + "-" + loc.poiname);
			$("input[name='lat']").val(loc.latlng.lat);
			$("input[name='lng']").val(loc.latlng.lng);
          	$("#mapPage").hide();
  			$(".page").show();
        }                                
    }, false);
</script>
</html>