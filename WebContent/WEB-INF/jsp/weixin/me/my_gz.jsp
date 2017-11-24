<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>我的关注</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<link rel="stylesheet" href="${ctx }/css/weui.list.css"/>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">我的关注</h2>
    </div>
    <div class="page__bd">
    	<div class="weui-search-bar" id="searchBar">
            <form class="weui-search-bar__form">
                <div class="weui-search-bar__box">
                    <i class="weui-icon-search"></i>
                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="名称/拼音首字母搜索" required/>
                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                </div>
                <label class="weui-search-bar__label" id="searchText">
                    <i class="weui-icon-search"></i>
                    <span>名称/拼音首字母搜索</span>
                </label>
            </form>
        </div>
	    <!-- 类别选择 -->
		<div class="weui-cell" style="padding:5px 10px 0;">
			<div class="weui-cell__bd weui-btn-area_inline">						
				<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
				<a href="javascript:;" data="a" onclick="chooseAmount(this,2)" class="weui-btn weui-btn_mini weui-btn_default">商家</a>
				<a href="javascript:;" data="a" onclick="chooseAmount(this,3)" class="weui-btn weui-btn_mini weui-btn_default">专家</a>
				<a href="javascript:;" data="a" onclick="chooseAmount(this,4)" class="weui-btn weui-btn_mini weui-btn_default">安装工</a>
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
		sort:"createTime",
		order:"desc",
		name:""
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
	pageQueryData.name = v;
    pageQueryData.pageNum = 0;
    if(categroys.length > 0){
    	pageQueryData.category = categroys.join(",");
    }
    else {
    	pageQueryData.category = "1,2,3,4";
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

function doView(id){
	location.href = ctx + "/wx/web/fx/view?id=" + id;
}

function doCheHui(id){
	weui.confirm('您确定取消关注？', function(){ 
		var loading = weui.loading('提交中...');
		//将文件加入到表单中提交
		$.getJSON(ctx + "/wx/web/fx/gz",{bgzid:id},function(data){
			loading.hide();
			if(Constants.ResultStatus_Ok == data.status){
				weui.toast('取消成功!', 3000);
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
            url: ctx + "/wx/web/me/queryMyGz",
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
                    	result += '<div class="weui-cell" id="' + row[0] + '">';
                        
                    	result += '<div class=weui-cell__hd" style="padding-top:8px;">';
                    	if(row[3] == null || row[3] == ""){
                    		result += '<img src="${ctx}/images/mms.png" height="70" width="70">';
                    	}
                    	else {
                    		result += '<img src="'+ publicDownloadUrl + row[3] + '" height="70" width="70">';
                    	}
                    	result += '</div>';
                    	result += '<div class="weui-cell__bd" onclick="doView(\'' + row[0] + '\')" style="margin-left:5px;">';
                    	result += '<div>';
                    	result += '<p class="title">' + row[1] + '</p>';
                    	result += '<span class="categ">';
                    	var cate = "";
                    	switch(row[2]){
                    		case '1' :
                    			cate = "厂家";
                    			break;
                    		case '2' :
                    			cate = "商家";
                    			break;
                    		case '3' :
                    			cate = "专家";
                    			break;
                    		case '4' :
                    			cate = "安装师傅";
                    			break;
                    		case '5' :
                    			cate = "自然人";
                    			break;
                    		case '6' :
                    			cate = "其他";
                    			break;
                    	}
    					result += cate + '</span>';	
                   		result += '</div>';
                   		result += '<p class="info">地址：' + row[4] + '</p>';
                   		result += '<p class="info">电话：<a href="tel:' + row[5] + '" class="tel">' + row[5] + '</a>  微信：' + row[6] + '</p>';
                   		result += '<p class="info">关注时间：' + row[7] + '</p>';
                   		result += '</div>';

                    	result += '<div class="weui-cell__ft" style="width:40px">';
                    	result += '<a href="javascript:;" onclick="doCheHui(\'' + row[0] + '\')" class="weui-btn weui-btn_mini weui-btn_plain-primary gz_button">取消关注</a>';
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