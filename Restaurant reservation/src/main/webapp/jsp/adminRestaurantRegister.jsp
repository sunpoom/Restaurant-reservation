<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="../restaurantRegister.do" method="post"
		enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>관리자아이디</td>
				<td>${admin.admin_id }</td>
			</tr>
			<tr>
				<td>식당이름</td>
				<td><input type="text" name="name" required="required"></td>
			</tr>
			<tr>
				<td>식당주소</td>
				<td><input type="text" id="sample4_postcode" placeholder="우편번호"
					name="postcode" readonly> <input type="button"
					onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br />
					<input type="text" id="sample4_roadAddress" placeholder="도로명주소"
					name="roadAddress"> <input type="text"
					id="sample4_jibunAddress" placeholder="지번주소" name="jibunAddress">
					<span id="guide" style="color: #999; display: none"></span> <input
					type="text" id="sample4_detailAddress" placeholder="상세주소"
					name="detailAddress"> <input type="text"
					id="sample4_extraAddress" placeholder="참고항목" name="extraAddress">
				</td>
			</tr>
			<tr>
				<td>매장전화번호</td>
				<td><input type="text" name="phone_number"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="email" name="email"></td>
			</tr>
			<tr>
				<td>음식종류</td>
				<td><select name="cuisine_type">
						<option value="koreanFood">한식</option>
						<option value="chineseFood">중식</option>
						<option value="japaneseFood">일식</option>
						<option value="westernFood">양식</option>
						<option value="alcoholFood">술집</option>
						<option value="restaurantFood">레스토랑</option>
				</select></td>
			</tr>
			<tr>
				<td>식당소개글</td>
				<td><textarea rows="10" cols="40" name="description"
						placeholder="식당소개해주세요"></textarea></td>
			</tr>
			<tr>
				<td>식당사진</td>
				<td><input type="file" name="restaurantImg"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="등록하기"></td>
			</tr>
		</table>
	</form>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	 <script src="../js/memberRegister.js"></script> 

</body>
</html>