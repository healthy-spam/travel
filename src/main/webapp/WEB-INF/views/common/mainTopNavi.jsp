<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row fw-bold">
	<div class="col">
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
			<div class="container-fluid">
				<span class="fw-bold navbar-brand mb-0 h1" style="font-size: 30px; font-weight: 700;"> TripStation</span>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" aria-current="page"
							data-bs-toggle="dropdown" href="/travel/main"
							aria-expanded="false">여행</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/travel/main">맞춤여행</a></li>
								<li><a class="dropdown-item" href="/travel/package">패키지</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="/travel/plan/planPage">플래너</a></li>
						<li class="nav-item"><a class="nav-link" href="/travel/hotel/hotelPage" role="button">숙소</a></li>
						<li class="nav-item"><a class="nav-link" href="#">이벤트</a></li>
						<li class="nav-item"><a class="nav-link" href="/travel/admin/registedCityPage">관리자</a></li>
						<li class="nav-item"><a class="nav-link" href="/travel/planPlace/placePage">플레이스</a></li>
					</ul>
					<c:choose>
						<c:when test="${!empty sessionuser}">
							<div class="nav-item dropdown">
								<a class="nav-link dropdown-toggle me-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: black;"> ${sessionuser.user_nickname} </a>
								<ul class="dropdown-menu" aria-labelledby="userDropdown">
									<li><a class="dropdown-item" href="/travel/myPage">마이페이지</a></li>
									<li><a class="dropdown-item" href="/travel/crew/main">크루페이지</a></li>
									<li><a class="dropdown-item" href="/travel/allCouponPage">쿠폰</a></li>
									<li><a class="dropdown-item" href="/travel/messageGot">쪽지</a></li>
									<li><a class="dropdown-item" href="/travel/logoutProcess">로그아웃</a></li>
								</ul>
							</div>
						</c:when>
						<c:otherwise>
							<a class="btn me-1" href="/travel/login" style="height: 35px;">로그인</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</nav>
	</div>
</div>
