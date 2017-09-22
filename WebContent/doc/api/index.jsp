<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>基础系统</title>
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
				href : murl,
				closable : true,
				bodyCls : 'content-doc' ,
				extractor : function(data) {
					data = $.fn.panel.defaults.extractor(data);
					var tmp = $('<div></div>').html(data);
					data = tmp.find('#content').html();
					tmp.remove();
					return data;
				} 
			});
		}
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
				<li><a href="javascrit:void(0)">您好，${session_user.name }！</a></li>
				<li><a href="/demo/main/index.php">退出</a></li>
				<!-- <li><a href="/tutorial/index.php">Tutorial</a></li>
				<li><a href="/documentation/index.php">Documentation</a></li>
				<li><a href="/download/index.php">Download</a></li>
				<li><a href="/extension/index.php">Extension</a></li>
				<li><a href="/contact.php">Contact</a></li>
				<li><a href="/forum/index.php">Forum</a></li> -->
			</ul>
		</div>
	</div>
	<div region="north" border="false" class="group wrap header"
		style="height: 66px; font-size: 100%">
		<div class="content">
			<div class="navigation-toggle" data-tools="navigation-toggle"
				data-target="#navbar-1">
				<span>教育培训</span>
			</div>
			<div id="elogo" class="navbar navbar-left">
				<ul>
					<!-- <li><a href="index.jsp"><img src="images/logo2.png"
							alt="jQuery EasyUI" /></a></li> -->
					<li style="font-size: 28px;font-weight: bold;"><a href="index.jsp">教育培训管理系统</a></li>
				</ul>
			</div>
			<div id="navbar-1" class="navbar navbar-right">
				<ul>
					<li><a href="javascrit:void(0)">您好，${session_user.name }！</a></li>
					<li><a href="logout">退出</a></li>
					<!-- 此可加内容 -->
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
			<li iconCls="icon-base"><span>Base</span>
			<ul>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('表单','html/form.html')">表单</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('jsp表单','jsp/form.jsp')">jsp表单</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('jsp表单','/webbase/user/add')">新增用户</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('登录','/webbase/login')">登录</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('draggable')">draggable</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('droppable')">droppable</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('resizable')">resizable</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('pagination')">pagination</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('searchbox')">searchbox</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('progressbar')">progressbar</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('tooltip')">tooltip</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('mobile')">mobile</a></li>
				</ul></li>
			<li iconCls="icon-layout"><span>Layout</span>
			<ul>
					<li iconCls="icon-gears"><a href="#" onclick="open1('panel')">panel</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('tabs')">tabs</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('accordion')">accordion</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('layout')">layout</a></li>
				</ul></li>
			<li iconCls="icon-menu"><span>Menu and Button</span>
			<ul>
					<li iconCls="icon-gears"><a href="#" onclick="open1('menu')">menu</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('linkbutton')">linkbutton</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('menubutton')">menubutton</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('splitbutton')">splitbutton</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('switchbutton')">switchbutton</a></li>
				</ul></li>
			<li iconCls="icon-form"><span>Form</span>
			<ul>
					<li iconCls="icon-gears"><a href="#" onclick="open1('form')">form</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('validatebox')">validatebox</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('textbox')">textbox</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('passwordbox')">passwordbox</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('combo')">combo</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('combobox')">combobox</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('combotree')">combotree</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('combogrid')">combogrid</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('combotreegrid')">combotreegrid</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('numberbox')">numberbox</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('datebox')">datebox</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('datetimebox')">datetimebox</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('datetimespinner')">datetimespinner</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('calendar')">calendar</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('spinner')">spinner</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('numberspinner')">numberspinner</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('timespinner')">timespinner</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('slider')">slider</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('filebox')">filebox</a></li>
				</ul></li>
			<li iconCls="icon-window"><span>Window</span>
			<ul>
					<li iconCls="icon-gears"><a href="#" onclick="open1('window')">window</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('dialog')">dialog</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('messager')">messager</a></li>
				</ul></li>
			<li iconCls="icon-datagrid"><span>DataGrid and Tree</span>
			<ul>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('datagrid')">datagrid</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('datalist')">datalist</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('propertygrid')">propertygrid</a></li>
					<li iconCls="icon-gears"><a href="#" onclick="open1('tree')">tree</a></li>
					<li iconCls="icon-gears"><a href="#"
						onclick="open1('treegrid')">treegrid</a></li>
				</ul></li>
		</ul>
	</div>
	<div region="center">
		<div id="tt" class="easyui-tabs" fit="true" border="false"
			plain="true">
			<!-- <div title="welcome" href="welcome.php" class="content-doc"></div> -->
		</div>
	</div>
	<!-- dialog div -->
	<div id="dd"></div>
</body>
</html>



