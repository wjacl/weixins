<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp" %>
<script type="text/javascript">
	$(function() {
		
		var sw = $(window).width();
		if (sw < 767) {
			$('body').layout('collapse', 'west');
		}
		$('.navigation-toggle span').bind('click', function() {
			$('#head-menu').toggle();
		});
	});
	function open1(mname,murl) {
		if ($('#tt').tabs('exists', mname)) {
			$('#tt').tabs('select', mname);
		} else {
			$('#tt').tabs('add', {
				title : mname,
				//href : murl,
				closable : true,
				//bodyCls : 'content-doc' ,
				content:'<iframe scrolling="auto" frameborder="0"  src="'+murl+'?inframe=yes" style="width:100%;height:100%;"></iframe>'
				/* extractor : function(data) {
					data = $.fn.panel.defaults.extractor(data);
					var tmp = $('<div></div>').html(data);
					data = tmp.find('#content').html();
					tmp.remove();
					return data;
				}    */
			});
		}
	}
	
	function login(xhr){
		$('#loginDialog').dialog({
		    title: '请登录',
		    width: 600,
		    height: 400,
		    closed: false,
		    cache: false,
		    href: xhr.responseText,
		    modal: true,
		    extractor : function(data) {
				data = $.fn.panel.defaults.extractor(data);
				var tmp = $('<div></div>').html(data);
				data = tmp.find('#content').html();
				tmp.remove();
				return data;
			} 
		});
	}
</script>
<style type="text/css">
.tree-title {
	font-size: 14px;
}

.tree-title a {
	text-decoration: none;
}

#head-menu {
	position: absolute;
	z-index: 8;
	display: none;
	background: #2d3e50;
	color: #fff;
	left: 0;
	padding: 0 4.5%;
	top: 66px;
}

#head-menu .navbar {
	margin: 0 40px 20px 40px;
}

