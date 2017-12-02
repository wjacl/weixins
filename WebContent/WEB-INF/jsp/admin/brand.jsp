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
		品牌管理
	</h3>	
	<div id="my_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<app:author path="/admin/brand/add">
				<a href="#" onclick="javascript:$('#my_grid').edatagrid('addRow')" class="easyui-linkbutton"
					iconCls="icon-add" plain="true"><s:message code='comm.add' /></a> 
			</app:author>
			<app:author path="/admin/brand/delete">
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#my_grid').edatagrid('destroyRow')"><s:message code='comm.remove' /></a>
			</app:author>
			<app:author path="/admin/brand/add;/admin/brand/update">
				<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#my_grid').edatagrid('saveRow')"><s:message code='comm.save' /></a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#my_grid').edatagrid('cancelRow')"><s:message code='comm.cancel' /></a>
			</app:author>
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
		data-options="rownumbers:true,singleSelect:true,pagination:true,multiSort:true,selectOnCheck:true,checkOnSelect:true,
				sortName:'pinyin',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#my_tb',loadFilter:myDataProcess">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th
					data-options="field:'name',width:160,sortable:'true'">名称</th>
				<th
					data-options="field:'logo',width:110,formatter:imageFormatter">Logo</th>	
				<th
					data-options="field:'ownerName',width:160">创建者</th>
				<th
					data-options="field:'createTime',sortable:'true',align:'center',width:120,formatter:dateFormatter">创建时间</th>	
			</tr>
		</thead>
	</table>
	<script type="text/javascript">	
	
		function doQuery(){
			$('input[name=\"or_pinyin_like_string\"]').val($('input[name=\"name_like_string\"]').val());
			$.ad.gridQuery('my_query_form','my_grid')
		}
		
		function myDataProcess(data){
			return data;
		}
		
		function imageFormatter(value,row,index){
			if(value != null && value != ""){
				return "<img src=\"" + publicDownloadUrl + value + "\" width=\"100\">";
			}
			return '';
		}
		
		function dateFormatter(value,row,index){
			if(value != null && value != ""){
				return value.substring(0,10);
			}
			return '';
		}
		

		$('#my_grid').edatagrid({
			url:'${ctx }/admin/brand/query',
			saveUrl: '${ctx }/admin/brand/add',
			updateUrl: '${ctx }/admin/brand/update',
			destroyUrl: '${ctx }/admin/brand/delete',
			onBeforeEdit:myGridBeforeEdit
		});
				
		function myUpdate(){
			if(!$("#my_w").window("options").closed){
				var selRows = $("#my_grid").datagrid("getSelections");
				$("#brokerTreeInput").combotree('setValue', selRows[0].broker.id);
			}
		}

		var currmyGridEditRowIndex;
		
		function myGridBeforeEdit(index){
			currmyGridEditRowIndex = index;
		}

	</script>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>