<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
 
<script type="text/javascript">

	
	document.addEventListener("DOMContentLoaded", function() {
	
		/* 카테고리 유호성 검사 */
		function categoryVcForm() {
			
			const categoryVcDiv = document.getElementById("categoryVc");
			
			const radioButtons = document.querySelectorAll("input[type='radio'][name='hotel_category']");
			
			let isChecked = false;
			
			for (let i = 0; i < radioButtons.length; i++) {
				
				if (radioButtons[i].checked) {
						
					isChecked = true;
					
					break;
				}
			}
			
			if (!isChecked) {
				
				categoryVcDiv.innerText = "*숙소 종류를 선택해주세요(필수 1개 선택)"
				categoryVcDiv.style.color = "red";
				categoryVcDiv.style.fontSize = "0.9em";
				
				return false;
				
			}
			
			return true;
		}
		
		document.getElementById("nextButton").addEventListener("click", function(event){
			
			if (!categoryVcForm()) {
				
				event.preventDefault();
			}
		});
		
	});
	
 
</script>
 
    <style>
    
    body {
		font-family: 'Noto Sans KR', sans-serif;	
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
		<form action="./hotelRegisterPage2Process" method="post">
        <div class="row" style="padding-top: 5em; padding-bottom: 5em;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-4">
                    <div class="col">
                        <div style="font-size: 1.6em; font-weight: 500;">다음 중 숙소를 가장 잘 설명한 것은 무엇인가요?</div>
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
                                        <img src="/travel/resources/img/free-icon-building-77486.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="주택">
                                            <span class="categoryFont" id="1">주택</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-apartment-4056455.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="아파트">
                                            <span class="categoryFont" id="2">아파트</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-log-cabin-10726360.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="통나무집">
                                            <span class="categoryFont" id="3">통나무집</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-camper-3322510.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="캠핑카">
                                            <span class="categoryFont" id="4">캠핑카</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-hotel-1668915.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="호텔">
                                            <span class="categoryFont" id="5">호텔</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-farm-house-4185805.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="농장">
                                            <span class="categoryFont" id="6">농장</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-camping-tent-3017102.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="텐트">
                                            <span class="categoryFont" id="7">텐트</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-school-3976510.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="게스트용 별채">
                                            <span class="categoryFont" id="8">게스트용 별채</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-castle-5082433.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="캐슬">
                                            <span class="categoryFont" id="9">캐슬</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-boat-8221451.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="보트">
                                            <span class="categoryFont" id="10">보트</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-tree-house-4170073.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="트리하우스">
                                            <span class="categoryFont" id="11">트리하우스</span>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-houses-4955904.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="초소형 주택">
                                            <span class="categoryFont" id="12">초소형 주택</span>
                                        </div>
                                    </div>
                                </div>
                            </div>   
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-windmill-2163437.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="풍차">
                                            <span class="categoryFont" id="13">풍차</span>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-cave-3430253.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="동굴">
                                            <span class="categoryFont" id="14">동굴</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/travel/resources/img/free-icon-container-860105.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="radio" name="hotel_category" value="컨테이너하우스">
                                            <span class="categoryFont" id="15">컨테이너하우스</span>
                                        </div>
                                    </div>
                                </div>
                            </div>                  
                        </div>
                    </div>
                </div>
                <div class="row">
                	<div class="col">
                		<div id="categoryVc">                			
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
                <button id="nextButton" class="nextButton" >
                    <span>다음</span>
                </button>
            </div>
        </div>
        </form>
    </div>

            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>