#head-menu a {
	color: #fff;
}
</style>
</head>
<body class="easyui-layout" style="text-align: left">
	<div id="head-menu">
		<div class="navbar navbar-right">
			<ul>
				<c:if test="${not empty session_user }">
					<li><a href="javascrit:void(0)"><s:message code="sys.header.hello"/>,${session_user.name }！</a></li>
					<li><a href="${ctx }/logout" ><s:message code="sys.logout"/></a></li>
					<li><a href="javascript:$('#sys_pwd_update_w').window('open')"><s:message code="user.pwd.update"/></a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<div region="north" border="false" class="group wrap header"
		style="height: 66px; font-size: 100%">
		<div class="content">
			<div class="navigation-toggle" data-tools="navigation-toggle"
				data-target="#navbar-1">
				<span><s:message code="sys.app.name"/></span>
			</div>
			<div id="elogo" class="navbar navbar-left">
				<ul>
					<!-- <li><a href="index.jsp"><img src="images/logo2.png"
							alt="jQuery EasyUI" /></a></li> -->
					<li style="font-size: 28px;font-weight: bold;"><a href="index.jsp"><s:message code="sys.app.name"/></a></li>
				</ul>
			</div>
			<div id="navbar-1" class="navbar navbar-right">				
				<ul>
					<c:if test="${not empty session_user }">
					<li><a href="javascrit:void(0)"><s:message code="sys.header.hello"/>,${session_user.name }！</a></li>
					<li><a href="${ctx }/logout" ><s:message code="sys.logout"/></a></li>
					<li><a href="javascript:$('#sys_pwd_update_w').window('open')"><s:message code="user.pwd.update"/></a></li>
					</c:if>
				</ul>
			</div>
			<div style="clear: both"></div>
		</div>
		<script type="text/javascript">
			function setNav() {
				var demosubmenu = $('#demo-submenu');
				if (demosubmenu.length) {
					if ($(window).width() < 450) {
						demosubmenu.find('a:last').hide();
					} else {
						demosubmenu.find('a:last').show();
					}
				}
				if ($(window).width() < 767) {
					$('.navigation-toggle').each(function() {
						$(this).show();
						var target = $(this).attr('data-target');
						$(target).hide();
						setDemoNav();
					});
				} else {
					$('.navigation-toggle').each(function() {
						$(this).hide();
						var target = $(this).attr('data-target');
						$(target).show();
					});
				}
			}
			function setDemoNav() {
				$('.navigation-toggle').each(function() {
					var target = $(this).attr('data-target');
					if (target == '#navbar-demo') {
						if ($(target).is(':visible')) {
							$(this).css('margin-bottom', 0);
						} else {
							$(this).css('margin-bottom', '2.3em');
						}
					}
				});
			}
			$(function() {
				setNav();
				$(window).bind('resize', function() {
					setNav();
				});
				$('.navigation-toggle').bind('click', function() {
					var target = $(this).attr('data-target');
					$(target).toggle();
					setDemoNav();
				});
				
				$(".easyui-tree li:first ul li:first a").click();
			})
		</script> 
		
		<div id="sys_pwd_update_w" class="easyui-window" title='<s:message code="user.pwd.update" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 380px; height: 320px; padding: 10px;">
		<div class="content">
				<form id="sys_pwd_update_form" method="post" action="${ctx }/user/pwdupdate">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="oldpassword" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.oldpwd"/>:',required:true,
							validType:{length:[6,20],remote:['${ctx }/user/oldPwdCheck','pwd']},
							invalidMessage:'<s:message code="user.oldpwd.error"/>'">
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
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('sys_pwd_update_form',null,'sys_pwd_update_w')" style="width: 80px">
						<s:message code="comm.update" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('sys_pwd_update_form')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
		
	</div>
	<div region="west" split="true" title=""
		style="width: 20%; min-width: 180px; padding: 5px;">
		<ul class="easyui-tree">
			<c:set var="pid" value="abcd555"></c:set>
			<c:if test="${not empty privs }">
				<c:forEach items= "${privs}" var="p">
					<c:if test="${p.type == '1' || p.type == '2' }">
					<c:choose>
						<c:when test="${p.pid == null || p.pid != pid }">
							<c:if test="${pid != 'abcd555' }">
									</ul></li>
							</c:if>				
							<c:set var="pid" value="${p.id }"></c:set>
							
							<c:if test="${p.type == '2' }">
								<li iconCls="icon-base"><span>${p.name }</span>
									<ul>
							</c:if>
							<c:if test="${p.type == '1' }">
								<li iconCls="icon-base"><a href="#"
									onclick="open1('${p.name}','${p.path }')">${p.name}</a>
								<ul>
							</c:if>
						</c:when>
						<c:otherwise>
							<li iconCls="icon-gears"><a href="#"
								onclick="open1('${p.name}','${p.path }')">${p.name}</a></li>
						</c:otherwise>
					</c:choose>
					</c:if>
				</c:forEach>
				
				</ul></li>
				
			</c:if>
		</ul>
	</div>
	<div region="center">
		<div id="tt" class="easyui-tabs" fit="true" border="false"
			plain="true">
			<!-- <div title="welcome" href="welcome.php" class="content-doc"></div> -->
		</div>
	</div>
	
	<!-- 密码修改窗口 -->	
	<div id="sys_pwd_update_w" class="easyui-window" title='<s:message code="user.pwd.update" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 360px; height: 320px; padding: 10px;">
		<div class="content">
				<form id="sys_pwd_update_form" method="post" action="${ctx }/user/pwdupdate">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="oldpassword" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.oldpwd"/>:',required:true,
							validType:{length:[6,20],remote:['${ctx }/user/oldPwdCheck','pwd']},
							invalidMessage:'<s:message code="user.oldpwd.error"/>'">
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
                    <input type="hidden" name="id" value="${session_user.id }"/>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('sys_pwd_update_form',null,'sys_pwd_update_w')" style="width: 80px">
						<s:message code="comm.update" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('user_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	<div id="loginDialog"></div>
</body>
</html>



