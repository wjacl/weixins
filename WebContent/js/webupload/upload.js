
jQuery(function() {
	var $ = jQuery;
	if ( !WebUploader.Uploader.support() ) {
        alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
        throw new Error( 'WebUploader does not support the browser you are using.' );
    }
	
	// 初始化Web Uploader
	var uploader = WebUploader.create({

	    // 选完文件后，是否自动上传。
	    auto: true,

	    // swf文件路径
	    swf: '${ctx }/js/webupload/Uploader.swf',

	    // 文件接收服务端。
	    server: '${ctx }/admin/upload/comm',
	    
	    formData: {type:'product'},

	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#filePicker',

	    // 只允许选择图片文件。
	    accept: {
	        title: 'Images',
	        extensions: 'gif,jpg,jpeg,bmp,png',
	        mimeTypes: 'image/*'
	    }
	});
	
	$queue = $('ul.filelist');
	
	uploader.on( 'fileQueued', function( file ) {});
	
	// 文件上传成功，给item添加成功class, 用样式标记上传成功。
	uploader.on( 'uploadSuccess', function(file,response) {
		var $li = $( '<li id="' + file.id + '">' +
                '<p class="imgWrap"><img src="' + response.link + '"></p>'+
                '</li>' );

        var $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span></div>').appendTo( $li );

        $li.on( 'mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on( 'mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on( 'click', 'span', function() {
            //确认是否移除？
            $.sm.confirmDelete(function(){
                uploader.removeFile( file );
                $("#" + file.id).remove();
			});
        });

        $li.appendTo( $queue );
	});

	// 文件上传失败，显示上传出错。
	uploader.on( 'uploadError', function( file ) {
		uploader.removeFile(file);
		$.sm.alert(file.name + '上传失败');
	});
});