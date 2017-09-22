<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

			<h3>
				<s:message code="role.title" />
			</h3>
			<div id="role_tb" style="padding: 5px; height: auto">
				<div style="margin-bottom: 5px">
					<a
						href="javascript:rolePrivTree.checkAllNodes(false);$.ad.toAdd('role_w',I18N.role,'role_add','${ctx }/role/add')"
						class="easyui-linkbutton easyui-tooltip"
						title="<s:message code='comm.add' />" iconCls="icon-add"
						plain="true"></a> 
					<a
						href="javascript:$.ad.toUpdate('role_grid','role_w',I18N.role,'role_add','${ctx }/role/update');roleUpdate()"
						class="easyui-linkbutton easyui-tooltip"
						title="<s:message code='comm.update' />" iconCls="icon-edit"
						plain="true"></a> 
					<a
						href="javascript:$.ad.doDelete('role_grid','${ctx }/role/delete')"
						class="easyui-linkbutton easyui-tooltip"
						title="<s:message code='comm.remove' />" iconCls="icon-remove"
						plain="true"></a>
				</div>
			</div>
			<table class="easyui-datagrid" style="width: 700px;" id="role_grid"
				data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				url:'${ctx }/role/query',method:'post',toolbar:'#role_tb',onCheck:roleRowOnCheck,loadFilter:roleDataProcess">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'name',width:100"><s:message code="role.name" /></th>
						<th data-options="field:'type',width:80,sortable:true,formatter:roleTypeFormatter"><s:message code="role.type" /></th>
						<th data-options="field:'remark',width:300"><s:message code="role.remark" /></th>
					</tr>
				</thead>
			</table>
			<script type="text/javascript">
			
			function roleDataProcess(data){
				if(data && data.rows){
					var rows = data.rows;
					for(var i in rows){
						if(rows[i].privs){
							var privs = rows[i].privs;
							for(var j in privs){
								if(privs[j].$ref){
									privs[j] = eval(privs[j].$ref.replace('$',"data"));
								}
							}
						}
					}
				}
				return data;
			}
			
			function roleRowOnCheck(index,row){
				if(row.type == "s"){
					$("#role_grid").datagrid("uncheckRow",index);
					$.sm.show(I18N.role_sys_no_modify)
				}
			}
			
			function roleTypeFormatter(value,row,index){
				if(value == "s"){
					return I18N.role_type_s;
				}
				else {
					return I18N.role_type_u;
				}
			}
			</script>
			
			<div id="role_w" class="easyui-window"
				data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
				style="width: 620px; height: 480px; padding: 10px;">
				<div class="content easyui-layout" style="width:580px;height:420px">
						<div data-options="region:'center',border:false" style="width:50%;height:400px;margin-left: 40px;">
							<s:message code="role.priv"/>:
							<div class="easyui-panel" style="padding:5px;width:260px;height:340px;overflow:scroll">
								<ul id="role_priv_tree" class="ztree"></ul>
							</div>
	                    </div>	
	                    
	                    <div data-options="region:'west',border:false" style="width:40%;height:400px;padding-left:10px">	
							<form id="role_add" method="post" action="${ctx }/role/add">
								<div style="margin-bottom: 20px">
									<input class="easyui-textbox" name="name" style="width: 100%"
										data-options="label:'<s:message code="role.name"/>:',labelPosition:'top',required:true">
								</div>
								<div style="margin-bottom: 20px">
									<input class="easyui-textbox" name="remark" style="width:100%;height:90px" 
										data-options="label:'<s:message code="role.remark"/>:',labelPosition:'top',multiline:true">
								</div>
			                    <input type="hidden" name="id" />
			                    <input type="hidden" name="version" />
							</form>
								   
							<div style="text-align: center;margin-top: 40px; padding: 20px 0">
								<a href="javascript:void(0)" class="easyui-linkbutton"
									onclick="addRole()" style="width: 80px">
									<s:message code="comm.submit" /></a> 
								<a href="javascript:void(0)"
									class="easyui-linkbutton" onclick="$.ad.clearForm('role_add')"
									style="width: 80px"><s:message code="comm.clear" /></a>
							</div>
		                </div>
						
						<SCRIPT type="text/javascript">
							var roleSetting = {
								check: {
									enable: true
								},
								data: {
									simpleData: {
										enable: true,
										pIdKey:"pid"
									}
								}
							};
					
							var rolezNodes;
							$.ajax({ url: "${ctx }/user/privs",async:false,dataType:'json', success: function(data){
								rolezNodes = data;
						      }});
							
							var rolePrivTree = $.fn.zTree.init($("#role_priv_tree"), roleSetting, rolezNodes);
							
							function addRole(){
								if($("#role_add").form("validate")){
									var nodes = rolePrivTree.getCheckedNodes(true);
									var privIds = [];
									if(nodes && nodes.length > 0){
										for(var i in nodes){
											privIds.push(nodes[i].id);
										}
									}
									 var obj = {};
									if(privIds.length > 0){
										obj.privIds = privIds.join(",");
									}
									
									$("#role_add").form({queryParams:obj});
									$.ad.submitForm('role_add','role_grid','role_w');
								}
							}
							
							function roleUpdate(){
								if(!$("#role_w").window("options").closed){
									var selRows = $("#role_grid").datagrid("getSelections");
									var privs = selRows[0].privs;
									rolePrivTree.checkAllNodes(false);
									var node;
									for(var i in privs){
										node = rolePrivTree.getNodeByParam("id", privs[i].id, null);
										rolePrivTree.checkNode(node,true,false);
									}
								}
							}
						</SCRIPT>
				</div>
			</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>