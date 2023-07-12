<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

function clickDashButton1() {
	
	let currentValue = parseInt(numberOfGuest.innerText);
	
	if (currentValue <= 0) {
		
		return;
	}
	
	numberOfGuest.innerText = currentValue - 1;
	
}

function clickPlusButton1() {
	
	let currentValue = parseInt(numberOfGuest.innerText);
	
	if (currentValue >= 16) {
		
		return;
	}
	
	numberOfGuest.innerText = currentValue + 1;
}

function clickDashButton2() {
	
	let currentValue = parseInt(numberOfBedRoom.innerText);
	
	if (currentValue <= 0) {
		
		return;
	}
	
	numberOfBedRoom.innerText = currentValue - 1;
	
}

function clickPlusButton2() {
	
	let currentValue = parseInt(numberOfBedRoom.innerText);
	
	if (currentValue >= 16) {
		
		return;
	}
	
	numberOfBedRoom.innerText = currentValue + 1;
}

function clickDashButton3() {
	
	let currentValue = parseInt(numberOfBathRoom.innerText);
	
	if (currentValue <= 0) {
		
		return;
	}
	
	numberOfBathRoom.innerText = currentValue - 1;
	
}

function clickPlusButton3() {
	
	let currentValue = parseInt(numberOfBathRoom.innerText);
	
	if (currentValue >= 16) {
		
		return;
	}
	
	numberOfBathRoom.innerText = currentValue + 1;
}

function clickDashButton4() {
	
	let currentValue = parseInt(numberOfBed.innerText);
	
	if (currentValue <= 0) {
		
		return;
	}
	
	numberOfBed.innerText = currentValue - 1;
	
}

function clickPlusButton4() {
	
	let currentValue = parseInt(numberOfBed.innerText);
	
	if (currentValue >= 16) {
		
		return;
	}
	
	numberOfBed.innerText = currentValue + 1;
}

function sendHotelBasics() {
	
	const numberOfGuest = document.getElementById("numberOfGuest");
	const numberOfBedRoom = document.getElementById("numberOfBedRoom");
	const numberOfBathRoom = document.getElementById("numberOfBathRoom");
	const numberOfBed = document.getElementById("numberOfBed");
	
	const guestNum = parseInt(numberOfGuest.innerText);
	const bedRoomNum = parseInt(numberOfBedRoom.innerText);
	const bedNum = parseInt(numberOfBed.innerText);
	const bathRoomNum = parseInt(numberOfBathRoom.innerText);
	
	const checkInTimeElement = document.getElementById("checkInTime").value;
	const checkOutTimeElement = document.getElementById("checkOutTime").value;
	
	const checkInTime = parseInt(checkInTimeElement);
	const checkOutTime = parseInt(checkOutTimeElement);
	
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		
		if(xhr.readyState == 4 && xhr.status == 200) {
			
			const response = JSON.parse(xhr.responseText);
			
			
		}
	}
	
	xhr.open("post", "./inserthotelInfo2");
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send("hotel_limit_number=" + guestNum + "&hotel_bedRoom=" + bedRoomNum + "&hotel_bed=" + bedNum + "&hotel_bathRoom=" + bathRoomNum + "&hotel_check_in_time=" + checkInTime + "&hotel_check_out_time=" + checkOutTime);
	
	window.location.href = "/travel/hotel/hotelRegisterPage4";
}

window.addEventListener("DOMContentLoaded", function() {
	
	let numberOfGuest = document.getElementById("numberOfGuest");
	
	let numberOfBedRoom = document.getElementById("numberOfBedRoom");
	
	let numberOfBathRoom = document.getElementById("numberOfBathRoom");
	
	let numberOfBed = document.getElementById("numberOfBed");
	
 	numberOfGuest.innerText = 0;
 	numberOfBedRoom.innerText = 0;
 	numberOfBathRoom.innerText = 0;
 	numberOfBed.innerText = 0;
	
});

</script>

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
   
        .reserveButton {
        width: auto;
        height: auto;
        background: linear-gradient(to right, rgb(60, 60, 60), rgb(36, 36, 36), rgb(46, 46, 46), rgb(46, 46, 46));
        border-radius: 10px;
        border: none;
        color: rgb(255, 255, 255);
        padding: 10px 30px;
        font-weight: 600;
        font-size: 14px;
        text-align: center;
    }

    .box {
        width: auto;
        height: auto;
        border: solid rgb(205, 205, 205) 1px;
        border-radius: 10px;
        padding: 17px 15px;

    }
    </style>
