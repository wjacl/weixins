<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test='${not empty param.inframe}'>
	</div>
</c:if>
<c:if test='${empty param.inframe}'>
	<c:if test="${not empty session_user }">
		<div id="sys_pwd_update_w" class="easyui-window"
			title='<s:message code="user.pwd.update" />'
			data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
			style="width: 360px; height: 320px; padding: 10px;">
			<div class="content">
				<form id="sys_pwd_update_form" method="post"
					action="${ctx }/user/pwdupdate">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="oldpassword" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.oldpwd"/>:',required:true,
							validType:{length:[6,20],remote:['${ctx }/user/oldPwdCheck','pwd']},
							invalidMessage:'<s:message code="user.oldpwd.error"/>'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password" type="password"
							id="pwd" style="width: 100%"
							data-options="label:'<s:message code="user.pwd"/>:',required:true,validType:'length[6,20]'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password2" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.pwd.match"/>:',required:true,
								validType:{equals:['#pwd','<s:message code="user.pwd"/>']}">
					</div>
					<input type="hidden" name="id" value="${session_user.id }" />
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('sys_pwd_update_form',null,'sys_pwd_update_w')"
						style="width: 80px"> <s:message code="comm.update" /></a> <a
						href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.clearForm('user_add')" style="width: 80px"><s:message
							code="comm.clear" /></a>
				</div>
			</div>
		</div>
	</c:if>
	</div>
	</div>
	<div id="loginDialog"></div>
	<div id="footer" class="content text-centered">
		<div>Copyright © 2008-${copyRightYear} www.cshyc.com</div>
	</div>
</c:if>