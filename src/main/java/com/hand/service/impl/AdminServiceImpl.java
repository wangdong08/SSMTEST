package com.hand.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.AdminDao;
import com.hand.service.AdminService;

/**
 * 
 * @author wangdong
 * @since 2017/07/07
 *
 */
@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Resource
	private AdminDao adminDao;
	
	/**
	 * 管理员登录
	 */
	public int adminLogin(String admin_name, String pwd) {
		// TODO Auto-generated method stub
		return this.adminDao.adminLogin(admin_name, pwd);
	}

}
