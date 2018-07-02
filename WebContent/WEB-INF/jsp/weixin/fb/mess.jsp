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
		      <form action="messfb" method="post" id="mform">
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
			                            </ul>
			                           <div class="weui-uploader__input-box" id="uploadInput">
			                           </div>
			                        </div>
			                    </div>
			                </div>
						</div>
			            <div class="weui-cell">
			                <div class="weui-cell__bd">
			                	<p>内容：</p>
			                	<div>
			                    <textarea name="content" id="intro">		                         
			                    </textarea>
			                    </div>
			                </div>
			            </div>			      
		            <div class="weui-cell weui-cell_select weui-cell_select-after">
		                <div class="weui-cell__hd">
		                    <label for="" class="weui-label">发送范围：</label>
		                </div>
		                <div class="weui-cell__bd">
		                    <select class="weui-select" name="trange">
		                        <option value="1">全平台(${mpf }元/条)</option>
		                        <option value="2">关注者(免费)</option>
		                    </select>
		                </div>
					</div>      
			        <div class="weui-cell no-top-line weui-btn-area_inline">
						<input type="hidden" name="pubid" value="${openId }">
						<input type="hidden" name="img" >
			            <a class="weui-btn weui-btn_primary" href="javascript:;" id="mformSubmitBtn">发布</a>
			        </div>
			    </div>
			    </form>
		    </div>
		    <div class="weui-tab__panel" id="prod" style="display:none;padding-top:30px;">
				<form action="prodfb" method="post" id="pform">
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
			                    	placeholder="请输入单价(元)" 
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
			                            </ul>
			                            <div class="weui-uploader__input-box" id="productUploadInput">
			                            </div>
			                        </div>
			                    </div>
			                </div>
						</div>
			            <div class="weui-cell">
			                <div class="weui-cell__bd">
			                	<p>产品介绍：</p>
			                	<div>
			                    <textarea name="content" id="prodIntro">
			                    </textarea>
			                    </div>
			                </div>
			            </div>
		            <div class="weui-cell weui-cell_select weui-cell_select-after">
		                <div class="weui-cell__hd">
		                    <label for="" class="weui-label">推送范围：</label>
		                </div>
		                <div class="weui-cell__bd">
		                    <select class="weui-select" name="trange">
		                        <option value="1">全平台(${mpf }元/条)</option>
		                        <option value="2">关注者(免费)</option>
		                    </select>
		                </div>
					</div> 
			        <div class="weui-cell no-top-line weui-btn-area_inline">
						<input type="hidden" name="pubid" value="${openId }">
						<input type="hidden" dd="prod" name="img" >
			            <a class="weui-btn weui-btn_primary" href="javascript:;" id="pformSubmitBtn">发布</a>
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
<%@ include file="/WEB-INF/jsp/weixin/js_sdk_config.jsp" %>
<script type="text/javascript" src="${ctx }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${ctx }/js/app/weixin/wx_js_sdk_img_upload.js"></script>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_js.jsp" %>
<script>

	var imgUploader =  new WXImgUploader(1,0,"uploadInput",'uploadCount','uploaderFiles');
	var productImgUploader = new WXImgUploader(10,0,"productUploadInput",'productUploaderCount','productUploaderFiles');
	
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
		
		h5FichEditorAuthInroInit("intro");
		h5FichEditorAuthInroInit("prodIntro");
		
	  	$("#mformSubmitBtn").on("click",function(){
        	weui.form.validate('#mform', function (error) {
                if (!error) {
                	var re = imgUploader.upload();
            		if(re){
            			var xx = 1;
            			function ccck(){
            				if(imgUploader.uploadOk.length < imgUploader.localIds.length && xx < 10){
            					xx++;
            					setTimeout(ccck,300);
            				}
            				else{
            					if(imgUploader.uploadOk.length == imgUploader.localIds.length){
            						$("input[name='img']").val(imgUploader.getUploadedFileServerIdStr());
            						var loading = weui.loading('提交中...');
            						//将文件加入到表单中提交
            						$('#mform').ajaxSubmit({dataType:"json",success:function(data){
            							loading.hide();
            							if(Constants.ResultStatus_Ok == data.status){
	            							weui.toast('发布成功', 3000);
	            							setTimeout(location.reload(),3000);
            							}
            							else{
            								if(data.mess){
            									weui.alert(data.mess);
            								}
            								else{
            									weui.alert("提交失败，请重试！");
            								}
            							}
            						}});
            					}
            					else {
            						weui.alert('请等待3秒待都完成上传后，再点击 下一步');
            					}
            				}
            			}
            			setTimeout(ccck,300);
            		}                   
                }
            });
        });
	  	
	  	$("#pformSubmitBtn").on("click",function(){
        	weui.form.validate('#pform', function (error) {
                if (!error) {
                	var re = productImgUploader.upload();
            		if(re){
            			var xx = 1;
            			function ccck(){
            				if(productImgUploader.uploadOk.length < productImgUploader.localIds.length && xx < 10){
            					xx++;
            					setTimeout(ccck,300);
            				}
            				else{
            					if(productImgUploader.uploadOk.length == productImgUploader.localIds.length){
            						$("input[dd='prod']").val(productImgUploader.getUploadedFileServerIdStr());
            						var loading = weui.loading('提交中...');
            						//将文件加入到表单中提交
            						$('#pform').ajaxSubmit({dataType:"json",success:function(data){
            							loading.hide();
            							if(Constants.ResultStatus_Ok == data.status){
	            							weui.toast('发布成功', 3000);
	            							setTimeout(location.reload(),3000);
            							}
            							else{
            								if(data.mess){
            									weui.alert(data.mess);
            								}
            								else{
            									weui.alert("提交失败，请重试！");
            								}
            							}
            						}});
            					}
            					else {
            						weui.alert('请等待3秒待都完成上传后，再点击 下一步');
            					}
            				}
            			}
            			setTimeout(ccck,300);
            		}                   
                }
            });
        });
	});
</script>
</html>