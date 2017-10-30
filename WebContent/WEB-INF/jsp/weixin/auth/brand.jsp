<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://wja.com/jsp/app/functions" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, height=device-height,initial-scale=1,user-scalable=0">
	<title>认证</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_css.jsp" %>
	<style>
		.pouple {
			position: fixed;
			  z-index: 5000;
			  width: 90%;
			  max-height:90%;
			  top: 50%;
			  left: 50%;
			  -webkit-transform: translate(-50%, -50%);
			          transform: translate(-50%, -50%);
			  background-color: #FFFFFF;
			  border-radius: 3px;
			  overflow: auto;
		}
		.mtop5 {
			margin-top:5px;
		}
	</style>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">认证-品牌设置</h2>
    </div>	
	<!-- 工厂信息填写  -->
    <div class="page__bd">
      <form action="../saveBrand" method="post" id="xxform">
		<div class="weui-cells weui-cells_radio" style="margin-top:5px">
            <label class="weui-cell weui-check__label" for="x11">
                <div class="weui-cell__bd">
                    <p>代理品牌</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="brandType" value="1" id="x11" ${fi.brandType eq "1" ? "checked":"" } required emptyTips="请选择品牌类型"/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x12">
                <div class="weui-cell__bd">
                    <p>自有品牌</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="brandType" value="2" id="x12" ${fi.brandType eq "2" ? "checked":"" } required emptyTips="请选择品牌类型"/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x13">
                <div class="weui-cell__bd">
                    <p>无品牌</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="brandType" value="3" id="x13" ${fi.brandType eq "3" ? "checked":"" } required emptyTips="请选择品牌类型"/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
        </div>
        
       <div id="chooseDiv" style='display:${fi.brandType == "1" || fi.brandType == "2" ? "block":"none"}'>
    	<h5 style="margin-top:10px;padding-left:10px;">已选品牌(点击可删除)：</h5>
    	<div class="weui-cells" style="margin-top:5px">
	    	<div class="button-sp-area" id="finalChoosedBrand" style="padding:0px 5px;">
	    		<c:forTokens items="${fi.brands }" var="it" delims=";">
	    			<a href="javascript:;" onclick="delBrand(this)" class="weui-btn weui-btn_mini weui-btn_warn">${it }</a>
	    		</c:forTokens>
	    		<a href="javascript:;" onclick="toBrandChoose()" class="weui-btn weui-btn_mini weui-btn_primary">+</a>
	        </div>
	     </div>
	     
	   <div id="authorDiv" style='display:${fi.brandType == "1" ? "block":"none"}'> 
 		<h5 style="margin-top:10px;padding-left:10px;">品牌授权书拍照上传（请上传，否则认证审核会通不过）</h5>
	     <div class="weui-cells" style="margin-top:5px">
            <div class="weui-cell" id="uploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <!-- <div class="weui-uploader__hd">
                            <div class="weui-uploader__info"><span id="uploadCount">0</span></div>
                        </div> -->
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            <c:forTokens items="${fi.brandAuthors }" var="it" delims=";">
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/web/upload/get/${it })" data-id="${it }"></li>
                            </c:forTokens>
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple/>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			<div>
				<h5 style="margin-bottom:10px;padding-left:10px;">下载品牌授权书模板 <a href="brandAuthTemplate" style="color:blue;">请点我</a></h5>
			</div>
        </div>
        </div>
        </div>
        <div class="weui-btn-area_inline" style="margin-top: 10px;">
            <a class="weui-btn weui-btn_primary" href="intro">上一步</a>
            <a class="weui-btn weui-btn_primary" href="javascript:;" onclick="zancun()">暂 存</a>
            <a class="weui-btn weui-btn_primary" href="javascript:;" id="nextStep">下一步</a>
        </div>
	    <input type="hidden" name="brands" value="${fi.brands }" />
	    <input type="hidden" name="brandAuthors" value="${fi.brandAuthors }" />
    	<input type="hidden" name="openId" value="${openId }">
    	<input type="hidden" name="saveType" >
    </form>
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div> 

