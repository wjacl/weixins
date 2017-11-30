<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>审核</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<link rel="stylesheet" href="${ctx }/css/weui.list.css"/>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">待审核认证列表</h2>
    </div>
    <div class="page__bd">
		<div class="weui-cells mtop5" style="overflow: auto;height:500px;" id="searchResult">
	
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
		order:"asc"
	};

function doView(id){
	location.href = ctx + "/wx/web/fx/view/" + id;
}

function doCheHui(id){
	location.href="toAudit?id=" + id;
}

 	function loadPageData(me){
 		$.ajax({
            type: 'GET',
            url: ctx + "/wx/web/auth/queryAuditList",
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
                    	result += '<div class="weui-cell" id="' + row.openId + '">';
                        
                    	result += '<div class=weui-cell__hd" style="padding-top:8px;">';
                    	if(row.logo == null || row.logo == ""){
                    		result += '<img src="${ctx}/images/mms.png" height="70" width="70">';
                    	}
                    	else {
                    		result += '<img src="'+ publicDownloadUrl + row.logo + '" height="70" width="70">';
                    	}
                    	result += '</div>';
                    	result += '<div class="weui-cell__bd" onclick="doCheHui(\'' + row.openId + '\')" style="margin-left:5px;">';
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
                   		result += '</div>';

                    	result += '<div class="weui-cell__ft" style="width:40px">';
                    	result += '<a href="javascript:;" onclick="doCheHui(\'' + row.openId + '\')" class="weui-btn weui-btn_mini weui-btn_plain-primary gz_button">审核</a>';
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