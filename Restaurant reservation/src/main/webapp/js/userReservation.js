$(document).on("click", ".addfoodBtn", function () {
			let name = $(this).closest("tr").children("td").eq(1).text()
			let price = $(this).closest("tr").children("td")[2].innerText
		//	console.log(name);
			let basketWrap = `<tr>
                <td>`+ name + `</td><td>` + price + `</td><td><button type='button' class="subCnt" >-</button><span>1</span><button type='button' class="addCnt" >+</button></td><td>` + price + `</td>
				<td><button type='button' class='deletebtn' >취소</button>
				</td>
				<input type="hidden" name="name">
				<input type="hidden" name="price" value=`+price+` >				
				<input type="hidden" name="cnt" value="1" >				
                </tr>`
			$("#basket").append(basketWrap)
              console.log($("#basket").children("tr:last-child").children().siblings("input").eq(0).val(name))
			totalprice()
		})

		let currnetCnt = -1;
		$(document).on("click", ".subCnt", function () {
			currnetCnt = $(this).siblings("span").text();
			let currnetprice = $(this).parent().siblings().eq(1).text()
			if (currnetCnt <= 1) {
				currnetCnt = 1;
			}
			else {
				currnetCnt--;
			}
			$(this).siblings("span").text(currnetCnt)
			$(this).parent().siblings().eq(2).text(currnetprice * currnetCnt)
			totalprice()
			$(this).parent().siblings("input").eq(2).val(currnetCnt)
		})

		
		$(document).on("click", ".addCnt", function () {
			currnetCnt = $(this).siblings("span").text()
			currnetCnt++;
			$(this).siblings("span").text(currnetCnt)
			let currnetprice = $(this).parent().siblings().eq(1).text()
			$(this).parent().siblings().eq(2).text(currnetprice * currnetCnt)
			totalprice()
			$(this).parent().siblings("input").eq(2).val(currnetCnt)
		})
		
		function totalprice() {
		//	console.log($("#basket").children().children())
			let sum = 0
			for (let i = 0; i < $("#basket").children().length; i++) {
				let price = parseInt($("#basket").children().children().eq((8 * i) + 3).text())
				sum += price
			}
			$("#totalpriceZone").text(sum)
		}
		
		$(document).on("click", '.deletebtn', function () {
			$(this).closest("tr").remove()
			totalprice()
		})
		
		