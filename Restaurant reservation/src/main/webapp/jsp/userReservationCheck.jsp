<%@page import="com.naver.www.common.dto.ReservationDTO"%>
<%@page import="com.naver.www.common.dto.FoodDTO"%>
<%@page import="java.util.ArrayList"%>
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
	예약 확인 페이지입니다.
	<form action="./reservationOK.do" method="post">
		<table border="1">
			<tr>
				<td colspan="5" style="text-align: center;">식당정보</td>
			</tr>
			<tr>
				<td>식당이름</td>
				<td colspan="4">${reservationCheck.restaurantName }</td>
			</tr>
			<tr>
				<td>식당설명</td>
				<td colspan="4">${reservationCheck.restaurantDescription }</td>
			</tr>
			<tr>
				<td colspan="5" style="text-align: center;">예약자 정보 확인</td>
			</tr>
			<tr>
				<td>예약자 이름</td>
				<td colspan="4">${user.name }</td>
			</tr>
			<tr>
				<td>예약자 이메일</td>
				<td colspan="4">${user.email }</td>
			</tr>
			<tr>
				<td>예약자 연락처</td>
				<td colspan="4">${user.phone_number }</td>
			</tr>
			<tr>
				<td colspan="5" style="text-align: center;">식당 예약 정보 확인</td>
			</tr>
			<tr>
				<td>예약 날짜</td>
				<td colspan="4">${reservationCheck.reservation_date }</td>
			</tr>
			<tr>
				<td>예약 시간</td>
				<td colspan="4">${reservationCheck.reservation_time }</td>
			</tr>
			<tr>
				<td>예약 인원</td>
				<td colspan="4">${reservationCheck.number_of_guests }명</td>
			</tr>
			<tr>
				<td>요청사항</td>
				<td colspan="4">${reservationCheck.special_requests }</td>
			</tr>
			<%
			ArrayList<FoodDTO> list = ((ReservationDTO) request.getAttribute("reservationCheck")).getFoods();
			%>
			<tr>
				<td rowspan="<%=list.size() + 1%>">예약 메뉴</td>
				<td>이름</td>
				<td>수량</td>
				<td>단가</td>
				<td>가격</td>
			</tr>
			<%
			int sum = 0;
			for (int i = 0; i < list.size(); i++) {
				FoodDTO dto = list.get(i);
			%>
			<tr>
				<td><%=dto.getName()%></td>
				<td><%=dto.getCnt()%></td>
				<td><%=dto.getPrice()%></td>
				<td><%=dto.getPrice() * dto.getCnt()%></td>
			</tr>
			<%
			sum += dto.getPrice() * dto.getCnt();
			}
			%>
			<tr>
				<td colspan="4" style="text-align: right;">총가격</td>
				<td colspan="1"><%=sum%></td>
			</tr>
		</table>
		<a href="./reservationOK.do?check=cancle"><button type="button" >취소하기</button></a>
		<input type="submit" value="예약하기" >
	</form>
</body>
</html>