<div class="js_dialog" id="dialog1" style="display: none;">
    <div class="weui-mask"></div>
    <div class="pouple" style="text-align:left;padding:0 5px;">  
    	<h4 style="text-align:center;margin:5px 0">品牌选择</h4>
    	<div class="weui-cells mtop5">
    	<div class="weui-cell">
	    	<div class="weui-cell__bd">
		    	<div class="weui-search-bar" id="searchBar">
		            <form class="weui-search-bar__form">
		                <div class="weui-search-bar__box">
		                    <i class="weui-icon-search"></i>
		                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索" required/>
		                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
		                </div>
		                <label class="weui-search-bar__label" id="searchText">
		                    <i class="weui-icon-search"></i>
		                    <span>搜索</span>
		                </label>
		            </form>
		        </div>
	        </div>
        </div>
        </div>
        <div class="searchbar-result  weui-cells_checkbox" id="searchResult" style="height:200px;overflow: auto">
            
        </div>
    	<div class="weui-cells" style="margin-top:10px;">
	   		<h5 style="margin-top:5px;">已选品牌：</h5>
	    	<div class="button-sp-area" id="choose-choosed" style="padding:10px 5px;">
	        </div>
	    	<div class="weui-cell weui-btn-area_inline">
	        	<a class="weui-btn weui-btn_primary" href="javascript:;" id="brandChooseOk">确定</a>    
	        </div>
        </div>
    </div>
</div>

<div class="js_dialog" id="dialog2" style="display: none;">
    <div class="weui-mask"></div>
    <div class="pouple">  
    	<h4 style="text-align:center;margin:5px 0">新增品牌</h4>
    	<form action="${ctx }/wx/web/brand/save" method="post" id="brandForm">
    	<div class="weui-cells weui-cells_form mtop5">    	
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">名称：</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="text" name="name" required maxlength="30"
                    	placeholder="请输入品牌名称" emptyTips="请输入品牌名称" 
                    	notMatchTips="品牌名称长度不能超过30个字符"/>
                </div>
            </div>
            <div class="weui-cell" id="brandLogoUploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">品牌商标/Logo：</p>
                            <div class="weui-uploader__info"><span id="brandLogoUploadCount"></span></div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="brandLogoUploaderFiles">
                            <%-- <c:if test="${not empty brand.logo }">
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/pubget/${brand.logo })" data-id="${brand.logo } }"></li>
                            </c:if> --%>
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple/>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                	<p><label class="weui-label">品牌简介：</label></p>
                	<div >
                    <textarea name="intro" id="barndInro"></textarea>
                    </div>
                </div>
            </div>
        <div class="weui-btn-area_inline" style="margin:10px 5px">
            <a class="weui-btn weui-btn_primary" href="javascript:;" id="brand-add-cancle">取消</a>
            <a class="weui-btn weui-btn_primary" href="javascript:" id="brandAddSubmit">提交</a>
        </div>
    </div>
    	<input type="hidden" name="openId" value="${openId }">
    	<input type="hidden" name="logo">
    </form>
    </div>
</div>

