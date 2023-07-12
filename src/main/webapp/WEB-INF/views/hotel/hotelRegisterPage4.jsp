<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">

function sendHotelBasics2() {
	
	const hotelTitleValue = document.getElementById("hotelTitle").value;
	const hotelContentValue = document.getElementById("hotelContent").value;
	const hotelPriceValue = document.getElementById("hotelPrice").value;
	const hotelOpenDateValue = document.getElementById("hotelOpenDate").value;
	const hotelEndDateValue = document.getElementById("hotelEndDate").value;
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		
		if (xhr.readyState == 4 && xhr.status == 200) {
			
			const response = JSON.parse(xhr.responseText);
			
			
		}
	}
	
	xhr.open("post", "./inserthotelInfo3");
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send();
}
	
window.addEventListener("DOMContentLoaded", function() {
	
	
});
	
</script>

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
    font-size: 16px;
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
        <div class="row align-items-center py-4" style="position: fixed; top: 0; width: 100%; z-index: 1;">
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

        <div class="row" style="padding-top: 100px; padding-bottom: 100px;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-3">
                    <div class="col">
                        <div style="font-size: 28px; font-weight: 600;">숙소 정보를 추가하세요</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">1.숙소 이름은 무엇인가요?</div>
                            </div>
                        </div>
                        <div class="row">
                           <div class="col">
                                <input id="hotelTitle" class="form-control" type="text" placeholder="멋진 이름을 지어주세요">
                           </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">2.숙소를 설명해주세요</div>
                            </div>
                        </div>
                        <div class="row">
                           <div class="col">
                                <input id="hotelContent" class="form-control" type="text" placeholder="멋진 설명을 적어주세요">
                           </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">3.숙소 사진을 올려주세요</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <input id="hotelMainImage" class="form-control" type="file">
                            </div>
                        </div>
                         <div class="row mt-1">
                            <div class="col">
                                <input id="hotelSubImage" accept="image/*" class="form-control" type="file" multiple>
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">4.숙소 오픈일과 마감일을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <span>오픈일</span>
                            </div>
                            <div class="col">
                                <input id="hotelOpenDate" type="date" class="form-control">
                            </div>
                            <div class="col-auto">
                                <span>마감일</span>
                            </div>
                            <div class="col">
                                <input id="hotelEndDate" type="date" class="form-control">
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">5.마지막으로 숙소 가격을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <input id="hotelPrice" type="text" class="form-control">
                            </div>
                            <div class="col ps-0">
                                <span style="font-weight: 600; font-size: 20px;">\</span>
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
                <div class="reserveButton">
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