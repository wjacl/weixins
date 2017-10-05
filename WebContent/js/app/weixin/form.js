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
            if(doFormSubmit){
            	doFormSubmit();
            }
            else {
                var loading = weui.loading('提交中...');
            	$('#form').submit();
                
                setTimeout(function () {
                    loading.hide();
                    weui.toast('提交成功', 3000);
                }, 1500);
            }
        }
    }, regexp);
});