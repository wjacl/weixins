<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>认证-信息填写</title>
	<!-- 引入 WeUI -->
	<link rel="stylesheet" href="${ctx }/css/weui.min.css"/>
</head>
<body>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">认证-信息填写</h2>
    </div>
    <div class="page__bd">
      <form action="" method="post">
        <div class="weui-cells weui-cells_form" style="margin-top:5px">    	
            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__hd">
                    <label for="" class="weui-label">经营类别：</label>
                </div>
                <div class="weui-cell__bd">
                    <select class="weui-select" name="category" required="required">
                        <option value="1">厂家 (有实体店、有工厂等)</option>
                        <option value="2">商家 (有店铺、附有小型工厂等)</option>
                        <option value="3">专家 (行业专家)</option>
                        <option value="4">安装工 (有专业技能等)</option>
                        <option value="5">个人 (以自然人身份)</option>
                        <option value="6">其他</option>
                    </select>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">厂/店名：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="dname" pattern=".{1,30}" placeholder="请输入"/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">法人/自然人姓名：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="name" required="required" pattern=".{1,30}" placeholder="请输入"/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">身份证号：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="idcard" required="required" pattern="[0-9A-Za-z]{16-18}" placeholder="请输入"/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">手机号：</label>
                </div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="mphone" type="tel" placeholder="请输入手机号" required="required"/>
                </div>
                <div class="weui-cell__ft">
                    <button class="weui-vcode-btn">获取验证码</button>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">短信验证码：</label>
                </div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="smsAuthCode" type="tel" placeholder="请输入短信验证码" required="required"/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="" class="weui-label">厂/店地址：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="location" type="text" value=""/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">身份证正反面、营业执照副本图片上传</p>
                            <div class="weui-uploader__info">0/2</div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" multiple/>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
        <div class="weui-btn-area">
            <a class="weui-btn weui-btn_primary" href="javascript:" id="showTooltips">确定</a>
        </div>
    </div>
    </form>
        <div class="weui-gallery" id="gallery">
            <span class="weui-gallery__img" id="galleryImg"></span>
            <div class="weui-gallery__opr">
                <a href="javascript:" class="weui-gallery__del">
                    <i class="weui-icon-delete weui-icon_gallery-delete"></i>
                </a>
            </div>
		</div>
    </div>
    <div class="page__ft">
        <div class="weui-footer">
            <p class="weui-footer__text">Copyright &copy; 2008-2017 weui.io</p>
		</div>
    </div>
</div>
    <script type="text/javascript" src="${ctx }/js/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="https://res.wx.qq.com/open/libs/weuijs/1.0.0/weui.min.js"></script>
<script type="text/javascript">
    $(function(){
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
            $gallery = $("#gallery"), $galleryImg = $("#galleryImg"),
            $uploaderInput = $("#uploaderInput"),
            $uploaderFiles = $("#uploaderFiles")
            ;
        
        $("a.weui-gallery__del").on("click",function(){
        	$("li[style='" + $galleryImg.attr("style") + "']").remove();
        });
        
        $uploaderInput.on("change", function(e){
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];
                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }
                $uploaderFiles.append($(tmpl.replace('#url#', src)));
            }
        });
        $uploaderFiles.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $gallery.on("click", function(){
            $gallery.fadeOut(100);
        });
    });
</script>
</body>
</html>