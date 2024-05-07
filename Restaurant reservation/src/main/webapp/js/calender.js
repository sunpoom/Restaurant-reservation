
let flag = false;
let now = new Date();
let curMonth = now.getMonth();
let curYear = now.getFullYear();  // 현재 년도
let arrDay = ["일 요 일", "월 요 일", "화 요 일", "수 요 일", "목 요 일", "금 요 일", "토 요 일"];
function setcalender(btn_clink) {
    if (btn_clink == 0) {
        curMonth = now.getMonth();
        curYear = now.getFullYear();
    }
    else if (btn_clink == -1) {
        if (curMonth < 1) {
            curMonth = 11;
            curYear--;
        }
        else {
            curMonth--;
        }
    }
    else {
        if (curMonth >= 11) {
            curMonth = 0;
            curYear++;
        }
        else {
            curMonth++;
        }
    }
    let lastDay = getLastDayOfMonth(curYear, curMonth);    //현재 달 마지막 날짜갯수
    let firstDayOfTheWeekInst = new Date(curYear, curMonth, 1);
    let firsDayoftheweek = firstDayOfTheWeekInst.getDay();        //현재 달 첫날 요일
    let numofWeeks = Math.ceil((firsDayoftheweek + lastDay) / 7);
    display(curYear, curMonth, lastDay, firsDayoftheweek, numofWeeks);
}

function getLastDayOfMonth(curYear, curMonth) {
    const lastDayofMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    let leapYear;
    if ((curYear % 4 == 0) && (curYear % 100 != 0)) {
        leapYear = true;
    }
    else if (curYear % 400 == 0) {
        leapYear = true;
    }
    else {
        leapYear = false;
    }
    lastDayofMonth[1] = (leapYear) ? 29 : 28;
    return lastDayofMonth[curMonth];
}

function display(curYear, curMonth, lastDay, firsDayoftheweek, numofWeeks) {
    let cell = 0;
    let date = 1;
    let table = `<table>`
    table += `<caption> <button class=allowBtn onclick=btn_left()><</button> ${curYear}년 ${(curMonth + 1)}월 <button class=allowBtn onclick=btn_right()>></button> </caption>`;
    table += `<tr id="week">`
    table += `<td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>`;
    table += `</tr>`;
    for (let i = 0; i < numofWeeks; i++) {
        table += `<tr>`;
        for (let j = 0; j < 7; j++) {
            if (cell < firsDayoftheweek) {
                table += `<td class=notDay></td>`;
            }
            else if (date <= lastDay) {
                if ((now.getFullYear() == curYear) && (now.getMonth() == curMonth) && (date == now.getDate())) {
                    table += `<td class="day">${date}</td>`
                }
                else {
                    table += `<td class="day">${date}</td>`
                }
                date++;
            }
            else {
                table += `<td class="notDay"></td>`;
            }
            cell++;
        }
        table += `</tr>`;
    }
    table += `</table>`
    document.getElementById("displayCalender").innerHTML = table; 
}

setcalender(0);



let dayArr = document.querySelectorAll(".day")
let today = document.querySelector("#today")
let selectDay = document.querySelector("#selectDay")
let selectWeek = document.querySelector("#selectWeek")

function btn_left() {
    setcalender(-1);
}
function btn_reset() {
    setcalender(0);
}
function btn_right() {
    setcalender(1);
}


let idx = -1




/* $(function () {
    $(document).on("click", ".day", function () {
        let dayArr = $(this).parent().parent().prev().text().trim().split(" ")
        let year = dayArr[1].split("년")[0]
        let month = dayArr[2].split("월")[0]
        let day = $(this).text()
        let year_month_day = year + '-' + month + '-' + day
        let week = new Date(year_month_day).getDay()
        // console.log(day+" "+week)
        $("#selectDay").text(day + " 일")
        $("#selectWeek").text(arrDay[week])
        if (idx == -1) {
            $("#today").css("background-color", "rgb(255, 230, 153)")
            $(this).css("background-color", "white")
        }
        else {
            $(".day").eq(idx).css("background-color", "rgb(255, 230, 153)")
            $(this).css("background-color", "white")
        }
        idx = $(".day").index(this)
    })  
}) */
