<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>${b.name }</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<link href="${ctx }/js/froala-editor/css/froala_style.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${ctx }/css/weui.list.css"/>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__bd">
    	<div class="weui-cell" style="padding:10px;border-bottom: 1px solid #e5e5e5;">
    		<c:if test="${not empty b.logo }">
	    		<div class=weui-cell__hd" style="padding-top:8px;">
	    			<img src="${publicDownloadUrl}${b.logo}" height="77" width="70">
	    		</div>
    		</c:if>
    		<div class="weui-cell__bd" style="margin-left:5px;">
    			<div>
    				<p class="title">${b.name }</p>
    			</div>
    		</div>
    	</div>
    	<div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item weui-bar__item_on" data-for="intro">
					品牌简介
                </div>
                <div class="weui-navbar__item" data-for="prod">
			                     品牌经销商
                </div>
            </div>
	    	<div class="weui-tab__panel fr-view" id="intro" style="padding-left:10px;padding-right:10px;">
		      ${b.intro }
		    </div>
            <div class="weui-tab__panel" id="prod" style="display:none;padding-top:30px;">
				<div class="weui-cells no-top-line" style="overflow: auto;height:400px;" id="searchResult">
				</div>
            </div>
        
        </div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>
$(function(){
    $('.weui-navbar__item').on('click', function () {
        $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
    	var id = $(this).data("for");
    	if(id == "intro"){
    		$("#prod").hide();
    	}
    	else{
    		$("#intro").hide();
    	}
    	$("#" + id).show();
    });
});

</script>
<script>
var pageQueryData = {
		pageNum:0,
		size:10,
		sort:"pinyin",
		order:"asc",
		brands_like_string:'${b.name}'
	};

function doView(id){
	location.href = "view/" + id;
}

 	function loadPageData(me){
 		$.ajax({
            type: 'GET',
            url: ctx + "/wx/web/fx/fxQuery",
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
						result += '<div class="weui-cell" id="' + row.id + '">';
                        
                    	result += '<div class=weui-cell__hd" style="padding-top:8px;">';
                    	if(row.logo == null || row.logo == ""){
                    		result += '<img src="${ctx}/images/mms.png" height="70" width="70">';
                    	}
                    	else {
                    		result += '<img src="'+ publicDownloadUrl + row.logo + '" height="70" width="70">';
                    	}
                    	result += '</div>';
                    	result += '<div class="weui-cell__bd" onclick="doView(\'' + row.id + '\')" style="margin-left:5px;">';
                    	result += '<div>';
                    	result += '<p class="title">' + row.name + '</p>';
                    	result += '<span class="categ">';
                    	var cate = "";
                    	switch(row.category){
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
                   		result += '<p class="info">地址：' + row.address + '</p>';
                   		result += '<p class="info">电话：<a href="tel:' + row.mphone + '" class="tel">' + row[5] + '</a>  微信：' + row.wechat + '</p>';
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