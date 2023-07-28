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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=818488f03bbc3c53eaa216d3aaf39e13&libraries=services"></script>
<script type="text/javascript">
	
	
	window.onload = function() {
	    var mapContainer = document.getElementById('map');
	    
	    var addressElement = document.getElementById("hotel_address");
	    var hotelAddress = addressElement.innerText;
	
	    geocodeAddress(hotelAddress, function(lng, lat) {
	        if (lng && lat) {
	            var mapOption = {
	                center: new kakao.maps.LatLng(lat, lng), // 초기 중심 좌표
	                level: 3 // 지도의 확대 레벨
	            };
	            
	            var map = new kakao.maps.Map(mapContainer, mapOption);
	
	            var markerPosition = new kakao.maps.LatLng(lat, lng);
	            var marker = new kakao.maps.Marker({
	                position: markerPosition
	            });
	            marker.setMap(map);
	        } else {
	            console.log('주소 변환 실패');
	        }
	    });
	}
	
	function geocodeAddress(hotelAddress, callback) {
	    var geocoder = new kakao.maps.services.Geocoder();
	    geocoder.addressSearch(hotelAddress, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            callback(result[0].x, result[0].y);
	        } else {
	            console.log('Geocoding failed: ' + status);
	            callback(null, null);
	        }
	    });
	}

	
	
	let sessionUserId = null;
	
	//로그인 상태 확인
	function getUserId() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				if (response.result == "success") {
					
					sessionUserId = response.userId;
				}
			}
		}
		
		xhr.open("get", "/travel/getUserId", false);
		xhr.send();
	}

	
	const hotelId = new URLSearchParams(location.search).get("hotel_id");
	
	// 선택된 체크인, 체크아웃 날짜 리턴 함수 
	function getSelectedDates() {
		
		const checkInDateId = document.getElementById("checkInDate");
		const checkOutDateId = document.getElementById("checkOutDate");
		
		
		const checkInDate = new Date(checkInDateId.value);
		const checkOutDate = new Date(checkOutDateId.value);
	
		  
		return { checkInDate, checkOutDate };
		
	}
	
	// 숙소 일일 예약금 변수 초기화
	let reservationFeePerDay;
	
	// ajax 숙소 일일가격 호출 함수
	function getReservationFeePerDay() {
		
		const xhr = new XMLHttpRequest();
		  
		  xhr.onreadystatechange = function() {
			  
			  if(xhr.readyState == 4 && xhr.status == 200) {
				  
				  const response = JSON.parse(xhr.responseText);
				  
				  reservationFeePerDay = response.hotel.hotelDto.hotel_price;
				  
			  }
		  }
		  
		  xhr.open("get", "./getHotel?hotel_id=" + hotelId);
		  xhr.send();
	}
	
	let numDays = 0;
	
	// 예약금 총합 계산 함수
	function calculateReservationTotal() {
		  const { checkInDate, checkOutDate } = getSelectedDates();

		  const millisecondsPerDay = 24 * 60 * 60 * 1000;
		  
		  const checkInTime = checkInDate.getTime();
		  const checkOutTime = checkOutDate.getTime();

		  const timeDiff = checkOutTime - checkInTime;

		  numDays = Math.round(timeDiff / millisecondsPerDay);
		  
		  let numPeople = parseInt(numberOfPeople.innerText);
		  
		  const totalReservationFee = reservationFeePerDay * numDays * numPeople;
		  
		  return totalReservationFee;
		}
	
	// 예약금 총합 출력 함수
	function displayReservationTotal() {
		
	  const reservationTotal = calculateReservationTotal();
	  	  
	  const reservationTotalElement = document.getElementById("reservationTotal");
	  const reserveDay = document.getElementById("reserveDay");
	  
	  reserveDay.innerText = numDays
	  reservationTotalElement.innerText = reservationTotal;
	  
	  if (isNaN(reserveDay.innerText)) {
		  
		  reserveDay.innerText = 0;
		  
	  }
	  
	  if (isNaN(reservationTotalElement.innerText)) {
		  
		  reservationTotalElement.innerText = 0;
		  
	  }
		  
	}
	
	// 인원 감소 함수
	function clickDashButton() {
		
		let currentValue = parseInt(numberOfPeople.innerText);
		
		if (currentValue <= 1) {
			
			return;
		}
		
		numberOfPeople.innerText = currentValue - 1;
		
		displayReservationTotal();
	}
	
	// 인원 추가 함수
	function clickPlusButton() {
		
		let currentValue = parseInt(numberOfPeople.innerText);
		
		numberOfPeople.innerText = currentValue + 1;
		
		displayReservationTotal();
	}
	
	function reserveProcess() {
		
		if (sessionUserId == null) {
			
			return;
			
		}
		const guestNum = document.getElementById("numberOfPeople").innerText;
		const checkInDate = document.getElementById("checkInDate").value;
		const checkOutDate = document.getElementById("checkOutDate").value;
		const totalFee = document.getElementById("reservationTotal").innerText;
		
		if (checkInDate && checkOutDate == null) {
			
			return;
			
		}
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if(xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
			
			}
		}
		
		
		xhr.open("post", "./insertReservationInfo");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("hotel_id=" + hotelId + "&hotel_reservation_check_in=" + checkInDate + "&hotel_reservation_check_out=" + checkOutDate);
		
		window.location.href = "/travel/hotel/hotelPaymentPage?hotel_id=" + hotelId + "&guestNum=" + guestNum + "&checkInDate=" + checkInDate + "&checkOutDate=" + checkOutDate + "&totalFee=" + totalFee + "&numDays=" + numDays;
	}

		  
		  
	
	window.addEventListener("DOMContentLoaded", function() {
		
		getUserId()
		
		const checkInDateId = document.getElementById("checkInDate");
		const checkOutDateId = document.getElementById("checkOutDate");
		const numberOfPeople = document.getElementById("numberOfPeople");
		const reserveDay = document.getElementById("reserveDay");
		  
		numberOfPeople.innerText = 1;
		
		checkInDateId.addEventListener("change", displayReservationTotal);
		checkOutDateId.addEventListener("change", displayReservationTotal);
		
		getReservationFeePerDay();
		displayReservationTotal();
		
	});

	
