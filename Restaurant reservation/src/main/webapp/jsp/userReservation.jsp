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
#wrap {
	width: 800px;
	height: 300px;
	/* 	border: 1px solid; */
	position: relative;
}

#btnArea {
	position: absolute;
	right: 0px;
	bottom: 0px;
}

#selectMenu div {
	padding: 0 50px;
}

#selectMenu {
	display: flex;
	justify-content: left;
	display: none;
}

#selectMenu div {
	float: left;
	padding: 0px;
	margin: 20px;
}

#basketArea table {
	width: 300px;
}

#revserBtn {
	display: none;
}

#detailRequest {
	display: none;
}

#displayCalender {
	display: flex;
	justify-content: center;
	width: 400px;
	height: 300px;
}

#displayCalender table {
	text-align: center;
	width: 80%;
	cursor: pointer;
}

#selectDate div {
	float: left;
}

#seleteDay {
	width: 200px;
	height: 100px;
	font-size: 20px;
	text-align: center;
}

#selectTime {
	font-size: 20px;
	text-align: center;
}

#menuList table {
	margin-bottom: 20px;
}

#menuList table:last-child {
	margin-bottom: 0px;
}
</style>
</head>
<body>


	<c:forEach items="${list }" var="vo" begin="0" end="0">
매장 이미지: <img src="../img/${vo.restaurantImage_URL }">
		<br>
		<c:set var="restaurantName" value="${vo.restaurantName }"></c:set>
		<c:set var="restaurantDescription"
			value="${vo.restaurantDescription }"></c:set>
매장 이름 : ${vo.restaurantName }<br>
매장 평점 : ${vo.restaurantAvg }<br>
매장 주소 : ${vo.restaurantAddress }<br>
매장 전화번호 : ${vo.restaurantPhone }<br>
매장 설명 : ${vo.restaurantDescription }<br>
	</c:forEach>
	<br>
	<div id="wrap">
		<form action="./userBasketResvervation.do" method="post">
			<div id="btnArea">
				<button type="button" id="nextBtn">다음</button>
				<input type="hidden" name="restaurantName"
					value="${restaurantName }"> <input type="hidden"
					name="restaurantDescription" value="${restaurantDescription }">
				<input type="hidden" name="restaurant_id"
					value="${param.restaurant_id }"> <input id="revserBtn"
					type="submit" value="예약하기">
			</div>
			<div id="selectDate">
				<div id="displayCalender"></div>
				<div id="seleteDay">날짜를 클릭하세요</div>
				<input name="reservation_date" value="" type="hidden">
				<div id="selectTime">
					<select name="hour">
						<c:forEach var="h" begin="10" end="20">
							<option value="${h }">${h }</option>
						</c:forEach>
					</select>시 <select name="minute">
						<c:forEach var="m" begin="0" end="50" step="10">
							<option value="${m }">${m }</option>
						</c:forEach>
					</select>분
				</div>
			</div>
			<div id="detailRequest">
				<div>
					인원수 : <input type="text" name="number_of_guests">명 <br>
					요청사항<br>
					<textarea style="font-size: 15px;" rows="20" cols="70"
						placeholder="사장님께 요청사항을 보내세요" name="special_requests"></textarea>
				</div>
			</div>
			<div id="selectMenu">
				<div id="basketArea">
					<table border="1">
						<tr>
							<td colspan="5">장바구니</td>
						</tr>
						<tr>
							<td>음식이름</td>
							<td>단가</td>
							<td>수량</td>
							<td colspan="2">가격</td>
						</tr>
						<tbody id="basket">

						</tbody>
						<tr>
							<td colspan="3" style="text-align: right;">총구매액</td>
							<td id="totalpriceZone">0</td>
						</tr>
					</table>
				</div>
				<%
				String type = "";
				String tableCode = "";
				ArrayList<RestaurantANDMenuDTO> list = (ArrayList<RestaurantANDMenuDTO>) request.getAttribute("list");
				for (int i = 0; i < list.size(); i++) {
					RestaurantANDMenuDTO vo = list.get(i);
					if (!type.equals(vo.getFoodCategory())) {
						type = vo.getFoodCategory();
						tableCode += "<table border='1' ><tr><td colspan='4'>" + type + "</td></tr>";
						tableCode += "<tr><td>사진</td><td>이름</td><td>가격</td><td>설명</td>";
						tableCode += "<tr><td>요리사진</td><td>" + vo.getFoodName() + "</td><td>" + vo.getFoodPrice()
						+ "</td><td colspan='2' >" + vo.getFoodDescription()
						+ "<button type='button' class='addfoodBtn'>추가</button></td></tr>";
					} else {
						tableCode += "<tr><td>요리사진</td><td>" + vo.getFoodName() + "</td><td>" + vo.getFoodPrice()
						+ "</td><td colspan='2' >" + vo.getFoodDescription()
						+ "<button type='button' class='addfoodBtn'>추가</button></td></tr>";
					}
				}
				out.print("<div id='menuList' >" + tableCode + "</div>");
				%>
			</div>
		</form>
	</div>
	<script>
		let flagarr = [ true, false, false ]
		$(document).on("click", "#nextBtn", function() {
			let flag = -1;
			for (let i = 0; i < flagarr.length; i++) {
				if (flagarr[i]) {
					flag = i;
				}
			}
			if (flag == 0) {
				$("#selectDate").css("display", "none")
				$("#selectMenu").css("display", "block")
			} else if (flag == 1) {
				$("#selectMenu").css("display", "none")
				$("#detailRequest").css("display", "block")
				$("#revserBtn").css("display", "block")
				$("#nextBtn").css("display", "none")
			}
			flagarr[flag] = false;
			flagarr[flag + 1] = true;
		})
	</script>
	<script src="./js/userReservation.js"></script>
	<script src="./js/calender.js"></script>

	<script>
		$(document).on(
				"click",
				".day",
				function() {
					let dayArr = $(this).parent().parent().prev().text().trim()
							.split(" ")
					let year = dayArr[1].split("년")[0]
					let month = dayArr[2].split("월")[0]
					let day = $(this).text()
					let year_month_day = year + '-' + month + '-' + day
					let week = new Date(year_month_day).getDay()
					$("#seleteDay").text(year_month_day)
					$("#seleteDay").siblings("input").val(year_month_day)
					//		console.log()
					/*     $("#selectWeek").text(arrDay[week])
					    if (idx == -1) {
					        $("#today").css("background-color", "rgb(255, 230, 153)")
					        $(this).css("background-color", "white")
					    }
					    else {
					        $(".day").eq(idx).css("background-color", "rgb(255, 230, 153)")
					        $(this).css("background-color", "white")
					    }
					    idx = $(".day").index(this) */
				})
	</script>
</body>
</html>