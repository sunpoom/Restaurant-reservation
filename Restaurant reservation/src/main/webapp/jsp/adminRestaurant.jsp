<%@page import="java.util.StringTokenizer"%>
<%@page import="com.naver.www.restaurant.dto.RestaurantDTO"%>
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
	<%
	RestaurantDTO dto = (RestaurantDTO) request.getAttribute("restaurant");
	%>
	<form action="./restaurantmodify.do" method="post"
		enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>관리자아이디</td>
				<td>${admin.admin_id }</td>
			</tr>
			<tr>
				<td>식당이름</td>
				<td><input type="text" name="name" required="required"
					value="<%=dto.getName()%>"></td>
			</tr>
			<tr>
				<td>식당주소</td>
				<td>
					<%
					StringTokenizer st = new StringTokenizer(dto.getAddress(), "/");
					String[] strarr = new String[5];
					int strCnt = 0;
					while (st.hasMoreElements()) {
						strarr[strCnt++] = st.nextToken();
					}
					%> <input type="text" id="sample4_postcode" placeholder="우편번호"
					name="postcode" value="<%=strarr[0]%>" readonly> <input
					type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
					<br /> <input type="text" id="sample4_roadAddress"
					placeholder="도로명주소" name="roadAddress" value="<%=strarr[1]%>">
					<input type="text" id="sample4_jibunAddress" placeholder="지번주소"
					name="jibunAddress" value="<%=strarr[2]%> "> <span
					id="guide" style="color: #999; display: none"></span> <input
					type="text" id="sample4_detailAddress" placeholder="상세주소"
					name="detailAddress" value="<%=strarr[3]%>"> <input
					type="text" id="sample4_extraAddress" placeholder="참고항목"
					name="extraAddress" value="<%=strarr[4]%>">
				</td>
			</tr>
			<tr>
				<td>매장전화번호</td>
				<td><input type="text" name="phone_number"
					value="<%=dto.getPhone_number()%>"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="email" name="email"
					value="<%=dto.getEmail()%>"></td>
			</tr>
			<tr>
				<td>음식종류</td>
				<td><select name="cuisine_type">
						<%
						if (dto.getCuisine_type().equals("koreanFood")) {
						%>
						<option value="koreanFood" selected>한식</option>
						<option value="chineseFood">중식</option>
						<option value="japaneseFood">일식</option>
						<option value="westernFood">양식</option>
						<option value="alcoholFood">술집</option>
						<option value="restaurantFood">레스토랑</option>
						<%
						} else if (dto.getCuisine_type().equals("chineseFood")) {
						%>
						<option value="koreanFood">한식</option>
						<option value="chineseFood" selected>중식</option>
						<option value="japaneseFood">일식</option>
						<option value="westernFood">양식</option>
						<option value="alcoholFood">술집</option>
						<option value="restaurantFood">레스토랑</option>
						<%
						} else if (dto.getCuisine_type().equals("japaneseFood")) {
						%>
						<option value="koreanFood">한식</option>
						<option value="chineseFood">중식</option>
						<option value="japaneseFood" selected>일식</option>
						<option value="westernFood">양식</option>
						<option value="alcoholFood">술집</option>
						<option value="restaurantFood">레스토랑</option>
						<%
						} else if (dto.getCuisine_type().equals("westernFood")) {
						%>
						<option value="koreanFood">한식</option>
						<option value="chineseFood">중식</option>
						<option value="japaneseFood">일식</option>
						<option value="westernFood" selected>양식</option>
						<option value="alcoholFood">술집</option>
						<option value="restaurantFood">레스토랑</option>
						<%
						} else if (dto.getCuisine_type().equals("alcoholFood")) {
						%>
						<option value="koreanFood">한식</option>
						<option value="chineseFood">중식</option>
						<option value="japaneseFood">일식</option>
						<option value="westernFood">양식</option>
						<option value="alcoholFood" selected>술집</option>
						<option value="restaurantFood">레스토랑</option>
						<%
						} else if (dto.getCuisine_type().equals("restaurantFood")) {
						%>
						<option value="koreanFood">한식</option>
						<option value="chineseFood">중식</option>
						<option value="japaneseFood">일식</option>
						<option value="westernFood">양식</option>
						<option value="alcoholFood">술집</option>
						<option value="restaurantFood" selected>레스토랑</option>
						<%
						}
						%>
				</select></td>
			</tr>
			<tr>
				<td>식당소개글</td>
				<td><textarea rows="10" cols="40" name="description"
						placeholder="식당소개해주세요"><%=dto.getDescription()%></textarea></td>
			</tr>
			<tr>
				<td>식당사진</td>
				<td><input type="file" name="restaurantImg"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="hidden" value="${param.restaurant_id}" name="restaurant_id" >
				<input type="submit" value="수정하기">
				<a href="./deleteRestaurant.do?restaurant_id=${param.restaurant_id} "><button type="button">삭제하기</button></a>
				</td>
			</tr>
		</table>
	</form>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="./js/memberRegister.js"></script>


</body>
</html>