</script>

<style>

	body {
		font-family: 'Noto Sans KR', sans-serif;	
	}
	
    .hostImage {
        width: 54px;
        height: 54px;
        border-radius: 50%;
        overflow: hidden;
    }

     .hostImage2 {
        width: 62px;
        height: 62px;
        border-radius: 50%;
        overflow: hidden;
    }
    .reserveButton {
        width: 100%;
        height: 100%;
        background-image: linear-gradient(98deg,#03c75a,#38a877);
        border-radius: 10px;
        border: none;
        padding: 0.8em;
        color: rgb(255, 255, 255);
        font-weight: 500;
        font-size: 1em;
    }
    
    .reserveButton:hover {
        background-image: linear-gradient(98deg,#1e9f58,#0e8a69);
    }
    
    .commentProfileImage {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        overflow: hidden;
    }
    .commentButton {
        width: auto;
        height: auto;
        border-radius: 10px;
        border: solid black 1px;
        font-weight: 500;
        font-size: 0.9em;
        background-color: rgb(255, 255, 255);
        padding: 10px 20px;
    }
    .reserveCard {
        width: auto;
        height: auto;
        border: solid rgb(218, 218, 218) 1px;
        border-radius: 15px;
        background: #ffffff;
        box-shadow: 0px 6px 9px rgba(0, 0, 0, 0.18);
        padding: 2em 1.5em;
    }
    
    .imageButton {
     	width: auto;
        height: auto;
        border-radius: 10px;
        border: solid black 1px;
        font-weight: 500;
        font-size: 0.9em;
        background-color: rgb(255, 255, 255);
        padding: 10px 20px;
    }
    
    /* 숙소 제목 스타일 */
    .hotelTitleBox {
    	font-size: 1.7em; 
    	font-weight: 600;
    }
    
    /* 숙소 보조 스타일1 */
    .hotelSubTitleBox1 {
    	font-size: 0.9em; 
    	font-weight: 500;
    }
    
    .hotelSubTitleBox2 {
    	font-size: 0.9em; 
    }
    
    /* 이미지 스타일 */
    .mainImgBox {
    	width: 100%;
    	height: 32em;
    }
    
    .subImgBox {
    	width: 100%;
    	height: 16em;
    }
</style>
</head>

<body>
    
<div class="container">

	<div class="row fw-bold justify-content-center">
			<div class="col-10">
				<nav class="navbar navbar-expand-lg bg-body-tertiary">
					<div class="container-fluid p-0">
						<span class="fw-bold navbar-brand mb-0 h1" style="font-size: 30px; font-weight: 700;"> TripStation</span>
						<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav me-auto mb-2 mb-lg-0">
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

    <div class="row mt-4 justify-content-center">
        <div class="col-10">
<!--숙소 제목 및 정보들입니다.-->        
            <div class="row">
                <div class="col">
                    <span class="hotelTitleBox">${hotelMap.hotelDto.hotel_title }</span>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-auto pe-1">
                    <i class ="bi bi-star-fill" style="font-size: 0.85em;"></i>
                </div>
                <div class="col-auto px-0">
                	<c:choose>
	                	<c:when test="${!empty hotelAvgReviewPoint}">
	                		<span class="hotelSubTitleBox1">
	                			 ${hotelAvgReviewPoint}
	                		</span>
	                	</c:when>
	                	<c:otherwise>
	                		<span class="hotelSubTitleBox1">0.0</span>
	                	</c:otherwise>
                	</c:choose>
                </div>
                <div class="col-auto px-1">
                    <span class="hotelSubTitleBox1">∙후기</span>
                    <c:choose>
                    	<c:when test="${!empty hotelReviewPoint}">
                    		<span class="hotelSubTitleBox1" style="font-size: 0.85em;">${hotelReviewPoint}</span>
                    	</c:when>
                    	<c:otherwise>
                    		<span class="hotelSubTitleBox1">아직없음</span>
                    	</c:otherwise>
                    </c:choose>
                </div>
                <div class="col-auto">
                    <span id="hotel_address" class="hotelSubTitleBox2">${hotelMap.hotelDto.hotel_address}</span>
                </div>
                <div class="col px-0 d-flex justify-content-end">
                    <span class="hotelSubTitleBox1">공유하기</span>
                </div>
                <div class="col-auto d-flex">
                    <span class="hotelSubTitleBox1">저장</span>
                </div>
            </div>
<!--이미지를 불러옵니다.-->            
            <div class="row mb-5">
                <div class="col">
                    <img src="/uploadFiles/hotelMainImage/${hotelMap.hotelDto.hotel_main_image }" alt="" class="mainImgBox">
                </div>
                <div class="col">
                    <div class="row row-cols-2">
                    	<c:forEach items="${hotelImageDetailsDtoList}" var="list" begin="0" end="3">
	                        <div class="col">
	                            <img src="/uploadFiles/hotelDetailImages/${list.hotelImageDetailsDto.hotel_image_details_link }" alt="" class="subImgBox">
	                        </div>
                    	</c:forEach>             
                    </div>
                </div>
            </div>
<!--숙소 호스팅 관련 옵션 소개란입니다.-->            
            <div class="row">
                <div class="col-7">
                    <div class="row">
                        <div class="col-auto">
                            <div class="row">
                                <div class="col-auto pe-1">
                                    <span style="font-size: 1.3em; font-weight: 500;">${hotelMap.userDto.user_nickname }</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 1.3em; font-weight: 500;">님이 호스팅하는 숙소</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <span style="font-size: 0.85em;">최대 인원${hotelMap.hotelDto.hotel_limit_number }명</span>
                                </div>
                                <div class="col-auto px-1">
                                    <span>∙</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 0.85em;">침실${hotelMap.hotelDto.hotel_bedRoom }개</span>
                                </div>
                                <div class="col-auto px-1">
                                    <span>∙</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 0.85em;">침대${hotelMap.hotelDto.hotel_bed }개</span>
                                </div>
                                <div class="col-auto px-1">
                                    <span>∙</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 0.85em;">욕실${hotelMap.hotelDto.hotel_bathRoom }개</span>
                                </div>
                            </div>
                        </div>
                        <div class="col d-flex justify-content-end">
                            <img class="hostImage" src="/uploadFiles/profileImage/${hotelMap.userDto.user_image }" alt="">
                        </div>
                    </div>
                    <hr class="my-4">
<!--숙소 소개입니다.-->                    
                    <div class="row mb-4">
                        <div class="col-auto">
                            <i class="bi bi-door-closed" style="font-size: 1.6em;"></i>
                        </div>
                        <div class="col-auto">
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 0.9em; font-weight: 500;">셀프 체크인</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 0.85em; color: gray;">키패드를 이용해 체크인하세요.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-auto">
                            <i class="bi bi-trophy" style="font-size: 1.6em;"></i>
                        </div>
                        <div class="col-auto ps-0">
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <span style="font-size: 0.9em; font-weight: 500;">${hotelMap.userDto.user_nickname }</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 0.9em; font-weight: 500;">님은 슈퍼호스트입니다</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 0.85em; color: gray;">편안히 머무를 수 있도록 최선을 다하는 호스트입니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-auto">
                            <i class="bi bi-geo-alt" style="font-size: 1.6em;"></i>
                        </div>
                        <div class="col-auto">
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 0.9em; font-weight: 500;">훌륭한 숙소 위치</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 0.85em; color: gray;">최근 숙박한 게스트중 100%가 별점 5점을 준 숙소입니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="my-4">
<!--숙소 정보입니다.-->                    
                    <div class="row my-5">
                        <div class="col">
                            <span style="font-size: 0.9em;">
                                ${hotelMap.hotelDto.hotel_content}
                            </span>
                        </div>
                    </div>
                    <hr class="my-4">
<!--숙소 편의시설입니다.-->                    
                    <div class="row mb-3">
                        <div class="col">
                            <span style="font-size: 1.3em; font-weight: 500;">숙소 편의시설</span>
                        </div>
                    </div>
                    <div class="row row-cols-2">
                       	<c:forEach items="${hotelFacilityList}" var="hotelFacilityList" begin="0" end="7">
	                        <div class="col py-2">
	                            <div class="row align-items-center">
	                                <div class="col-auto">
	                                	<img alt="" src="/uploadFiles/hotelFacilityIcon/${hotelFacilityList.hotelFacilityDto.hotel_facility_image}" style="width: 23px;">
	                                </div>
	                                <div class="col ps-0">
	                                    <span style="font-size: 0.9em;">${hotelFacilityList.hotelFacilityDto.hotel_facility_name}</span>
	                                </div>
	                            </div>
	                        </div>
                        </c:forEach>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                        	<c:if test="${hotelFacilityCount > 6}">
                            <button class="commentButton">편의시설 ${hotelFacilityCount}개 모두 보기</button>
                            </c:if>
                        </div>
                    </div>
                </div>
<!--예약 기능이 들어있는 카드입니다.-->                
                <div class="col d-flex justify-content-end ps-5">
                    <div class="row">
                        <div class="col">
                            <div class="reserveCard">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col-auto pe-0">
                                                <span style="font-size: 1.4em; font-weight: 600;">\</span>
                                            </div>
                                            <div class="col px-0">
                                                <span style="font-size: 1.4em; font-weight: 600;">
                                                	<fmt:formatNumber pattern="#,###" value="${hotelMap.hotelDto.hotel_price }" var="price"/>${price }
                                                </span>
                                                <span style="font-size: 1em;">/박</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <div class="row">
                                            <div class="col pe-1">
                                                <i class ="bi bi-star-fill" style="font-size: 0.9em;"></i>
                                            </div>
                                            <div class="col-auto px-0">
                                            	<c:choose>
                                            		<c:when test="${!empty hotelAvgReviewPoint}">
                                            			<span style="font-size: 0.9em; font-weight: 500;">
                                                			${hotelAvgReviewPoint}
                                                		</span>
                                            		</c:when>
                                            		<c:otherwise>
                                            			<span style="font-size: 0.9em; font-weight: bold;">
                                                			0.0
                                                		</span>
                                            		</c:otherwise>
                                            	</c:choose>
                                            </div>
                                            <div class="col-auto px-0">
                                                <span>∙</span>
                                            </div>
                                            <div class="col-auto px-0">
                                                <span style="font-size: 0.85em; color: gray;">∙후기</span>
                                            </div>
                                            <div class="col-auto ps-0">
                                            	<c:choose>
                                            		<c:when test="${!empty hotelReviewPoint}">
                                            			<span style="font-size: 0.85em; color: gray;">
                                                			${hotelReviewPoint}
                                                		</span>
                                            		</c:when>
                                            		<c:otherwise>
                                            			<span style="font-size: 0.85em; color: gray;">
                                                			없음
                                                		</span>
                                            		</c:otherwise>
                                            	</c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row my-3">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col-6">
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <span style="font-size: 0.7em; font-weight: 500;">체크인</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <input type="date" class="form-control" id="checkInDate" min="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_start_date}" pattern="yyyy-MM-dd" />" max="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_end_date}" pattern="yyyy-MM-dd" />">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <span style="font-size: 0.7em; font-weight: 500;">체크아웃</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <input type="date" class="form-control" id="checkOutDate" min="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_start_date}" pattern="yyyy-MM-dd" />" max="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_end_date}" pattern="yyyy-MM-dd" />">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mt-1">
                                            <div class="col-auto">
                                                <span style="font-size: 0.7em; font-weight: 500;">인원</span>
                                            </div>
                                        </div>
                                        <div class="row py-1 align-items-center">
                                            <div class="col-auto">
                                                <i onclick="clickDashButton()" class="bi bi-dash-lg" style="font-size: 1em;"></i>
                                            </div>
                                            <div class="col-auto">
                                                <span id="numberOfPeople" style="color: gray;"></span>
                                            </div>
                                            <div class="col-auto">
                                                <i onclick="clickPlusButton()" class="bi bi-plus-lg" style="font-size: 1em;"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <button onclick="reserveProcess()" class="reserveButton">예약하기</button>
                                    </div>
                                </div>
                                <div class="row py-2">
                                    <div class="col px-3 text-center">
                                        <span style="font-size: 0.8em;">예약 확정 전에는 요금이 청구되지 않습니다.</span>
                                    </div>
                                </div>
                                <div class="row py-2" style="font-size: 1em; ">
                                    <div class="col-auto pe-0">
                                        <span >\</span>
                                    </div>
                                    <div class="col-auto px-0">
                                        <span>
                                        	<fmt:formatNumber pattern="#,###" value="${hotelMap.hotelDto.hotel_price }" var="price"/>${price }
                                        </span>
                                    </div>
                                    <div class="col-auto px-1">
                                        <span>x</span>
                                    </div>
                                    <div class="col-auto px-0">
                                        <span id="reserveDay">1</span>
                                    </div>
                                    <div class="col-auto ps-0">
                                        <span>박</span>
                                    </div>
                                    <div class="col d-flex justify-content-end" >
                                        <div class="row">
                                            <div class="col px-0">
                                                <span >\</span>
                                            </div>
                                            <div class="col-auto ps-0">
                                                <span>
                                                	<fmt:formatNumber pattern="#,###" value="${hotelMap.hotelDto.hotel_price }" var="price"/>${price }
                                               	</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row py-2" style="font-size: 1em;">
                                    <div class="col">
                                        <span style="text-decoration: underline;">트립스테이션 서비스 수수료</span>
                                    </div>
                                    <div class="col-auto">
                                        <span>무료</span>
                                    </div>
                                </div>
                                <hr class="my-3">
                                <div class="row" style="font-size: 1.1em; font-weight: 500;">
                                    <div class="col text-start">
                                        <span>총 합계</span>
                                    </div>
                                    <div class="col px-0 text-end">
                                        <span>\</span>
                                    </div>
                                    <div class="col-auto ps-0">
                                    	<span id="reservationTotal"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<!--별점 및 후기-->
            <hr class="my-5">
            <div class="row align-items-center">
                <div class="col-auto pe-1">
                    <i class ="bi bi-star-fill" style="font-size: 1.1em;"></i>
                </div>
                <div class="col-auto px-0">
                	<c:choose>
                		<c:when test="${!empty hotelAvgReviewPoint}">
                			 <span style="font-size: 1.3em; font-weight: 500;">${hotelAvgReviewPoint}</span>
                		</c:when>
	                	<c:otherwise>
	                		 <span style="font-size: 1.3em; font-weight: 500;">0.0</span>
	                	</c:otherwise>
                	</c:choose>
                </div>
                <div class="col-auto px-1">
                    <span style="font-size: 20px; font-weight: bold;">∙후기</span>
                    <c:choose>
                    	<c:when test="${!empty hotelReviewPoint}">
                    		<span style="font-size: 1.3em; font-weight: 500;">${hotelReviewPoint}</span>
                    	</c:when>
                    	<c:otherwise>
                    		<span style="font-size: 1.3em; font-weight: 500;">아직없음</span>
                    	</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="row row-cols-2 my-4">
            	<c:forEach items="${hotelReviewDtoList}" var="list">
	                <div class="col mb-4">
	                    <div class="row align-items-center">
	                        <div class="col-auto">
	                            <img src="/uploadFiles/profileImage/${list.userDto.user_image }" alt="" class="commentProfileImage">
	                        </div>
	                        <div class="col px-0">
	                            <div class="row">
	                                <div class="col">
	                                    <span style="font-size: 1em; font-weight: 500;">${list.userDto.user_nickname }</span>
	                                </div>
	                            </div>
	                            <div class="row">
	                                <div class="col">
	                                    <span style="font-size: 0.85em; color: gray;">2023년 7월</span>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="row mt-2">
	                        <div class="col">
	                            <span>${list.hotelReviewDto.hotel_review_content}</span>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
            <div class="row">
                <div class="col">
               		<c:if test="${hotelReviewPoint > 6}">
               			<button class="commentButton"><span>${hotelReviewPoint}개 모두보기</span></button>
               		</c:if>
                </div>
            </div>
            <hr class="my-5">
