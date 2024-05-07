<%@page import="com.naver.www.common.dto.FoodDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<style>
table {
	width: 870px;
	text-align: center;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>




	<button type="button" id="typeBtn">카테고리추가</button>

	<form id="tables" action="./adminMenuRegister.do" method="post">
		<%-- <%
		List<FoodDTO> list = (List<FoodDTO>) request.getAttribute("menuList");
		int size = list.size();
		String category = "";
		for (int i = 0; i < size; i++) {
			%>
			<table class="type" border="1" >
			
			</table>
			<%
			FoodDTO food = list.get(i);
			if (category.equals(food.getCategory())) {

			}
		}
		%> --%>
		<input type="hidden" name="restaurant_id" value="${param.restaurant_id }">
		<input type="submit" value="등록하기">
	</form>

	<script>
		let typeCnt = 0;

		$("#typeBtn").click(function () {
			let createTable = `
			<table class="type" border="1">
		<input type="hidden" class="typeValue" value="`+ typeCnt + `">
		<thead>
			<tr>
				<td colspan="4">카테고리 이름 : <input type="text" name="type[`+ typeCnt + `].category" required> <button type="button" class="deleteType" style=" float: right; " >전체삭제</button></td>
			</tr>
			<tr>
				<td>사진</td>
				<td>이름</td>
				<td>가격</td>
				<td>설명</td>
			</tr>
		</thead>
		<tbody class="addMenu">
		</tbody>
		<tr>
			<td colspan="4" style="text-align: right;">
				<button type="button" class="addRowBtn">추가</button>
			</td>
		</tr>
	</table>`;
			$("#tables").append(createTable);
			typeCnt++
		})


		$(document).on("click", ".addRowBtn", function () {
			let value = $(this).parent('td').parent('tr').parent('tbody').siblings(".typeValue").val();
			let newRow1 = "<tr class=" + value + " >"
			newRow1 += "<td><input type='file' name='type[" + value + "].foodImg'></td>"
			newRow1 += "<td><input type='text' name='type[" + value + "].name'></td>"
			newRow1 += "<td><input type='text' name='type[" + value + "].price'></td>"
			newRow1 += "<td  colspan='2' ><input type='text' name='type[" + value + "].description'> <button type='button' class='deleteRowBtn'>삭제</button></td></tr>"
			$(this).parent('td').parent('tr').parent('tbody').prev('.addMenu').append(newRow1)
		})

		$(document).on("click", ".deleteRowBtn", function () {
			$(this).closest("tr").remove();
		});
		$(document).on("click", ".deleteType", function () {
            let value=$(this).closest("table").children("input.typeValue").val()
            let hiddenArr=`
            <input type="hidden" name="type[`+ value + `].category" value="NULL" >
            <input type="hidden" name="type[`+ value + `].foodImg" value="NULL" >
            <input type="hidden" name="type[`+ value + `].name" value="NULL" >
            <input type="hidden" name="type[`+ value + `].price" value="-1" >
            <input type="hidden" name="type[`+ value + `].description" value="NULL" >
            `
            $(this).closest("table").parent().append(hiddenArr)
			$(this).closest("table").remove()
		})
	</script>
</body>

</html>

