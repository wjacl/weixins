<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>派单</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
</head>
<body ontouchstart="">
<div class="page">	
    <div class="page__hd" style="margin-top:5px">
         <h2 style="text-align:center;vertical-align: middle;">派单</h2>
    </div>	
    <div class="page__bd"> 	
				<form action="save" method="post" id="pform">
					<div class="weui-cells weui-cells_form mtop5"> 			
						<div class="weui-cell">
			                <div class="weui-cell__bd">
			                	<p><label class="weui-label">说明：</label></p>
			                    <textarea class="weui-textarea" placeholder="请输入说明" name="remark" rows="4"></textarea>
			                </div>
						</div> 			
			            <div class="weui-cell" id="productUploader">
			                <div class="weui-cell__bd">
			                    <div class="weui-uploader">
			                        <div class="weui-uploader__hd">
			                            <p class="weui-uploader__title">图片：</p>
			                            <div class="weui-uploader__info"><span id="productUploaderCount"></span></div>
			                        </div>
			                        <div class="weui-uploader__bd">
			                            <ul class="weui-uploader__files" id="productUploaderFiles">
			                            <c:if test="${not empty p.img }">
				                            <c:forTokens items="${p.img }" var="it" delims=";">
				                                <li class="weui-uploader__file" style="background-image:url(${publicDownloadUrl}${it })" data-id="${it }"></li>
				                            </c:forTokens>
			                            </c:if>
			                            </ul>
			                            <div class="weui-uploader__input-box">
			                                <input id="productUploaderInput" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple/>
			                            </div>
			                        </div>
			                    </div>
			                </div>
						</div>
			            <div class="weui-cell">
			                <div class="weui-cell__bd">
			                	<p>选择安装师傅：</p>
			                	<div>
			                		<p>常用安装师傅：</p>
			                		<div class="button-sp-area" id="noraml" style="padding:10px 5px;">
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家厂家厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
	        						</div>
			                    </div>
			                	<div>
			                		<p>选择其他安装师傅：</p>
			                		<div>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                			<a href="javascript:;" data="a" onclick="chooseAmount(this,1)" class="weui-btn weui-btn_mini weui-btn_default">厂家</a>
			                		</div>
			                    </div>
			                </div>
			            </div>
			        <div class="weui-cell no-top-line weui-btn-area_inline">
						<input type="hidden" name="pubId" value="${openId }">
						<input type="hidden" dd="prod" name="img" >
			            <a class="weui-btn weui-btn_primary" href="javascript:;" id="pformSubmitBtn">派单</a>
			        </div>
			    </div>
			    </form>   
	</div>
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>

<div class="page" id="mapChoose">
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
		<div class="weui-cells mtop5" style="overflow: auto;height:300px;" id="searchResult">
	
		</div>
	</div>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script type="text/javascript" src="${ctx }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${ctx }/js/app/weixin/img_upload.js"></script>
<script>
	
	var productImgUploader = new ImgUploader('productUploader',ctx + '/wx/web/upload/comm',false,10,0,'productUploaderCount','productUploaderFiles',{type:'worder'});
	
	$(function(){
		
	  	$("#pformSubmitBtn").on("click",function(){
        	weui.form.validate('#pform', function (error) {
                if (!error) {
                	var re = productImgUploader.upload();
            		if(re){
            			var xx = 1;
            			function ccck(){
            				if(productImgUploader.uploadedFileNames.length < productImgUploader.uploadList.length && xx < 10){
            					xx++;
            					setTimeout(ccck,300);
            				}
            				else{
            					if(productImgUploader.uploadedFileNames.length == productImgUploader.uploadCount){
            						$("input[dd='prod']").val(productImgUploader.getUploadedFileNameStr());
            						var loading = weui.loading('提交中...');
            						//将文件加入到表单中提交
            						$('#pform').ajaxSubmit({dataType:"json",success:function(data){
            							loading.hide();
            							if(Constants.ResultStatus_Ok == data.status){
	            							weui.toast('修改成功', 3000);
	            							setTimeout(location.href="${ctx}/wx/web/fx/view?id=${p.pubId}",4000);
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
	
	var workers = [];
	function chooseAmount(obj,cate){
		var $a = $(obj)
		if($a.attr("data") == "a"){
			$a.addClass("weui-btn_warn");
			$a.removeClass("weui-btn_default");
			$a.attr("data","c");
			workers.push(cate);
		}
		else{
			$a.addClass("weui-btn_default");
			$a.removeClass("weui-btn_warn");
			$a.attr("data","a");
			for(var i = workers.length - 1; i >= 0; i--){
				if(workers[i] == cate){
					workers.splice(i,1);
					break;
				}
			}
		}
	}
</script>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<script>

var map,center,markersArray = [];
var bounds;
function init() {
	/* wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
	    	center = new qq.maps.LatLng(res.latitude,res.longitude)
	    	initMap();
	    }
	}); */
	center = new qq.maps.LatLng(39.916527,116.397128);
	initMap();
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

//分页查询相关
var pageQueryData = {
		pageNum:0,
		size:30,
		sort:"pinyin",
		order:"asc",
		category:"4",
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
	location.href = "view?id=" + id;
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