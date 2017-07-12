package com.hand.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.model.User;
import com.hand.service.UserService;
import com.hand.util.Page;
import com.hand.util.ResponseUtil;
/**
 * 
 * @author wangdong
 * @since 2017/07/07
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {

//	private static Logger logger = Logger.getLogger(TestMyBatis.class);

	@Resource
	private UserService userService;

	/**
	 * 初始化系统登录页面
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "login";
//		return "verificationCodeTest";
//		return "userLogin";
	}

	/**
	 * 用户登录
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	//@RequestMapping(value = "/userLogin", method = RequestMethod.POST)
	@RequestMapping(value = "/userLogin", method ={RequestMethod.POST,RequestMethod.GET}) //method也可以不写，不写也是同时支持POST和GET
	public String useLogin(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String name = request.getParameter("userName");
		String pwd = request.getParameter("password");
		String loginCode = request.getParameter("verificationCode");
		HttpSession session = request.getSession();
		String verifyCode = session.getAttribute("verCode").toString();
		System.out.println("userName= "+ name);
//		System.out.println("loginCode= "+ loginCode + "verifyCode= "+ verifyCode);
//		String str = (String) session.getAttribute("User");
		/*if(session == null || session.getAttribute("User") == null){
			return "login";
		}else{*/
			int loginFlag = userService.userLogin(name, pwd);
			if (loginFlag == 1 && loginCode.equals(verifyCode)) {
				System.out.println("登录成功了。。。");
				session.setAttribute("userName", name);
//				session.setAttribute("User", "success");
				return "main";
//				return userListEasyUi(request, model);
//				return userList(request, model);
//				// 登录成功加载用户列表
//				List<User> userList = userService.userList();
//				model.addAttribute("userList", userList);
////				System.out.println(userList.get(0).toString());
//				return "showUser";
			} else {
				return "login";
			}
