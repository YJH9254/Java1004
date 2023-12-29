package chap06.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import chap06.model.PizzaOrder;

public class ApplicationServlet extends HttpServlet {

/*
 	# Front Controller Design Pattern
 	
 	- 모든 요청을 하나의 서블릿에서 받고 URI에 따라 알맞은 페이지로 포워딩
 	- 요청 -> URI 식별 -> 처리 -> 포워딩 -> 뷰 생성 순서로 모든 요청을 처리할 수 있다
*/
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		ServletContext application = req.getServletContext();
		HttpSession session = req.getSession();
		
		// 1. 요청을 받으면 URI를 통해 알맞은 처리로 안내한다
		String cmd = req.getRequestURI()
				.substring(req.getContextPath().length());
		
		// 2. 원하는 코드로 처리한 후 뷰 페이지에서 필요한 데이터는 어트리뷰트에 실어 보낸다..
		if (cmd.equals("/hello")) {
			String userName = req.getParameter("userName");
			
			// DB에 접근해서 자료를 들고온 후 어트리뷰트에 실어 보낸다..
			Set<String> resultSet = new HashSet<>(); 
			
			resultSet.add("Smith A");
			resultSet.add("Smith B");
			resultSet.add("Smith C");
			
			req.setAttribute("result", resultSet);
			
			// 포워딩을 통해서는 WEB-INF 폴더에 접근할 수 있다
			req.getRequestDispatcher("/views/hello.jsp").forward(req, resp);
		} else if (cmd.equals("/pizza/form")) {
			req.getRequestDispatcher("/WEB-INF/views/pizza/form.jsp").forward(req, resp);
		} else if (cmd.equals("/pizza/cart/add")) {
			String size = req.getParameter("size2");
			String qtyStr = req.getParameter("qty2");
			
			// 파라미터 값이 안전한지 체크
			if (size == null || qtyStr == null || size.equals("") || qtyStr.equals("")) {
				throw new ServletException("파라미터 값이 이상함");
			}
			
			int qty = Integer.parseInt(qtyStr);
			
			System.out.println(size);
			System.out.println(qty);
			
			Object c = session.getAttribute("cart");
			
			if (c == null) {
				// 새로운 장바구니 리스트를 추가
				List<PizzaOrder> newCart = new ArrayList<>();
				newCart.add(new PizzaOrder(size, qty));
				session.setAttribute("cart", newCart);
			} else {
				// 있던 카트에 방금 받은 파라미터를 추가
				List<PizzaOrder> cart = (List) c; 
				cart.add(new PizzaOrder(size, qty));
			}
			
			resp.sendRedirect(req.getContextPath() + "/pizza/form");
		}
	}
	
}

