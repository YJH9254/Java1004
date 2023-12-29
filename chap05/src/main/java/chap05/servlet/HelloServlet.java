package chap05.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// web.xml에서 @WebServlet없이 매핑할 수 있음
public class HelloServlet extends HttpServlet{
	 @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 resp.getWriter()
		 	.append("<html><h1>Hello~</h1></html>");
		 
		 
	 }
	 
}
