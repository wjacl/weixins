<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>发布历史</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<link rel="stylesheet" href="${ctx }/css/weui.list.css"/>
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
                    <span>标题搜索</span>
                </label>
            </form>
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
		sort:"createTime",
		order:"desc",
		title_like_string:""
	};

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
    	pageQueryData.title_like_string = v;
        pageQueryData.pageNum = 0;
        $searchResult.empty();
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
	location.href = "view?id=" + id;
}

function doCheHui(id){
	weui.confirm('您确定撤回？', function(){ 
		var loading = weui.loading('提交中...');
		//将文件加入到表单中提交
		$.getJSON("chehui",{id:id},function(data){
			loading.hide();
			if(Constants.ResultStatus_Ok == data.status){
				weui.toast('成功撤回!', 3000);
				setTimeout($("#" + id).remove(),4000);
			}
			else{
				if(data.mess){
					weui.alert(data.mess);
				}
				else{
					weui.alert("提交失败，请重试！");
				}
			}
		});
	});
}

 	function loadPageData(me){
 		$.ajax({
            type: 'GET',
            url: ctx + "/wx/web/fb/queryMyfb",
            data:pageQueryData,
            dataType: 'json',
            success: function(data){      	
                // 拼接HTML
                var result = '';
                var arrLen = data.rows.length;
                if(arrLen > 0){
                	var row;
                    for(var i=0; i<arrLen; i++){
                    	row = data.rows[i];
                    	result += '<div class="weui-cell" id="' + row.id + '">';
                        
                    	result += '<div class=weui-cell__hd" style="padding-top:8px;">';
                    	if(row.img == null || row.img == ""){
                    		result += '<img src="${ctx}/images/mms.png" height="70" width="70">';
                    	}
                    	else {
                    		result += '<img src="'+ publicDownloadUrl + row.img + '" height="70" width="70">';
                    	}
                    	result += '</div>';
                    	result += '<div class="weui-cell__bd" onclick="doView(\'' + row.id + '\')" style="margin-left:5px;">';
                    	result += '<div>';
                    	result += '<p class="title">' + row.title + '</p>';
                    		
                   		result += '</div>';
                   		result += '<p class="info">发布时间：' + row.createTime.substring(0,16) + '</p>';
                   		result += '</div>';

                    	result += '<div class="weui-cell__ft" style="width:40px">';
                    	result += '<a href="javascript:;" onclick="doCheHui(\'' + row.id + '\')" class="weui-btn weui-btn_mini weui-btn_plain-primary gz_button">撤回</a>';
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