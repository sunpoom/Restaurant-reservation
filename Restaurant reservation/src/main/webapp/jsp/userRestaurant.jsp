<%@page import="com.naver.www.common.dto.ReviewDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.naver.www.common.dto.RestaurantANDMenuDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* #wrap {
	display: flex;
	justify-content: left;
}

#wrap div {
	padding: 0 50px;
} */
#reviewArea {
	display: none;
}

#restaurantIntroArea {
	display: none;
}
</style>
</head>
<body>
	<div id="wrap">
		<div id="intro">
			<%
			ArrayList<RestaurantANDMenuDTO> list = (ArrayList<RestaurantANDMenuDTO>) request.getAttribute("list");
			RestaurantANDMenuDTO restaurant = list.get(0);
			%>
			매장 이미지: <img src="./img/<%=restaurant.getRestaurantImage_URL()%>">
			<br> 매장 이름 :
			<%=restaurant.getRestaurantName()%><br> 매장 평점 :
			<%=restaurant.getRestaurantAvg()%><br>
		</div>

		<div>
			<a href="./userReservation.do?restaurant_id=${param.restaurant_id }"><button>예약하기</button></a>
		</div>

		<div>
			<span><button id="menubtn">메뉴보기</button></span> <span><button
					id="reviewbtn">리뷰보기</button></span> <span><button
					id="descriptionbtn">설명보기</button></span>
		</div>
		<div id="restaurantIntroArea">
			매장 주소 :
			<%=restaurant.getRestaurantAddress()%><br> 매장 전화번호 :
			<%=restaurant.getRestaurantPhone()%><br> 매장 설명 :
			<%=restaurant.getRestaurantDescription()%><br>
		</div>
		<div id="reviewArea">
			<%
			ArrayList<ReviewDTO> reviewlist = (ArrayList<ReviewDTO>) request.getAttribute("reviewlist");
			String replyCode = "";
			for (int i = 0; i < reviewlist.size(); i++) {
				ReviewDTO vo = reviewlist.get(i);
			%>
			<table border="1">
				<tr>
					<td>고객 아이디</td>
					<td><%=vo.getCustomer_id()%></td>
				</tr>
				<tr>
					<td>별점</td>
					<td><%=vo.getScore()%></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=vo.getReview_date()%></td>
				</tr>
				<tr>
					<td colspan="2"><%=vo.getComment()%></td>
				</tr>
			</table>
			<%
			}
			%>
		</div>
		<!-- ///////////////////////////////////////////////////////////////////////////// -->
		<div id="menuListArea">
			<%
			String type = "";
			String tableCode = "";
			//	ArrayList<RestaurantANDMenuDTO> list = (ArrayList<RestaurantANDMenuDTO>) request.getAttribute("list");
			for (int i = 0; i < list.size(); i++) {
				RestaurantANDMenuDTO vo = list.get(i);
				if (!type.equals(vo.getFoodCategory())) {
					type = vo.getFoodCategory();
					if (!type.equals("")) {
			%>
			</table>
			<%
			}
			%>
			<table border="1">
				<tr>
					<td colspan="4"><%=type%></td>
				</tr>
				<tr>
					<td>사진</td>
					<td>이름</td>
					<td>가격</td>
					<td>설명</td>
				</tr>
				<tr>
					<td>요리사진</td>
					<td><%=vo.getFoodName()%></td>
					<td><%=vo.getFoodPrice()%></td>
					<td><%=vo.getFoodDescription()%></td>
				</tr>
				<%
				} else {
				%>
				<tr>
					<td>요리사진</td>
					<td><%=vo.getFoodName()%></td>
					<td><%=vo.getFoodPrice()%></td>
					<td><%=vo.getFoodDescription()%></td>
				</tr>
				<%
				}
				}
				%>
				</div>
				</div>

				<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
				<script>
					$(document).on("click", "#menubtn", function() {
						$("#menuListArea").css("display", "block");
						$("#reviewArea").css("display", "none");
						$("#restaurantIntroArea").css("display", "none");
					})
					$(document).on("click", "#reviewbtn", function() {
						$("#reviewArea").css("display", "block");
						$("#menuListArea").css("display", "none");
						$("#restaurantIntroArea").css("display", "none");
					})
					$(document).on("click", "#descriptionbtn", function() {
						$("#restaurantIntroArea").css("display", "block");
						$("#menuListArea").css("display", "none");
						$("#reviewArea").css("display", "none");
					})
				</script>
</body>
</html>