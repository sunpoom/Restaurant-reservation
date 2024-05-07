
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	고객로그인페이지 입니다.
	<form action="../userLogin.do" method="post" >
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="customer_id"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="로그인"></td>
			</tr>
		</table>
	</form>
	<a href="userRegister.jsp">회원가입</a>
	<a href="searchId.do">아이디 찾기</a>
	<a href="searchPassword.do">비밀번호 찾기</a>
</body>
</html>