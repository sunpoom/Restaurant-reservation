<%@page import="com.naver.www.common.dto.ReviewDTO"%>
<%@page import="com.naver.www.common.dto.FoodDTO"%>
<%@page import="com.naver.www.common.dto.ReservationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	position: relative;
	top: 150px;
	margin: auto;
	padding: 20px;
	width: 50%;
	background-color: #fff;
	overflow-y: auto; /* 수직 스크롤바를 필요할 때만 표시 */
	max-height: 70vh; /* 모달 창의 최대 높이를 지정 (옵션) */
}

.close {
	position: absolute;
	top: 0;
	right: 0;
	cursor: pointer;
}

#myReplyArea {
	display: flex;
	justify-content: center;
}
</style>
</head>
<body>
	<a href="./jsp/userRestaurantList.jsp">뒤로가기</a>
	<%
	ArrayList<ReservationDTO> list = (ArrayList<ReservationDTO>) request.getAttribute("myreservationList");
	for (int i = 0; i < list.size(); i++) {
		ReservationDTO dto = list.get(i);
	%>
	<table border="1">
		<tr>
			<td colspan="5">식당정보</td>
		</tr>
		<tr>
			<td colspan="2">식당이름</td>
			<td colspan="3"><%=dto.getRestaurantName()%></td>
		</tr>
		<tr>
			<td colspan="2">식당설명</td>
			<td colspan="3"><%=dto.getRestaurantDescription()%></td>
		</tr>
		<tr>
			<td colspan="5">예약자 정보 확인</td>
		</tr>
		<tr>
			<td colspan="2">예약자 이름</td>
			<td colspan="3"><%=dto.getCustomer_id()%></td>
		</tr>
		<tr>
			<td colspan="2">예약자 이메일</td>
			<td colspan="3"><%=dto.getCustomer_email()%></td>
		</tr>
		<tr>
			<td colspan="2">예약자 연락처</td>
			<td colspan="3"><%=dto.getCustomerphone()%></td>
		</tr>
		<tr>
			<td colspan="5">식당 예약정보 확인</td>
		</tr>
		<tr>
			<td colspan="2">예약 날짜</td>
			<td colspan="3"><%=dto.getReservation_date()%></td>
		</tr>
		<tr>
			<td colspan="2">예약 시간</td>
			<td colspan="3"><%=dto.getReservation_time()%></td>
		</tr>
		<tr>
			<td colspan="2">요청사항</td>
			<td colspan="3"><%=dto.getSpecial_requests()%></td>
		</tr>

		<%
		ArrayList<FoodDTO> foods = dto.getFoods();
		boolean replybtn = false;
		%>
		<tr>
			<td rowspan="<%=foods.size() + 1%>">예약메뉴</td>
			<td>이름</td>
			<td>수량</td>
			<td>단가</td>
			<td>가격</td>
		</tr>
		<%
		int sum = 0;
		for (int j = 0; j < foods.size(); j++) {
			FoodDTO food = foods.get(j);
		%>
		<tr style="text-align: right;">
			<td><%=food.getName()%></td>
			<td><%=food.getCnt()%>개</td>
			<td><%=food.getPrice()%>원</td>
			<td><%=food.getPrice() * food.getCnt()%>원</td>
		</tr>
		<%
		sum += food.getPrice() * food.getCnt();
		}
		%>
		<tr>
			<td colspan="4" style="text-align: right;">총가격</td>
			<td colspan="1"><%=sum%>원</td>
		</tr>
		<tr style="text-align: right;">
			<td colspan="4">예약상태</td>
			<%
			String stauts = dto.getReservation_status();
			if (stauts.equals("cancelled")) {
			%>
			<td colspan="3" style="color: red">취소</td>
			<%
			} else if (stauts.equals("waiting")) {
			%>
			<td colspan="3">대기중</td>
			<%
			} else {
			replybtn = true;
			%>
			<td colspan="3" style="color: blue">확인</td>
			<%
			}
			%>
		</tr>
		<%
		if (replybtn) {
		%>
		<tr>
			<td colspan="5" style="text-align: right;">
			<button value="<%=dto.getRestaurant_id()%>" class="replybtn">리뷰달기</button></td>
		</tr>
		<%
		}
		%>
	</table>
	<br>
	<%
	}
	%>

	<div id="myModal" class="modal">
		<div class="modal-content">
			<!-- <span class="close">&times;</span> -->
			<div id="replyArea">
				<div id="myReplyArea">
					
					<form action="./myreplyOk.do" method="post">
						<table id="myreplyTable" border="1">
							<tr>
								<td>평점</td>
								<td style="text-align: center;">1<input type="radio"
									name="score" value="1"> 2<input type="radio"
									name="score" value="2"> 3<input type="radio"
									name="score" value="3"> 4<input type="radio"
									name="score" value="4"> 5<input type="radio"
									name="score" value="5">
								</td>
							</tr>
							<tr>
								<td>리뷰</td>
								<td><textarea rows="20" cols="60" placeholder="리뷰를 남겨주세요"
										name="comment"></textarea></td>
							</tr>
							<tr style="text-align: right;">
								<td colspan="2">
									<button>리뷰하기</button>
								</td>
							</tr>
						</table>
					</form>
				
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).on("click",".replybtn",function() {
							document.getElementById('myModal').style.display = 'block';
							let createInput = `<input type="hidden" name="restaurant_id" value=`
									+ $(this).val() + `>`
							$("#myreplyTable").append(createInput)
						})
						
		function closeModal() {
			document.getElementById('myModal').style.display = 'none';
			console.log($("#myreplyTable").children("input[type=hidden]")
					.remove())
		}
		// 모달 창 바깥 부분 클릭 시 닫기
		window.onclick = function(event) {
			var modal = document.getElementById('myModal');
			if (event.target === modal) {
				closeModal();
			}
		}
	</script>
</body>
</html>