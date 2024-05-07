<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
img {
	width: 65px;
	height: 65px;
}

#wrap {
	width: 1100px;
	height: 500px;
}

#restaurantType {
	display: flex;
	justify-content: center;
}

#restaurantType button {
	font-size: 15px;
	margin: 10px;
}

#restaurantArea {
	display: flex;
	justify-content: center;
}

#restaurantArea table {
	text-align: center;
}

#userInfor {
	width: 100%;
	display: flex;
	justify-content: space-between;
}

#userInfor {
	height: 50px;
}

#userInfor span {
	font-size: 23px;
	margin-top: 10px;
}

#myArea a {
	text-decoration: none;
	cursor: pointer;
	margin: 10px;
}

button {
	cursor: pointer;
}
</style>
</head>
<body>

	<div id="wrap">
		<div id="userInfor">
			<span>${user.name }님 환영합니다.</span> <span id="myArea"> <a
				href="../myreservationList.do">예약확인</a><a href="../userLogout.do">로그아웃</a>
			</span>
		</div>
		<div id="restaurantType">
			<button class="foods" value="koreanFood">한식</button>
			<button class="foods" value="chineseFood">중식</button>
			<button class="foods" value="japaneseFood">일식</button>
			<button class="foods" value="westernFood">양식</button>
			<button class="foods" value="alcoholFood">술집</button>
			<button class="foods" value="restaurantFood">레스토랑</button>
		</div>
		<div id="restaurantArea">
			<table id="restaurantTable" border="1">
			<!-- 	<tr style="text-align: right;">
					<td colspan="7">
					<select class="sortbtn" name="listSort">
							<option  value="name">기본정렬</option>
							<option value="average_rating">별점순</option>
					</select>
					</td>
				</tr> -->
				<tr>
					<td>이미지</td>
					<td>식당이름</td>
					<td>주소</td>
					<td>전화번호</td>
					<td>소개</td>
					<td>평점</td>
					<td>예약하기</td>
				</tr>
				<tbody id="restaurantlist">
				</tbody>
			</table>
		</div>
	</div>
	<script src="../js/jquery-3.6.0.min.js"></script>
	<script>
	
		$(document).on("click",".sortbtn",function(){
			getRestaurantListFnt($(this).val())
		})
	
		function getRestaurantListFnt(sort) {
			
			$.ajax({
				url : "../getRestaurantTypeList.do", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
				type : "get", // HTTP 요청방식 (get/post)
				data : {
					foods : $(this).val(),
		//			sortname:sort
				}, // HTTP 요청과 함께 서버로 보낼 데이터
				dataType : "json", // 서버에서 보내줄 데이터의 타입
				success : searchProcess, // 성공적으로 값을 서버로 보냈을 경우 처리하는 코드
				error : function(xhr, status, error) {
					console.error('데이터를 받아오는 도중 오류가 발생했습니다:', status, error);
				}
			});
		}
		
		function searchProcess(data) {
			
			let table = document.getElementById("restaurantlist")
			table.innerHTML = ""
			let result = data.result;
			for (let i = 0; i < result.length; i++) {
				let row = table.insertRow(0);
				for (let j = 0; j < result[i].length; j++) {
					let cell = row.insertCell(j);
					if (j == 0) {
						let img = document.createElement('img')
						img.src = '../img/' + result[i][j].value
						cell.appendChild(img)
					} else if (j == result[i].length - 1) {
						let btn = document.createElement("button")
						btn.textContent = '매장확인'
						btn.classList.add('your-button-class')
						btn.value = result[i][j].value
						cell.appendChild(btn);
					} else {
						cell.innerHTML = result[i][j].value;
					}
				}
			}
			$('.your-button-class').click(function() {
				var uri = '../userRestaurant.do?restaurant_id=' + $(this).val()
				window.location.href = uri;
			});
		}
		$(".foods").on("click", getRestaurantListFnt)
	</script>

</body>
</html>