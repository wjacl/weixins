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
		认证用户管理
	</h3>
	
	<div id="fuser_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<app:author path="/admin/fuser/introUpdate">
				<a href="#" onclick="$.ad.toUpdate('fuser_grid','user_w','简介','user_add','${ctx }/admin/fuser/introUpdate');initIntroUpdate();" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true">编辑简介</a> 
			</app:author>
			<app:author path="/admin/fuser/view">
				<a href="#" onclick="javascript:doView()" class="easyui-linkbutton"
					iconCls="icon-search" plain="true">查看</a> 
			</app:author>
			<app:author path="/admin/fuser/tk">
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="showtk()">退款</a>
			</app:author>
		</div>
		<div>
			<form id="fuser_query_form">
				名称
				: <input class="easyui-textbox" style="width: 120px"
					name="name_like_string">
				经营类别:
				<input class="easyui-combobox" name="category_in_String"
					style="width: 80px;"
					data-options="
	                    url:'${ctx }/dict/get?pvalue=follwer.category',
	                    method:'get',
	                    valueField:'value',
	                    textField:'name',
	                    panelHeight:'auto',				
	                    multiple:true,
	                    editable:false
                    ">
                	状态:
				<select class="easyui-combobox" name="status_in_intt" multiple="multiple" style="width:120px;">
				    <option value="6">审核通过</option>
				    <option value="7">待审核</option>
				    <option value="8">审核未通过</option>
				    <option value="0">编辑中</option>
				    <option value="1">已选好类别</option>
				    <option value="2">填写好基本信息</option>
				    <option value="3">填写好简介</option>
				    <option value="4">已设置好品牌</option>
				    <option value="5">保证金已支付</option>
				</select>
				注册时间
				: <input class="easyui-datebox" style="width: 100px"
					name="createTime_after_date">
					-
					<input class="easyui-datebox" style="width: 100px"
					name="createTime_before_date">
				<a
					href="javascript:$.ad.gridQuery('fuser_query_form','fuser_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>
	<table id="fuser_grid" 
		data-options="rownumbers:true,singleSelect:true,pagination:true,multiSort:true,selectOnCheck:true,
				sortName:'pinyin',sortOrder:'asc',
				idField:'id',method:'post',toolbar:'#fuser_tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'name',width:120">名称</th>	
				<th
					data-options="field:'logo',width:80,formatter:imageFormatter">头像</th>	
				<th
					data-options="field:'category',width:80,align:'center',formatter:categoryFormatter">经营类别</th>			
				<th
					data-options="field:'createTime',width:90,align:'center',formatter:createTimeFormatter">注册时间</th>
				<th
					data-options="field:'status',width:100,formatter:statusFormatter">状态</th>
				<th
					data-options="field:'mphone',align:'center',width:100">手机号</th>
				<th
					data-options="field:'wechat',align:'center',width:100">微信号</th>
				<th
					data-options="field:'address'">地址</th>	
			</tr>
		</thead>
	</table>
	<script type="text/javascript">	
		function imageFormatter(value,row,index){
			if(value != null && value != ""){
				return "<img src=\"" + publicDownloadUrl + value + "\" width=\"70\" width=\"70\" >";
			}
			return '';
		}
		function createTimeFormatter(value,row,index){
			if(value != null && value != ""){
				return value.substring(0,10);
			}
			return '';
		}
		function categoryFormatter(value,row,index){
			switch(value){
				case '1':
					return '厂家';
				case '2':
					return '商家';
				case '3':
					return '专家';
				case '4':
					return '安装师傅';
				case '5':
					return '自然人';
				case '6':
					return '其他';
			}
			return "";
		}
		var status=["编辑中","已选经营类别","已填基本信息","已填简介","已选品牌","已付保证金","审核通过","待审核","审核未通过"];
		function statusFormatter(value,row,index){
			switch(value){
				case 0:
					return "编辑中";
				case 1:
					return "已选经营类别";
				case 2:
					return "已填基本信息";
				case 3:
					return "已填简介";
				case 4:
					return "已选品牌";
				case 5:
					return "已付保证金";
				case 6:
					return "审核通过";
				case 7:
					return "待审核";
				case 8:
					return "审核未通过";
			}
			return "";
		}
		
		$('#fuser_grid').datagrid({
			url:'${ctx }/admin/fuser/query'
		});
	
		function doView(){
			var rows = $("#fuser_grid").datagrid("getChecked");
			if(rows.length != 1){
				$.sm.alert("请选择一个认证用户");
				return;
			}
			else{
				window.open("${ctx }/admin/fuser/view/" + rows[0].id,"_blank");
			}
		}
		
		var tkid = null;
		
		function showtk(){
			var rows = $("#fuser_grid").datagrid("getChecked");
			if(rows.length != 1){
				$.sm.alert("请选择一个认证用户");
				return;
			}
			else{
				tkid = rows[0].id;
				$.getJSON("getTk",{id : tkid},function(data){
					var bzj = 0;
					var balance = 0;
					if(data.openId != tkid){
						$.sm.alert("该用户没有款需要退！");
						return;
					}
					if(data.bzj){
						bzj = data.bzj;
					}
					if(data.balance){
						balance = data.balance;
					}
					if(bzj + balance == 0){
						$.sm.alert("该用户没有款需要退！");
						return;
					}
					
					$("#tk_bzj").html(bzj);
					$("#tk_balance").html(balance);
					
					$("#tk_name").html(rows[0].name);
					$('#dd').dialog('open');
				});
			}
		}
		
		function dotk(){
			$.sm.confirm("您确定进行退款吗？",function(){
				$.getJSON("doTk",{id : tkid},function(data){
					$.sm.handleResult(data);
					$('#dd').dialog('close');
				});
			});
		}
		
		
		// 2018-07-10 增加的编辑简介信息
		function initIntroUpdate(){
			var rows = $("#fuser_grid").datagrid("getChecked");

			$("#blogo").attr("src","");
			
			if(rows[0].logo){
				$("#blogo").attr("src",'${publicDownloadUrl}' + rows[0].logo);
			}
			
			//先清空
			$('#myIntro').froalaEditor('html.set', "");
			if(rows[0].intro){
				$('#myIntro').froalaEditor('html.set', rows[0].intro);
			}	
		}
	</script>
	
	<div id="dd" class="easyui-dialog" title="退款" style="width:440px;height:230px;"
    data-options="resizable:false,modal:true,closed:true">	
		<form id="ff" method="post">
	        <div  style="text-align:center;padding:5px">
	    		<label>名称:<span id="tk_name"></span></label>
	        </div>
	        <div  style="text-align:center;padding:5px">
	    		<label>保证金:<span id="tk_bzj"></span></label>
	        </div>
	        <div  style="text-align:center;padding:5px">
	    		<label>余额:<span id="tk_balance"></span></label>
	        </div>
	        <div style="text-align:center;padding:15px">
	    		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="dotk()">退 款</a>
	        </div>
	    </form>
	</div>
	<script type="text/javascript">	
		

	</script>
	<div id="user_w" class="easyui-window" title='<s:message code="user.add" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 600px; height: 500px; padding: 10px;">
		<div class="content">
				<form id="user_add" method="post" action="${ctx }/admin/fuser/introUpdate">
					<div style="margin-bottom: 10px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'名称：',disabled:true">
					</div>						
					<div style="margin-bottom: 10px">
						<label>头像/logo：&nbsp;&nbsp;&nbsp;</label>
						<a href="#" onclick="$('#myfile').click();" class="easyui-linkbutton" data-options="iconCls:'icon-add'">选择文件</a>						
					</div>	
					<div style="margin-bottom: 10px">	
						<img id="blogo" src="" width="100" height="100"/>
					</div>
					<div style="margin-bottom: 10px">
						简介：
					</div>
					<div >
                    <textarea name="intro" id="myIntro"></textarea>
                    </div>
                    <input type="hidden" name="id" id="introId"/>
                    <input type="hidden" name="logo" id="logo"/>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('user_add','fuser_grid','user_w')" style="width: 80px">
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
	h5FichEditorInit("myIntro",ctx + "/admin/upload/comm",{type:"brand"});
	$("#myfile").change(function(){
		$("#liveData_import").form('submit',{success:function(data){
			data = eval('(' + data + ')');
			$("#blogo").attr("src",data.link);
			$("#logo").val(data.fileName);
		}});
	});
});
</script>