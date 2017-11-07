<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>费用</title>
	<%@ include file="/WEB-INF/jsp/weixin/comm_css.jsp" %>
	<style type="text/css">
		.dd1{
			background-color: #909090;
			border-color:#909090;
			text-align: center;
			vertical-align: middle;
			color:#F8F8F8;
			font-weight: 700;
			padding:5px 0;
		}
		.dd1 a {
			margin-top:12px;
		}
		
		.dd2{
			background-color: #D0D0D0;
			border-color:#D0D0D0;
			padding:5px 10px;
			font-size:12px;
			vertical-align: middle;
		}
	</style>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__bd">
		<div class="weui-flex dd1">		
			<div  class="weui-flex__item">
				<p>保证金</p>
				<p>500￥</p>
			</div>
			<div  class="weui-flex__item">
				<p>余额</p>
				<p>500￥</p>
			</div>
			<div  class="weui-flex__item">
				<a href="" class="weui-btn weui-btn_mini weui-btn_primary">充值</a>
			</div>
		</div>
		<div class="dd2">
			交易记录
			<a href="javascript:;" id="showDatePicker" style="float:right"><img src="${ctx }/images/calender.png" height="24px"></a>
		</div>
		<div></div>
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
		order:"desc"
	};

var lastLetter;
	
	$(function(){
		$('#showDatePicker').on('click', function () {
			var pdata = wx_comm.getMonthPickerData();		
	        weui.picker(pdata.years,pdata.months,{
	        	defaultValue: [pdata.currYear,pdata.currMonth],
	            onChange: function (result) {
	                
	            },
	            onConfirm: function (result) {
	                reInitSearch(result.join("-"));
	            }
	        });
	    });
	});	
	
	
 function reInitSearch(month){
	 if(pageQueryData.month != month){
     	pageQueryData.month = month;
        pageQueryData.pageNum = 0;
        $searchResult.empty();
        lastLetter = "";
        initBrandDrop();
	 }
 }
     
     // dropload
    function initBrandDrop(){
     	$('#searchResult').dropload({       
         loadDownFn : function(me){
         	pageQueryData.pageNum++;
             $.ajax({
                 type: 'GET',
                 url: ctx + "/wx/web/trade/query",
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
                             result += '<label class="weui-cell weui-check__label" for="' + row.id + '">';
                             var nas = "&nbsp;&nbsp;" + row.name;
                         	var fl = row.pinyin.charAt(0);
                         	if(fl != lastLetter){
                         		lastLetter = fl;
                         		nas = lastLetter.toUpperCase() + "&nbsp; " + row.name;
                         	}
                         	
                         	result += '<div class="weui-cell__bd">' +
                             	'<p>' + nas + '</p></div>' +
                             	'<div class="weui-cell__ft">' +
                                 	'<input type="checkbox" class="weui-check" onclick="brandListItemClick(this,\'' + row.name + '\')" id="' + row.id + '"/>' +
                                 	'<span class="weui-icon-checked"></span>' +
                             	'</div></label>';
                         }
                         // 插入数据到页面，放到最后面
                         $('#searchResult').append(result);
                     
                     }else{// 如果没有数据
                         // 锁定
                         me.lock();
                         // 无数据
                         me.noData();
                     }
                     // 每次数据插入，必须重置
                     //me.resetload();
                  // 为了测试，延迟1秒加载
                     setTimeout(function(){
                         // 每次数据插入，必须重置
                         me.resetload();
                     },1000);
                 },
                 error: function(xhr, type){
                     alert('Ajax error!');
                     // 即使加载出错，也得重置
                     me.resetload();
                 }
             });
         },
     });
    }
     
    initBrandDrop();
</script>
</html>