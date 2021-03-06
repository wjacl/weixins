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
		
		.tinfo{	
			font-size:16px;
			font-weight: 700;
			padding-left:10px;
			vertical-align: middle;
		}
		.ttime{
			font-size:14px;
			color:#D0D0D0;
			font-weight: 700;
			padding-left:10px;
			vertical-align: middle;
		}
		.tamount_o {
			font-size:20px;
			font-weight: 700;
		}
		.tamount_i {
			font-size:20px;
			font-weight: 700;
			color:#FF9900;
		}
		.ttj_month{
			background-color:#F8F8F8;
			font-size:14px;
			font-weight: 700;
		}
		.ttj_month_info{
			font-size:13px;
			color:#C0C0C0;
		}
	</style>
</head>
<body ontouchstart>
<div class="page">
    <div class="page__bd">
		<div class="weui-flex dd1">		
			<div  class="weui-flex__item">
				<p>保证金</p>
				<p>￥${ac.bzj }</p>
			</div>
			<div  class="weui-flex__item">
				<p>余额</p>
				<p>￥${ac.balance }</p>
			</div>
			<div  class="weui-flex__item">
				<a href="cz" class="weui-btn weui-btn_mini weui-btn_primary">充值</a>
			</div>
		</div>
		<div class="dd2">
			交易记录
			<a href="javascript:;" id="showDatePicker" style="float:right"><img src="${ctx }/images/calender.png" height="24px"></a>
		</div>
		<div class="weui-cells" style="overflow: auto;height:500px;" id="searchResult">
	
		</div>
	</div>	
	<%@ include file="/WEB-INF/jsp/weixin/footer.jsp" %>
</div>
</body>
<%@ include file="/WEB-INF/jsp/weixin/comm_js.jsp" %>
<script>

	var nowMonth = _sysCurrDate.substring(0,7);
	var pageQueryData = {
			pageNum:0,
			size:10,
			sort:"createTime",
			order:"desc",
			month:nowMonth
		};
		
	//列表上用来判断是否加入月统计用
	var lastMonth;
	
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
        $('#searchResult').empty();
        lastMonth = "";
        initBrandDrop();
	 }
 }
    
 	function getMonthTjInfo(mm,tjArray){
 		var month = mm;
 		if(month.charAt(4) == '0'){
 			month = mm.substring(0,4) + mm.charAt(5);
 		}
 		for(var i=0; i < tjArray.length; i++){
 			if(tjArray[i][0] == month){
 				return "消费支出：￥" + tjArray[i][2] + "&nbsp;&nbsp;充值：￥" + tjArray[i][1];
 			}
 		}
 	}

 	function loadPageData(me){
 		$.ajax({
            type: 'GET',
            url: ctx + "/wx/web/fee/query",
            data:pageQueryData,
            dataType: 'json',
            success: function(data){      	
                // 拼接HTML
                var result = '';
                var arrLen = data.page.rows.length;
                if(arrLen > 0){
                	var row;
                	var mon;
                	var info;
                    for(var i=0; i<arrLen; i++){
                    	row = data.page.rows[i];
                    	var ym = row.createTime.substring(0,7).split("-");
                    	mon = ym[0] + ym[1];
                    	if(mon != lastMonth){
                    		result += '<div class="weui-cell ttj_month">' +
				                    		'<div class="weui-cell__bd">' +
				            					'<p>'+ ym[0] + '年' + ym[1] + '月</p>' +
				            					'<p class="ttj_month_info">' + getMonthTjInfo(mon,data.tj) + '</p>' +
				            				'</div>' +
				            		  '</div>';
                    		lastMonth = mon;
                    	}
                    	
                    	info = row.info;
                    	if(info.length > 12){
                    		info = info.substring(0,12) + "...";
                    	}
                       result += '<div class="weui-cell">' +
		                				'<div class="weui-cell__hd">' +
				        					'<img src="${ctx }/images/trade_'+ row.busiType +'.png" >' + 
				        				'</div>' +
				        				'<div class="weui-cell__bd">' +
				        					'<p class="tinfo">' + info + '</p>' +
				        					'<p class="ttime">'+ row.createTime.substring(0,16) + '</p>' +
				        				'</div>' +
				        				'<div class="weui-cell__ft">' +
				        					'<label class="tamount_' + row.ioType + '">' + (row.ioType == 'i' ? '+' : '-') + row.amount + '</label>' +
				        				'</div>' +
				        			'</div>';
                    }

                    $(".dropload-refresh").remove();
                    // 插入数据到页面，放到最后面
                    $('#searchResult').append(result);
                    if(data.page.pageNum * data.page.size >= data.page.total){
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