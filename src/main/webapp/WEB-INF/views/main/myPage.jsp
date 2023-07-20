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
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@100;300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>마이 페이지</title>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var fileInput = document.getElementById("fileInput");
		var imageContainer = document.querySelector(".image-container");
		var selectedFile = null; // 선택한 파일 저장 변수
		var modal = new bootstrap.Modal(
				document.getElementById("exampleModal"), {
					keyboard : false
				});
		var confirmButton = document.getElementById("confirmButton");
		
		fileInput.addEventListener("change", function() {
			selectedFile = fileInput.files[0];

			if (!selectedFile) {
				return; // 파일을 선택하지 않은 경우, 함수 종료
			}

			modal.show();
		});

		confirmButton.addEventListener("click", function() {
			modal.hide(); // 모달 창 닫기

			if (!selectedFile) {
				return; // 선택한 파일이 없는 경우, 함수 종료
			}

			var reader = new FileReader();

			reader.onload = function(e) {
				var dataURL = e.target.result;

				if (imageContainer) {
					imageContainer.src = dataURL;
				}

				var formData = new FormData();

				formData.append("file", selectedFile);

				const xhr = new XMLHttpRequest();

				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {

					}
				}

				//post
				xhr.open("post", "./insertImage");
				xhr.send(formData);
			};

			reader.readAsDataURL(selectedFile);
		});
		
		setupCollapseListeners();
	});
</script>
<script type="text/javascript">
	function setupCollapseListeners() {
		// Get all collapse elements
		const collapseElements = document
				.querySelectorAll('[id^="collapseExample"]');

		collapseElements.forEach(function(collapseElement) {
			// Add event listener for 'show' event
			collapseElement.addEventListener('show.bs.collapse', function() {
				changeIcon('iconButton' + this.id.replace('collapseExample', ''), true);
			});

			// Add event listener for 'hide' event
			collapseElement.addEventListener('hide.bs.collapse', function() {
				changeIcon('iconButton' + this.id.replace('collapseExample', ''), false);
			});
		});
	}

	function changeIcon(buttonId, isOpen) {
	    const iconButton = document.getElementById(buttonId);
	    
	    if (isOpen) {
	        iconButton.classList.remove('bi-envelope');
	        iconButton.classList.add('bi-envelope-open');
	    } else {
	        iconButton.classList.remove('bi-envelope-open');
	        iconButton.classList.add('bi-envelope');
	    }
	}
</script>
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
	background: linear-gradient(98deg, #03c75a, #49c6dd);
	display: flex;
	align-items: center;
}

.card-wrapper {
	border: 1px solid #E6E6E6;
	border-bottom: none;
	border-radius: 0.5rem 0.5rem 0 0;
}

.icon-wrapper {
	border: 0.18em solid white;
	width: 2em;
	height: 2em;
	border-radius: 50%;
	background-color: #03c75a;
	position: absolute;
	bottom: 0.3em;
	right: 7.8em;
	display: flex;
	justify-content: center;
}

.fileInput {
	width: 100%;
	height: 100%;
	border-radius: 50%;
}

.image-container {
	width: 8.2em;
	height: 8.2em;
	border-radius: 50%;
}

button {
	background: none;
}

