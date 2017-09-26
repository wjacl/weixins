/* form */
// 约定正则
var regexp = {
    regexp: {
        IDNUM: /(?:^\d{15}$)|(?:^\d{18}$)|^\d{17}[\dXx]$/,
        VCODE: /^.{4}$/
    }
};

// 失去焦点时检测
weui.form.checkIfBlur('#form', regexp);

// 表单提交
document.querySelector('#formSubmitBtn').addEventListener('click', function () {
    weui.form.validate('#form', function (error) {
        console.log(error);
        if (!error) {
            var loading = weui.loading('提交中...');
            setTimeout(function () {
                loading.hide();
                weui.toast('提交成功', 3000);
            }, 1500);
        }
    }, regexp);
});

/* 图片自动上传 */
var uploadCount = 0, uploadList = [];
var uploadCountDom = document.getElementById("uploadCount");
weui.uploader('#uploader', {
    url: 'http://' + location.hostname + ':8002/upload',
    auto: false,
    type: 'file',
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
        if (files.length > 3) { // 防止一下子选中过多文件
            weui.alert('最多只能上传3张图片，请重新选择');
            return false;
        }
        if (uploadCount + 1 > 3) {
            weui.alert('最多只能上传3张图片');
            return false;
        }

        ++uploadCount;
        uploadCountDom.innerHTML = uploadCount;
    },
    onQueued: function(){
        uploadList.push(this);
        console.log(this);
    },
    onBeforeSend: function(data, headers){
        console.log(this, data, headers);
        // $.extend(data, { test: 1 }); // 可以扩展此对象来控制上传参数
        // $.extend(headers, { Origin: 'http://127.0.0.1' }); // 可以扩展此对象来控制上传头部

        // return false; // 阻止文件上传
    },
    onProgress: function(procent){
        console.log(this, procent);
    },
    onSuccess: function (ret) {
        console.log(this, ret);
    },
    onError: function(err){
        console.log(this, err);
    }
});

// 缩略图预览
document.querySelector('#uploaderFiles').addEventListener('click', function(e){
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
                --uploadCount;
                uploadCountDom.innerHTML = uploadCount;

                var index;
                for (var i = 0, len = uploadList.length; i < len; ++i) {
                    var file = uploadList[i];
                    if(file.id == id){
                        index = i;
                        break;
                    }
                }
                if(index !== undefined) uploadList.splice(index, 1);
                target.remove();
                gallery.hide();
            });
        }
    });
});
