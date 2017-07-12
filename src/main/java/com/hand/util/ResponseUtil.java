package com.hand.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @author wangdong
 * @since 2017/07/11
 *
 */
public class ResponseUtil {
	
	/**
	 * 
	 * @param response
	 * @param object
	 * @throws Exception
	 */
	public static void write(HttpServletResponse response,Object object)throws Exception{
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.println(object);
        out.flush();
        out.close();
    }
}
