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
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/web/upload/get/${it })" data-id="${it }"></li>
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
<script>

	function WXImgUploader(max,min,uploadInput,countDomId,uploaderFilesDomId){
		this.max = 20;
		if(max){
			this.max = max;
		}
		this.min = 0;
		if(min){
			this.min = min;
		}
		this.localIds = [];
		this.uploadCount = 0;
		this.uploadedServerIds = [];
		
		if(countDomId){
			this.uploadCountDom = document.getElementById(countDomId);
		}
		
		var uploadObj = this;
		//获取已存在的图片
		$("#" + uploaderFilesDomId).children("img").each(function(index){
			uploadObj.uploadedServerIds.push($(this).data("id"));
		});
		
		this.uploadCount = this.uploadedServerIds.length;
		
		this.showCount = function(){
			//显示数量
		    if(this.uploadCountDom){
		    	this.uploadCountDom.innerHTML = this.uploadCount + "/" + this.max;
		    }
		}
		
		this.showCount();
	    
	    $("#" + uploadInput).on("click",function(){
	    	var nn = uploadObj.max - uploadObj.uploadCount;
	    	if(nn <= 0){
	    		weui.alert('最多只能上传' + uploadObj.max + '张图片，不可选择了！');
	    		return;
	    	}
			wx.chooseImage({
				count: nn, // 默认9
				sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
				sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				success: function (res) {
					for(var i in res.localIds){
						uploadObj.uploadCount++;
						uploadObj.localIds.push(res.localIds[i]); // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
						$("#uploaderFiles").append('<img class="upimg" local="local" src="' + res.localIds[i] + '">');
					}

					uploadObj.showCount();
				}
			});
		});
	    
	    this.upload = function(){
	    	if(this.uploadCount < this.min){
	    		weui.alert('至少需上传' + this.min + '张图片,还少' + (this.min - this.uploadCount) + '张！');
				return false;
	    	}
	    	if(this.uploadCount > this.max){
				weui.alert('只能上传' + this.max + '张图片！');
				return false;
			}
	    	if(this.localIds.length > 0){
	    		var loading = weui.loading('图片上传中...');
	    		/* for(var i in this.localIds){
	    			var lid = this.localIds[i]; */
	    			this.localIds.forEach(function(lid,index,array){	
	    			wx.uploadImage({
	    	    		localId: lid, // 需要上传的图片的本地ID，由chooseImage接口获得
	    	    		isShowProgressTips: 0, // 默认为1，显示进度提示
	    	    		success: function (res) {
	    	    			uploadObj.uploadedServerIds.push(res.serverId);
	    	    			$("img[src='" + lid + "']").attr("data-id",res.serverId);
	    	    			if(index == array.length - 1){
	    	    				loading.hide();
	    	    			}
	    	    		}
	    	    	});
	    			});
	    		//}
	    	}
	    	return true;
	    }
	    
	 // 缩略图预览
		document.querySelector('#' + uploaderFilesDomId).addEventListener('click', function(e){
		    var target = e.target;

		    while(!target.classList.contains('upimg') && target){
		        target = target.parentNode;
		    }
		    if(!target) return;

		    var src = target.getAttribute('src');
		    var gallery = weui.gallery(src, {
		        className: 'custom-name',
		        onDelete: function(){
		            weui.confirm('确定删除该图片？', function(){
		            	
		            	--uploadObj.uploadCount;
		            	uploadObj.showCount();
		            	
		            	var local = target.getAttribute('local');
		            	if(local == "local"){
		            		for(var i = 0; i < uploadObj.localIds.length; i++){
		            			if(uploadObj.localIds[i] == src){
		            				uploadObj.localIds.splice(i, 1);
		            				break;
		            			}
		            		}
		            	}
		            	else{
		            		src = target.getAttribute('data-id');
		            		for(var i = 0; i < uploadObj.uploadedServerIds.length; i++){
		            			if(uploadObj.uploadedServerIds[i] == src){
		            				uploadObj.uploadedServerIds.splice(i, 1);
		            				break;
		            			}
		            		}
		            	}
		            	target.remove();
		                gallery.hide();
		            });
		        }
		    });
		});
	}

	//var imgUploader = new ImgUploader('uploader',ctx + '/wx/web/upload/auth',false,3,2,'uploadCount','uploaderFiles');
	var upImgs={
			localIds:[],
			serverIds:[]
	}
	function imgUpload(){
		$("#uploadInput").on("click",function(){
			wx.chooseImage({
				count: 3, // 默认9
				sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
				sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				success: function (res) {
					for(var i in res.localIds){
						upImgs.localIds.push(res.localIds[i]); // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
						$("#uploaderFiles").append('<img class="upimg" onclick="preview(this)" src="' + res.localIds[i] + '">');
					}
				}
			});
		});
	}
	
	function preview(obj){
		var gallery = weui.gallery(obj.src, {
	        className: 'custom-name',
	        onDelete: function(){
	            weui.confirm('确定删除该图片？', function(){
	               $(obj).remove();
	                gallery.hide();
	            });
	        }
	    });
	}
	$(function(){
		var imup1 = new WXImgUploader(3,3,"uploadInput","uploadCount","uploaderFiles");
		$("#formSubmitBtn").on("click",function(){
			if(imup1.upload()){
				alert(JSON.stringify(imup1.uploadedServerIds));
			};
		})
	})
</script>
</html>