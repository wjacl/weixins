<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%> 
<script type="text/javascript" src="${ctx }/js/app/system/org.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<h3>
		<s:message code="org.title" />
	</h3>
	<div class="easyui-layout" style="width:720px;height:430px;">
		<div data-options="region:'west'" style="padding: 5px;width:300px;max-height:430px;">
		<ul id="orgTree" class="ztree"></ul>
	</div>
		<div data-options="region:'center',border:false" style="width:400px;max-height:430px;padding-left:30px"> 
			<div class="content">
				<form id="org_add" method="post" action="${ctx }/org/save">		
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 300px"
							data-options="label:'<s:message code="org.name"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/org/nameCheck','name','#org_oldname','pid','#pid']},
							invalidMessage:'<s:message code="org.name.exist"/>'">
						<input type="hidden" name="oldname" id="org_oldname" />
					</div>			
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="type" style="width: 300px"
							data-options="label:'<s:message code="org.type"/>:',
							url:'${ctx }/dict/get?pvalue=org.type',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true">
					</div>
					<input type="hidden" name="ordno" />
                    <input type="hidden" name="id" />
                    <input type="hidden" name="pid"  id="pid"/>
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0;width:240px;display:none" id="org_buttons">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="org.submitForm('org_add')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('org_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>