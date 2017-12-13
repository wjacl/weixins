<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>附近</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body onload="init()" ontouchstart>
<div class="page">
    <div class="page__bd">
    	<div class="weui-search-bar" id="searchBar">
            <form class="weui-search-bar__form">
                <div class="weui-search-bar__box">
                    <i class="weui-icon-search"></i>
                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="名称搜索" />
                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                </div>
                <label class="weui-search-bar__label" id="searchText">
                    <i class="weui-icon-search"></i>
                    <span>名称搜索</span>
                </label>
            </form>
        </div>
        <!-- 地图 -->
	    <div id="mapContainer" style="height:240px">
	    
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
		<div class="weui-cells mtop5" style="overflow: auto;height:300px;" id="searchResult">
	
		</div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<%@ include file="/WEB-INF/jsp/weixin/js_sdk_config.jsp" %>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<script>

var map,center,markersArray = [];
var bounds;
function init() {
	wx.ready(function(){
		wx.getLocation({
		    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
		    success: function (res) {
		    	center = new qq.maps.LatLng(res.latitude,res.longitude)
		    	initMap();
		    }
		}); 
	});
	/* center = new qq.maps.LatLng(39.916527,116.397128);
	initMap(); */
}

function initMap(){
    map = new qq.maps.Map(document.getElementById("mapContainer"), {
        // 地图的中心地理坐标。
       center: center,
       zoom: 13,
       minZoom:8,
       disableDefaultUI: true,
    });
    /* var decoration = new qq.maps.MarkerDecoration(100, new qq.maps.Point(0, -5));
    var marker = new qq.maps.Marker({
        position: center,
        decoration:decoration,
        map: map
    }); */
    //添加缩放监听
    qq.maps.event.addListener(map,'zoom_changed',function() {
        bounds = map.getBounds();
        $searchInput = $('#searchInput').blur();
    	reInitSearch();
    });
    
    //当地图中心属性更改时触发事件
    qq.maps.event.addListener(map, 'center_changed', function() {
        bounds = map.getBounds();
        $searchInput = $('#searchInput').blur();
    	reInitSearch();
    });
    
    setTimeout(function(){
    bounds = map.getBounds();     //获取函数范围
    if(bounds){                       //如果得到函数范围值 
        //获取数据    
        reInitSearch();
        
    }},1000);
	
}

//添加标记
function addMarker(location,index) {
	var decoration = new qq.maps.MarkerDecoration(index, new qq.maps.Point(0, -5));
    var marker = new qq.maps.Marker({
        position: location,
        decoration:decoration,
        map: map
    });
    markersArray.push(marker);
}

//删除覆盖物
function deleteOverlays() {
    if (markersArray) {
        for (i in markersArray) {
            markersArray[i].setMap(null);
        }
        markersArray.length = 0;
    }
}


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

//分页查询相关
var pageQueryData = {
		pageNum:0,
		size:30,
		sort:"pinyin",
		order:"asc",
		name_like_string:"",
		or_pinyin_like_string:""
	};

var lastLetter;

function reInitSearch(){
	var v = $('#searchInput').val();
	pageQueryData.name_like_string = v;
	pageQueryData.or_pinyin_like_string = v;
    pageQueryData.pageNum = 0;
    if(!bounds){
    	 bounds = map.getBounds();
    }
    pageQueryData.lat_gt_doubt = bounds.lat.minY;
    pageQueryData.lat_lt_doubt = bounds.lat.maxY;
    pageQueryData.lng_gt_doubt = bounds.lng.minX;
    pageQueryData.lng_lt_doubt = bounds.lng.maxX;
    if(categroys.length > 0){
    	pageQueryData.category_in_string = categroys.join(",");
    }
    else {
    	pageQueryData.category_in_string = "1,2,3,4";
    }
    $('#searchResult').empty();
    lastLetter = "";
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

function reMark(page){
	if(page.pageNum == 1){
		deleteOverlays();
	}
	if(page.rows && page.rows.length > 0) {
		var row;
		var index = (page.pageNum - 1) * page.size;
		for(var i = 0; i < page.rows.length; i++){
			index++;
			row = page.rows[i];
			if(row.lat && row.lng){
				var loca = new qq.maps.LatLng(row.lat / 1,row.lng / 1);
				addMarker(loca,index);
			}
		}
	}
}

function doView(id){
	location.href = "view/" + id;
}

 	function loadPageData(me){
 		$.ajax({
            type: 'POST',
            async:false,
            url: ctx + "/wx/web/fx/fxQuery",
            data:pageQueryData,
            dataType: 'json',
            success: function(data){   
            	//图上处理
            	reMark(data);
                // 拼接HTML
                var result = '';
                var arrLen = data.rows.length;
                if(arrLen > 0){
                	var row;
                	var mon;
                	var info;
                	var index = (data.pageNum - 1) * data.size;
                    for(var i=0; i<arrLen; i++){
                    	row = data.rows[i];
                    	index++;
                    	 result += '<div class="weui-cell">';
                         var nas = "&nbsp;&nbsp;" + '<span class="weui-badge" style="margin-right: 5px;">' + index + '</span>' + row.name;
                     	var fl = row.pinyin.charAt(0);
                     	if(fl != lastLetter){
                     		lastLetter = fl;
                     		nas = lastLetter.toUpperCase() + "&nbsp; " + '<span class="weui-badge" style="margin-right: 5px;">' + index + '</span>' + row.name;
                     	}
                     	
                     	result += '<div class="weui-cell__bd">' +
                         	'<div><h5 class="line_block" style="width:70%"  onclick="doView(\'' + row.id + '\')">' + nas + '</h5>' + 
                         	'<h5 class="line_block" style="width:30%;"><a href="tel:' + row.mphone + '" >' + row.mphone + '</a></h5></div>' +
                         	'<p style="padding-left:30px;font-size:13px;">' + row.address + '</p></div>' +
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
</script>
</html>