</head>
<body>

<div class="container-fluid">
        <div class="row align-items-center py-4" style="position: fixed; top: 0; width: 100%; background-color: white; z-index: 1;">
            <div class="col px-5">
                <span style="color: #e7104a; font-size: 25px; font-weight: 600;">LOGO</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <div>
                    <span>나가기</span>
                </div>
            </div>
        </div>

        <div class="row" style="padding-top: 100px;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-3">
                    <div class="col">
                        <div style="font-size: 28px; font-weight: 600;">숙소 기본 사항 작성하기</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row my-4">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙박 가능한 인원은 몇 명인가요?</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">게스트</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickDashButton1()">
                                	<span>-</span>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" id="numberOfGuest"></div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickPlusButton1()">
                                	<span>+</span>
                                </div>
                            </div>
                        </div>
                        <hr class="my-3">
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">침실</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickDashButton2()">-</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" id="numberOfBedRoom">4</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickPlusButton2()">+</div>
                            </div>
                        </div>
                        <hr class="my-3">
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">욕실</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickDashButton3()">-</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" id="numberOfBathRoom">4</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickPlusButton3()">+</div>
                            </div>
                        </div>
                        <hr class="my-3">
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">침대</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickDashButton4()">-</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" id="numberOfBed">4</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;" onclick="clickPlusButton4()">+</div>
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 체크인, 체크아웃 시간을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">체크인</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">
                                    <select id= "checkInTime" class="form-control">
                                        <option value="00">00:00</option>
                                        <option value="01">01:00</option>
                                        <option value="02">02:00</option>
                                        <option value="03">03:00</option>
                                        <option value="04">04:00</option>
                                        <option value="05">05:00</option>
                                        <option value="06">06:00</option>
                                        <option value="07">07:00</option>
                                        <option value="08">08:00</option>
                                        <option value="09">09:00</option>
                                        <option value="10">10:00</option>
                                        <option value="11">11:00</option>
                                        <option value="12">12:00</option>
                                        <option value="13">13:00</option>
                                        <option value="14">14:00</option>
                                        <option value="15">15:00</option>
                                        <option value="16">16:00</option>
                                        <option value="17">17:00</option>
                                        <option value="18">18:00</option>
                                        <option value="19">19:00</option>
                                        <option value="20">20:00</option>
                                        <option value="21">21:00</option>
                                        <option value="22">22:00</option>
                                        <option value="23">23:00</option>
                                        <option value="24">24:00</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">체크아웃</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">
                                    <select id= "checkOutTime" class="form-control">
                                        <option value="00">00:00</option>
                                        <option value="01">01:00</option>
                                        <option value="02">02:00</option>
                                        <option value="03">03:00</option>
                                        <option value="04">04:00</option>
                                        <option value="05">05:00</option>
                                        <option value="06">06:00</option>
                                        <option value="07">07:00</option>
                                        <option value="08">08:00</option>
                                        <option value="09">09:00</option>
                                        <option value="10">10:00</option>
                                        <option value="11">11:00</option>
                                        <option value="12">12:00</option>
                                        <option value="13">13:00</option>
                                        <option value="14">14:00</option>
                                        <option value="15">15:00</option>
                                        <option value="16">16:00</option>
                                        <option value="17">17:00</option>
                                        <option value="18">18:00</option>
                                        <option value="19">19:00</option>
                                        <option value="20">20:00</option>
                                        <option value="21">21:00</option>
                                        <option value="22">22:00</option>
                                        <option value="23">23:00</option>
                                        <option value="24">24:00</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 위치를 알려주세요</div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="col"></div>
        </div>
                

        <div class="row align-items-center py-4" style="position: fixed; bottom: 0; width: 100%; z-index: 1;">
            <div class="col-auto px-5">
                <span style="font-size: 14px; font-weight: 600;">뒤로</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <div class="reserveButton" onclick="sendHotelBasics()">
                    <span>다음</span>
                </div>
            </div>
        </div>
    </div>

            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>

</body>
</html>