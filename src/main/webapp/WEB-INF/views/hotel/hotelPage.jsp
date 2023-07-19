<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- bootstrap icon CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

</script>

<style type="text/css">
	.btn-gradient {
		background: linear-gradient(to right, #db2566, #f2075a, #f5228c);
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
		background-image: linear-gradient(98deg,#03c75a,#49c6dd);
		font-size: 0.9em;
		font-weight: 600;
	}

	.registerButton:hover {
	   	background-image: linear-gradient(98deg,#07e86b,#57def7);
	   	color: #f0f0f0;
	}
	
	a {
		text-decoration: none;
	}
	
	a:hover {
		text-decoration: none;
		color: white;
	}
	
	.categoryIcon {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	.categoryIcon:hover span {
		color: black;
		font-weight: 800;
	}
	
	.categoryIconFont {
		color: gray;
		font-size: 0.8em;
		padding-top: 0.5em;
	}
	
	/*swiper style*/
	.swiper {
		width: 100%;
		height: 100%;
	}
	
	.swiper-slide {
	  text-align: center;
	  font-size: 1em;
	  font-weight: 600;  	
	  background: #fff;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	}
	
	.swiper-button-next, .swiper-button-prev {
		color: black;
		
	}
	
	:root {
    --swiper-navigation-size: 1em;
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
</style>

</head>	
<body>

	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
	</div>
		<div class="row my-3 mx-5">
			<div class="col">
				<!-- 카테고리 스와이퍼입니다. -->
				<div class="swiper">
				    <div class="swiper-wrapper">
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=house">
				      		<span style="font-size: 1.3em; font-weight: 600">전체</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=house">
				      		<img src="/travel/resources/img/free-icon-building-77486.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">주택</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=apartment">
				      		<img src="/travel/resources/img/free-icon-apartment-4056455.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">아파트</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=logHouse">
				      		<img src="/travel/resources/img/free-icon-log-cabin-10726360.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">통나무집</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=campingCar">
				      		<img src="/travel/resources/img/free-icon-camper-3322510.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">캠핑카</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=hotel">
				      		<img src="/travel/resources/img/free-icon-hotel-1668915.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">호텔</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=farm">
				      		<img src="/travel/resources/img/free-icon-farm-house-4185805.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">농장</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=tent">
				      		<img src="/travel/resources/img/free-icon-camping-tent-3017102.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">텐트</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=guestHouse">
				      		<img src="/travel/resources/img/free-icon-school-3976510.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">게스트용 별채</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=castle">
				      		<img src="/travel/resources/img/free-icon-castle-5082433.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">캐슬</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=boat">
				      		<img src="/travel/resources/img/free-icon-boat-8221451.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">보트</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=treeHouse">
				      		<img src="/travel/resources/img/free-icon-tree-house-4170073.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">트리하우스</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=smallHouse">
				      		<img src="/travel/resources/img/free-icon-houses-4955904.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">초소형 주택</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=windmill">
				      		<img src="/travel/resources/img/free-icon-windmill-2163437.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">풍차</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=cave">
				      		<img src="/travel/resources/img/free-icon-cave-3430253.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">동굴</span>
				      	</a>
				      </div>
				      <div class="swiper-slide">
				      	<a class="categoryIcon" href="/travel/hotel/hotelPage?sortType=containerHouse">
				      		<img src="/travel/resources/img/free-icon-container-860105.png" alt="" style="width: 25px;">
				      		<span class="categoryIconFont">컨테이너하우스</span>
				      	</a>
				      </div>
				    </div>
				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				</div>
			</div>
		</div>
		<div class="row mx-5">
			<div class="col">
				<div class="row">
					<div class="col text-center">
       					<c:if test="${!empty sessionuser}">
							<a class="registerButton" href="./hotelRegisterPage1">
								<span>나만의 숙소 등록하기</span>
								<i style="font-size: 15px;" class="bi bi-pencil-square"></i>
							</a>
						</c:if>
        			</div>
				</div>
				<div class="row mt-2 mb-5">
					<c:forEach items="${hotelList}" var="hotelList" varStatus="status">
						<div class="col-2">
							<div class="card" style="border: none;">
								<div class="row">
									<div class="col">
										<a href="./hotelDetailPage?hotel_id=${hotelList.hotelDto.hotel_id}">
											<img alt="" src="/uploadFiles/hotelMainImage/${hotelList.hotelDto.hotel_main_image}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">
										</a>
									</div>
								</div>
								<div class="row py-2">
									<div class="col">
										<div class="row align-items-center">
											<div class="col-auto pb-0 m-0">
												<span class="fw-bold" style="font-size: 14px;">${hotelList.hotelDto.hotel_title}</span>
											</div>
											<c:choose>
												<c:when test="${!empty hotelList.hotelReviewPointCount}">
													<div class="col text-end">
														<i class="bi bi-star-fill" style="color: #fcc203; font-size: 14px;"></i>
														<span class="p-0 fw-bold" style="font-size: 14px;">${hotelList.hotelReviewPointCount}</span>
														<span style="font-size: 14px;">(</span>
														<span style="font-size: 14px;">${hotelList.hotelReviewCount}</span><span>)</span>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col text-end">
														<i class="bi bi-star-fill" style="color: #b8b8b8; font-size: 14px;"></i>
														<span style="font-size: 14px;" class="p-0 fw-bold">0.0</span>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="row">
											<div class="col">
												<div class="card-text p-0">
													<span style="color: gray; font-size: 14px;">${hotelList.hotelCategoryDto.hotel_category_title}</span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-auto pe-0">
												<span style="color: gray; font-size: 14px;"><fmt:formatDate value="${hotelList.hotelDto.hotel_reserve_start_date}" pattern="MM월 dd일" /></span>
											</div>
											<div class="col-auto px-0">
												<span style="color: gray; font-size: 14px;">~</span>
											</div>
											<div class="col-auto ps-0">
												<span style="color: gray; font-size: 14px;">
												<fmt:formatDate value="${hotelList.hotelDto.hotel_reserve_end_date}" pattern="MM월 dd일" /></span>
											</div>
										</div>
										<div class="row">
											<div class="col">
												<span style="color: gray; font-size: 14px;">${hotelList.hotelDto.hotel_address}</span>
											</div>
										</div>
										<div class="row">
											<div class="col-auto pe-0">
												<span style="font-size: 14px; font-weight: bold;">\</span>
											</div>
											<div class="col-auto px-0">
												<span style="font-size: 14px; font-weight: bold;">${hotelList.hotelDto.hotel_price}</span>
											</div>
											<div class="col-auto p-0">
												<span style="font-size: 14px;">/</span>
											</div>
											<div class="col-auto p-0">
												<span style="font-size: 14px;">박</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
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
      slidesPerView: 14,
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