<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="login.title" /></title>
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
		<div style="width:400px;height:300px;margin: auto;position: absolute;top:0;left:0;bottom: 0;right:0;">
			<h2>
				<s:message code="login.title" />
			</h2>
			
			<p style="color:red">${error }</p>
			<!-- <div style="margin: 20px 0;"></div> -->
			<div class="easyui-panel"
				style="width: 100%; max-width: 400px; padding: 30px 60px;">
				
				<form id="ff" method="post" action="${ctx }/login">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="username" style="width: 100%" value="${param.username }"
							data-options="label:'<s:message code="login.username"/>:',required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password" type="password" value="${param.password }"
							style="width: 100%"
							data-options="label:'<s:message code="login.pwd"/>:',required:true">
					</div>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="submitForm()" style="width: 80px"><s:message
							code="login.submit" /></a> 
					<a href="${ctx}/user/regist"
						class="easyui-linkbutton"
						style="width: 80px"><s:message code="login.regist" /></a>
				</div>

				<script>
			        function submitForm(){
			            $('#ff').form('submit',{"ajax":false});
			        }
			      	//绑定回车动作 
			        $('#ff').keydown(function(event){ 
				        if(event.which==13){
				        	submitForm();
				        } 
			        });
	    		</script>
			</div>
		</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>