//		}
	}
	
	/**
     * shiro框架登录
     * @param user
     */
    @RequestMapping(value = "/login")//method=RequestMethod.POST
    public ModelAndView login(HttpServletRequest request, User user){
    
    	System.out.println("shiro框架登录。。。"+user.getUser_name());
        // 表面校验
//        if(!StringUtil.isNullOrBlank(user.getUser_name()) || !StringUtil.isNullOrBlank(user.getPassword())){
//             return new ModelAndView("login")
//                     .addObject("message", "账号或密码不能为空")
//                     .addObject("failuser", user);
//        }
    	//1.判断用户名，密码，验证码
    	String name = request.getParameter("userName");
		String pwd = request.getParameter("password");
		String loginCode = request.getParameter("verificationCode");
		HttpSession session = request.getSession();
		String verifyCode = session.getAttribute("verCode").toString();
		int loginFlag = userService.userLogin(name, pwd);
		if (loginFlag != 1 || !loginCode.equals(verifyCode)) {
			return new ModelAndView("login");
		}
    	//2.验证身份
        // 获取主体
        Subject subject = SecurityUtils.getSubject();
        try{
            // 调用安全认证框架的登录方法
            subject.login(new UsernamePasswordToken(user.getUser_name(), user.getPassword()));
        }catch(AuthenticationException ex){
            System.out.println("登陆失败: " + ex.getMessage());
            return new ModelAndView("login")
                    .addObject("message", "用户不存在")
                    .addObject("failuser", user);
        }
        // 登录成功后重定向到首页
        return new ModelAndView("main");
    }

	/**
	 * 新增用户
	 * 
	 * @param request
	 * @param model
	 * @param user
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model, User user) throws Exception {
		userService.insertUser(user);
		response.setContentType("text/html;charset=utf-8");//设置响应的编码格式，不然会出现中文乱码现象  
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("success", true);
        ResponseUtil.write(response, jsonObject);
		return null;
	}

	/**
	 * 删除用户
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		int userId = Integer.parseInt(request.getParameter("id"));
		userService.deleteUser(userId);
//		return userList(request, model);
		response.setContentType("text/html;charset=utf-8");//设置响应的编码格式，不然会出现中文乱码现象  
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("success", true);
        ResponseUtil.write(response, jsonObject);
		return null;
	}

	/**
	 * 修改用户
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/updateUser")
	public String updateUser(HttpServletRequest request, HttpServletResponse response, Model model, User user) throws Exception {
		userService.updateUser(user);
//		return userList(request, model);
		response.setContentType("text/html;charset=utf-8");//设置响应的编码格式，不然会出现中文乱码现象  
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("success", true);
        ResponseUtil.write(response, jsonObject);
		return null;
	}

	/**
	 * 用户列表
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/userList")
	public String userList(HttpServletRequest request, Model model) {
//		System.out.println("日志测试方法触发了我。。。");
		List<User> userList = userService.userList();
		model.addAttribute("userList", userList);
		return "showUser";
	}

	/**
	 * 根据ID查询用户
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/findUserByID")
	public String findUserByID(HttpServletRequest request, Model model) {
		int userId = Integer.parseInt(request.getParameter("id"));
		User user = this.userService.getUserById(userId);
		List<User> idList = new ArrayList<User>();
		idList.add(user);
//		System.out.println("是否有数据========="+idList.size());
		model.addAttribute("userList", idList);
		return "showUser";
	}

	/**
	 * 根据用户名查询用户
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/findUserByName")
	public String findUserByName(HttpServletRequest request, Model model) {
		String userName = request.getParameter("name");
		List<User> nameList = userService.findUserByName(userName);
//		System.out.println("nameList.size() = " + nameList.size());
		model.addAttribute("userList", nameList);
		return "showUser";
	}
	
	/**
	 * log4j日志事物处理测试方法
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/logTest")
	//@ResponseBody //将返回值变成字符串页面内容，不代表JSP文件名
	@Transactional
	public String logTest(HttpServletRequest request, Model model){
		User user = new User();
		user.setUser_name("logTest1");
		user.setPassword("123");
		user.setAge(50);
		try {
			userService.insertUser(user);
		} catch (Exception e) {
			// TODO: handle exception
			throw new RuntimeException();
		}
		return userList(request, model);
	}
	
//	/**
//	 * log4j日志事物处理测试方法
//	 * @return
//	 */
//	@RequestMapping("/logTest2")
//	@ResponseBody
//	@Transactional
//	public String logTest2(){
//		if(true){
//			throw new RuntimeException();
//		}
//		return "1";
//	}

	/**
	 * 框架搭建流程测试方法
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/showUser")
	public String toIndex(HttpServletRequest request, Model model) {
		int userId = Integer.parseInt(request.getParameter("id"));
		User user = this.userService.getUserById(userId);
		model.addAttribute("user", user);
//		System.out.println("姓名:" + user.getUser_name().toString());
		return "showUser";
	}
	
	/** 
	 * 初始化 “用户列表”JSP页面,具有分页功能 
	 *  
	 * @param request 
	 * @param model 
	 * @return 
	 */  
	@RequestMapping(value = "/userListPage", method = RequestMethod.GET)
	public String showProductsByPage(HttpServletRequest request, Model model) {  
	    String pageNow = request.getParameter("pageNow");  
//	    System.out.println("pageNow="+pageNow);
	    Page page = null;  
	  
	    List<User> userList = new ArrayList<User>();  
	  
	    int totalCount = (int) userService.getProductsCount();  
	  
	    if (pageNow != null && pageNow.length() != 0) {  
	        page = new Page(totalCount, Integer.parseInt(pageNow));  
	        userList = userService.showProductsByPage(page.getStartPos(), page.getPageSize());  
	    } else {  
	        page = new Page(totalCount, 1);  
	        userList = userService.showProductsByPage(page.getStartPos(), page.getPageSize());  
	    }  
	  
	    model.addAttribute("userList", userList);  
	    model.addAttribute("page", page);
	    return "showUser";
	}
	
	/**
	 * 用户列表查询(Easy-UI DataGird数据源)
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/userListEasyUi")
	@ResponseBody
	public Map<String, Object> listConfig(HttpServletRequest request){
//		List<User> list = userService.userList();
		String pageSize1 = request.getParameter("rows");
		String pageNow1 = request.getParameter("page");
		System.out.println("pageSize1=" + pageSize1 + "-----pageNow1=" + pageNow1);
		if(pageSize1 == null || pageNow1 == null){
			List<User> userList = userService.userList();
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("rows", userList);
			result.put("total", userList.size());
			return result;
		}else{
			int pageSize = Integer.parseInt(request.getParameter("rows"));
			int pageNow = Integer.parseInt(request.getParameter("page"));
			int totalCount = (int) userService.getProductsCount(); 
//			Page page = new Page(pageSize, pageNow);
			int startPos = (pageNow - 1) * pageSize;
			List<User> userList = userService.showProductsByPage(startPos, pageSize); 
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("rows", userList);
			result.put("total", totalCount);
			return result;
		}
	}
//	public String userListEasyUi(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
//		List<User> userList = userService.userList();
//		JSONArray jsonArray = JSONArray.fromObject(userList);
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("rows", jsonArray.toString());
//		result.put("total", userList.size());
//		ResponseUtil.write(response, result);
//		return null;
//	}
	
	/**
	 * 退出登录,销毁Session
	 * @param request
	 * @return
	 */
	@RequestMapping("/signOut")
	public String signOut(HttpServletRequest request){
		HttpSession session=request.getSession();
		session.invalidate();
		return "login";
		
	}
}
