<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script type="text/javascript">

/* const categoryValue = 'recent';

//플레이스 목록을 보여줍니다.
function showPlaceList() {
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		
		if(xhr.readyState == 4 && xhr.status == 200) {
			
			const response = JSON.parse(xhr.responseText);
			
			//반복문을 실행할 row를 가져오고 안의 html요소들을 초기화 합니다.
			const listStartRow = document.getElementById("listStartRow");
			
			listStartRow.innerHTML = "";
			
			//반복문을 시작합니다.
			for(data of response.list) {
				
				const divCol = document.createElement("div");
				divCol.className = "col-2 mb-4";
				listStartRow.appendChild(divCol);
				
				const divCard = document.createElement("div");
				divCard.className = "card";
				divCard.style.border = "none";
				divCol.appendChild(divCard);
				
				const divRow1 = document.createElement("div");
				divRow1.className = "row";
				divCard.appendChild(divRow1);
				
				const divCol2 = document.createElement("div");
				divCol2.className = "col";
				divRow1.appendChild(divCol2);
				
				const anchor = document.createElement("a");
				anchor.href="./PlanPlaceDetailPage?plan_place_id=" + data.planPlaceDto.plan_place_id;
				divCol2.appendChild(anchor);
				
				const image = document.createElement("img");
				image.src = "/uploadFiles/mainImage/" + data.planPlaceDto.plan_place_photo;
				image.style.width = "100%";
				image.style.height = "12em";
				image.style.objectFit = "cover";
				image.style.borderRadius = "10px";
				anchor.appendChild(image);
				
				const divRow2 = document.createElement("div");
				divRow2.className = "row align-items-center my-2";
				divCard.appendChild(divRow2);
				
				const divCol3 = document.createElement("div");
				divCol3.className = "col-auto";
				divRow2.appendChild(divCol3);
				
				const span1 = document.createElement("span");
				span1.style.fontSize = "0.9em";
				span1.style.fontWeight = "bold";
				span1.style.display = "-webkit-box";
				span1.style.webkitLineClamp = "1";
				span1.style.webkitBoxOrient = "vertical";
				span1.style.overflow = "hidden";
				span1.style.textOverflow = "ellipsis";
				span1.textContent = data.planPlaceDto.plan_place_name;
				divCol3.appendChild(span1);
				
				const divCol4 = document.createElement("div");
				divCol4.className = "col text-end pe-1";
				divRow2.appendChild(divCol4);
				
				const span2 = document.createElement("span");
				span2.className = "bi bi-heart-fill";
				span2.style.color = "#ff4f78";
				span2.style.fontSize = "12px";
				divCol4.appendChild(span2);
				
				const divCol5 = document.createElement("div");
				divCol5.className = "col-auto p-0";
				divRow2.appendChild(divCol5);
				
				const span3 = document.createElement("span");
				span3.style.fontSize = "0.9em";
				span3.style.fontWeight = "bold";
				span3.textContent = data.loveCount;
				divCol5.appendChild(span3);
				
				const divCol6 = document.createElement("div");
				divCol6.className = "col-auto pe-1";
				divRow2.appendChild(divCol6);
				
				const icon = document.createElement("i");
				icon.style.fontSize = "0.9em";
				icon.className = "bi bi-chat";
				divCol6.appendChild(icon);
				
				const divCol7 = document.createElement("div");
				divCol7.className = "col-auto ps-0";
				divRow2.appendChild(divCol7);
				
				const span5 = document.createElement("span");
				span5.style.fontSize = "0.9em";
				span5.style.fontWeight = "bold";
				span5.textContent = data.commentCount;
				divCol7.appendChild(span5);
				
				const divRow3 = document.createElement("div");
				divRow3.className = "row";
				divCard.appendChild(divRow3);
				
				const divCol8 = document.createElement("div");
				divCol8.className = "col";
				divRow3.appendChild(divCol8);
				
				const span6 = document.createElement("span");
				span6.style.fontSize = "0.9em"
				span6.style.color = "gray"
				span6.style.display = "-webkit-box"
				span6.style.webkitLineClamp = "3"
				span6.style.webkitBoxOrient = "vertical"
				span6.style.overflow = "hidden"
				span6.style.textOverflow = "ellipsis"
				span6.textContent = data.planPlaceDto.plan_place_content;
				divCol8.appendChild(span6);
				
				const divRow4 = document.createElement("div");
				divRow4.className = "row my-2";
				divCard.appendChild(divRow4);
				
				const divCol9 = document.createElement("div");
				divCol9.className = "col";
				divRow4.appendChild(divCol9);
				
				const span7 = document.createElement("span");
				span7.style.fontSize = "0.9em"
				span7.style.display = "-webkit-box"
				span7.style.webkitLimeClamp = "1"
				span7.style.webkitBoxOrient = "vertical"
				span7.style.overflow = "hidden"
				span7.style.textOverflow = "ellipsis"
				span7.textContent = data.planPlaceDto.plan_place_address;
				divCol9.appendChild(span7);
				
			}
			
		}

	}
		xhr.open("post", "./getPlaceList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("sortType=" + categoryValue);
}

window.addEventListener("DOMContentLoaded", function() {
	
	showPlaceList();
	
}); */

