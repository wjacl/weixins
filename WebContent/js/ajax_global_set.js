/**
	jquery ajax 全局设置
	在此js中主要设置当用户session失效、鉴权不通过时的ajax请求的处理。
*/
$.ajaxSetup({traditional:true});

$( document ).ajaxComplete(function( event, xhr, settings ) {
	
	if(xhr.status == 401){ //未认证
		if(document.getElementById('loginDialog')) {
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
		else {
			window.parent.login(xhr);
		}
	}
	else if(xhr.status == 403){//没有权限
		$.messager.alert('警告','您没有权限进行此项操作！','warning');
		return false;
	}
 
});

/**
 * 扩展的提示、结果处理方法插件
 */
$.sm = {
		alert:function(mess){
			$.messager.alert(I18N.ALERT_TITLE,mess);
		},
		
		show:function(mess){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:mess,
                showType:'show'
            });
		},
		
		showAddOK : function(){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:I18N.OPER_ADD_OK,
                showType:'show'
            });
		},
		showUpdateOK : function(){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:I18N.OPER_UPDATE_OK,
                showType:'show'
            });
		},
		showDeleteOK : function(){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:I18N.OPER_DELETE_OK,
                showType:'show'
            });
		},
		showSysError:function(error){
			$.messager.show({
                title:I18N.ALERT_TITLE,
                msg:I18N.OPER_SYS_ERROR + (error ? ":" + error : ""),
                showType:'show'
            });
		},
		confirmDelete:function(fun){
			 $.messager.confirm(I18N.CONFIRM_TITLE, I18N.CONFIRM_DELETE_MESS, function(r){		 
				 if(r){
	                fun.call(this);
				 }
	           });
		},
		
		confirm:function(mess,fun){
			$.messager.confirm(I18N.CONFIRM_TITLE, mess, function(r){		 
				 if(r){
	                fun.call(this);
				 }
	           });
		},
		
		ResultStatus_Ok:200,   //操作结果码：成功
		ResultStatus_Eorror : 500,  //操作结果码：失败
		
		/**通用的操作结果处理方法 <br> 
		 * 参数:res:结果对象 {status:200,operate:1,mess:"",data:{}}<br>
		 * status表示操作结果200成功，500失败；<br>
		 * operate表示操作：0操作，1新增，2修改，3删除<br>
		 * mess表示结果信息<br>
		 * data表示服务器返回的操作数据<br>
		 * success：成功的回调处理方法 function(data){} <br>
		 * faild的回调处理方法 function(data){}
		 * 
		 */
		handleResult:function(res,success,faild){
			if(res.status == this.ResultStatus_Ok){
				var content = "";
				if(res.mess){
					content = res.mess;
				}
				else{
					content = I18N.operate_ok[res.operate];
				}
				
				$.messager.show({
	                title:I18N.SHOW_TITLE,
	                msg:content,
	                showType:'show'
	            });
				
				if(success){
					if(typeof success == "function"){
						success.call(this,res.data);
					}
				}
			}
			else{
				var title = I18N.operate_faild[res.operate];
				var content = "";
				if(res.mess){
					content += res.mess;
				}
				else{
					content += I18N.OPER_SYS_ERROR;
				}
				
				$.messager.alert(title,content);
				
				if(faild){
					if(typeof faild == "function"){
						faild.call(this,res.data);
					}
				}
			}
		}		
};


/**
 * 将表单序列化为json对象的jquery插件
 */
(function($){  
    $.fn.serializeJson=function(){  
        var serializeObj={};  
        var array=this.serializeArray();  
        var str=this.serialize();  
        $(array).each(function(){  
            if(serializeObj[this.name]){  
                if($.isArray(serializeObj[this.name])){  
                    serializeObj[this.name].push(this.value);  
                }else{  
                    serializeObj[this.name]=[serializeObj[this.name],this.value];  
                }  
            }else{  
                serializeObj[this.name]=this.value;   
            }  
        });  
        return serializeObj;  
    };  
})(jQuery);  


