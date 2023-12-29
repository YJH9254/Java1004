<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.List,chap06.model.PizzaOrder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Pizza form</title>
</head>
<body>

	<div>
		<div>
			<span>피자1</span> 
			M 30,000원<input type="radio" name="price1">
			L 35,900원<input type="radio" name="price1"> <br> 
			<input type="number" name="qty1"> <br>
			<button>추가하기</button>
		</div>
		<div>
			<span>피자2</span> 
			M 31,000원<input type="radio" name="size2" form="form2" value="medium"> 
			L 37,900원<input type="radio" name="size2" form="form2" value="large"> <br> 
			<input type="number" name="qty2" form="form2"> <br>
			<button type="submit" form="form2">추가하기</button>
			<form action="<%=request.getContextPath() %>/pizza/cart/add"
				method="POST" id="form2"></form>
		</div>
		<div>
			<span>피자3</span> 
			M 29,000원<input type="radio" name="price3">
			L 34,900원<input type="radio" name="price3"> <br> 
			<input type="number" name="qty3"> <br>
			<button>추가하기</button>
		</div>
		<div>
			<span>피자4</span> 
			M 29,000원<input type="radio" name="price4">
			L 34,900원<input type="radio" name="price4"> <br> 
			<input type="number" name="qty4"> <br>
			<button>추가하기</button>
		</div>
	</div>

	<h4># 현재 장바구니 목록</h4>

	<ul>
	<%
		Object cart = session.getAttribute("cart");

		if (cart == null) {
			out.print("<li>장바구니가 비어있습니다.</li>");
		} else {
			for (PizzaOrder order : (List<PizzaOrder>) cart) {
				out.print(order);
			}
		}
	%>
	</ul>

</body>
</html>