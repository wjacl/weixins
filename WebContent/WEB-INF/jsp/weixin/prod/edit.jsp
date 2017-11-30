<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>产品修改</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_css.jsp" %>
</head>
<body ontouchstart="">
<div class="page">	
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">产品修改</h2>
    </div>	
    <div class="page__bd"> 	
				<form action="save" method="post" id="pform">
					<div class="weui-cells weui-cells_form mtop5"> 			
						<div class="weui-cell">
							<div class="weui-cell__hd"><label class="weui-label">产品名称：</label></div>
			                <div class="weui-cell__bd">
			                    <input class="weui-input" type="text" name="title" required maxlength="30"
			                    	placeholder="请输入名称" emptyTips="请输入名称" value="${p.title }"
			                    	notMatchTips="名称长度不能超过30个字符"/>
			                </div>
						</div> 			
						<div class="weui-cell">
							<div class="weui-cell__hd"><label class="weui-label">单价：</label></div>
			                <div class="weui-cell__bd">
			                    <input class="weui-input" type="number" name="price" maxlength="10"
			                    	placeholder="请输入单价（元）"  value="${p.price }"
			                    	notMatchTips="单价长度不能超过10位"/>
			                </div>
			                <div class="weui-cell__ft"><label class="weui-label">元</label></div>
						</div>   			
						<div class="weui-cell">
							<div class="weui-cell__hd"><label class="weui-label">单位：</label></div>
			                <div class="weui-cell__bd">
			                    <input class="weui-input" type="text" name="unit" maxlength="10"
			                    	placeholder="请输入产品单价单位"  value="${p.unit }"
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
			                            <c:if test="${not empty p.img }">
				                            <c:forTokens items="${p.img }" var="it" delims=";">
				                                <li class="weui-uploader__file" style="background-image:url(${publicDownloadUrl}${it })" data-id="${it }"></li>
				                            </c:forTokens>
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
			                    <textarea name="content" id="prodIntro">
			                    ${p.content }
			                    </textarea>
			                    </div>
			                </div>
			            </div>
			        <div class="weui-cell no-top-line weui-btn-area_inline">
						<input type="hidden" name="pubId" value="${openId }">
						<input type="hidden" dd="prod" name="img" >
						<input type="hidden" name="id" value="${p.id }">
			            <a class="weui-btn weui-btn_primary" href="javascript:;" id="pformSubmitBtn">提交</a>
			        </div>
			    </div>
			    </form>   
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script type="text/javascript" src="${ctx }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${ctx }/js/app/weixin/img_upload.js"></script>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_js.jsp" %>
<script>
	
	var productImgUploader = new ImgUploader('productUploader',ctx + '/wx/web/upload/comm',false,10,0,'productUploaderCount','productUploaderFiles',{type:'product'});
	
	$(function(){
		
		h5FichEditorAuthInroInit("prodIntro");
		
	  	$("#pformSubmitBtn").on("click",function(){
        	weui.form.validate('#pform', function (error) {
                if (!error) {
                	var re = productImgUploader.upload();
            		if(re){
            			var xx = 1;
            			function ccck(){
            				if(productImgUploader.uploadedFileNames.length < productImgUploader.uploadList.length && xx < 10){
            					xx++;
            					setTimeout(ccck,300);
            				}
            				else{
            					if(productImgUploader.uploadedFileNames.length == productImgUploader.uploadCount){
            						$("input[dd='prod']").val(productImgUploader.getUploadedFileNameStr());
            						var loading = weui.loading('提交中...');
            						//将文件加入到表单中提交
            						$('#pform').ajaxSubmit({dataType:"json",success:function(data){
            							loading.hide();
            							if(Constants.ResultStatus_Ok == data.status){
	            							weui.toast('修改成功', 3000);
	            							setTimeout(location.href="${ctx}/wx/web/fx/view/${p.pubId}",4000);
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
            						weui.alert('请检查一下图片是否都已上传，待都完成上传后，再点击 下一步');
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