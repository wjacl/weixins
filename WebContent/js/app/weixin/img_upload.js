/* 图片上传 */
function ImgUploader(domId,url,auto,max,min,countDomId,uploaderFilesDomId,fileParam){
	this.uploadCount = 0;
	this.uploadList = [];
	this.uploadedFileNames = [];
	this.max = 20;
	if(max){
		this.max = max;
	}
	this.min = 0;
	if(min){
		this.min = min;
	}

	this.uploadCountDom = document.getElementById(countDomId == undefined ? domId + "Count" : countDomId);
	var uploadObj = this;
	
	$("#" + uploaderFilesDomId).children("li").each(function(index){
		uploadObj.uploadedFileNames.push({fileName:$(this).data("id"),old:true});
	});

	this.uploadCount = this.uploadedFileNames.length;
	this.uploadCountDom.innerHTML = this.uploadCount;
	
	weui.uploader("#" + domId, {
	    url: url,
	    auto: auto,
	    type: fileParam == undefined ? 'file' : fileParam,
	    compress: {
	        width: 1600,
	        height: 1600,
	        quality: .8
	    },
	    onBeforeQueued: function(files) {
	        if(["image/jpg", "image/jpeg", "image/png", "image/gif"].indexOf(this.type) < 0){
	            weui.alert('请上传图片');
	            return false;
	        }
	        if(this.size > 10 * 1024 * 1024){
	            weui.alert('请上传不超过10M的图片');
	            return false;
	        }
	        if (files.length > uploadObj.max) { // 防止一下子选中过多文件
	            weui.alert('最多只能上传' + uploadObj.max + '张图片，请重新选择');
	            return false;
	        }
	        if (uploadObj.uploadCount + 1 > uploadObj.max) {
	            weui.alert('最多只能上传' + uploadObj.max + '张图片');
	            return false;
	        }

	        ++uploadObj.uploadCount;
	        if(uploadObj.uploadCountDom){
	        	uploadObj.uploadCountDom.innerHTML = uploadObj.uploadCount;
	        }
	    },
	    onQueued: function(){
	    	uploadObj.uploadList.push(this);
	        //console.log(this);
	    },
	    onBeforeSend: function(data, headers){
	        //console.log(this, data, headers);
	        // $.extend(data, { test: 1 }); // 可以扩展此对象来控制上传参数
	        // $.extend(headers, { Origin: 'http://127.0.0.1' }); // 可以扩展此对象来控制上传头部

	        // return false; // 阻止文件上传
	    },
	    onProgress: function(procent){
	        //console.log(this, procent);
	    },
	    onSuccess: function (ret) {
	    	if(ret.fileName){
	    		uploadObj.uploadedFileNames.push({fileName:ret.fileName,order:this.id,old:false});
	    		return true;
	    	}
	    	else {
	    		weui.alert(ret.errMsg);
	    		return false;
	    	}
	    },
	    onError: function(err){
	        //console.log(this, err);
	    }
	});
	
	// 缩略图预览
	document.querySelector(uploaderFilesDomId == undefined ? "#" + domId + 'UploaderFiles' : '#' + uploaderFilesDomId).addEventListener('click', function(e){
	    var target = e.target;

	    while(!target.classList.contains('weui-uploader__file') && target){
	        target = target.parentNode;
	    }
	    if(!target) return;

	    var url = target.getAttribute('style') || '';
	    var id = target.getAttribute('data-id');

	    if(url){
	        url = url.match(/url\((.*?)\)/)[1].replace(/"/g, '');
	    }
	    var gallery = weui.gallery(url, {
	        className: 'custom-name',
	        onDelete: function(){
	            weui.confirm('确定删除该图片？', function(){
	                --uploadObj.uploadCount;
	                uploadObj.uploadCountDom.innerHTML = uploadObj.uploadCount;

	                var index;
	                for (var i = 0, len = uploadObj.uploadList.length; i < len; ++i) {
	                    var file = uploadObj.uploadList[i];
	                    if(file.id == id){
	                        index = i;
	                        break;
	                    }
	                }
	                if(index !== undefined) {
	                	uploadObj.uploadList.splice(index, 1);
	                }
	                else{
	                	for(var i = 0,len = uploadObj.uploadedFileNames.length; i < len; ++i ){
	                		if(uploadObj.uploadedFileNames[i].fileName == id){
	                			index = i;
	                			break;
	                		}
	                	}               	
	                	if(index !== undefined) {
	                	uploadObj.uploadedFileNames.splice(index, 1);
	                	}
	                }
	                target.remove();
	                gallery.hide();
	            });
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
		 this.uploadList.forEach(function(file){
			 if(file.status != 'success'){  //加入状态判断来决定是否需要上传
				 file.upload();
			 }
         });
		 
		 return true;
	};
	
	this.getUploadedFileNameStr = function(){
		var fns = [];
		var oldCount = -1;
		for(var i = 0,len = this.uploadedFileNames.length;i < len;i++){
			var obj = this.uploadedFileNames[i];
			if(obj.old){
				fns[i] = obj.fileName
			}
			else {
				if(oldCount == -1){
					oldCount = i
				}
				fns[obj.order - 1 + oldCount] = obj.fileName
			}
		}
		
		return fns.join(";");
	}
}

