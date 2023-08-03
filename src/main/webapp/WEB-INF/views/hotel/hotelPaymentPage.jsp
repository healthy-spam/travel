<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<script type="text/javascript">

const hotelId = new URLSearchParams(location.search).get("hotel_id");

function returnPage() {
	
	window.location.href = "/travel/hotel/hotelDetailPage?hotel_id=" + hotelId
}
</script>
<style>

	body {
		font-family: 'Noto Sans KR', sans-serif;	
	}

    .reserveCard {
        width: auto;
        height: auto;
        border: solid rgb(218, 218, 218) 1px;
        border-radius: 15px;
        background: #ffffff;
        box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.2);
        padding: 20px 20px;
    }

    .imgCard {
        width: 6.5em;
        height: 5em;
        border: none;
        border-radius: 5px;
    }

    .reserveButton {
	    width: 100%;
	    height: 100%;
	    background-image: linear-gradient(30deg,#00b078,#00b067);
	    border-radius: 10px;
	    border: none;
	    padding: 10px 20px;
	    color: rgb(255, 255, 255);
	    font-weight: 500;
	    font-size: 1.2em;
	}
        
</style>
</head>
<body>

<div class="container">
	
	<div class="row fw-bold justify-content-center">
			<div class="col-auto"></div>
			<div class="col-11">
				<nav class="navbar navbar-expand-lg bg-body-tertiary">
					<div class="container p-0">
						<img class="navbar-brand" src="/travel/resources/img/tripstationLOGO.png" style="width: 7em;">
						<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav mb-2 mb-lg-0">
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
									<ul class="navbar-nav align-items-center ms-auto">
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
											<a class="nav-link dropdown-toggle pe-0" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> ${sessionuser.user_nickname} </a>
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

    <div class="row mt-3 justify-content-center">
        <div class="col-auto">
            <div class="row mt-1">
                <div class="col pe-0">
                    <div onclick="returnPage()">
                        <i style="font-size: 1.3em;" class="bi bi-chevron-left"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-11">
             <!-- 확인 및 결제 -->
            <div class="row mb-4">
                <div class="col">
                    <span style="font-size: 1.8em; font-weight: 500;">확인 및 결제</span>
                </div>
            </div>
            <div class="row mb-5">
                <div class="col-6">
                    <div class="row">
                        <!-- 결제정보란 -->
                        <div class="col">                
                            <!-- 예약 정보 -->
                            <div class="row my-3">
                                <div class="col">
                                    <span style="font-size: 1.4em; font-weight: 500;">예약 정보</span>
                                </div>
                            </div>
                            <!-- 날짜 -->
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 1em; font-weight: 500;">날짜</span>
                                </div>
                                <div class="col text-end">
                                    <span style="font-size: 0.9em; font-weight: 500;">수정</span>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col">
                                    <span style="font-size: 0.9em;"><fmt:formatDate value="${formatCheckInDate }" pattern="M월 d일"/>~<fmt:formatDate value="${formatCheckOutDate }" pattern="d일"/></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 1em; font-weight: 500;">게스트</span>
                                </div>
                                <div class="col text-end">
                                    <span style="font-size: 0.9em; font-weight: 500;">수정</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 0.9em;">게스트 ${guestNum}명</span>
                                </div>
                            </div>
                            <hr class="my-4">
                            <!-- 환불정책 -->
                            <div class="row pb-3">
                                <div class="col">
                                    <span style="font-size: 1.4em; font-weight: 500;">환불정책</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <span style="font-size: 0.9em; font-weight: 500;">
	                                    <c:set var="currentDate" value="<%= new java.util.Date() %>" />
	    								<fmt:formatDate value="${currentDate}" pattern="M월 d일" />
                                    </span>
                                </div>
                                <div class="col-auto ps-0">
                                    <span style="font-size: 0.9em; font-weight: 500;">
                                        오후 2:00 전까지 무료로 취소하실 수 있습니다.
                                    </span>
                                </div>
                                <div class="col-auto">
                                    <span style="font-size: 0.9em;">
                                        체크인 날짜인 <fmt:formatDate value="${formatCheckInDate }" pattern="M월 d일"/> 전에 취소하면 부분 환불을 받으실 수 있습니다.
                                    </span>
                                </div>
                            </div>
                            <hr class="my-4">
                            <!-- 기본 규칙 -->
                            <div class="row pb-3">
                                <div class="col">
                                    <span style="font-size: 1.4em; font-weight: 500;">기본 규칙</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col mb-2">
                                    <span style="font-size: 0.9em;">
                                        훌륭한 게스트가 되기 위한 몇 가지 간단한 규칙을 지켜주실 것을 모든 게스트에게 당부드리고 있습니다. 
                                    </span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <span style="font-size: 0.9em;">
                                        •                                  
                                    </span>
                                </div>
                                <div class="col ps-1">
                                    <span style="font-size: 0.9em;">
                                        숙소 이용규칙을 준수하세요.                                    
                                    </span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <span style="font-size: 0.9em;">
                                        •                                  
                                    </span>
                                </div>
                                <div class="col ps-1">
                                    <span style="font-size: 0.9em;">
                                        호스트의 집도 자신의 집처럼 아껴주세요.                               
                                    </span>
                                </div>
                            </div>
                            <hr class="my-4">
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 0.8em; color: gray;">아래 버튼을 선택하면 호스트가 설정한 숙소 이용규칙, 게스트에게 적용되는 기본 규칙, 에어비앤비 재예약 및 환불 정책에 동의하며, 피해에 대한 책임이 본인에게 있을 경우 트립스테이션이 결제 수단으로 청구의 조치를 취할 수 있다는 사실에 동의하는 것입니다.</span>
                                </div>
                            </div>
                            <div class="row my-4">
                                <div class="col">
                                    <button class="reserveButton">확인 및 결제</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 결제카드 박스 -->
                <div class="col-5 ps-5 content-end">
                    <div class="row mt-3">
                        <div class="col">
                            <div class="reserveCard">	
                                <!-- 사진 -->
                                <div class="row">
                                    <div class="col-auto pe-0">
                                        <img class="imgCard" src="/uploadFiles/hotelMainImage/${hotelMap.hotelDto.hotel_main_image}" alt="">
                                    </div>
                                    <div class="col-auto">
                                        <div class="row">
                                            <div class="col">
                                                <span class="align-text-top" style="font-size: 0.8em; color: gray;">
                                                	${hotelMap.hotelDto.hotel_category}
                                                </span>
                                            </div>
                                        </div>
                                        <div class="row" style="position: relative; top: 0.35em;">
                                            <div class="col">
                                                <span class="align-text-top" style="font-size: 0.85em;">
                                                	${hotelMap.hotelDto.hotel_title}
                                                </span>
                                            </div>
                                        </div>
                                        <div class="row" style="position: relative; top: 0.7em;">
                                            <div class="col-auto pe-1">
                                                <i style="font-size: 0.7em;" class="bi bi-star-fill"></i>
                                            </div>
                                            <div class="col-auto px-0">
                                                <span style="font-size: 0.8em;">
                                                	${avgPointOfReview}
                                                </span>
                                            </div>
                                            <div class="col-auto px-0">
                                                <span style="font-size: 0.8em; color: gray;">(후기 ${countOfReview}개)</span>
                                            </div>
                                            <div class="col-auto px-1">
                                                <span style="font-size: 0.8em;">•</span>
                                            </div>
                                            <div class="col-auto ps-0">
                                                <span style="font-size: 0.8em; color: gray;">슈퍼호스트</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4">
                                    <!-- 요금 세부정보 -->
                                    <div class="row">
                                        <div class="col">
                                            <span style="font-size: 1.15em; font-weight: 500;">요금 세부정보</span>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-auto pe-0">
                                            <img style="width: 100%; height: 0.8em; margin-bottom: 0.2em;" alt="" src="/travel/resources/img/pngegg.png/">
                                        </div>
                                        <div class="col-auto px-0">
                                            <span style="font-size: 0.9em;">
                                            	${hotelMap.hotelDto.hotel_price }
                                            </span>
                                        </div>
                                        <div class="col-auto px-1">
                                            <span style="font-size: 0.9em;">x</span>
                                        </div>
                                        <div class="col-auto px-0">
                                            <span style="font-size: 0.9em;">
                                 				${numDays }
                                            </span>
                                        </div>
                                        <div class="col-auto ps-0">
                                            <span style="font-size: 0.9em;">박</span>
                                        </div>
                                        <div class="col-auto ms-auto pe-0">
                                            <img style="width: 100%; height: 0.8em; margin-bottom: 0.2em;" alt="" src="/travel/resources/img/pngegg.png/">
                                        </div>
                                        <div class="col-auto ps-0">
                                            <span style="font-size: 0.9em;">
                                            	${totalFee }
                                            </span>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-auto pe-0">
                                            <span style="font-size: 0.9em;">
                                                트립스테이션 서비스 수수료
                                            </span>
                                        </div>
                                        <div class="col text-end">
                                            <span style="font-size: 0.9em;">무료</span>
                                        </div>
                                    </div>
                                    <hr class="my-4">
                                    <!-- 합계 금액 -->
                                    <div class="row my-1">
                                        <div class="col-auto pe-0">
                                            <span style="font-size: 1.15em; font-weight: 500;">총 합계</span>
                                        </div>
                                        <div class="col ps-0">
                                            <span style="font-size: 1.15em; font-weight: 500;">(KRW)</span>
                                        </div>
                                        <div class="col-auto text-end pe-0">
                                            <img style="width: 100%; height: 1.1em; " alt="" src="/travel/resources/img/pngegg.png/">
                                        </div>
                                        <div class="col-auto text-end ps-0">
                                            <span style="font-size: 1.15em; font-weight: 600;">
                                            	${totalFee }
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<div class="container-fluid" style="background-color: #ededed;" >
    <div class="row">
        <div class="col" style="padding-left: 5em; padding-right: 9em;">
            <div class="row mt-4">
                <div class="col"></div>
                <div class="col-10">
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
                <div class="col"></div>
                <div class="col-10">
                    <span style="font-size: 0.5em; color: gray;">
                        웹사이트 제공자: Tripstation Ireland KOREA, private unlimited company, 8 Hanover Quay Dublin 2, D02 DP23 Ireland | 이사: hoyeong shin | VAT 번호: IE982232384L | 사업자 등록 번호: IE 123125 | 연락처: terms@tripstation.com, 웹사이트, 080-822-0230 | 호스팅 서비스 제공업체: 아마존 웹서비스 | 트립스테이션은 통신판매 중개자로 트립스테이션 플랫폼을 통하여 게스트와 호스트 사이에 이루어지는 통신판매의 당사자가 아닙니다. 트립스테이션 플랫폼을 통하여 예약된 숙소, 체험, 호스트 서비스에 관한 의무와 책임은 해당 서비스를 제공하는 호스트에게 있습니다.
                    </span>
                </div>
                <div class="col"></div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
    crossorigin="anonymous"></script>

</body>
</html>