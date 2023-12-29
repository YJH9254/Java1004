package chap05.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ParamServlet extends HttpServlet {
	
	static ServletContext application;
	
	static int abc = 10;
	
	// init() : 이 서블릿이 최초로 실행될 때 호출되는 메서드
	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init가 실행되었습니다...");
		System.out.println("web.xml에서 받아온 초기화 파라미터...");
		System.out.println(config.getInitParameter("dbid"));
		System.out.println(config.getInitParameter("dbpwd"));
		System.out.println(config.getInitParameter("driverName"));
		System.out.println(config.getInitParameter("driverPath"));
		
		application = getServletContext();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext application = req.getServletContext();
		
		System.out.println("doGet()이 실행되었습니다...");
		System.out.println("web.xml에서 받아온 전역 초기화 파라미터..");
		System.out.println(application.getInitParameter("version"));
	}
	@Override
	public void destroy() {
		System.out.println("destroy()가 실행되었습니다...");
	}
}
