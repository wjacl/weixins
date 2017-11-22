<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>派单</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart="">
<div class="page">	
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">派单</h2>
    </div>	
    <div class="page__bd"> 	
				<form action="save" method="post" id="pform">
					<div class="weui-cells weui-cells_form mtop5"> 			
						<div class="weui-cell">
			                <div class="weui-cell__bd">
			                	<p><label class="weui-label">说明：</label></p>
			                    <textarea class="weui-textarea" placeholder="请输入文本" name="remark" rows="3"></textarea>
			                </div>
						</div> 			
			            <div class="weui-cell" id="productUploader">
			                <div class="weui-cell__bd">
			                    <div class="weui-uploader">
			                        <div class="weui-uploader__hd">
			                            <p class="weui-uploader__title">图片：</p>
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
			                	<p>选择安装师傅：</p>
			                	<div>
			                		<p>常用安装师傅：</p>
			                		<div class="button-sp-area" id="noraml" style="padding:10px 5px;">
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家厂家厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
	        						</div>
			                    </div>
			                	<div>
			                		<p>选择其他安装师傅：</p>
			                		<div>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                		</div>
			                    </div>
			                </div>
			            </div>
			        <div class="weui-cell no-top-line weui-btn-area_inline">
						<input type="hidden" name="pubId" value="${openId }">
						<input type="hidden" dd="prod" name="img" >
			            <a class="weui-btn weui-btn_primary" href="javascript:;" id="pformSubmitBtn">派单</a>
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
<script>
	
	var productImgUploader = new ImgUploader('productUploader',ctx + '/wx/web/upload/comm',false,10,0,'productUploaderCount','productUploaderFiles',{type:'worder'});
	
	$(function(){
		
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
	            							setTimeout(location.href="${ctx}/wx/web/fx/view?id=${p.pubId}",4000);
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
	
	var workers = [];
	function chooseAmount(obj,cate){
		var $a = $(obj)
		if($a.attr("data") == "a"){
			$a.addClass("weui-btn_warn");
			$a.removeClass("weui-btn_default");
			$a.attr("data","c");
			workers.push(cate);
		}
		else{
			$a.addClass("weui-btn_default");
			$a.removeClass("weui-btn_warn");
			$a.attr("data","a");
			for(var i = workers.length - 1; i >= 0; i--){
				if(workers[i] == cate){
					workers.splice(i,1);
					break;
				}
			}
		}
	}
</script>
</html>