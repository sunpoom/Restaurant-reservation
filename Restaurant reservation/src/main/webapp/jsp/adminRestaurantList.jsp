<%@page import="com.naver.www.restaurant.dto.RestaurantDTO"%>
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

#reservationList table {
	text-align: center;
}

button {
	cursor: pointer;
}
</style>
</head>
<body>
	<h1>${admin.name}님환영합니다.</h1>
	<a href="./adminLogout.do">로그아웃</a>
	<hr>

	<div id="myModal" class="modal">
		<div class="modal-content">
			<!-- <span class="close">&times;</span> -->

			<div id="reservationList"></div>
		</div>
	</div>

	<!-- ----------------------------------------- -->

	<div id="reviewModal" class="modal">
		<div class="modal-content">
			<!-- <span class="close">&times;</span> -->
			<div id="reviewList"></div>
		</div>
	</div>


	<table border="1">
		<tr>
			<td>번호</td>
			<td>매장이름</td>
			<td>주소</td>
			<td>매장전화번호</td>
			<td>식당종류</td>
			<td>평점</td>
			<td>수정하기</td>
			<td>예약현황</td>
		</tr>
		<c:forEach items="${getRestaurantList }" var="list">
			<tr>
				<td>${list.restaurant_id }</td>
				<td>${list.name }</td>
				<td>${list.address }</td>
				<td>${list.phone_number }</td>
				<td>${list.cuisine_type }</td>
				<td><button class="reviewModelopen"
						style="border: none; background-color: white;"
						value="${list.restaurant_id }">${list.average_rating }</button></td>
				<td><a
					href="./adminMenu.do?restaurant_id=${list.restaurant_id }"><button>메뉴추가및수정</button></a>
					<a href="./adminRestaurant.do?restaurant_id=${list.restaurant_id }"><button>매장수정</button></a>
				</td>
				<td><button value="${list.restaurant_id }" class="openModel">예약확인</button></td>
			</tr>
		</c:forEach>
	</table>
	<a href="./jsp/adminRestaurantRegister.jsp">식당등록</a>
	<script>
	
	////////////리뷰리스트 모달창//////////////////
	$(document).on("click", ".reviewModelopen", function() {
		document.getElementById('reviewModal').style.display = 'block';
		getrestaurantreviewList($(this).val())
	})
	function reviewcloseModal() {
		document.getElementById('reviewModal').style.display = 'none';
		$("#reviewList").children().remove()
	}
	
	function getrestaurantreviewList(val) {
		$.ajax({
			url : './restaurantreviewList.do',
			method : 'GET',
			data : {
				restaurant_id : val
			},
			dataType : 'json',
			success : reviewprocess,
			error : function(xhr, status, error) {
				console.error('데이터를 받아오는 도중 오류가 발생했습니다:', status, error);
			}
		});
	}
	
	function reviewprocess(date) {
	//	console.log(date.result.length)
		let createTable=``
		for(let i=0; i<date.result.length; i++) {
			let result=date.result[i]
			console.log(result)
			createTable+=`
			<table border='1' >
			<tr>
			<td>작성자 아이디</td>
			<td>`+result[2].value+`</td>
			</tr>
			<tr>
			<td>별점</td>
			<td>`+result[3].value+`</td>
			</tr>
			<tr>
			<td>작성한 날짜</td>
			<td>`+result[5].value+`</td>
			</tr>
			<tr>
			<td>리뷰내용</td>
			<td>`+result[4].value+`</td>
			</tr>
			`
			console.log(result[6].value)
			if(result[6].value==='null') {
				createTable+=`
				<tr>
				<td>
				사장님의 리뷰
				</td>
				<td>
				<textarea rows="10" cols="50" class="admincomment" ></textarea>
				</td>
				</tr>
				<tr style='text-align: right;' >
					<td colspan='2' >
					<button  value=`+result[0].value+` class='admincommentbtn' >댓글달기</button>
					</td>
				</tr>
				`
			}
			else {
				createTable+=`
					<tr>
					<td>
					사장님의 리뷰
					</td>
					<td>
					<textarea rows="10" cols="50">`+result[6].value+`</textarea>
					</td>
					</tr>
					<tr style='text-align: right;' >
					<td colspan='2' >
					<button  value=`+result[0].value+` class='admincommentbtn' >수정하기</button>
					</td>
				</tr>
					`
			}
			createTable+=`</table><br>`
		}
		$("#reviewList").append(createTable)
	}
	
	$(document).on("click",".admincommentbtn",function(){
	//	$(this).parent()
	let review_id=$(this).val()
	let text=$(this).parent().parent().prev().children().eq(1).children().val()
		console.log($(this).val())
		console.log($(this).parent().parent().prev().children().eq(1).children().val())
		 $.ajax({
			url:"./updatereview_comment.do",
			type: "get",
			data:{
				review_id:review_id,
				reply_comment:text,
				},
			dataType:"text",
			success:function(){
				console.log("성공함")
			},
			error:function(xhr, status, error) {
				console.error('데이터를 받아오는 도중 오류가 발생했습니다:', status, error);
			}
		}); 
	})
	
	//////////////////////예약리스트 모달창 ////////////////////
		$(document).on("click", ".openModel", function() {
			document.getElementById('myModal').style.display = 'block';
			getRestaurantListFnt($(this).val())
		})
		function closeModal() {
			document.getElementById('myModal').style.display = 'none';
			$("#reservationList").children().remove()
		}
		// 모달 창 바깥 부분 클릭 시 닫기
	  /* 	window.onclick = function(event) {
			console.log(event.target)
			var modal = document.getElementById('myModal');
			if (event.target === modal) {
				closeModal();
			}
		} */  
		
		// 모달 창 바깥 부분 클릭 시 닫기
		   window.onclick = function(event) {
			var reviewmodal = document.getElementById('reviewModal');
			var reservationmodal = document.getElementById('myModal');
			if (event.target === reviewmodal) {
				reviewcloseModal();
			}
			else if (event.target === reservationmodal) {
				closeModal()
			}
		}  
		
		//////////////////////////////////////////////////
		function getRestaurantListFnt(val) {
			$.ajax({
				url : './restaurantReservationList.do',
				method : 'GET',
				data : {
					restaurant_id : val
				},
				dataType : 'json',
				success : process,
				error : function(xhr, status, error) {
					console.error('데이터를 받아오는 도중 오류가 발생했습니다:', status, error);
				}
			});
		}
		function process(data) {
			let createTable=``;
			for(let i=0; i<data.reservation.length; i++) {
				let foodArrsize=(data.reservation[i][1].reserFood.length/2)+1
				createTable+=`
					<table border="1">
					<tr>
						<td colspan="3">예약자 정보 확인</td>
					</tr>
					<tr>
						<td>예약자 이름</td>
						<td colspan="2">`+data.reservation[i][0].reserNum[1].user+`</td>
					</tr>
					<tr>
						<td>예약자 이메일</td>
						<td colspan="2">`+data.reservation[i][0].reserNum[2].email+`</td>
					</tr>
					<tr>
						<td colspan="3">식당 예약 정보 확인</td>
					</tr>
					<tr>
						<td>예약 날짜</td>
						<td colspan="2">`+data.reservation[i][0].reserNum[3].date+`</td>
					</tr>
					<tr>
						<td>예약시간</td>
						<td colspan="2">`+data.reservation[i][0].reserNum[4].time+`</td>
					</tr>
					<tr>
						<td>예약 인원</td>
						<td colspan="2">`+data.reservation[i][0].reserNum[5].person+`</td>
					</tr>
					<tr>
						<td>요청사항</td>
						<td colspan="2">`+data.reservation[i][0].reserNum[6].request+`</td>
					</tr>
					
					<tr>
						<td rowspan=`+foodArrsize+`>예약 메뉴</td>
						<td>이름</td>
						<td>수량</td>
					</tr>`
				for(let k=0; k<data.reservation[i][1].reserFood.length; k=k+2) {
					createTable+=`
					<tr>
					<td>`+data.reservation[i][1].reserFood[k].foodName+`</td>
					<td>`+data.reservation[i][1].reserFood[k+1].foodcnt+`개</td>
					</tr>
					
					`
				}
				createTable+=`<tr style="text-align: right;" >
					<td colspan="3">`
				let status=data.reservation[i][0].reserNum[7].status
				if(status=='confirmed') {
					createTable+=`예약확인`
				}
				else if(status=='cancelled') {
					createTable+=`예약취소`
				}
				else {					
					createTable+=`<button type="button" class="reservationOkBtn" value=`+data.reservation[i][0].reserNum[0].reservationNum+`>예약확인</button>
							  <button type="button" class="reservationNoBtn" value=`+data.reservation[i][0].reserNum[0].reservationNum+`>예약취소</button>`
				}
				
				createTable+=`</td>
					</tr>
				</table>
				`
			}
			$("#reservationList").append(createTable)
		}
	 	
		$(document).on("click",".reservationOkBtn",function(){
			updateStaus($(this),'confirmed')
		})
		$(document).on("click",".reservationNoBtn",function(){
			updateStaus($(this),'cancelled')
		})
		
		function updateStaus(me,check){
		$.ajax({
			url:"./updateStatus.do",
			type: "get",
			data:{
				reservation_id:me.val(),
				checkvalue:check,
				},
			dataType:"text",
			success:function(){
				console.log("성공함")
				if(check=='confirmed') {
					me.parent().text("예약확인")
				}
				else {
					me.parent().text("예약취소")
				}
			},
			error:function(xhr, status, error) {
				console.error('데이터를 받아오는 도중 오류가 발생했습니다:', status, error);
			}
		});
	}
	</script>
</body>
</html>