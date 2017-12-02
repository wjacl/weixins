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
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
	<h3>
		热门品牌管理
	</h3>
	
	<div id="hotBrand_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<app:author path="/admin/hotBrand/add">
				<a href="#" onclick="javascript:$('#dd').dialog('open')" class="easyui-linkbutton"
					iconCls="icon-add" plain="true"><s:message code='comm.add' /></a> 
			</app:author>
			<app:author path="/admin/hotBrand/delete">
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#hotBrand_grid').edatagrid('destroyRow')"><s:message code='comm.remove' /></a>
			</app:author>
			<app:author path="/admin/hotBrand/add;/admin/hotBrand/update">
				<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#hotBrand_grid').edatagrid('saveRow')"><s:message code='comm.save' /></a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#hotBrand_grid').edatagrid('cancelRow')"><s:message code='comm.cancel' /></a>
			</app:author>
		</div>
		<div>
			<form id="hotBrand_query_form">
				品牌名称
				: <input class="easyui-textbox" style="width: 100px"
					name="brandName_like_string">
				开始时间：
				: <input class="easyui-datebox" style="width: 100px"
					name="startTime_after_date">
					-
					<input class="easyui-datebox" style="width: 100px"
					name="startTime_before_date">
				结束时间：
				: <input class="easyui-datebox" style="width: 100px"
					name="endTime_after_date">
					-
					<input class="easyui-datebox" style="width: 100px"
					name="endTime_before_date">
				<a
					href="javascript:$.ad.gridQuery('hotBrand_query_form','hotBrand_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>
	<table id="hotBrand_grid" 
		data-options="rownumbers:true,singleSelect:true,pagination:true,multiSort:true,selectOnCheck:true,checkOnSelect:true,
				sortName:'orderno',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#hotBrand_tb',loadFilter:hotBrandDataProcess">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'brandName',width:120,sortable:'true'">品牌名称</th>	
				<th
					data-options="field:'logo',width:110,formatter:imageFormatter">Logo</th>			
				<th
					data-options="field:'startTime',width:100,align:'center',editor:'datebox'">开始时间</th>
				<th
					data-options="field:'endTime',width:100,align:'center',editor:'datebox'">截止时间</th>	
				<th
					data-options="field:'orderno',align:'center',width:80,editor:'numberbox'">排名</th>
				<th
					data-options="field:'remark',width:300,editor:{type:'textarea',
						options:{
							validType:'length[0,400]'}}">说明</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">	
		function hotBrandDataProcess(data){
			return data;
		}
		
		
		function imageFormatter(value,row,index){
			if(value != null && value != ""){
				return "<img src=\"" + publicDownloadUrl + value + "\" width=\"100\">";
			}
			return '';
		}
		
		$('#hotBrand_grid').edatagrid({
			url:'${ctx }/admin/hotBrand/query',
			saveUrl: '${ctx }/admin/hotBrand/add',
			updateUrl: '${ctx }/admin/hotBrand/update',
			destroyUrl: '${ctx }/admin/hotBrand/delete'
		});
	
	</script>
	
	<div id="dd" class="easyui-dialog" title="选择品牌" style="width:570px;height:480px;"
    data-options="resizable:false,modal:true,closed:true">	
	<div id="my_tb" style="padding: 5px; height: auto">
		<div>
			<a href="#" onclick="javascript:$('#dd').dialog('close')" class="easyui-linkbutton"
				iconCls="icon-undo" plain="true">取消</a>
			<a href="#" onclick="javascript:addBrand()" class="easyui-linkbutton"
				iconCls="icon-add" plain="true">确定</a>
		</div>
		<div>
			<form id="my_query_form">		
				<s:message code="liver.name" text="名称"/>
				: <input class="easyui-textbox" style="width: 100px"
					name="name_like_string">
				<a
					href="javascript:doQuery()"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
				<input type="hidden" name="or_pinyin_like_string" />
			</form>
		</div>
	</div>
	<table id="my_grid" 
		data-options="rownumbers:true,singleSelect:true,pagination:true,multiSort:true,selectOnCheck:true,
				sortName:'pinyin',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#my_tb',loadFilter:myDataProcess">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th
					data-options="field:'name',width:100,sortable:'true'">名称</th>
				<th
					data-options="field:'logo',width:110,formatter:imageFormatter">Logo</th>	
				<th
					data-options="field:'ownerName',width:140">创建者</th>
				<th
					data-options="field:'createTime',sortable:'true',align:'center',width:120,formatter:dateFormatter">创建时间</th>	
			</tr>
		</thead>
	</table>
	</div>
	<script type="text/javascript">	
		function addBrand(){
			var rows = $("#my_grid").datagrid("getChecked");
			if(rows.length != 1){
				$.sm.alert("请选择一个品牌！")
			}
			else{
				// insert a row with default values
				$('#hotBrand_grid').edatagrid('addRow',{
					row:{
						brandId:rows[0].id,
						brandName:rows[0].name,
						logo:rows[0].logo
					}
				});
				$('#dd').dialog('close');
			}
		}
	
		function doQuery(){
			$('input[name=\"or_pinyin_like_string\"]').val($('input[name=\"name_like_string\"]').val());
			$.ad.gridQuery('my_query_form','my_grid')
		}
		
		function myDataProcess(data){
			return data;
		}

		
		function dateFormatter(value,row,index){
			if(value != null && value != ""){
				return value.substring(0,10);
			}
			return '';
		}
		

		$('#my_grid').datagrid({
			url:'${ctx }/admin/brand/query'
		});

	</script>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>