/**
 * easyui中的组件的ajax数据的通用处理方法
 */
$.ad = {
	/**
	 * 往下来框框中增加全部选项，要求 值字段名为id,文本字段名为text
	 */
	addAllOption : function(data){
		data.splice(0,0,{id:"",name:I18N.option_all});
		return data;
	},
	addChooseOption : function(data){
		data.splice(0,0,{id:"",name:I18N.option_choose});
		return data;
	},
	
	gridQuery:function(formId,gridId){
		var jsonData = $("#" + formId).serializeJson();
		//为解决数组多值，mvc中map接收只能接收到一个的问题，而将数组转为以","间隔的字符串来传递。
		for(var i in jsonData){
			if(jsonData[i] instanceof Array){
				jsonData[i] = jsonData[i].join(",");
			}
		}
		$('#' + gridId).datagrid('load',jsonData);
		
	},
	
	joinArrayInObjectToString:function(obj){
		for(var i in obj){
			if(obj[i] instanceof Array){
				obj[i] = obj[i].join(",");
			}
		}
	},
	
	submitForm:function(formId,gridId,wid,success){
		var succ;
		if(success && (typeof success == "function")){
			succ = success;
		} 
		else{
			succ = function(data){
				var data = eval('(' + data + ')');
				$.sm.handleResult(data,function(data){
					$('#' + wid).window('close');
					$('#' + formId).form('clear');
					
					if(gridId){
						$('#' + gridId).datagrid('load'); 
					}
				});
			};
		}
		$('#' + formId).form('submit',{success:succ});
	},
	
	clearForm: function (formId) {
		$('#' + formId).form('clear');
	},
	
	toAdd:function(wid,wTitle,formId,url){
		$('#' + formId).form('clear');
		if(url){
			$('#' + formId).form({url:url});
		}
		$("#" + wid).window({title:I18N.add + wTitle});
		$("#" + wid).window("open");
	},
	
	/**
	 * 打开表单窗口方法
	 * @param options:{beforeProc:function,formId:String,clear:boolean,initFun:function,
	 * 		url:string,initData:object,wid:string,wTitle:string}
	 */
	openFormWin:function(options){
		if(options.beforeProc){
			options.beforeProc();
		}
		if(options.formId){
			if(options.clear){
				$('#' + options.formId).form('clear');
			}
			if(options.url){
				$('#' + options.formId).form({url:options.url});
			}
			if(options.initFun){
				options.initFun();
			}
			if(options.initData){
				$('#' + options.formId).form('load',options.initData);
			}
		}
		if(options.wid){
			if(options.wTitle){
				$('#' + options.wid).window({title:options.wTitle});
			}
			$('#' + options.wid).window('open');
		}
	},
	
	/**
	 * 从表格选择数据修改的方法<br>
	 * @param gridId 表格id<br>
	 * @param wid  窗口id<br>
	 * @param wTitle  标题<br>
	 * @param formId  表单id<br>
	 * @param url 提交的url<br>
	 * @param addAttr  非必须，{key:dataKey} 要向表格数据中补充的属性,key指定属性名，dataKey指定要用到的数据的key,<br>
	 * 该参数加入的原因是:修改界面有唯一校验，以补充属性的方式给表单填充一个隐藏值。参见user.jsp上的使用
	 */
	toUpdate:function(gridId,wid,wTitle,formId,url,addAttr){
		var selRows = $("#" + gridId).datagrid("getSelections");
		if(selRows.length != 1){
			$.sm.alert(I18N.alert_select_one);
			return;
		}
		var fdata = selRows[0];
		if(addAttr){
			for(var key in addAttr){
				fdata[key] = fdata[addAttr[key]];
			}
		}
		$('#' + formId).form('load',fdata);
		
		if(url){
			$('#' + formId).form({url:url});
		}
		$("#" + wid).window({title:I18N.update + wTitle});
		$("#" + wid).window("open");
	},
	
	doDelete:function(gridId,url){
		var selRows = $("#" + gridId).datagrid("getChecked");
		if(selRows.length == 0){
			$.sm.alert(I18N.alert_select);
			return;
		}
		
		$.sm.confirmDelete(function(){
			var ids = [];
			for(var i in selRows){
				ids.push(selRows[i].id);
			}
			
			$.post(url,{id:ids},function(data){
				$.sm.handleResult(data,function(data){
					$("#" + gridId).datagrid("reload");
				});
			},'json');
		});
	},
	
	/**
	 * 将有父子关系的数据数组，转为easyui-tree的树结构<br>
	 * @param data []  待转的数据数组<br>
	 * @param id String 数据的id属性名<br>
	 * @param pid String 数据的父id属性名<br>
	 * @param name String 数据的名称属性名<br>
	 * @returns {Array}
	 */
	toEasyUiTree : function (rows,id,pid,name){
		function exists(rows, pid){
			for(var i=0; i<rows.length; i++){
				if (rows[i].id == pid) return true;
			}
			return false;
		}
		
		var nodes = [];
		// get the top level nodes
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			row.id = row[id];
			row.text = row[name];
			if (!exists(rows, row[pid])){
				nodes.push(row);
			}
		}
		
		var toDo = [];
		for(var i=0; i<nodes.length; i++){
			toDo.push(nodes[i]);
		}
		while(toDo.length){
			var node = toDo.shift();	// the parent node
			// get the children nodes
			for(var i=0; i<rows.length; i++){
				var row = rows[i];
				if (row[pid] == node.id){
					if (node.children){
						node.children.push(row);
					} else {
						node.children = [row];
					}
					toDo.push(row);
				}
			}
		}
		return nodes;
	},
	
	/**
	 * 新建的命名更确切的标准数据转easyUiTree
	 * @param data
	 * @returns
	 */
	standardIdPidNameArrayToEasyUITree : function(data){
		if(!data){
			return null;
		}
		
		return $.ad.toEasyUiTree(data,'id','pid','name');
	},
	
	easyTreeDefaultLoadFilter : function (data){
		if(!data){
			return null;
		}
		
		return $.ad.toEasyUiTree(data,'id','pid','name');
		
	},
	
	/**
	 * 从数组中取值对应的名字的方法<br>
	 * @param value  值<br>
	 * @param array  数组<br>
	 * @param vAttr  值对应的属性名，默认为 id<br>
	 * @param nameAttr 名字对应的属性名，默认为 name <br>
	 * @returns 找到了则为名字，否则为""
	 */
	getName:function(value,array,vAttr,nameAttr){
		if(!vAttr){
			vAttr = 'id';
		}
		if(!nameAttr){
			nameAttr = "name";
		}
		var vname = "";
		if((array instanceof Array) && array.length > 0) {
			for(var i in array){
				if(array[i][vAttr] == value){
					return array[i][nameAttr];
				}
			}
		}
		return "";
	},
	
	dateFormatter:function(value,row,index){
		if(value){
			if(value.length > 10){
				return value.substring(0,10);
			}
			else{
				return value;
			}
		}
		return "";
	},
	
	/**
	 * 加载的字典数组，以字典pvalue值为key索引放入一类字典的数组
	 */
	dictArray : [],	
	getDictName:function(pvalue,value){
		if(!$.ad.dictArray[pvalue]){
			var url = ctx + "/dict/get?pvalue=" + pvalue;
			$.ajax({url:url,async:false,dataType:'json',success:function(data){
				$.ad.dictArray[pvalue] = data;
			}})
		}
		
		return $.ad.getName(value,$.ad.dictArray[pvalue],'value');
	},
	
	/**
	 * undefind、null替换
	 * @param value
	 * @param target  目标值
	 * @returns
	 */
	nvl: function(value,target){
		if(!target){
			target = '';
		}
		if(value == undefined || value == null){
			return target;
		}
		else{
			return value;
		}
	}
}

