<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<div class="content">
				<form id="user_add" method="post" action="${ctx }/admin/brand/add">
					<div style="margin-bottom: 10px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'品牌名称：',required:true,validType:'length[1,30]'">
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
                    <input type="hidden" name="openId" value="${fi.openId }"/>
                    <input type="hidden" name="logo" id="logo" value="${fi.logo }"/>
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