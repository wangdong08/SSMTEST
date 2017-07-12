package com.hand.service;

import java.util.List;

import com.hand.model.User;

/**
 * 
 * @author wangdong
 * @since 2017/07/07
 *
 */
public interface UserService {
	
	/**
	 * 根据ID查找用户
	 * @param userId
	 * @return
	 */
	public User getUserById(int userId);
	
	/**
	 * 用户登录
	 * @param name
	 * @param pwd
	 * @return
	 */
    public int userLogin(String name,String pwd);
    
    /**
     * 用户列表
     * @return
     */
    public List<User> userList();
    
    /**
     * 新增用户
     * @param user
     */
    public void insertUser(User user);
    
    /**
     * 删除用户
     * @param userId
     */
    public void deleteUser(int userId);
    
    /**
     * 修改用户
     * @param user
     */
    public void updateUser(User user);
    
    /**
     * 根据用户名查询用户
     * @param name
     * @return
     */
    
    public List<User> findUserByName(String name);
    
    /** 
     * 分页显示商品 
     * @param request 
     * @param model 
     * @param loginUserId 
     */  
    public List<User> showProductsByPage(Integer startPos, Integer pageSize);
    
    /**
     * 查询总数据数
     * @return
     */
    public long getProductsCount();
}
