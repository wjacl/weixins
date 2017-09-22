<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<script type="text/javascript" src="${ctx }/js/app/system/dict.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

		<h3>
			<s:message code="dict.title" />
		</h3>
		<div class="easyui-layout" style="width:720px;height:430px;">
			<div data-options="region:'west'" style="padding: 5px;width:300px;max-height:430px;">
				<ul id="dictTree" class="ztree"></ul>				
			</div>
			
			<div data-options="region:'center',border:false" style="width:400px;max-height:430px;padding-left:30px"> 
				<div class="content">
						<form id="dict_add" method="post" action="${ctx }/dict/save">
							<div style="margin-bottom: 20px">
								<input class="easyui-textbox" name="name" style="width: 100%"
									data-options="label:'<s:message code="dict.name"/>:',required:true,
									validType:{length:[1,20],myRemote:['${ctx }/dict/nameCheck','name','#oldDictName','pid',$('#dictpid').val()]}">
								<input type="hidden" name="oldDictName" id="oldDictName"/>
							</div>
							<div style="margin-bottom: 20px">
								<input class="easyui-textbox" name="value" style="width: 100%" id="dictValue"
									data-options="label:'<s:message code="dict.value"/>:',required:true,
									validType:{length:[1,10],myRemote:['${ctx }/dict/valueCheck','value','#oldDictValue','pid','#dictpid']}">
								<input type="hidden" name="oldDictValue" id="oldDictValue" />
								<p style="color:red">*<s:message code="dict.value.notchange"/></p>
							</div>
		                    <input type="hidden" name="id" />
		                    <input type="hidden" name="pid" id="dictpid"/>
		                    <input type="hidden" name="version" />
		                    <input type="hidden" name="type" />
		                    <input type="hidden" name="ordno" />
						</form>
						<div style="text-align: center; padding: 5px 0;display:none" id="dict_buttons">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								onclick="dict.submitForm('dict_add')" style="width: 80px">
								<s:message code="comm.submit" /></a> 
							<a href="javascript:void(0)"
								class="easyui-linkbutton" onclick="$.ad.clearForm('dict_add')"
								style="width: 80px"><s:message code="comm.clear" /></a>
						</div>
				</div>
			</div>
		</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>