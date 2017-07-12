package com.hand.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.UserDao;
import com.hand.model.User;
import com.hand.service.UserService;

/**
 * 
 * @author wangdong
 * @since 2017/07/07
 *
 */
@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userDao;
	
	/**
	 * 根据ID查找用户
	 */
	public User getUserById(int userId) {
		// TODO Auto-generated method stub
		return this.userDao.selectByPrimaryKey(userId);
	}
    
	/**
	 * 用户登录
	 */
	public int userLogin(String name, String pwd) {
		// TODO Auto-generated method stub
		return this.userDao.userLogin(name, pwd);
	}
	
	/**
	 * 用户列表
	 */
	public List<User> userList() {
		// TODO Auto-generated method stub
		return this.userDao.userList();
	}
	
	/**
	 * 新增用户
	 */
	public void insertUser(User user) {
		// TODO Auto-generated method stub
		this.userDao.insert(user);
	}

	/**
	 * 删除用户
	 */
	public void deleteUser(int userId) {
		// TODO Auto-generated method stub
		this.userDao.deleteByPrimaryKey(userId);
	}
    
	/**
	 * 修改用户
	 */
	public void updateUser(User user) {
		// TODO Auto-generated method stub
//		System.out.println("进入了修改方法。。。");
		this.userDao.updateByPrimaryKeySelective(user);
	}
	
	/**
	 * 根据用户名查询用户
	 */
	public List<User> findUserByName(String name) {
		// TODO Auto-generated method stub
		return this.userDao.findUserByName(name);
	}

	/**
	 * 分页
	 */
	public List<User> showProductsByPage(Integer startPos, Integer pageSize) {
		// TODO Auto-generated method stub
		return this.userDao.selectProductsByPage(startPos, pageSize);
	}
	
	/**
	 * 查询总数据数
	 */
	public long getProductsCount() {
		// TODO Auto-generated method stub
		return this.userDao.getProductsCount();
	}

}