</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script type="text/javascript" src="${ctx }/js/app/weixin/img_upload.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.form.min.js"></script>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_js.jsp" %>
<script>
	var $dialog1 = $("#dialog1");

	function toBrandChoose(){
		$("#choose-choosed").empty();
		$("#choose-choosed").append($("#finalChoosedBrand").html());
		var ad = $("#choose-choosed").children().last();
		$(ad).attr("onclick","toAddBrand()");
		$(ad).html("新增");
		$dialog1.fadeIn(200);
	}
	
	$("input[name='brandType']").on("click",function(){
		var value = $(this).val();
		if(value == 1 || value == 2){
			toBrandChoose();
			$("#chooseDiv").show();
			if(value == 1){
				$("#authorDiv").show();
			}
			else{
				$("#authorDiv").hide();
			}
		}
		else{
			$("#chooseDiv").hide();
		}
	});
	$("#chooseBranda").on("click",toBrandChoose);
	
	$("#brandChooseOk").on("click",function(){
		$("#finalChoosedBrand").empty();
		$("#finalChoosedBrand").append($("#choose-choosed").html());
		var ad = $("#finalChoosedBrand").children().last();
		$(ad).attr("onclick","toBrandChoose()");
		$(ad).html("+");
		$dialog1.fadeOut(200);
	});
	
	var $dialog2 = $("#dialog2");
	
	function toAddBrand(){
		$('#brandForm').clearForm();
		$dialog1.fadeOut(200);
		$dialog2.fadeIn(200);
	};
	
	$("#brand-add-cancle").on("click",function(){
		$dialog2.fadeOut(200);
		$dialog1.fadeIn(200);
	});
	
	
	var imgUploader = new ImgUploader('uploader',ctx + '/wx/web/upload/auth',false,30,0,'uploadCount','uploaderFiles');
	
	function zancun(){
		$("input[name='saveType']").val("zancun");
		$("#nextStep").click();
	}
	
	$("#nextStep").on("click",function(){
		weui.form.validate('#xxform', function (error) {
            if (!error) {
            	
            	var brs = $("#finalChoosedBrand").children();
            	var brsary = [];
            	for(var i = 0; i < brs.length - 1; i++){
            		brsary.push($(brs[i]).text());
            	}
            	var brandType = $("input[name='brandType']:checked").val();
            	if(brandType == 1){//代理需上传授权书
            		if(brsary.length > imgUploader.uploadCount && $("input[name='saveType']").val() != "zancun"){
            			weui.alert("代理品牌，请上传品牌授权书图片！每个品牌至少一张图片。")
            			return;
            		}
            	}
            	$("input[name='brands']").val(brsary.join(";"));
            	var re = imgUploader.upload();
        		if(re){
        			var xx = 1;
        			function ccck(){
        				if(imgUploader.uploadedFileNames.length < imgUploader.uploadList.length && xx < 10){
        					xx++;
        					setTimeout(ccck,300);
        				}
        				else{
        					if(imgUploader.uploadedFileNames.length == imgUploader.uploadCount){
        						$("input[name='brandAuthors']").val(imgUploader.getUploadedFileNameStr());
        						var loading = weui.loading('提交中...');
        						$('#xxform').submit();
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
	})
	
</script>

<script type="text/javascript">



var pageQueryData = {
		pageNum:0,
		size:5,
		sort:"pinyin",
		order:"asc",
		name_like_string:"",
		or_pinyin_like_string:""
	};

var lastLetter;

    $(function(){
        var $searchBar = $('#searchBar'),
            $searchResult = $('#searchResult'),
            $searchText = $('#searchText'),
            $searchInput = $('#searchInput'),
            $searchClear = $('#searchClear');
        function hideSearchResult(){
            $searchResult.hide();
            $searchInput.val('');
        }
        function cancelSearch(){
            hideSearchResult();
            $searchBar.removeClass('weui-search-bar_focusing');
            $searchText.show();
        }
        $searchText.on('click', function(){
            $searchBar.addClass('weui-search-bar_focusing');
            $searchInput.focus();
        });
        $searchInput
            .on('blur', function () {
                if(!this.value.length) cancelSearch();
            })
            .on('input', function(){
            	pageQueryData.name_like_string = this.value;
            	pageQueryData.or_pinyin_like_string = this.value;
                pageQueryData.pageNum = 0;
                $searchResult.empty();
                lastLetter = "";
                initBrandDrop();
            })
        ;
        $searchClear.on('click', function(){
            //hideSearchResult();
            $searchInput.focus();
        });
        
        // dropload
       function initBrandDrop(){
        	$('#searchResult').dropload({
        
            //scrollArea : window,
            isLockUp:true,
            domUp:"",
            loadDownFn : function(me){
            	pageQueryData.pageNum++;
                $.ajax({
                    type: 'GET',
                    url: ctx + "/wx/web/brand/query",
                    data:pageQueryData,
                    dataType: 'json',
                    success: function(data){
                        var arrLen = data.rows.length;
                        if(arrLen > 0){
                        	var row;
                            // 拼接HTML
                            var result = '';
                            for(var i=0; i<arrLen; i++){
                            	row = data.rows[i];
                                result += '<label class="weui-cell weui-check__label" for="' + row.id + '">';
                                var nas = "&nbsp;&nbsp;" + row.name;
                            	var fl = row.pinyin.charAt(0);
                            	if(fl != lastLetter){
                            		lastLetter = fl;
                            		nas = lastLetter.toUpperCase() + "&nbsp; " + row.name;
                            	}
                            	
                            	result += '<div class="weui-cell__bd">' +
                                	'<p>' + nas + '</p></div>' +
                                	'<div class="weui-cell__ft">' +
                                    	'<input type="checkbox" class="weui-check" onclick="brandListItemClick(this,\'' + row.name + '\')" id="' + row.id + '"/>' +
                                    	'<span class="weui-icon-checked"></span>' +
                                	'</div></label>';
                            }
                            // 插入数据到页面，放到最后面
                            $('#searchResult').append(result);
                            // 每次数据插入，必须重置
                            me.resetload();
                        
                        }else{// 如果没有数据
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
                    },
                    error: function(xhr, type){
                        alert('Ajax error!');
                        // 即使加载出错，也得重置
                        me.resetload();
                    }
                });
            }
        });
       }
        
       initBrandDrop();
    });

    
    function brandListItemClick(obj,name){
    	if(obj.checked){
    		if(!checkChoosed(name)){
    			$("#choose-choosed").children().last().before('<a href="javascript:;" onclick="delBrand(this)" class="weui-btn weui-btn_mini weui-btn_warn">'+ name + '</a> ');
    		}
    	}
    	else{
    		var cnames = $("#choose-choosed").children();
        	for(var i=0;i < cnames.length - 1;i++){
        		if($(cnames[i]).text() == name){
        			$(cnames[i]).remove();
        			return;
        		}
        	}
    	}
    }
    
    
    function delBrand(obj){
    	weui.confirm("您要删除该品牌吗？",function(){$(obj).remove()});
    }
    
    function checkChoosed(name){
    	var cnames = $("#choose-choosed").children();
    	for(var i=0;i < cnames.length - 1;i++){
    		if($(cnames[i]).text() == name){
    			return true;
    		}
    	}
    	return false;
    }
</script>
<script>
    var brandLogoImgUploader = new ImgUploader('brandLogoUploader',ctx + '/wx/web/upload/comm',false,1,0,'brandLogoUploadCount','brandLogoUploaderFiles',{type:"brand"});
    var nameOk = false;
    function checkBrandName(){
		var name = $('input[name="name"]').val();
		if(name != ""){
			$.getJSON(ctx + "/wx/web/brand/checkName",{name:name},function(data){
				if(data.id){
					weui.confirm("您输入的品牌名称已存在,是否选择此品牌？",function(){
						if(!checkChoosed(data.name)){
							$("#choose-choosed").children().last().before('<a href="javascript:;" onclick="delBrand(this)" class="weui-btn weui-btn_mini weui-btn_warn">'+ data.name + '</a> ');	
						}
						$dialog2.fadeOut(200);
						$dialog1.fadeIn(200);
					});
				}
			});
		}
	}
    $(function(){
    	h5FichEditorBrandInit("barndInro");
    	$('input[name="name"]').on("blur",checkBrandName);
    	$("#brandAddSubmit").on("click",function(){
        	weui.form.validate('#brandForm', function (error) {
                if (!error) {
                	var re = brandLogoImgUploader.upload();
            		if(re){
            			var xx = 1;
            			function ccck(){
            				if(brandLogoImgUploader.uploadedFileNames.length < brandLogoImgUploader.uploadList.length && xx < 10){
            					xx++;
            					setTimeout(ccck,300);
            				}
            				else{
            					if(brandLogoImgUploader.uploadedFileNames.length == brandLogoImgUploader.uploadCount){
            						$("input[name='logo']").val(brandLogoImgUploader.getUploadedFileNameStr());
            						var loading = weui.loading('提交中...');
            						//将文件加入到表单中提交
            						$('#brandForm').ajaxSubmit({dataType:"json",success:function(data){
            							loading.hide();
            							if(Constants.ResultStatus_Ok == data.status){
            								data = data.data;
            								if(!checkChoosed(data.name)){
            									$("#choose-choosed").children().last().before('<a href="javascript:;" onclick="delBrand(this)" class="weui-btn weui-btn_mini weui-btn_warn">'+ data.name + '</a> ');	
            								}
	            							weui.toast('提交成功', 3000);
	            							$dialog2.fadeOut(200);
	            							$dialog1.fadeIn(200);
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