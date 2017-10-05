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
         <h2 style="text-align:center;vertical-align: middle;">认证-选择经营类别</h2>
    </div>
    <div class="page__bd">
		<div class="weui-cells weui-cells_radio" style="margin-top:5px">
            <label class="weui-cell weui-check__label" for="x11">
                <div class="weui-cell__bd">
                    <p>厂家 (有实体店、有工厂等)</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="category" value="1" id="x11" ${fi.category eq "1" ? "checked":"" }/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x12">
                <div class="weui-cell__bd">
                    <p>商家 (有店铺、附有小型工厂等)</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="category" value="2" id="x12" ${fi.category eq "2" ? "checked":"" }/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x13">
                <div class="weui-cell__bd">
                    <p>专家 (行业专家)</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="category" value="3" id="x13"  ${fi.category eq "3" ? "checked":"" }/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x14">
                <div class="weui-cell__bd">
                    <p>安装工 (有专业技能等)</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="category" value="4" id="x14"  ${fi.category eq "4" ? "checked":"" }/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x15">
                <div class="weui-cell__bd">
                    <p>个人 (以自然人身份)</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="category" value="5" id="x15"  ${fi.category eq "5" ? "checked":"" }/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x16">
                <div class="weui-cell__bd">
                    <p>其他</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="category" value="6" id="x16"  ${fi.category eq "6" ? "checked":"" }/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
	        <div class="weui-btn-area_inline">
	            <a class="weui-btn weui-btn_primary" href="javascript:" id="cc1Pre">下一步</a>
	        </div>
        </div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
	var formData = {category : '${fi.category}',openId:'${fi.openId}'};
	if(!formData.category){
		$("#cc1Pre").hide();
	}
	$("input[name='category']").on("click",function(){
		$("#cc1Pre").hide();
		var cval = $(this).val();
		if(formData.category != cval){
			formData.category = cval;
			$.ajax({url:ctx + "/wx/web/auth/saveCategory",
				type:"POST",
				data:formData,
				dataType:"json",
				async: false,
				success:function(data){
					if(data.status == 200){
						location.href = ctx + "/wx/web/auth/toInfo?openId=" + formData.openId;
					}
				}
			});
		}
		else {
			location.href = ctx + "/wx/web/auth/toInfo?openId=" + formData.openId;
		}
	});
	
	$("#cc1Pre").on("click",function(){
		location.href = ctx + "/wx/web/auth/toInfo?openId=" + formData.openId;
	});
</script>
</html>