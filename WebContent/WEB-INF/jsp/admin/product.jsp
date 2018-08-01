<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="appfn" uri="http://wja.com/jsp/app/functions"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_css.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx }/js/webupload/demo.css">
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
	<h3>
		产品管理
	</h3>	
	<div id="my_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<app:author path="/admin/product/add">
				<a href="#" onclick="$.ad.toAdd('user_w','产品','user_add','${ctx }/admin/product/add');initAdd();" class="easyui-linkbutton"
					iconCls="icon-add" plain="true"><s:message code='comm.add' /></a> 
			</app:author>
			<app:author path="/admin/product/update">
				<a href="#" onclick="$.ad.toUpdate('my_grid','user_w','产品','user_add','${ctx }/admin/product/update');initUpdate();" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a> 
			</app:author>
			<app:author path="/admin/product/delete">
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="$.ad.doDelete('my_grid','${ctx }/admin/product/delete')"><s:message code='comm.remove' /></a>
			</app:author>
		</div>
		<div>
			<form id="my_query_form">		
				名称
				: <input class="easyui-textbox" style="width: 100px"
					name="title_like_string">
				<a
					href="javascript:doQuery()"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>
	<table id="my_grid" 
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,checkOnSelect:true,
				sortName:'createTime',sortOrder:'desc',
				idField:'id',method:'post',toolbar:'#my_tb',loadFilter:myDataProcess">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th
					data-options="field:'title',width:160">名称</th>
				<th
					data-options="field:'price',width:100,sortable:'true'">价格</th>
				<th
					data-options="field:'unit',width:100">单位</th>	
				<th
					data-options="field:'pubId',width:160,sortable:'true',formatter:ownFormatter">所属厂/商</th>
				<th
					data-options="field:'createUserName',width:160,formatter:creatorFormatter">发布者</th>
				<th
					data-options="field:'createTime',sortable:'true',align:'center',width:120,formatter:dateFormatter">发布时间</th>	
			</tr>
		</thead>
	</table>
	<script type="text/javascript">	
	
		function doQuery(){
			$.ad.gridQuery('my_query_form','my_grid')
		}
		
		function myDataProcess(data){
			return data;
		}
		
		function creatorFormatter(value,row,index){
			if(value != null && value != ""){
				return value;
			}
			return row.ownName;
		}
		
		function ownFormatter(value,row,index){
			return row.ownName;
		}
		
		function dateFormatter(value,row,index){
			if(value != null && value != ""){
				return value.substring(0,10);
			}
			return '';
		}
		

		$('#my_grid').datagrid({
			url:'${ctx }/admin/product/query'
		});
				
		function initAdd(){
			$("#imgUploadList").empty();
			$('#brandIntro').froalaEditor('html.set', '');
		}
		
		function initUpdate(){
			initAdd(); //清空
			var selRows = $("#my_grid").datagrid("getSelections");
			if(selRows[0].img){
				var imgs = selRows[0].img.split(";");
				for(var i in imgs){
					addImg(imgs[i]);
				}
				
				$("ul.filelist li").on('mouseenter', function() {
		            $(this).children(".file-panel").stop().animate({height: 30});
		        });
				
				$("ul.filelist li").on('mouseleave', function() {
		            $(this).children(".file-panel").stop().animate({height: 0});
		        });
			}
			if(selRows[0].content){
				$('#brandIntro').froalaEditor('html.set', selRows[0].content);
			}
			
			$("#cc").combogrid("setText",selRows[0].ownName);
		}

		function prepareImg(){
			var lis = $("#imgUploadList").children();
			if(lis.length > 0){
				var imgs = [];
				for(var i = 0 ; i < lis.length; i++){
					imgs.push($(lis[i]).attr("data"));
				}
				
				$("#logo").val(imgs.join(";"));
			}
			else{
				$("#logo").val("");
			}
			
			$.ad.submitForm('user_add','my_grid','user_w');
		}
		
		function categoryFormatter(value,row,index){
			switch(value){
				case '1':
					return '厂家';
				case '2':
					return '商家';
				case '3':
					return '专家';
				case '4':
					return '安装师傅';
				case '5':
					return '自然人';
				case '6':
					return '其他';
			}
			return "";
		}
		var status=["编辑中","已选经营类别","已填基本信息","已填简介","已选品牌","已付保证金","审核通过","待审核","审核未通过"];
		function statusFormatter(value,row,index){
			switch(value){
				case 0:
					return "编辑中";
				case 1:
					return "已选经营类别";
				case 2:
					return "已填基本信息";
				case 3:
					return "已填简介";
				case 4:
					return "已选品牌";
				case 5:
					return "已付保证金";
				case 6:
					return "审核通过";
				case 7:
					return "待审核";
				case 8:
					return "审核未通过";
			}
			return "";
		}

	</script>

	<div id="user_w" class="easyui-window" title='<s:message code="user.add" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 600px; height: 500px; padding: 10px;">
		<div class="content">
				<form id="user_add" method="post" action="${ctx }/admin/product/add">
					<div style="margin-bottom: 10px">
						<select id="cc" class="easyui-combogrid" name="pubId" style="width: 100%"
					        data-options="label:'厂/商家：',required:true,
					        panelWidth:450,
					        mode: 'remote',pagination:true,
					        idField:'id',
					        textField:'name',
					        url:'${ctx }/admin/fuser/query',
					        queryParams:{category_in:'1,2'},
					        columns:[[
					        {field:'name',title:'名称',width:160},
					        {field:'category',title:'经营类别',width:120,formatter:categoryFormatter},
					        {field:'status',title:'状态',width:100,formatter:statusFormatter}
					        ]]
					        ">
						</select>
					</div>
					<div style="margin-bottom: 10px">
						<input class="easyui-textbox" name="title" style="width: 100%"
							data-options="label:'产品名称：',required:true,validType:'length[1,30]'">
					</div>	
					<div style="margin-bottom: 10px">
						<input class="easyui-numberbox" name="price" style="width: 100%"
							data-options="label:'单价(元)：',validType:'length[0,10]'">
					</div>
					<div style="margin-bottom: 10px">
						<input class="easyui-textbox" name="unit" style="width: 100%"
							data-options="label:'单位：',validType:'length[0,10]'">
					</div>				
					<div style="margin-bottom: 10px">
						<label>产品图片：&nbsp;&nbsp;&nbsp;</label>
						<a href="#" onclick="$('#myfile').click();" class="easyui-linkbutton" data-options="iconCls:'icon-add'">选择文件</a>						
					</div>	
					<div style="margin-bottom: 10px" id="uploader">	
						<ul class="filelist" id="imgUploadList">
						
						</ul>
					</div>
					<div style="margin-bottom: 10px">
						产品简介：
					</div>
					<div >
                    <textarea name="content" id="brandIntro"></textarea>
                    </div>
                    <input type="hidden" name="id" />
                    <input type="hidden" name="img" id="logo"/>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="prepareImg()" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('user_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
	
	<div style="display:none">
		<form id="liveData_import" method="post" action="${ctx }/admin/upload/comm/multi" enctype="multipart/form-data">		
			<input type="file" id="myfile" name="file"  accept="image/*" multiple="multiple"/>
			<input type="hidden" name="type" value="product" />
		</form>
	</div>
</body>
</html>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_js.jsp" %>
<script type="text/javascript">

var publicDownloadUrl = '${publicDownloadUrl}';
function addImg(filename){
	var $li = $( '<li data="' + filename + '">' +
            '<p class="imgWrap"><img src="' + publicDownloadUrl + filename + '"></p>'+
            '</li>' );

    var $btns = $('<div class="file-panel">' +
            '<span class="cancel">删除</span></div>').appendTo( $li );

    $btns.on( 'click', 'span', function() {
    	var $obj = $(this);
        //确认是否移除？
        $.sm.confirmDelete(function(){
            $obj.parent().parent().remove();
		});
    });
    $queue = $('ul.filelist');
    $li.appendTo( $queue );
}

$(function(){
	h5FichEditorInit("brandIntro",ctx + "/admin/upload/comm",{type:"brand"});
	$("#myfile").change(function(){
		$("#liveData_import").form('submit',{success:function(data){
			data = eval('(' + data + ')');
			
			var error = "";
			for(i in data){
				if(data[i].errMsg){
					error += data[i].errMsg;
					continue;
				}
				addImg(data[i].fileName);
			}
			
			$("ul.filelist li").on('mouseenter', function() {
	            $(this).children(".file-panel").stop().animate({height: 30});
	        });
			
			$("ul.filelist li").on('mouseleave', function() {
	            $(this).children(".file-panel").stop().animate({height: 0});
	        });
			
			if(error){
				$.sm.alert(error);
			}
		}});
	}); 
});

</script>