<!--호스팅 지역-->            
            <div class="row mb-4">
                <div class="col">
                    <span style="font-size: 1.3em; font-weight: 500;">호스팅 지역</span>
                </div>
            </div>
            <div class="row pb-2">
                <div class="col">
                    <div id="map" style="width:100%; height: 32em;"></div>
                </div>
            </div>
            <div class="row mt-2">
            	<div class="col">
            		<span style="font-size: 0.85em; font-weight: 500;">${hotelMap.hotelDto.hotel_address}</span>
            	</div>
            </div>
            <hr class="my-5">
<!--호스트 정보-->            
            <div class="row align-items-center">
                <div class="col-auto">
                    <img src="/uploadFiles/profileImage/${hotelMap.userDto.user_image }" alt="" class="hostImage2">
                </div>
                <div class="col ps-0">
                    <div class="row">
                        <div class="col-auto pe-1">
                            <span style="font-size: 1.2em; font-weight: 500;">호스트:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 1.2em; font-weight: 500;">${hotelMap.userDto.user_nickname }</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-auto pe-1">
                            <span style="font-size: 0.85em; color: gray;">회원 가입일:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 0.85em; color: gray;">2020년 5월</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row my-4 align-items-center">
                <div class="col-auto">
                    <i class="bi bi-star-fill" style="font-size: 0.85em;"></i>
                </div>
                <div class="col-auto ps-0 pe-1">
                    <span style="font-size: 0.85em;">후기</span>
                </div>
               	<c:choose>
                	<c:when test="${!empty hotelReviewPoint}">
               			<div class="col-auto px-0">
		                    <span style="font-size: 0.85em;">${hotelReviewPoint}</span> 
                		</div>
		                <div class="col-auto px-0">
		                    <span style="font-size: 0.85em;">개</span>
		                </div>
	                </c:when>
	                	<c:otherwise>
	                		<div class="col-auto px-0">
		                		<span style="font-size: 0.85em;">아직 없음</span>	                		
	                		</div>
	                	</c:otherwise>
                	</c:choose>
                <div class="col-auto">
                    <i class="bi bi-shield-fill-check" style="font-size: 14px;"></i>
                </div>
                <div class="col-auto px-0">
                    <span style="font-size: 0.85em;">본인 인증 완료</span>
                </div>
                <div class="col-auto">
                    <i class="bi bi-trophy-fill" style="font-size: 0.85em;"></i>
                </div>
                <div class="col px-0">
                    <span style="font-size: 0.85em;">슈퍼호스트</span>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <span style="font-size: 0.95em;">
                        은퇴 후 안동에 귀향하여 우리의 전통한옥을 사랑하고 연구하며 알리는 사람입니다.
                        좌우명
                        미소짓고
                        인사하고
                        대화하고
                        칭찬하자.
                        우리의 한옥에서 전세계 게스트를 통하여 한옥을 글로벌화 시키고자 합니다.
                    </span>
                </div>
            </div>
            <hr class="my-5">
