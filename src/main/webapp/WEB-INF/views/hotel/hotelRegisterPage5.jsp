<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    
     body {
		font-family: 'Noto Sans KR', sans-serif;	
	}
    
    .nextButton {
	    width: auto;
	    height: auto;
	    background-image: linear-gradient(98deg,#4f4f4f,#4f4f4f);
	    border-radius: 10px;
	    border: none;
	    color: rgb(255, 255, 255);
	    padding: 0.8em 1.2em;
	    font-size: 0.9em;
	    text-align: center;
    }
    
    .nextButton:hover {
    	background-image: linear-gradient(98deg,#4f4f4f,#333333);	
    }

    .box {
        width: auto;
        height: auto;
        border: solid rgb(205, 205, 205) 1px;
        border-radius: 10px;
        padding: 1.1em 2em;

    }
    
    .box:hover {
    	border: 2px solid black;
    	padding: 1em 2em;
    }
    
    .selectedBox {
       width: auto;
       height: auto;
       border: solid black 2px;
       border-radius: 10px;
       padding: 16px 14px;
       background-color: #f5f5f5;
    }
    
    .categoryFont {
   		font-size: 0.8em;
		font-weight: 500;
		overflow: hidden; 
		-webkit-box-orient: vertical; 
		text-overflow: ellipsis; 
		display: -webkit-box;  
		-webkit-line-clamp: 1;
    }
    
    .subtitleFont {
    	font-size: 1.1em;
    	font-weight: 500;
    }
    a {
    	text-decoration: none;
    	font-weight: 600;
    	color: #595959;
    }
    
    a:hover {
		text-decoration: none;
		color: black;
	}
	
    </style>
</head>
<body>

 <div class="container-fluid">
        <div class="row align-items-center py-4" style="position: fixed; top: 0; width: 100%; z-index: 1;">
            <div class="col px-5">
                <img class="navbar-brand" src="/travel/resources/img/tripstationLOGO.png" style="width: 6em;">
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <div>
                    <a href="/travel/hotel/hotelPage">나가기</a>
                </div>
            </div>
        </div>
		<form action="./hotelRegisterPage5Process" method="post">
        <div class="row" style="padding-top: 5em; padding-bottom: 5em;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-4">
                    <div class="col">
                        <div style="font-size: 1.6em; font-weight: 500;">숙소 편의시설 정보를 추가하세요</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row row-cols-3">
                            
                            <!-- 반복문 -->
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-wifi-3562383.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="1">
                                            <span class="categoryFont">무선인터넷</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-tv-5372376.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="2">
                                            <span class="categoryFont">TV</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-kitchen-tools-366055.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="3">
                                            <span class="categoryFont">세탁기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-kitchen-cabinet-6871864.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="4">
                                            <span class="categoryFont">주방</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-car-4347447.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="5">
                                            <span class="categoryFont">건물 내 무료 주차</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-parking-5201653.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="6">
                                            <span class="categoryFont">건물 내 유료 주차</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-snow-4361545.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="7">
                                            <span class="categoryFont">에어컨</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                        </div>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col">
                        <div class="subtitleFont">특별한 편의시설이 있나요?</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row row-cols-3">
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-summer-beach-3052780.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="8">
                                            <span class="categoryFont">해변 근처</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-steak-883614.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="9">
                                            <span class="categoryFont">바베큐 그릴</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-dumbell-1296767.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="10">
                                            <span class="categoryFont">헬스</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-fire-7519911.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="11">
                                            <span class="categoryFont">화로</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-computer-4854528.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="12">
                                            <span class="categoryFont">PC</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col">
                        <div class="subtitleFont">다음과 같은 안전 관련 물품이 있나요?</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row">
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-fire-alarm-578268.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="13">
                                            <span class="categoryFont">화재경보기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-first-aid-bag-5177161.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="14">
                                            <span class="categoryFont">구급 상자</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-fire-extinguisher-115097.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="15">
                                            <span class="categoryFont">소화기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-aed-5181669.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="16">
                                            <span class="categoryFont">자동제세동기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
            <div class="col"></div>
        </div>

        <div class="row align-items-center py-4" style="position: fixed; bottom: 0; width: 100%; z-index: 1;">
            <div class="col-auto px-5">
                <span style="font-size: 1em; font-weight: 500;">뒤로</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <button class="nextButton">
                    <span>다음</span>
                </button>
            </div>
        </div>
        </form>
    </div>

<!--const qwerModal = bootstrap.Modal.getOrCreateInstance("#qwerModal");-->
<!-- Modal -->
<div class="modal fade" id="qwerModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>