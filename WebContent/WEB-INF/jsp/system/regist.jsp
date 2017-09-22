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
				<s:message code="user.regist" />
			</h3>
			<div style="margin: 20px 0;"></div>
			<div class="easyui-panel"
				style="width: 100%; max-width: 400px; padding: 30px 60px;">
				<form id="ff" method="post" action="${ctx }/user/regist">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'<s:message code="user.name"/>:',required:true,validType:'length[1,30]'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="username" style="width: 100%"
							data-options="label:'<s:message code="user.username"/>:',required:true,
							validType:{length:[1,30],remote:['${ctx }/user/unameCheck','username']},
							invalidMessage:I18N.user_uname_exits">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password" type="password"  id="pwd"
							style="width: 100%"
							data-options="label:'<s:message code="user.pwd"/>:',required:true,validType:'length[6,20]'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password2" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.pwd.match"/>:',required:true,
								validType:{equals:['#pwd','<s:message code="user.pwd"/>']}">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="type"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=user.type',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="user.type"/>:'
	                    ">
                    </div>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="submitForm()" style="width: 80px"><s:message
							code="comm.submit" /></a> 
					<a href="${ctx }/login"
						class="easyui-linkbutton"
						style="width: 80px"><s:message code="login.submit" /></a>
				</div>

				<script>
			        function submitForm(){
			        	$.messager.progress('close');
			            $('#ff').form('submit',{success: function(data){
			            	var data = eval('(' + data + ')');
			            	
			        		if(data.mess == "unameExits"){
			        			$.sm.alert(I18N.user_uname_exits);
			        		}
			        		else if(data.status == $.sm.ResultStatus_Ok){
			        			$.sm.show(I18N.user_regist_success);
			        		}
			        	}});
			        }
			       
    			</script>
			</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>