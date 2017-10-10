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
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">认证-品牌设置</h2>
    </div>	
	<!-- 工厂信息填写  -->
    <div class="page__bd">
      <form action="" method="post" id="form">
		<div class="weui-cells weui-cells_radio" style="margin-top:5px">
            <label class="weui-cell weui-check__label" for="x11">
                <div class="weui-cell__bd">
                    <p>代理品牌</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="brandType" value="1" id="x11"/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x12">
                <div class="weui-cell__bd">
                    <p>自有品牌</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="brandType" value="2" id="x12"/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
            <label class="weui-cell weui-check__label" for="x13">
                <div class="weui-cell__bd">
                    <p>无品牌</p>
                </div>
                <div class="weui-cell__ft">
                    <input type="radio" class="weui-check" name="brandType" value="3" id="x13"/>
                    <span class="weui-icon-checked"></span>
                </div>
            </label>
        </div>
    	<div style="margin-top:10px;padding:0 10px;">
    		<div style="margin-top:5px;">
		   		<h5 style="float: left;width:50%;height:25px">已选品牌(点击可删除)：</h5>
		   		<a herf="javascript:;" id="chooseBranda" style="float: right;width:50%;text-align: right;color:green;">选择品牌</a>
	   		</div>
	    	<div class="button-sp-area">
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn">按钮</a>
	        </div>
            <div id="uploader">
                <div class="weui-cell__bd">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <h5 class="weui-uploader__title">品牌授权书拍照上传</h5>
                            <div class="weui-uploader__info"><span id="uploadCount">0</span>/20</div>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            <c:forTokens items="${fi.certificates }" var="it" delims=";">
                                <li class="weui-uploader__file" style="background-image:url(${ctx}/wx/web/upload/${it })" data-id="${it }"></li>
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
				<a href="" style="font-size: 12px;color:blue;">点我，下载品牌授权书模板</a>
			</div>
        </div>
        <div class="weui-btn-area_inline" style="margin-top: 10px;">
            <a class="weui-btn weui-btn_primary" href="javascript:" id="cc1Pre">下一步</a>
        </div>
    </form>
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div> 
<div class="js_dialog" id="dialog1" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog" style="text-align:left;padding:0 5px;">  
    	<h4 style="text-align:center;margin:5px 0">品牌选择</h4>
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
            <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">新增</a>
        </div>
        <div class="searchbar-result" id="searchResult" style="height:200px;overflow: auto">
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
            <div class="weui-cell weui-cell_access">
                <div class="weui-cell__bd weui-cell_primary">
                    <p>实时搜索文本</p>
                </div>
            </div>
        </div>
    	<div class="weui-cells" style="margin-top:10px;">
	   		<h5 style="margin-top:5px;">已选品牌：</h5>
	    	<div class="button-sp-area">
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn">按钮</a>
	        </div>
	    	<div class="weui-cell weui-btn-area_inline">
	        	<a class="weui-btn weui-btn_primary" href="javascript:;" id="brandChooseOk">确定</a>    
	        </div>
        </div>
    </div>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script type="text/javascript" src="${ctx }/js/app/weixin/img_upload.js"></script>
<script>
	var openId = '${openId}';

	var $dialog1 = $("#dialog1");
	$("input[name='brandType']").on("click",function(){
		var value = $(this).val();
		if(value == 1 || value == 2){
			 $dialog1.fadeIn(200);
		}
	});
	$("#chooseBranda").on("click",function(){
		$dialog1.fadeIn(200);
	});
	
	$("#brandChooseOk").on("click",function(){
		$dialog1.fadeOut(200);
	});
	
	var imgUploader = new ImgUploader('uploader',ctx + '/wx/web/upload/auth',false,20,0,'uploadCount','uploaderFiles');
</script>

<script type="text/javascript">
    $(function(){
        var $searchBar = $('#searchBar'),
            $searchResult = $('#searchResult'),
            $searchText = $('#searchText'),
            $searchInput = $('#searchInput'),
            $searchClear = $('#searchClear'),
            $searchCancel = $('#searchCancel');
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
                if(this.value.length) {
                    $searchResult.show();
                } else {
                    $searchResult.hide();
                }
            })
        ;
        $searchClear.on('click', function(){
            hideSearchResult();
            $searchInput.focus();
        });
        $searchCancel.on('click', function(){
            cancelSearch();
            $searchInput.blur();
        });
    });
</script>
</html>