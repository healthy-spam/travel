<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>마이 페이지</title>
<style type="text/css">
body {
	font-family: 'Noto Sans KR', sans-serif;
}

.card-title {
	border-radius: 0.5rem 0.5rem 0 0;
	font-size: 1.5em;
	padding-left: 0.5em;
	height: 2.2em;
	color: white;
	background: linear-gradient(98deg, #FF356B, #FA4673);
	display: flex;
	align-items: center;
}

.card-wrapper {
	border: 1px solid #E6E6E6;
	border-bottom: none;
	border-radius: 0.5rem 0.5rem 0 0;
}
</style>
</head>
<body>
	<div class="container" style="border-left: 1px solid #E6E6E6;">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>

		<div class="row">
			<div class="col-4" style="padding: 0 0 0 5em;">
				<div class="row">
					<div class="col">
						<div class="d-flex justify-content-center" style="height: 11em;">
							<i class="bi bi-person-circle" style="font-size: 8em; color: lightgrey;"></i>
						</div>
						<div class="d-flex justify-content-center" style="font-size: 1.5em; font-weight: 700;">${sessionuser.user_nickname}</div>
						<div class="d-flex justify-content-center text-secondary">${sessionuser.user_email}</div>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col mb-1" style="font-size: 1.5em; font-weight: 300;">
						<p>내프로필
					</div>
				</div>
				<div class="row">
					<div class="col mb-1" style="font-size: 1.5em; font-weight: 300;">
						<p>동행모집
					</div>
				</div>
				<div class="row">
					<div class="col mb-1" style="font-size: 1.5em; font-weight: 300;">
						<p>마이플랜
					</div>
				</div>
				<div class="row">
					<div class="col mb-1" style="font-size: 1.5em; font-weight: 300;">
						<p>등록숙소
					</div>
				</div>
				<div class="row">
					<div class="col mb-1" style="font-size: 1.5em; font-weight: 300;">
						<p>마이패키지
					</div>
				</div>
			</div>
			<div class="col-8 px-4">
				<div class="row my-4">
					<div class="col">
						<div class="card-wrapper">
							<div class="card-title">내프로필</div>
							<div style="padding-left: 2em; padding-right: 1em;">
								<div class="d-flex justify-content-between my-3">
									<span style="font-size: 1.1em;"> 
										<i class="bi bi-person me-2"></i>
										${sessionuser.user_nickname}
									</span>
									<button style="border: none;">수정</button>
								</div>
								<div class="d-flex justify-content-between my-3">
									<span style="font-size: 1.1em;"> 
										<i class="bi bi-phone me-2"></i> 010-1234-5678
									</span>
									<button style="border: none;">수정</button>
								</div>
								<div class="d-flex justify-content-between my-3">
									<span style="font-size: 1.1em;">
										<i class="bi bi-envelope me-2"></i>
										${sessionuser.user_email}
									</span>
									<button style="border: none;">수정</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<div class="card-wrapper">
							<div class="card-title">동행모집</div>
							<div style="padding-left: 2em; padding-right: 1em;">
								<c:forEach items="${list}" var="data">
									<div>
										<a class="d-flex justify-content-between my-3" href="#" style="text-decoration: none;">
											<span style="color: black;">[${data.planningStatus}] ${data.myPlanning.planning_title}</span>
											<fmt:parseDate var="parsedDate" value="${data.myPlanning.planning_end_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
											<span style="font-size: 0.9em; font-weight: 400; color: #A3A3A3;"><fmt:formatDate value="${parsedDate}" pattern="yyyy/MM/dd"/> 종료</span>
										</a>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<div class="card-wrapper">
							<div class="card-title">마이플랜</div>
							<div style="padding-left: 2em; padding-right: 1em;">
								<div>
									<a class="d-flex justify-content-between my-3" href="#" style="text-decoration: none;">
										<span style="color: black;">서울 여행 일정</span>
										<span style="font-size: 0.9em; font-weight: 400; color: #A3A3A3;">4 days</span>
									</a>
								</div>
								<div>
									<a class="d-flex justify-content-between my-3" href="#" style="text-decoration: none;">
										<span style="color: black;">부산 여행 일정</span>
										<span style="font-size: 0.9em; font-weight: 400; color: #A3A3A3;">7 days</span>
									</a>
								</div>
								<div>
									<a class="d-flex justify-content-between my-3" href="#" style="text-decoration: none;">
										<span style="color: black;">일본 여행 일정</span>
										<span style="font-size: 0.9em; font-weight: 400; color: #A3A3A3;">7 days</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<div class="card-wrapper">
							<div class="card-title">등록숙소</div>
							<div class="row mt-3 px-4">
								<div class="col-4">
									<div class="card">
										<img src=" https://via.placeholder.com/150x150" class="img-fluid" alt="썸네일">
										<div class="card-body">
										 	<h5>신호영 숙소1</h5>
										 </div>
									</div>
								</div>
								<div class="col-4">
									<div class="card">
										<img src=" https://via.placeholder.com/150x150" class="img-fluid" alt="썸네일">
										<div class="card-body">
										 	<h5>신호영 숙소2</h5>
										 </div>
									</div>
								</div>
								<div class="col-4">
									<div class="card">
										<img src=" https://via.placeholder.com/150x150" class="img-fluid" alt="썸네일">
										 <div class="card-body">
										 	<h5>신호영 숙소3</h5>
										 </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row my-4 pb-4">
					<div class="col">
						<div class="card-wrapper">
							<div class="card-title">마이패키지</div>
							<div class="d-flex justify-content-center mt-3">
								등록된 패키지가 없습니다.
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>		
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>