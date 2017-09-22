var org = {
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
				org.currNode = treeNode;
				var ordno = 0;
				if (treeNode.children) {
					ordno = treeNode.children.length;
				}
				var da = {
					ordno : ordno,
					pid : treeNode.id,
					pname : treeNode.name
				};
				$("#org_add").form("clear");
				$("#org_add").form("load", da);
				$("#org_buttons").show();
				return false;
			});
	},
	onClick : function(event, treeId, treeNode, clickFlag) {
		if (treeNode.pid != null) {
			org.currNode = treeNode;
			treeNode.oldname = treeNode.name;
			$("#org_add").form("load", treeNode);
			$("#org_buttons").show();
		} else {
			$("#org_buttons").hide();
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
			var orgIds = [];
			var childs = targetNode.getParentNode().children;
			for ( var i in childs) {
				orgIds.push(childs[i].id)
			}
			$.ajax({
				url : ctx + '/org/setOrder',
				async : false,
				data : {
					orgIds : orgIds
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
							newNode.oldname = newNode.name;
							$("#org_add").form("load", newNode);

							if (org.currNode.id == newNode.pid) {

								orgzTree.addNodes(org.currNode, newNode);
								orgzTree.currNode = orgzTree.getNodeByParam(
										"id", newNode.id);
							} else {
								org.currNode.name = newNode.name;
								org.currNode.type = newNode.type;
								org.currNode.version = newNode.version;
								orgzTree.updateNode(org.currNode);
							}
						});
					}
				});
	}
};

var orgTreeSetting = {
	view : {
		addHoverDom : org.addHoverDom,
		removeHoverDom : ztreef.removeHoverDom,
		selectedMulti : false
	},
	edit : {
		enable : true,
		removeTitle : I18N.remove,
		showRenameBtn : false,
		showRemoveBtn : function(treeId, treeNode) {
			if (treeNode.pid == null) {
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
		onClick : org.onClick,
		beforeDrop : org.beforeDrop,
		onDrop : org.onDrop
	}
};

var orgTreezNodes = [ {
	id : 0,
	pid : null,
	name : I18N.org
} ];

var orgzTree;

$(function(){
	
	$.ajax({
		url : ctx + "/org/tree",
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data && data.length > 0) {
				orgTreezNodes = data;
			}
		}
	});
	orgzTree = $.fn.zTree.init($("#orgTree"), orgTreeSetting, orgTreezNodes);
	orgzTree.deleteUrl = ctx + "/org/delete";
});