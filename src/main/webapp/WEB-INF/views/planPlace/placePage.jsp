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


// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
document.addEventListener("DOMContentLoaded", function() {
	Kakao.init('93ae12d4c0f00044228cbd5b5f2f588b'); // 여기에 JavaScript 키를 붙여넣으세요.

    // SDK 초기화 여부를 판단합니다.
	console.log(Kakao.isInitialized());
});

function logout() {
    Kakao.Auth.logout(function() {
        console.log('로그아웃이 완료되었습니다.');
        // 로그아웃이 완료되면 서버 측 로그아웃 URL로 리다이렉트
        location.href = '/travel/logoutProcess';
    });
}


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
		<div class="row fw-bold justify-content-center">
			<div class="col">
				<nav class="navbar navbar-expand-lg bg-body-tertiary">
					<div class="container-fluid p-0">
						<img class="navbar-brand mb-0 " src="/travel/resources/img/tripstationLOGO.png" style="width: 7em;">
						<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav ms-3 me-auto mb-2 mb-lg-0">
								<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" aria-current="page" data-bs-toggle="dropdown" href="/travel/main" aria-expanded="false">여행</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="/travel/main">맞춤여행</a></li>
										<li><a class="dropdown-item" href="/travel/package">패키지</a></li>
									</ul>
								</li>
								<li class="nav-item"><a class="nav-link" href="/travel/plan/planPage">플래너</a></li>
								<li class="nav-item"><a class="nav-link" href="#" role="button">크루</a></li>
								<li class="nav-item"><a class="nav-link" href="/travel/hotel/hotelPage" role="button">숙소</a></li>
								<li class="nav-item"><a class="nav-link" href="/travel/planPlace/placePage">플레이스</a></li>
							</ul>
							<c:choose>
								<c:when test="${!empty sessionuser}">
									<ul class="navbar-nav align-items-center">
										<li>
											<c:choose>
												<c:when test="${sessionuser.user_image != null}">
													<img alt="썸네일" src="/uploadFiles/profileImage/${sessionuser.user_image}" style="width: 2em; height: 2em; border-radius: 50%;">
												</c:when>
												<c:otherwise>
													<img alt="썸네일" src="/travel/resources/img/icon.png" style="width: 2em; height: 2em; border-radius: 50%;">
												</c:otherwise>
											</c:choose>
										</li>
										<li class="nav-item dropdown">
											<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> ${sessionuser.user_nickname} </a>
											<ul class="dropdown-menu" aria-labelledby="userDropdown">
												<li><a class="dropdown-item" href="/travel/myPage">마이페이지</a></li>
												<li><a class="dropdown-item" href="/travel/crew/main">크루페이지</a></li>
												<li><a class="dropdown-item" href="/travel/allCouponPage">쿠폰</a></li>
												<li><a class="dropdown-item" href="/travel/messageGot">쪽지</a></li>
												<li><a class="dropdown-item" href="javascript:logout();">로그아웃</a></li>
											</ul>
										</li>
									</ul>
								</c:when>
								<c:otherwise>
									<a class="nav-link" href="/travel/login">로그인</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</nav>
			</div>
		</div>
        <div class="row mt-2">
		
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