var ztreef = {
		clickToEdit:function (event, treeId, treeNode, clickFlag){
			$.fn.zTree.getZTreeObj(treeId).editName(treeNode);
		},
		
		beforeRename:function (treeId, treeNode, newName, isCancel){
			var ztree = $.fn.zTree.getZTreeObj(treeId);
			if(newName.length == 0){
				ztree.cancelEditName();
				$.sm.alert(I18N.org_name_not_null);
				return false;
			}
			
			if(treeNode.name == newName){
				return true;
			}
			
			var res = false;
			
			$.ajax({ url: ztree.saveUrl,dataType:'json',data:{id:treeNode.id,name:newName,pid:treeNode.pid},async:false, 
				success: function(data){
					$.sm.handleResult(data);
					if(!treeNode.id){
						treeNode.id = data.data;
					}
					res = true;
			      }});
			
			return res;
		},
		
		beforeRemove:function (treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj(treeId);
			zTree.selectNode(treeNode);
			$.sm.confirmDelete(function(){
				var ids = [];
				ztreef.getAllChildrenIds(treeNode,ids);
				if(ids.length == 0){
					zTree.removeNode(treeNode);
					return;
				}
				
				$.ajax({ url: zTree.deleteUrl,dataType:'json',method:"post",data:{ids:ids},async:false, 
					success: function(data){
						$.sm.handleResult(data);
						zTree.removeNode(treeNode);
				      }});
			});
			return false;
		},
		
		getAllChildrenIds:function (node,ids){
			if(node.id){
				ids.push(node.id);
			}
			if(node.children && node.children.length>0){
				for(var i in node.children){
					this.getAllChildrenIds(node.children[i],ids);
				}
			}
		},
		
		addHoverDom:function (treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj(treeId);
				zTree.addNodes(treeNode, {pid:treeNode.id, name:I18N.ztree_node_new});
				return false;
			});
		},
		
		removeHoverDom:function orgRemoveHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		},
		
		beforeDrag : function(treeId, treeNodes) {
			for (var i=0,l=treeNodes.length; i<l; i++) {
				if (treeNodes[i].drag === false) {
					return false;
				}
			}
			return true;
		},
		beforeDrop : function(treeId, treeNodes, targetNode, moveType) {
			return targetNode ? targetNode.drop !== false : true;
		}
}