.thumb {
	border-radius: 50%;
	width: 1.8em;
	height: 1.8em;
	margin-right: 0.5em;
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
						<div class="d-flex justify-content-center align-items-center" style="height: 9em; position: relative;">
							<img class="image-container" src="/uploadFiles/profileImage/${sessionuser.user_image}">
							<div class="icon-wrapper">
								<label for="fileInput" class="fileInput d-flex justify-content-center align-items-center">
									<i class="bi bi-pencil-fill" style="color: white; font-size: 0.7em;"></i>
								</label>
								<input type="file" id="fileInput" style="display: none;">

								<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-body">
												<p>해당 이미지로 수정하시겠습니까?</p>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
												<button type="button" class="btn" id="confirmButton" style="background-color: #03c75a; color: white;">확인</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="d-flex justify-content-center" style="font-size: 1.5em; font-weight: 700; ">${sessionuser.user_nickname}</div>
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
								<div class="d-flex justify-content-between my-2">
									<span style="font-size: 1.1em;"> 
										<i class="bi bi-person me-2"></i>
										${sessionuser.user_nickname}
									</span>
									<button style="border: none;">수정</button>
								</div>
								<div class="d-flex justify-content-between my-2">
									<span style="font-size: 1.1em;"> 
										<i class="bi bi-phone me-2"></i> 010-1234-5678
									</span>
									<button style="border: none;">수정</button>
								</div>
								<div class="d-flex justify-content-between my-2">
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
							<div class="card-title">동행모집 & 참여</div>
							<div style="padding-left: 2em; padding-right: 1em;">
								<c:choose>
									<c:when test="${empty map.list}">
										<div class="d-flex justify-content-center mt-3">
											동행 목록이 없습니다.
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach items="${map.list}" var="data">
											<div class="d-flex justify-content-between my-2">
												<a href="./plan/travelApplicationDetailPage?planning_id=${data.myPlanning.planning_id}" style="text-decoration: none;">
													<span style="color: black;">[${data.planningStatus}] ${data.myPlanning.planning_title}</span>
												</a>
												<div>
													<c:if test="${data.myPlanning.user_id == sessionuser.user_id}">
														<button type="button" style="border: none; color: #999999; font-size: 0.9em;" data-bs-toggle="modal" data-bs-target="#appList">신청 리스트</button>
													</c:if>
													<fmt:parseDate var="parsedDate" value="${data.myPlanning.planning_end_date}" pattern="yyyy-MM-dd HH:mm:ss" />
													<span style="font-size: 0.9em; font-weight: 400; color: #A3A3A3;">
													<fmt:formatDate value="${parsedDate}" pattern="yyyy/MM/dd" /> 종료</span>

													<!-- Modal -->
													<div class="modal modal-lg fade" id="appList">
														<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
															<div class="modal-content">
																<div class="modal-header">
																	<h1 class="modal-title fs-5" id="appListLabel">동행 신청 리스트</h1>
																	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
																</div>
																<div class="modal-body">
																	<div class="container border rounded-top">
																		<div class="row py-2" style="background-color: #dfdfdf;">
																			<div class="col"></div>
																			<div class="col d-flex justify-content-center" style="font-weight: 700;">
																				신청자
																			</div>
																			<div class="col d-flex justify-content-center" style="font-weight: 700;">
																				신청날짜
																			</div>
																			<div class="col d-flex justify-content-center" style="font-weight: 700;">
																				수락 / 거절
																			</div>
																		</div>
																		<c:forEach items="${data.list4}" var="item">
																			<div class="row py-3">
																				<div class="col d-flex justify-content-center">
																					<c:choose>
																						<c:when test="${item.planningApp.planning_member_status == '신청'}">
																							<span class="badge text-bg-secondary px-4 py-1 d-flex align-items-center" style="font-weight: 100;">신청</span>
																						</c:when>
																						<c:when test="${item.planningApp.planning_member_status == '수락'}">
																							<span class="badge px-4 py-1 d-flex align-items-center" style="background-color: #03c358; font-weight: 100;">수락</span>
																						</c:when>
																						<c:otherwise>
																							<span class="badge text-bg-danger px-4 py-1 d-flex align-items-center" style="font-weight: 100;">거절</span>
																						</c:otherwise>
																					</c:choose>
																				</div>
																				<div class="col d-flex justify-content-center align-items-center">
																					<img src="https://via.placeholder.com/50x50" class="thumb">
																					<span>
																						${item.user.user_nickname}
																						<a id="iconButton${item.user.user_id}" class="bi bi-envelope ms-1" style="color: black; cursor: pointer;" data-bs-toggle="collapse" data-bs-target="#collapseExample${item.user.user_id}"></a>
																					</span>
																				</div>
																				<div class="col d-flex justify-content-center">
																					<fmt:formatDate value="${item.planningApp.reg_date}" pattern="yyyy-MM-dd"/>
																				</div>
																				<div class="col d-flex justify-content-center">
																					<button style="border: none; color: #03c75a;">수락</button>
																					<button style="border: none; color: #ff4e4e;">거절</button>
																				</div>
																			</div>
																			<div class="row">
																				<div class="col-1"></div>
																				<div class="col p-0">
																					<div class="collapse pb-2" id="collapseExample${item.user.user_id}">
																						<div>${item.planningApp.planning_application_content}</div>
																					</div>
																				</div>
																			</div>
																		</c:forEach>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<div class="card-wrapper">
							<div class="card-title">마이플랜</div>
							<div style="padding-left: 2em; padding-right: 1em;">
								<c:choose>
									<c:when test="${empty map.list3}">
										<div class="d-flex justify-content-center mt-3">
											플랜 목록이 없습니다.
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach items="${map.list3}" var="data">
											<div>
												<a class="d-flex justify-content-between my-2" href="./plan/readPlanPage?id=${data.plan.plan_id}" style="text-decoration: none;">
													<span style="color: black;">[${data.plan.plan_statuse}] ${data.plan.plan_title}</span>
													<span style="font-size: 0.9em; font-weight: 400; color: #A3A3A3;">${data.day} days</span>
												</a>
											</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<div class="card-wrapper">
							<div class="card-title">등록숙소</div>
							<div class="row">
								<c:choose>
									<c:when test="${empty map.list2}">
										<div class="d-flex justify-content-center mt-3">
											등록된 숙소가 없습니다.
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach items="${map.list2}" var="data">
											<div class="col-4 pt-3 px-4">
												<div>
													<a href="./hotel/hotelDetailPage?hotel_id=${data.hotel.hotel_id}">
														<img src="/uploadFiles/hotelMainImage/${data.hotel.hotel_main_image}" class="img-fluid rounded" alt="썸네일" style="height: 10em; width: 100%;">
													</a>
													<div class="d-flex justify-content-between mt-2" style="font-size: 0.9em;">
														<span style="font-weight: 500;">${data.hotel.hotel_title}</span>
														<span style="font-weight: 400;">
															<i class="bi bi-star-fill text-warning" style="color: #b8b8b8; font-size: 14px;"></i>
															${data.reviewPoint == null ? 0.0 : data.reviewPoint}
														</span>
													</div>
													<span style="color: gray; font-size: 0.8em;"><fmt:formatDate value="${data.hotel.hotel_reserve_start_date}" pattern="MM월 dd일" /> ~ </span>
													<span style="color: gray; font-size: 0.8em;"><fmt:formatDate value="${data.hotel.hotel_reserve_end_date}" pattern="MM월 dd일" /></span>
												</div>
											</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
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