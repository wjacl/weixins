/**
 * 用微信的js-sdk来上传图片的组件
 * @param max
 * @param min
 * @param uploadInput
 * @param countDomId
 * @param uploaderFilesDomId
 * @returns
 */
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
		this.uploadOk = [];
		
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
		
	    this.syncUpload = function(localIds){
			var localId = localIds.pop();
			wx.uploadImage({
				localId: localId,
				isShowProgressTips: 0,
				success: function (res) {
					uploadObj.uploadOk.push({"localId" : localId,"serverId" : res.serverId});
					if(localIds.length > 0){
						uploadObj.syncUpload(localIds);
					}
				}
			});
		}
	    
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
						$("#" + uploaderFilesDomId).append('<img class="upimg" local="local" src="' + res.localIds[i] + '">');
					}

					uploadObj.showCount();

					uploadObj.syncUpload(res.localIds);
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
	    	if(this.localIds.length > this.uploadOk.length){
	    		var loading = weui.loading('图片上传中...');
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
		            		
		            		//删除已上传的
		            		for(var i = uploadObj.uploadOk.length - 1; i >= 0 ; i--){
		            			if(uploadObj.uploadOk[i]["localId"] == src){
		            				uploadObj.uploadOk.splice(i, 1);	            				
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
		
		this.getUploadedFileServerIdStr = function(){
			var fns = [];
			for(i in this.uploadedServerIds){
				fns.push(this.uploadedServerIds[i]);
			}
			
			for(i in this.uploadOk){
				fns.push(this.uploadOk[i].serverId);
			}
			
			return fns.join(";");
		}
		
		this.getNewUploadedFileServerIdStr = function() {
			var fns = [];		
			for(i in this.uploadOk){
				fns.push(this.uploadOk[i].serverId);
			}		
			return fns.join(";");
		}
}
