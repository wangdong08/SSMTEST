package com.hand.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hand.model.User;
/** 
 * 后台权限校验的拦截器 
 * 对没有登录后台的用户是不能够访问的 
 * @author wangdong
 * 
 */  
  
public class LoginFilter implements Filter {
	
	private String excludedPages;

    private String[] excludedPageArray;
    
    public FilterConfig fConfig;

    /**
     * @see Filter#destroy()
     */
    public void destroy() {
    	this.fConfig = null;
        return;
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
    	
    	HttpSession session = ((HttpServletRequest) request).getSession();
    	HttpServletRequest req = (HttpServletRequest) request;
    	String url = req.getRequestURI();
    	String contextPath = req.getContextPath();
    	System.out.println("url=" + url + "-------contextPath=" + contextPath);
    	
        boolean isExcludedPage = false;
        for (String page : excludedPageArray) {
            if (((HttpServletRequest) request).getServletPath().equals(page)) {
                isExcludedPage = true;
                break;
            }
        }
        if (isExcludedPage) {
            chain.doFilter(request, response);
//            session.setAttribute("User", "success");
        } else if(url.contains(".css") || url.contains(".js") || url.contains("/authImage") || url.contains("/userLogin") || url.contains("/signOut")){
	    	//如果发现是css或者js文件，直接放行
        	chain.doFilter(request, response);
	    } else {//
	        String str = (String) session.getAttribute("userName");
	        System.out.println("啦啦啦。。。"+ str);
	        if (session == null || session.getAttribute("userName") == null) {
	            ((HttpServletResponse) response).sendRedirect("index");
	        } else {
	            chain.doFilter(request, response);
	        }
        }
    }

    public void init(FilterConfig fConfig) throws ServletException {
        excludedPages = fConfig.getInitParameter("excludedPages");
        if (null != excludedPages && excludedPages.length() > 0) {
            excludedPageArray = excludedPages.split(",");
        }
        return;
    }
      
//    public FilterConfig config;    
//     
//    public void destroy() {    
////        this.config = null;    
////        System.out.println("end do the logging filter!");  
//    }
//     
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//    	// 获得在下面代码中要用的request,response,session对象
//		HttpServletRequest servletRequest = (HttpServletRequest) request;
//		HttpServletResponse servletResponse = (HttpServletResponse) response;
//		HttpSession session = servletRequest.getSession();
//
//		// 从session里取用户
//		User user = (User) session.getAttribute("user");
//		System.out.println("wwwwwww");
//		// 判断如果没有取到用户信息,说明这个请求是没有登录就在请求 就跳转到登陆页面
//		if (user == null) {
//			// 跳转到登陆页面
////			servletResponse.sendRedirect("user/index");    
//		} else {
//			// 已经登陆,继续此次请求
//			chain.doFilter(request, response);
//		}
//    }    
//     
//    public void init(FilterConfig config) throws ServletException {    
////        System.out.println("begin do the log filter!");    
////        this.config = config;    
//    }

 }
