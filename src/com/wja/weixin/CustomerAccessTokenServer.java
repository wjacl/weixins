/**
 * 
 */
package com.wja.weixin;

import org.sword.wechat4j.token.Token;
import org.sword.wechat4j.token.server.CustomerServer;

/**
 * @author repo_user
 * @date   2015年1月12日
 */
public class CustomerAccessTokenServer extends CustomerServer {

    private static Token accessToken;
	/*
	 * @see org.sword.wechat4j.token.DbAccessTokenServer#find()
	 */
	@Override
	public String find() {
		//String accessToken = null;
		//执行数据库操作
//		String sql = "select cfgValue from cfg where cfg.cfgKey = 'access_token'";
//		accessToken = DBUtil.query(sql);
		if(CustomerAccessTokenServer.accessToken != null){
		    return CustomerAccessTokenServer.accessToken.getToken();
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see org.sword.wechat4j.token.DbAccessTokenServer#save()
	 */
	@Override
	public boolean save(Token accessToken) {
		//如果没有需要插入，如果有的就更新，假设已经有了数据库配置项
//		String sql = "update cfg set cfg.cfgValue=" + accessToken.getToken() + 
//				" where cfg.cfgKey= 'access_token'";
//		DBUtil.execute(sql);
	    CustomerAccessTokenServer.accessToken = accessToken;
		return true;
	}
}
