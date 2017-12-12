INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('0','数据字典','',0,NULL,'s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('user.type','用户类别','user.type',1,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('2','管理领导','L',2,'user.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('3','普通用户','N',3,'user.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('user.status','用户状态','user.status',5,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('6','正常','N',6,'user.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('7','锁定','L',7,'user.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('5','未审核','W',8,'user.status','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('20','审核状态','audit',20,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('21','草稿','c',21,'20','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('22','待审核','w',22,'20','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('23','审核通过','p',23,'20','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('24','待审核','n',24,'20','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('sex','性别','sex',4,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('25','男','m',1,'sex','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('26','女','w',2,'sex','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('org.type','机构类别','org.type',5,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('ot1','公司','1',1,'org.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('ot4','部门','4',4,'org.type','s',1);


INSERT INTO t_sys_role(ID,NAME,TYPE,valid,version)
VALUES('admin','超级管理员','s',1,0);

INSERT INTO t_sys_user(Id,username,password,name,TYPE,status,valid,version)
VALUES('u001','admin','21232F297A57A5A743894A0E4A801FC3','系统管理员','A','N',1,0);

INSERT INTO t_sys_user_role(u_id,r_id)VALUES('u001','admin');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys','系统管理',NULL,NULL,'2',1,9000);

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict','字典维护','/dict/main','sys','1',1,9800);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-tree','查询','/dict/getTree','sys-dict','0',1,9801);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-add','新增','/dict/add','sys-dict','0',1,9802);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-update','修改','/dict/update','sys-dict','0',1,9803);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-remove','删除','/dict/remove','sys-dict','0',1,9804);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-tree');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-remove');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user','用户管理','/user/mana','sys','1',1,9101);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-query','查询','/user/query','sys-user','0',1,9102);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-add','新增','/user/add','sys-user','0',1,9103);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-update','修改','/user/update','sys-user','0',1,9104);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-remove','删除','/user/remove','sys-user','0',1,9105);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-remove');


INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role','角色管理','/role/manage','sys','1',1,9111);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-query','查询','/role/query','sys-role','0',1,9112);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-add','新增','/role/add','sys-role','0',1,9113);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-update','修改','/role/update','sys-role','0',1,9114);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-delete','删除','/role/delete','sys-role','0',1,9115);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-get','获取','/role/get','sys-role','0',1,9116);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-delete');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-get');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-org','机构管理','/org/manage','sys','1',1,9130);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-org');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-param','参数设置','/param/manage','sys','1',1,9850);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-param');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-param-query','查询','/param/query','sys','0',1,9851);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-param-query');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-param-save','修改','/param/save','sys','0',1,9852);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-param-save');

INSERT INTO t_sys_param(ID,name,VALUE,remark)
VALUES('login.try.max.times','登录最大尝试次数','6','登录最大尝试次数，当超过时，将被锁定。');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('person','个人信息','/person/info',NULL,'1',1,8990);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','person');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi','业务管理',NULL,NULL,'2',1,1000);

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-brand','品牌管理','/admin/brand/manage','busi','1',1,1111);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-brand-query','查询','/admin/brand/query','busi-brand','0',1,1112);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-brand');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-brand-query');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-hotBrand','热门品牌管理','/admin/hotBrand/manage','busi','1',1,1121);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-hotBrand-query','查询','/admin/hotBrand/query','busi-hotBrand','0',1,1122);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-hotBrand-add','新增','/admin/hotBrand/add','busi-hotBrand','0',1,1123);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-hotBrand-update','修改','/admin/hotBrand/update','busi-hotBrand','0',1,1124);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-hotBrand-delete','删除','/admin/hotBrand/delete','busi-hotBrand','0',1,1125);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-hotBrand');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-hotBrand-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-hotBrand-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-hotBrand-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-hotBrand-delete');


INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-recomExpert','推荐专家管理','/admin/recomExpert/manage','busi','1',1,1131);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-expert-query','专家查询','/admin/expert/query','busi-recomExpert','0',1,1132);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-recomExpert-query','查询','/admin/recomExpert/query','busi-recomExpert','0',1,1132);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-recomExpert-add','新增','/admin/recomExpert/add','busi-recomExpert','0',1,1133);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-recomExpert-update','修改','/admin/recomExpert/update','busi-recomExpert','0',1,1134);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-recomExpert-delete','删除','/admin/recomExpert/delete','busi-recomExpert','0',1,1135);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-recomExpert');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-expert-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-recomExpert-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-recomExpert-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-recomExpert-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-recomExpert-delete');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-fuser','认证用户管理','/admin/fuser/manage','busi','1',1,1141);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-fuser-query','查询','/admin/fuser/query','busi-fuser','0',1,1142);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-fuser-view','查看','/admin/fuser/view','busi-fuser','0',1,1143);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('busi-fuser-tk','退款','/admin/fuser/tk','busi-fuser','0',1,1144);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-fuser');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-fuser-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-fuser-view');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','busi-fuser-tk');
