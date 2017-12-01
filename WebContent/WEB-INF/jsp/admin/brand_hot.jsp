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
				<a href="#" onclick="javascript:$('#hotBrand_grid').edatagrid('addRow')" class="easyui-linkbutton"
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
					name="brand.name_like_string">
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
				sortName:'orderNo',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#hotBrand_tb',loadFilter:hotBrandDataProcess">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'brand',width:120,sortable:'true',formatter:brandFormatter">品牌名称</th>			
				<th
					data-options="field:'startTime',width:120,align:'center',sortable:'true',editor:'datebox'">开始时间</th>
				<th
					data-options="field:'startTime',width:120,align:'center',sortable:'true',editor:'datebox'">截止时间</th>	
				<th
					data-options="field:'orderNo',width:80,editor:'numberbox'">排名</th>
				<th
					data-options="field:'remark',width:160,editor:{type:'textarea',
						options:{
							validType:'length[0,400]'}}">说明</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">	
		function hotBrandDataProcess(data){
			return data;
		}
		
		function brandFormatter(value,row,index){
			return value.name;
		}
		
		$('#hotBrand_grid').edatagrid({
			url:'${ctx }/admin/hotBrand/query',
			saveUrl: '${ctx }/admin/hotBrand/add',
			updateUrl: '${ctx }/admin/hotBrand/update',
			destroyUrl: '${ctx }/admin/hotBrand/delete',
			onBeforeEdit:hotBrandGridBeforeEdit
		});
				
		function hotBrandUpdate(){
			if(!$("#hotBrand_w").window("options").closed){
				var selRows = $("#hotBrand_grid").datagrid("getSelections");
				$("#brokerTreeInput").combotree('setValue', selRows[0].broker.id);
			}
		}

		var today = _sysCurrDate;
		
		var currhotBrandGridEditRowIndex;
		
		function hotBrandGridBeforeEdit(index){
			currhotBrandGridEditRowIndex = index;
		}
		
		
		function liverTreeBeforeSelect(node){
			return node.type == "liver";
		}
		
		function liverTreeOnSelect(node){
			var row = $('#hotBrand_grid').edatagrid("getSelected");
			row.liverName = node.text;
			var editors = $('#hotBrand_grid').edatagrid("getEditors",currhotBrandGridEditRowIndex);
			for(var i in editors){
				if(editors[i].field == "brokerId"){
					$(editors[i].target).combotree("setValue",node.origin.broker.id);
					row.brokerName = node.origin.broker.name;
				}
				else if(editors[i].field == "platform"){
					$(editors[i].target).val(node.origin.platform);
				}
				else if(editors[i].field == "roomNo"){
					$(editors[i].target).val(node.origin.roomNo);
				}
				else if(editors[i].field == "liveName"){
					$(editors[i].target).val(node.origin.liveName);
				}
				else if(editors[i].field == "date"){
					$(editors[i].target).datebox("setValue",today);
				}
			}
		}
		
		
		function userOrgTreeLoadFilter(data){
			//去掉非经纪人
			for(var i = data.length - 1; i >=0; i--){
				if(data[i].userType != undefined && data[i].userType != "B"){
					data.splice(i,1);
				}
			} 
			return $.ad.standardIdPidNameArrayToEasyUITree(data);
		}
		
		function brokerTreeBeforeSelect(node){
			return node.userType != undefined && node.userType == "B";
		}
	</script>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>