<!--알아두어야 할 사항-->
            <div class="row mb-3">
                <div class="col">
                    <span style="font-size: 1.3em; font-weight: 500;">알아두어야 할 사항</span>
                </div>
            </div>
            <div class="row mb-5">
                <div class="col">
                    <div class="row">
                        <div class="col">
                            <span style="font-size: 1em; font-weight: 500;">숙소 이용규칙</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-auto pe-1">
                            <span style="font-size: 0.85em;">체크인 가능 시간:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 0.85em;">오후 ${hotelMap.hotelDto.hotel_check_in_time }:00 이후</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-auto pe-1">
                            <span style="font-size: 0.85em;">체크아웃 가능 시간:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 0.85em;">오전 ${hotelMap.hotelDto.hotel_check_out_time}:00 전까지</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-auto pe-1">
                            <span style="font-size: 0.85em;">게스트 정원</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 0.85em;">${hotelMap.hotelDto.hotel_limit_number }명</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="row">
                        <div class="col">
                            <span style="font-size: 1em; font-weight: 500;">안전 및 숙소</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <span style="font-size: 0.85em;">일산화탄소 경보기</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <span style="font-size: 0.85em;">화재경보기</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="row">
                        <div class="col">
                            <span style="font-size: 1em; font-weight: 500;">환불 정책</span>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col">
                        	<span id="checkInDay" style="font-size: 0.85em;"></span>
                            <span style="font-size: 0.85em;">오후 12:00</span>
                            <span style="font-size: 0.85em;">전에 취소하면 부분 환불을 받으실수 있습니다.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container" >
    <div class="row justify-content-center">
        <div class="col-10" style="background-color: #ededed;">
            <div class="row mt-4">
                <div class="col">
                    <div class="row">
                        <div class="col-auto">
                            <span style="font-size: 0.8em;">
                                © 2023 TripStation, Inc. · 개인정보 처리방침  · 이용약관  · 사이트맵  · 환불 정책  · 회사 세부정보
                            </span>
                        </div>
                        <div class="col d-flex justify-content-end">
                            <i class="bi bi-instagram"></i>
                            <i class="bi bi-twitter px-3"></i>
                            <i class="bi bi-envelope"></i>
                        </div>
                    </div>
                    <hr class="my-2">
                </div>
                <div class="col"></div>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <span style="font-size: 0.5em; color: gray;">
                        웹사이트 제공자: Tripstation Ireland KOREA, private unlimited company, 8 Hanover Quay Dublin 2, D02 DP23 Ireland | 이사: hoyeong shin | VAT 번호: IE982232384L | 사업자 등록 번호: IE 123125 | 연락처: terms@tripstation.com, 웹사이트, 080-822-0230 | 호스팅 서비스 제공업체: 아마존 웹서비스 | 트립스테이션은 통신판매 중개자로 트립스테이션 플랫폼을 통하여 게스트와 호스트 사이에 이루어지는 통신판매의 당사자가 아닙니다. 트립스테이션 플랫폼을 통하여 예약된 숙소, 체험, 호스트 서비스에 관한 의무와 책임은 해당 서비스를 제공하는 호스트에게 있습니다.
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</body>
</html>