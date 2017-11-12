<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>品牌</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__bd">
    	<div class="weui-search-bar" id="searchBar">
            <form class="weui-search-bar__form">
                <div class="weui-search-bar__box">
                    <i class="weui-icon-search"></i>
                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="品牌搜索" required/>
                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                </div>
                <label class="weui-search-bar__label" id="searchText">
                    <i class="weui-icon-search"></i>
                    <span>品牌搜索</span>
                </label>
            </form>
        </div>
	        <div class="weui-cell" style="padding:5px 10px;">
		    	<div class="weui-cell__bd">
		    		<h5>热门品牌</h5>
		    		<div>
		    		<c:forEach items="${hots }" var="d">
		    			<a href="brandView?id=${d.brand.id }">
		    				<c:choose>
		    					<c:when test="${not empty d.brand.logo }">
		    						<img alt="${d.brand.name }" src="${publicDownloadUrl }${d.brand.log}" height="40"/>
		    					</c:when>
		    					<c:otherwise>
		    						<img alt="${d.brand.name }"  height="40"/>
		    					</c:otherwise>
		    				</c:choose>
		    			</a>
		    		</c:forEach>
		    		</div>
		        </div>
	        </div>
		<div class="weui-cells" style="overflow: auto;height:500px;" id="searchResult">
	
		</div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
var pageQueryData = {
		pageNum:0,
		size:10,
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
    
    function cancelSearch(){
        $searchBar.removeClass('weui-search-bar_focusing');
        $searchText.show();
    }
    $searchText.on('click', function(){
        $searchBar.addClass('weui-search-bar_focusing');
        $searchInput.focus();
    });
    $searchInput
        .on('input', reInitSearch)
        .on('blur',function(){
        	if(this.value.length == 0){
        		cancelSearch();
        	}
        });
    
    function reInitSearch(){
    	var v = $searchInput.val();
    	pageQueryData.name_like_string = v;
    	pageQueryData.or_pinyin_like_string = v;
        pageQueryData.pageNum = 0;
        $searchResult.empty();
        lastLetter = "";
        initBrandDrop();
    }
    $searchClear.on('click', function(){
        //hideSearchResult();
        $searchInput.val('');
        $searchInput.focus();
        reInitSearch();
    });
});

function doView(id){
	location.href = "brandView?id=" + id;
}

 	function loadPageData(me){
 		$.ajax({
            type: 'GET',
            url: ctx + "/wx/pub/fx/brandQuery",
            data:pageQueryData,
            dataType: 'json',
            success: function(data){      	
                // 拼接HTML
                var result = '';
                var arrLen = data.rows.length;
                if(arrLen > 0){
                	var row;
                	var mon;
                	var info;
                    for(var i=0; i<arrLen; i++){
                    	row = data.rows[i];
                    	 result += '<div class="weui-cell">';
                         var nas = "&nbsp;&nbsp;&nbsp;&nbsp;" + row.name;
                     	var fl = row.pinyin.charAt(0);
                     	if(fl != lastLetter){
                     		lastLetter = fl;
                     		nas = lastLetter.toUpperCase() + "&nbsp; " + row.name;
                     	}
                     	
                     	result += '<div class="weui-cell__bd">' +
                     		'<h5 onclick="doView(\'' + row.id + '\')">'  + nas + '</h5></div>' +
                         	'</div>';
                    }

                    $(".dropload-refresh").remove();
                    // 插入数据到页面，放到最后面
                    $('#searchResult').append(result);
                    if(data.pageNum * data.size >= data.total){
                    	// 锁定
                        me.lock();
                        // 无数据
                        me.noData();
                        $('#searchResult').append(me.opts.domDown.domNoData);
                    }
                    else{
                    	$('#searchResult').append(me.opts.domDown.domRefresh);
                    }
                
                }else{// 如果没有数据
                	// 锁定
                    me.lock();
                    // 无数据
                    me.noData();
                    $(".dropload-refresh").remove();
                    $('#searchResult').append(me.opts.domDown.domNoData);
                }
               	$(".dropload-down").remove();
                me.resetload();
            },
            error: function(xhr, type){
                weui.alert('Ajax error!');
                // 即使加载出错，也得重置
                me.resetload();
             	// 锁定
                me.lock();
                // 无数据
                me.noData();
            }
        });
 	}
 	
     // dropload
    function initBrandDrop(){
     	$('#searchResult').dropload({ 
        	loadDownFn : function(me){
         		pageQueryData.pageNum++;
         		loadPageData(me);
         	}
     	});
    }
     
    initBrandDrop();
</script>
</html>