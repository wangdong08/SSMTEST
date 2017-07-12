package com.hand.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.model.User;
import com.hand.service.AdminService;
import com.hand.service.UserService;

/**
 * 
 * @author wangdong
 * @since 2017/07/07
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Resource
	private AdminService adminService;

	@Resource
	private UserService userService;

	/**
	 * 初始化系统登录页面
	 * 
	 * @return
	 */
	@RequestMapping("/adminIndex")
	public String index() {
		return "admin/adminLogin";
	}

	/**
	 * 管理员登录
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/adminLogin")
	public String adminLogin(HttpServletRequest request, Model model) {
		String admin_name = request.getParameter("adminName");
		String pwd = request.getParameter("password");
//		System.out.println(admin_name+pwd);
		int loginFlag = adminService.adminLogin(admin_name, pwd);
		if (loginFlag == 1) {
			// 登录成功加载用户列表
			List<User> userList = userService.userList();
			model.addAttribute("userList", userList);
			return "showUser";
//			return "redirect:user/userList";
		} else {
			return "admin/adminLoginFailed";
		}
	}

}
