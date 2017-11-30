<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>我的浏览记录</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<link rel="stylesheet" href="${ctx }/css/weui.list.css"/>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">我的浏览记录</h2>
    </div>
    <div class="page__bd">
    	<div class="weui-search-bar" id="searchBar">
            <form class="weui-search-bar__form">
                <div class="weui-search-bar__box">
                    <i class="weui-icon-search"></i>
                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="名称搜索" required/>
                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                </div>
                <label class="weui-search-bar__label" id="searchText">
                    <i class="weui-icon-search"></i>
                    <span>名称搜索</span>
                </label>
            </form>
        </div>
	    <!-- 类别选择 -->
		<div class="weui-cell" style="padding:5px 10px 0;">
			<div class="weui-cell__bd weui-btn-area_inline">						
				<a href="javascript:;" data="a" onclick="chooseAmount(this,'f')" class="weui-btn weui-btn_mini weui-btn_default">经营主体</a>
				<a href="javascript:;" data="a" onclick="chooseAmount(this,'b')" class="weui-btn weui-btn_mini weui-btn_default">品牌</a>
				<a href="javascript:;" data="a" onclick="chooseAmount(this,'p')" class="weui-btn weui-btn_mini weui-btn_default">产品</a>
				<a href="javascript:;" data="a" onclick="chooseAmount(this,'m')" class="weui-btn weui-btn_mini weui-btn_default">信息</a>
			</div>
		</div>
		<div class="weui-cells no-top-line mtop5" style="overflow: auto;height:500px;" id="searchResult">
	
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
		sort:"vtime",
		order:"desc",
		oname_like_string:""
	};
	
//类别选择处理
var categroys = [];
function chooseAmount(obj,cate){
	var $a = $(obj)
	if($a.attr("data") == "a"){
		$a.addClass("weui-btn_warn");
		$a.removeClass("weui-btn_default");
		$a.attr("data","c");
		categroys.push(cate);
	}
	else{
		$a.addClass("weui-btn_default");
		$a.removeClass("weui-btn_warn");
		$a.attr("data","a");
		for(var i = categroys.length - 1; i >= 0; i--){
			if(categroys[i] == cate){
				categroys.splice(i,1);
				break;
			}
		}
	}
	
	//查询
	reInitSearch();
}


function reInitSearch(){
	var v = $('#searchInput').val();
	pageQueryData.oname_like_string = v;
    pageQueryData.pageNum = 0;
    if(categroys.length > 0){
    	pageQueryData.otype_in_string = categroys.join(",");
    }
    else {
    	pageQueryData.otype_in_string = "";
    }
    $('#searchResult').empty();
    initBrandDrop();
}

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

    $searchClear.on('click', function(){
        //hideSearchResult();
        $searchInput.val('');
        $searchInput.focus();
        reInitSearch();
    });
});

function doView(id,otype){
	switch(otype){
		case 'f':
			location.href = ctx + "/wx/web/fx/view/" + id;
			break;
		case 'b':
			location.href = ctx + "/wx/web/fx/brandView/" + id;
			break;
		case 'p':
			location.href = ctx + "/wx/web/prod/view/" + id;
			break;
		case 'm':
			location.href = ctx + "/wx/web/fb/view/" + id;
			break;
		
	}
}



 	function loadPageData(me){
 		$.ajax({
            type: 'GET',
            url: ctx + "/wx/web/me/queryMyView",
            data:pageQueryData,
            dataType: 'json',
            success: function(data){      	
                // 拼接HTML
                var result = '';
                if(data.rows && data.rows.length > 0) {
                	var arrLen = data.rows.length;
                	var row;
                    for(var i=0; i<arrLen; i++){
                    	row = data.rows[i];
                    	result += '<div class="weui-cell" id="' + row.id + '">';
                    	result += '<div class="weui-cell__bd" onclick="doView(\'' + row.oid + '\',\'' + row.otype + '\')" style="margin-left:5px;">';
                    	result += '<div>';
                    	result += '<p class="title">' + row.oname + '</p>';
                   		result += '</div>';

                    	var cate = "";
                    	switch(otype){
	                		case 'f':
	                			cate="经营主体";
	                			break;
	                		case 'b':
	                			cate="品牌";
	                			break;
	                		case 'p':
	                			cate="产品";
	                			break;
	                		case 'm':
	                			cate="信息";
	                			break; 		
                		}
                   		result += '<p class="info">' + cate + '</p>';
                   		result += '<p class="info">浏览时间：' + row.vtime + '</p>';
                   		result += '</div>';
                     	
                     	result += '</div>';
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