/**
 * easyui校验扩展
 */
$.extend($.fn.validatebox.defaults.rules, {
    equals: {
        validator: function(value,param){
            return value == $(param[0]).val();
        },
        message: I18N.validator_equals
    }
});
$.extend($.fn.validatebox.defaults.rules, {
    minLength: {
        validator: function(value, param){
            return value.length >= param[0];
        },
        message: I18N.validator_minLength
    }
});
$.extend($.fn.validatebox.defaults.rules, {
    maxLength: {
        validator: function(value, param){
            return value.length <= param[0];
        },
        message: I18N.validator_maxLength
    }
});
$.extend($.fn.validatebox.defaults.rules, {
    myRemote: {
        validator: function(value, param){
        	if(value == $(param[2]).val()){
        		return true;
        	}
        	else{
        		var _48={};
        		_48[param[1]]=value;
        		//附加参数，在param数组中依次成对出现（名、值）
        		if(param.length > 3){
        			for(var i = 3; i < param.length;i+=2){
        				var v = param[i+1];
        				if(v.charAt(0) == "#"){
        					v = $(v).val();
        				}
        				_48[param[i]]=v;
        			}
        		}
        		var _49=$.ajax({url:param[0],dataType:"json",data:_48,async:false,cache:false,type:"post"}).responseText;
        		return _49=="true";
        	}
        },
        message: I18N.validator_exits
    }
});

