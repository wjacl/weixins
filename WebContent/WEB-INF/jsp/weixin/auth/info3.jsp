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
         <h2 style="text-align:center;vertical-align: middle;">认证-专家基本信息填写</h2>
    </div>	

	<!-- 专家信息填写  -->
    <div class="page__bd">
      <form action="" method="post" id="form3">
		<div class="weui-cells weui-cells_form" style="margin-top:5px"> 
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">姓名：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="idcard" required maxlength="30" placeholder="请输入姓名" 
                    	emptyTips="请输入姓名" notMatchTips="姓名长度不能超过30个字符">
                </div>
                <div class="weui-cell__ft">
                    <i class="weui-icon-warn"></i>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">身份证号：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="idcard" required pattern="REG_IDNUM" maxlength="18" placeholder="输入你的身份证号码" emptyTips="请输入身份证号码" notMatchTips="请输入正确的身份证号码">
                </div>
                <div class="weui-cell__ft">
                    <i class="weui-icon-warn"></i>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">手机号：</label>
                </div>
                <div class="weui-cell__bd">
                	<input class="weui-input" type="tel" name="mphone" required pattern="^\d{11}$" maxlength="11" placeholder="请输入你的手机号" emptyTips="请输入手机号" notMatchTips="请输入正确的手机号">
                </div>
                <div class="weui-cell__ft">
                    <button class="weui-vcode-btn">获取验证码</button>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">短信验证码：</label>
                </div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="smsAuthCode" type="tel" placeholder="请输入短信验证码" required/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="" class="weui-label">微信号：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="wechatNo" type="text" required placeholder="请输入你的微信号" emptyTips="请输入你的微信号"/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="" class="weui-label">联系地址：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="address" type="text" readOnly/>
                </div>
                <div class="weui-cell__ft">
                	<input name="lat" type="hidden"/>
                	<input name="lng" type="hidden"/>
                    <a class="weui-vcode-btn" id="location-btn" href="javascript:;">地图选址</a>
                </div>
            </div>
            <div class="weui-cell" id="uploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">身份证正反面图片上传</p>
                            <div class="weui-uploader__info"><span id="uploadCount">0</span>/3</div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple/>
                            </div>
                        </div>
                    </div>
                </div>
			</div>	
            <!-- <div class="weui-cell">
            	<div class="weui-cell__bd">
                    <p class="weui-textarea__title">专家简介：</p>
                    <textarea class="weui-textarea" placeholder="请输入简介信息" rows="3" maxlength="30"></textarea>
                    <div class="weui-textarea-counter"><span>0</span>/30</div>
                </div>
            </div> -->
        <div class="weui-btn-area_inline">
            <a class="weui-btn weui-btn_primary" href="toCategory" id="cc2Pre">上一步</a>
            <a class="weui-btn weui-btn_primary" href="javascript:" id="formSubmitBtn">确 定</a>
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
<script type="text/javascript" src="${ctx }/js/app/weixin/auth1.js"></script>
<script>
	var formData = {};
	$("#cc2Pre").on("click",function(){
		location.href = ctx + "/wx/web/auth/toCategory?category=" + formData.category;
	});
	
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