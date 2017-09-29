<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <div class="weui-btn-area_inline">
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
    	<div>
    		<h5>已选品牌：</h5>
	    	<div class="button-sp-area">
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
	            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn">按钮</a>
	        </div>
    	</div>
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
            <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
        </div>
        <div style="height:300px;overflow: auto;margin-top:5px;" id="searchResult">
        <div class="weui-cells__title"  style="margin-top:5px;">A</div>
        <div class="weui-cells searchbar-result" style="margin-top:5px;">
            <div class="weui-cell"  style="margin-top:5px;">
                <div class="weui-cell__bd weui-cell_primary">
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">按钮</a>
                </div>
            </div>
            </div>  
        <div class="weui-cells searchbar-result" >
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
    </div>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
	var openId = '${openId}';

	var $dialog1 = $("#dialog1");
	$("input[name='brandType']").on("click",function(){
		var value = $(this).val();
		if(value == 1 || value == 2){
			 $dialog1.fadeIn(200);
		}
	});

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