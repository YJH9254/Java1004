<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 경로 설정하기</title>
</head>
<body>

	<h3># webapp 밑의 자원에 직접 요청보내기</h3>
	
	<ul>
		<li>/프로젝트이름/폴더명/파일명</li>
		<li>프로젝트 이름에 해당하는 부분을 ContextPath라고 부른다</li>
		<li>ContextPath는 기본적으로 프로젝트이름으로 설정되어 있지만 수정도 가능하다</li>
	</ul>
	
	<h3># 서블릿으로 요청 보내기</h3>
	
	<ul>
		<li>해당 서블릿에 @WebServlet()으로 부여된 URL을 통해 요청</li>
		<li>*를 사용해 여러 경로를 하나의 서블릿으로 처리하는 것도 가능하다</li>
	</ul>
	
	<h3># 포워드 경로 설정하기</h3>
	
	<ul>
		<li>다음으로 처리를 맡은 서블릿 또는 .JSP로 이어지는 경로를 제공해야 한다</li>
		<li>webapp밑의 실제 파일 위치 경로를 전달해야한다</li>
	</ul>
	
	<h3># 리다이렉트 경로 설정하기</h3>
	
	<ul>
		<li>클라이언트가 다시 요청을 보내야하는 경로를 제공해야 한다</li>
		<li>ContextPath가 포함된 경로를 사용해야 한다</li>
	</ul>
	<!--  상대경로를 쓰는경우 내가 이공에 접속하는데 사용했던  URL의 상대경로로 요청을 보낸단 -->
	
	<a href="./test1.html">test.html</a>
	<img src="http://192.168.0.66:9000/chap05/path/pen2.jpg" width="200" />

</body>
</html>