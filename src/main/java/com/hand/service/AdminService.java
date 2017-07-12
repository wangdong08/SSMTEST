package com.hand.service;

/**
 * 
 * @author wangdong
 * @since 2017/07/07
 *
 */
public interface AdminService {
	
	/**
	 * 管理员登录
	 * @param admin_name
	 * @param pwd
	 * @return
	 */
    public int adminLogin(String admin_name,String pwd);
}
