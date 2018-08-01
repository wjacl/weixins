<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="appfn" uri="http://wja.com/jsp/app/functions"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_css.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
	<h3>
		品牌管理
	</h3>	
	<div id="my_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<app:author path="/admin/brand/add">
				<a href="#" onclick="$.ad.toAdd('user_w','品牌','user_add','${ctx }/admin/brand/add');initAdd();" class="easyui-linkbutton"
					iconCls="icon-add" plain="true"><s:message code='comm.add' /></a> 
			</app:author>
			<app:author path="/admin/brand/update">
				<a href="#" onclick="$.ad.toUpdate('my_grid','user_w','品牌','user_add','${ctx }/admin/brand/update');initUpdate();" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a> 
			</app:author>
			<app:author path="/admin/brand/delete">
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="$.ad.doDelete('my_grid','${ctx }/admin/brand/delete')"><s:message code='comm.remove' /></a>
			</app:author>
		</div>
		<div>
			<form id="my_query_form">		
				<s:message code="liver.name" text="名称"/>
				: <input class="easyui-textbox" style="width: 100px"
					name="name_like_string">
				<a
					href="javascript:doQuery()"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
				<input type="hidden" name="or_pinyin_like_string" />
			</form>
		</div>
	</div>
	<table id="my_grid" 
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,checkOnSelect:true,
				sortName:'pinyin',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#my_tb',loadFilter:myDataProcess">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th
					data-options="field:'name',width:160,sortable:'true'">名称</th>
				<th
					data-options="field:'logo',width:110,formatter:imageFormatter">Logo</th>	
				<th
					data-options="field:'ownerName',width:160">创建者</th>
				<th
					data-options="field:'createTime',sortable:'true',align:'center',width:120,formatter:dateFormatter">创建时间</th>	
			</tr>
		</thead>
	</table>
	<script type="text/javascript">	
	
		function doQuery(){
			$('input[name=\"or_pinyin_like_string\"]').val($('input[name=\"name_like_string\"]').val());
			$.ad.gridQuery('my_query_form','my_grid')
		}
		
		function myDataProcess(data){
			return data;
		}
		
		function imageFormatter(value,row,index){
			if(value != null && value != ""){
				return "<img src=\"" + publicDownloadUrl + value + "\" width=\"100\">";
			}
			return '';
		}
		
		function dateFormatter(value,row,index){
			if(value != null && value != ""){
				return value.substring(0,10);
			}
			return '';
		}
		

		$('#my_grid').edatagrid({
			url:'${ctx }/admin/brand/query'
		});
				
		function initAdd(){
			$("#blogo").attr("src",'');
			$('#brandIntro').froalaEditor('html.set', '');
		}
		
		function initUpdate(){
			initAdd(); //清空
			var selRows = $("#my_grid").datagrid("getSelections");
			if(selRows[0].logo){
				$("#blogo").attr("src",'${publicDownloadUrl}' + selRows[0].logo);
			}
			if(selRows[0].intro){
				$('#brandIntro').froalaEditor('html.set', selRows[0].intro);
			}
		}

	</script>

	<div id="user_w" class="easyui-window" title='<s:message code="user.add" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 600px; height: 500px; padding: 10px;">
		<div class="content">
				<form id="user_add" method="post" action="${ctx }/admin/brand/add">
					<div style="margin-bottom: 10px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'品牌名称：',required:true,validType:'length[1,30]'">
					</div>						
					<div style="margin-bottom: 10px">
						<label>品牌logo：&nbsp;&nbsp;&nbsp;</label>
						<a href="#" onclick="$('#myfile').click();" class="easyui-linkbutton" data-options="iconCls:'icon-add'">选择文件</a>						
					</div>	
					<div style="margin-bottom: 10px">	
						<img id="blogo" src="" width="100" height="100"/>
					</div>
					<div style="margin-bottom: 10px">
						品牌简介：
					</div>
					<div >
                    <textarea name="intro" id="brandIntro"></textarea>
                    </div>
                    <input type="hidden" name="id" />
                    <input type="hidden" name="version" />
                    <input type="hidden" name="openId" />
                    <input type="hidden" name="pinyin" />
                    <input type="hidden" name="logo" id="logo"/>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('user_add','my_grid','user_w')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('user_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
	
	<div style="display:none">
		<form id="liveData_import" method="post" action="${ctx }/admin/upload/comm" enctype="multipart/form-data">		
			<input type="file" id="myfile" name="file"  accept="image/*" />
			<input type="hidden" name="type" value="brandLogo" />
		</form>
	</div>
</body>
</html>
<%@ include file="/WEB-INF/jsp/weixin/h5_fich_editor_js.jsp" %>
<script type="text/javascript">
$(function(){
	h5FichEditorInit("brandIntro",ctx + "/admin/upload/comm",{type:"brand"});
	$("#myfile").change(function(){
		$("#liveData_import").form('submit',{success:function(data){
			data = eval('(' + data + ')');
			$("#blogo").attr("src",data.link);
			$("#logo").val(data.fileName);
		}});
	});
});
</script>