<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<script type="text/javascript">
 $(function(){
           $('#param_grid').edatagrid({
               //url: 'get_users.php',
               updateUrl: '${ctx}/param/save'
           });
       });
</script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

			<h3>
				<s:message code="param.title" />
			</h3>
			<div id="param_tb"  style="padding: 5px; height: auto">
				<div style="margin-bottom: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#param_grid').edatagrid('saveRow')"><s:message code='comm.save' /></a>
				</div>
			</div>
			<table id="param_grid"
				data-options="rownumbers:true,singleSelect:true,width:932,
				url:'${ctx }/param/query',method:'post',toolbar:'#param_tb'">
				<thead>
					<tr>
						<th data-options="field:'name',width:200"><s:message code="param.name" /></th>
						<th data-options="field:'value',width:200,editor:{type:'textbox',options:{required:true}}"><s:message code="param.value" /></th>
						<th data-options="field:'remark',width:500"><s:message code="param.remark" /></th>
					</tr>
				</thead>
			</table>
			
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>