var dict = {
	currNode : null,
	addHoverDom : function(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj(treeId);
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
			return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_" + treeNode.tId);
		if (btn)
			btn.bind("click", function() {
				dict.currNode = treeNode;
				var ordno = 0;
				if (treeNode.children) {
					ordno = treeNode.children.length;
				}
				var da = {
					pid : treeNode.id,
					pname : treeNode.name,
					ordno : ordno,
					type:'b'
				};
				$("#dict_add").form("clear");
				$("#dict_add").form("load", da);
				$("#dictValue").textbox("readonly", false);
				$("#dict_buttons").show();
				return false;
			});
	},
	onClick : function(event, treeId, treeNode, clickFlag) {
		if (treeNode.pid != null) {
			dict.currNode = treeNode;
			treeNode.oldDictName = treeNode.name;
			treeNode.oldDictValue = treeNode.value;
			$("#dict_add").form("load", treeNode);
			$("#dictValue").textbox("readonly", true);
			$("#dict_buttons").show();
		} else {
			$("#dict_buttons").hide();
		}
	},
	beforeDrop : function(treeId, treeNodes, targetNode, moveType) {
		if (targetNode) {
			if (targetNode.pid != treeNodes[0].pid) {
				return false;
			}
		}
		return true;
	},

	onDrop : function(event, treeId, treeNodes, targetNode, moveType) {
		if (targetNode) {
			var dictIds = [];
			var childs = targetNode.getParentNode().children;
			for ( var i in childs) {
				dictIds.push(childs[i].id)
			}
			$.ajax({
				url : ctx + '/dict/setOrder',
				method:'POST',
				async : false,
				data : {
					dictIds : dictIds
				},
				dataType : 'json',
				success : function(data) {

				}
			});
		}
	},
	submitForm : function(formId) {
		$('#' + formId).form(
				'submit',
				{
					success : function(data) {
						var data = eval('(' + data + ')');
						$.sm.handleResult(data, function(node) {

							var newNode = node;
							newNode.oldDictName = newNode.name;
							newNode.oldDictValue = newNode.value;
							$("#dict_add").form("load", newNode);

							if (dict.currNode.id == newNode.pid) {

								dictzTree.addNodes(dict.currNode, newNode);
								dict.currNode = dictzTree.getNodeByParam(
										"id", newNode.id);
								$("#dictValue").textbox("readonly", true);
							} else {
								dict.currNode.name = newNode.name;
								dict.currNode.version = newNode.version;
								dictzTree.updateNode(dict.currNode);
							}
						});
					}
				});
	}
};

var dictTreeSetting = {
	view : {
		addHoverDom : dict.addHoverDom,
		removeHoverDom : ztreef.removeHoverDom,
		selectedMulti : false
	},
	edit : {
		enable : true,
		removeTitle : I18N.remove,
		renameTitle : I18N.update,
		showRenameBtn : false,
		showRemoveBtn : function(treeId, treeNode) {
			if (treeNode.type == 's') {
				return false;
			}
			return true;
		},
		drag : {
			inner : false
		}
	},
	data : {
		simpleData : {
			enable : true,
			pIdKey : "pid"
		}
	},
	callback : {
		beforeRemove : ztreef.beforeRemove,
		onClick : dict.onClick,
		beforeDrop : dict.beforeDrop,
		onDrop : dict.onDrop
	}
};

var dictreezNodes = [ {
	id : 0,
	pid : null,
	name : I18N.dict
} ];
var dictzTree;

$(function() {
	$.ajax({
		url : ctx + "/dict/tree",
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data && data.length > 0) {
				dictreezNodes = data;
			}
		}
	});

	dictzTree = $.fn.zTree.init($("#dictTree"), dictTreeSetting, dictreezNodes);
	dictzTree.deleteUrl = ctx + "/dict/remove";
});
