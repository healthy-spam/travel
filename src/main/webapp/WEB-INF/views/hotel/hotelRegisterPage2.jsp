<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
 
 <!-- <script type="text/javascript">
 
	function clickBox() {
		
		const box1 = document.querySelector(".box1");
		
		function boxClick() {
			
			box1.classList.add('boxClick');
			
		}
		
		box1.addEventListener('click', boxClick);
		
	}
	
	window.addEventListener("DOMContentLoaded", function() {
		
		clickBox();
		
	});
	 

 
 </script> -->
 
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
    
    .box:hover {
    	border: 2px solid black;
    	padding: 16px 14px;
    }
    
    .boxClick {
        width: auto;
        height: auto;
        border: solid rgb(205, 205, 205) 2px;
        border-radius: 10px;
        padding: 16px 14px;
        background-color: gray;

    }
    
    .box1MouseOver {
        width: auto;
        height: auto;
        border: solid rgb(205, 205, 205) 2px;
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

        <div class="row" style="padding-top: 80px;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-4">
                    <div class="col">
                        <div style="font-size: 24px; font-weight: 600;">다음 중 숙소를 가장 잘 설명한 것은 무엇인가요?</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row row-cols-3">
                            
                            <!-- 반복문 -->
                            <div class="col-4 px-2 py-2">
                                <div class="box" id="box1">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-building-77486.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="1">주택</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-apartment-4056455.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="2">아파트</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-log-cabin-10726360.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="3">통나무집</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-camper-3322510.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="4">캠핑카</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-hotel-1668915.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="5">호텔</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-farm-house-4185805.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="6">농장</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-camping-tent-3017102.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="7">텐트</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-school-3976510.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="8">게스트용 별채</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-castle-5082433.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="9">캐슬</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-boat-8221451.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="10">보트</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-tree-house-4170073.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="11">트리하우스</span>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-houses-4955904.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="12">초소형 주택</span>
                                        </div>
                                    </div>
                                </div>
                            </div>   
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-windmill-2163437.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="13">풍차</span>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-cave-3430253.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="14">동굴</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/categoryIcon/free-icon-container-860105.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                            <span style="font-size: 14px; font-weight: 600;" id="15">컨테이너하우스</span>
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

        <div class="row align-items-center py-4" style="position: fixed; bottom: 0; width: 100%; z-index: 1; background-color: white;">
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