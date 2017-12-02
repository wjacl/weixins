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
		推荐专家管理
	</h3>
	
	<div id="recomExpert_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<app:author path="/admin/recomExpert/add">
				<a href="#" onclick="javascript:$('#dd').dialog('open')" class="easyui-linkbutton"
					iconCls="icon-add" plain="true"><s:message code='comm.add' /></a> 
			</app:author>
			<app:author path="/admin/recomExpert/delete">
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#recomExpert_grid').edatagrid('destroyRow')"><s:message code='comm.remove' /></a>
			</app:author>
			<app:author path="/admin/recomExpert/add;/admin/recomExpert/update">
				<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#recomExpert_grid').edatagrid('saveRow')"><s:message code='comm.save' /></a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#recomExpert_grid').edatagrid('cancelRow')"><s:message code='comm.cancel' /></a>
			</app:author>
		</div>
		<div>
			<form id="recomExpert_query_form">
				专家名称
				: <input class="easyui-textbox" style="width: 100px"
					name="expertName_like_string">
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
					href="javascript:$.ad.gridQuery('recomExpert_query_form','recomExpert_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>
	<table id="recomExpert_grid" 
		data-options="rownumbers:true,singleSelect:true,pagination:true,multiSort:true,selectOnCheck:true,checkOnSelect:true,
				sortName:'orderno',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#recomExpert_tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'expertName',width:120">专家姓名</th>	
				<th
					data-options="field:'logo',width:80,formatter:imageFormatter">头像</th>			
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
		function imageFormatter(value,row,index){
			if(value != null && value != ""){
				return "<img src=\"" + publicDownloadUrl + value + "\" width=\"70\" width=\"70\" >";
			}
			return '';
		}
		
		$('#recomExpert_grid').edatagrid({
			url:'${ctx }/admin/recomExpert/query',
			saveUrl: '${ctx }/admin/recomExpert/add',
			updateUrl: '${ctx }/admin/recomExpert/update',
			destroyUrl: '${ctx }/admin/recomExpert/delete'
		});
	
	</script>
	
	<div id="dd" class="easyui-dialog" title="选择专家" style="width:640px;height:520px;"
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
				姓名
				: <input class="easyui-textbox" style="width: 160px"
					name="name_like_string">
				<a
					href="javascript:doQuery()"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
				<input type="hidden" name="or_pinyin_like_string" />
				<input type="hidden" name="category" value="3" />
			</form>
		</div>
	</div>
	<table id="my_grid" 
		data-options="rownumbers:true,singleSelect:true,pagination:true,multiSort:true,selectOnCheck:true,
				sortName:'pinyin',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#my_tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th
					data-options="field:'name',width:100,sortable:'true'">姓名</th>
				<th
					data-options="field:'logo',width:80,formatter:imageFormatter">头像</th>
				<th
					data-options="field:'mphone',width:100">电话</th>	
				<th
					data-options="field:'wechat',width:100">微信</th>	
				<th
					data-options="field:'address',width:170">联系地址</th>
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
				$('#recomExpert_grid').edatagrid('addRow',{
					row:{
						expertId:rows[0].id,
						expertName:rows[0].name,
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

		$('#my_grid').datagrid({
			url:'${ctx }/admin/expert/query',
			queryParams:{category:'3'}
		});

	</script>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>