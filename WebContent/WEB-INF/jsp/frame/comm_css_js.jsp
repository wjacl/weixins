<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
	<title><s:message code="sys.app.name" /></title>
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jquery-easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/css/kube.css" />
	<link rel="stylesheet" type="text/css" href="${ctx }/css/main.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/js/jquery-easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/js/ztree/css/zTreeStyle/zTreeStyle.css">
    <script type="text/javascript">
	<!--
	var ctx = '${ctx}';
	var _sysCurrDate = '${currDate}';
	var _sysCurrDateTime = '${currDateTime}';
	var publicUploadUrl = '${publicUploadUrl}';
	var publicDownloadUrl = '${publicDownloadUrl}';
	//-->
	</script>
    <script type="text/javascript" src="${ctx }/js/jquery-easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/jquery-easyui/datagrid-detailview.js"></script>
    <script type="text/javascript" src="${ctx }/js/jquery-easyui/locale/easyui-lang-${user_lang}.js"></script>
    <script type="text/javascript" src="${ctx }/js/ztree/js/jquery.ztree.all.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/i18n/messages-${user_lang}.js"></script>
    <script type="text/javascript" src="${ctx }/js/ajax_global_set.js"></script>
    <script type="text/javascript" src="${ctx }/js/loading.js"></script>
	<script type="text/javascript" src="${ctx }/js/jquery-easyui/jquery.edatagrid.js"></script>

    