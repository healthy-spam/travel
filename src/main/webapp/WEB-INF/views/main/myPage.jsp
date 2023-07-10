<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>마이 페이지</title>
</head>
<body>
	<jsp:include page="../common/topNavi.jsp"></jsp:include>
	<div class="container">
		
		
		<div class="row">
			<div class="col-12">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">등록한 플래너</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">기획중 플래너</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">모집중 플래너</button>
					</li>
				</ul>
				<div class="container">
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
							<div class="row mt-3">
								<c:forEach items="${list}" var="map">
									<c:if test="${sessionuser.user_id == map.planDto.user_id && map.planDto.plan_statuse == '등록'}">
										<div class="col">
											<div class="card h-100" style="width: 12rem;">
												<div class="text-center mt-2">
													<a href="./plan/readPlanPage?id=${map.planDto.plan_id}">
														<img src="/uploadFiles/${map.planDto.plan_thumbnail}" class="card-img-top img-fluid" style="width: 150px; height: 150px;">
													</a>
												</div>
												<div class="card-body">
													<h5 class="card-title">${map.planDto.plan_title}</h5>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
							<div class="row mt-3">
								<c:forEach items="${list}" var="map">
									<c:if test="${sessionuser.user_id == map.planDto.user_id && map.planDto.plan_statuse == '기획'}">
										<div class="col">
											<div class="card h-100" style="width: 12rem;">
												<div class="text-center mt-2">
													<a href="./plan/readPlanPage?id=${map.planDto.plan_id}">
														<img src="/uploadFiles/${map.planDto.plan_thumbnail}" class="card-img-top img-fluid" style="width: 150px; height: 150px;">
													</a>
												</div>
												<div class="card-body">
													<h5 class="card-title">${map.planDto.plan_title}</h5>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
							<div class="row mt-3">
								<c:forEach items="${list}" var="map">
									<c:if test="${sessionuser.user_id == map.planDto.user_id && map.planDto.plan_statuse == '모집'}">
										<div class="col">
											<div class="card h-100" style="width: 12rem;">
												<div class="text-center mt-2">
													<a href="./plan/readPlanPage?id=${map.planDto.plan_id}">
														<img src="/uploadFiles/${map.planDto.plan_thumbnail}" class="card-img-top img-fluid" style="width: 150px; height: 150px;">
													</a>
												</div>
												<div class="card-body">
													<h5 class="card-title">${map.planDto.plan_title}</h5>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
					

			</div>
		</div>
		
	
		<div class="row">
			<div class="col d-grid">
				<button class="btn btn-primary">신청 리스트 보기</button>
			</div>
		</div>
	</div>	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>