</script>



<style type="text/css">

	/*swiper style*/
	 .swiper {
      width: 100%;
      height: 100%;
    }

    .swiper-slide {
      text-align: center;
      font-size: 1em;
	  font-weight: 500;  	
      background: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    
    :root {
    --swiper-navigation-size: 1em;
    
    .swiper-button-next, .swiper-button-prev {
		color: black;
		
	}	
	}
	
	@media (max-width: 760px) {
      .swiper-button-next {
        right: 20px;
        transform: rotate(90deg);
      }

      .swiper-button-prev {
        left: 20px;
        transform: rotate(90deg);
      }
	}
	
	body {
		font-family: 'Noto Sans KR', sans-serif;	
	}
	
	.registerButton {
		border-radius: 25px; 
		color: white; 
		position: fixed; 
		z-index: 9999; 
		bottom: 5%; 
		left: 50%; 
		transform: translate(-50%, -50%);
		width: auto;
		height: auto;
		padding: 12px 20px;
		background-image: linear-gradient(30deg,#00b078,#00b067);
		font-size: 0.9em;
		font-weight: 500;
	}
    
    .registerButton:hover {
    	background-image: linear-gradient(98deg,#1e9f58,#0e8a69);
    	color: #f0f0f0;
	}
    
    .categoryButton {
    	width: auto;
    	height: auto;
    	border-radius: 10px;
    	border: 1px solid lightgray;
    	font-size: 14px;
    	color: gray;
    	padding:  7px 15px;
    	background: white;
    }
    
    .categoryFont {
    	font-size: 1em;
    	font-weight: 600;
    	color: gray;
    	position: relative;
    	display: inline-block;
    	
    }
    
    a {
    	text-decoration: none;
    	color: gray;
    }
    
    a:hover {
		text-decoration: none;
		color: black;
	}
	
	ul {
		list-style: none;
	
	}
	
	.customCard3{
        width: auto;
        height: auto;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.06);
        border-radius: 5px;
        overflow: hidden;
        
    }
	
</style>

</head>
<body>

    <div class="container">
    	<jsp:include page="../common/mainTopNavi2.jsp"></jsp:include>
		
        <div class="row mt-4 mb-2">
			<div class="col">
				 <!-- Swiper -->
				<div class="swiper">
				    <div class="swiper-wrapper">
				      <div class="swiper-slide"><a href="/travel/planPlace/placePage">전체</a></div>
				      <div class="swiper-slide"><a href="/travel/planPlace/placePage?sortType=seoul">서울특별시</a></div>
				      <div class="swiper-slide"><a href="#">경기도</a></div>
				      <div class="swiper-slide"><a href="#">강원도</a></div>
				      <div class="swiper-slide"><a href="#">충청북도</a></div>
				      <div class="swiper-slide"><a href="#">충청남도</a></div>
				      <div class="swiper-slide"><a href="#">전라북도</a></div>
				      <div class="swiper-slide"><a href="#">전라남도</a></div>
				      <div class="swiper-slide"><a href="#">경상북도</a></div>
				      <div class="swiper-slide"><a href="#">경상남도</a></div>
				      <div class="swiper-slide"><a href="#">제주도</a></div>
				      <div class="swiper-slide"><a href="#">부산광역시</a></div>
				      <div class="swiper-slide"><a href="#">대구광역시</a></div>
				      <div class="swiper-slide"><a href="#">인천광역시</a></div>
				      <div class="swiper-slide"><a href="#">광주광역시</a></div>
				      <div class="swiper-slide"><a href="#">대전광역시</a></div>
				      <div class="swiper-slide"><a href="#">울산광역시</a></div>
				      <div class="swiper-slide"><a href="#">세종특별자치시</a></div>
				    </div>
				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				  </div>
			</div>
		</div>
        <div class="row">
        	<div class="col text-center">
        		<c:if test="${!empty sessionuser}">
					<a class="registerButton" href="./registerPlacePage">
						<span>나만의 플레이스 등록하기</span>
						<i style="font-size: 15px;" class="bi bi-pencil-square"></i>
					</a>
				</c:if>
        	</div>
        </div>
        <div class="row my-0">
            <div class="col">
                <div class="row flex-wrap justify-content-between my-3" id="listStartRow">
                	<c:forEach items="${planPlaceList}" var="list" begin="0" end="${planPlaceList.size()}" varStatus="status">
                    	<div class="col my-2">
                			<div class="customCard3">
                				<a href="/travel/planPlace/PlanPlaceDetailPage?plan_place_id=${list.planPlaceDto.plan_place_id}">
			                    	<img style="width: 100%; height: 12em;" src="/uploadFiles/mainImage/${list.planPlaceDto.plan_place_photo }" alt="">
			                    </a>
			                    <div style="z-index: 999; background-color: black;"></div>
			                    <div class="row mt-3 px-3">
			                        <div class="col">
			                            <span style="font-size: 1em; font-weight: 500; color: rgb(0, 0, 0); overflow: hidden; -webkit-box-orient: vertical; text-overflow: ellipsis; display: -webkit-box;  -webkit-line-clamp: 1;">
			                                ${list.planPlaceDto.plan_place_name}
			                            </span>
			                        </div>
			                    </div>
			                    <div class="row px-3 my-2">
			                        <div class="col" style="height: 2.5em;">
			                            <span style="font-size: 0.75em; font-weight: 100; color: rgb(60, 60, 60); overflow: hidden; -webkit-box-orient: vertical; text-overflow: ellipsis; display: -webkit-box;  -webkit-line-clamp: 2;">
			                                ${list.planPlaceDto.plan_place_content}
			                            </span>
			                        </div>
			                    </div>
			                    <div class="row px-3 mb-3 align-items-center">
			                        <div class="col-auto pe-0">
			                            <i class="bi bi-geo-alt-fill" style="font-size: 0.85em; color: rgba(255, 30, 0, 0.83);"></i>
			                        </div>
			                        <div class="col ps-1 pt-1">
			                            <span style="font-size: 0.75em; font-weight: 400; color: rgb(122, 122, 122); overflow: hidden; -webkit-box-orient: vertical; text-overflow: ellipsis; display: -webkit-box;  -webkit-line-clamp: 1;">
			                                ${list.planPlaceDto.plan_place_address}
			                            </span>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <c:if test="${status.index % 5 == 4 }">
			            	</div><div class="row flex-wrap justify-content-between my-3">
			            </c:if>
			            <c:if test="${status.last }">
			            	<c:if test="${(status.index % 5) < 4}">
			            		<c:forEach begin="0" end="${3 - (status.index % 5)}">
			            			<div class="col my-2"></div>
			            		</c:forEach>
			            	</c:if>
			            </c:if>
                	</c:forEach>
	            </div>
	        </div>
	    </div>
	</div>
    



<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper('.swiper', {
      slidesPerView: 8,
      direction: getDirection(),
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      on: {
        resize: function () {
          swiper.changeDirection(getDirection());
        },
      },
    });

    function getDirection() {
      var windowWidth = window.innerWidth;
      var direction = window.innerWidth <= 760 ? 'vertical' : 'horizontal';

      return direction;
    }
  </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>