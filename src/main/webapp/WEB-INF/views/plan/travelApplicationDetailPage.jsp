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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93ae12d4c0f00044228cbd5b5f2f588b&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">
	var commentList;
	var planning_id = '${map.planningDto.planning_id}';
	
	function createCommentFunc() {
		var comment = document.querySelector('.comment');
		
		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				// js 작업//
				
				if (response.ok != null) {
					comment.value = '';
					getCommentList();
				}
			}
		}

		//post
		xhr.open("post", "./createComment");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var params = "planning_id=" + planning_id + "&user_comment=" + encodeURIComponent(comment.value);
		xhr.send(params);
	}
	
	function getCommentList() {

		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				if (commentList) {
					commentList.innerHTML = '';	
				}
				
				if (response.list != null) {
					var boardInfo = document.querySelector('.board-info');
					var regDate = new Date('${map.planningDto.planning_reg_date}');
					var boardRegDate = formatDate(regDate);
					
					boardInfo.innerText = boardRegDate + ' · 댓글 ' + response.list.length;
					
					for (let i in response.list) {
						commentList = document.querySelector('.comment-list');
						
						var date = new Date(response.list[i].planningComment.reg_date);
						var formattedDate = formatDate(date);
						
					    // Row div
					    const rowDiv = document.createElement('div');
					    rowDiv.classList.add('row', 'mb-4');
					    rowDiv.style.fontFamily = "'Noto Sans KR', sans-serif";

					    // Col-1 div
					    const col1Div = document.createElement('div');
					    col1Div.classList.add('col-1');
					    const img = document.createElement('img');
					    img.classList.add('user-thumbnail');
					    img.alt = "썸네일";
					    img.src = "https://via.placeholder.com/40x40";
					    col1Div.appendChild(img);
					    
					    // Col div
					    const colDiv = document.createElement('div');
					    colDiv.classList.add('col', 'p-0', 'mb-2');
					    const p1 = document.createElement('p');
					    p1.classList.add('m-0');
					    p1.innerText = response.list[i].user.user_nickname;
					    const p2 = document.createElement('p');
					    p2.classList.add('mb-2');
					    p2.innerText = formattedDate;
					    colDiv.appendChild(p1);
					    colDiv.appendChild(p2);

					    // Col-12 div
					    const col12Div = document.createElement('div');
					    col12Div.classList.add('col-12');
					    const div = document.createElement('div');
					    div.innerText = response.list[i].planningComment.user_comment;
					    col12Div.appendChild(div);
					    
					    // Another col-12 div
					    const anotherCol12Div = document.createElement('div');
					    anotherCol12Div.classList.add('col-12', 'd-flex', 'justify-content-between', 'mt-1');
					    const button = document.createElement('button');
					    button.classList.add('comment-reply');
					    button.innerText = '답글 달기';
					    var heartIcon = document.createElement("i");
					    heartIcon.classList.add("bi", "bi-heart");
					    heartIcon.onclick = function() {
							addLike(response.list[i].planningComment.planning_comment_id);	
						}
					    const span = document.createElement('span');
					    span.classList.add('comment-love');
					    span.innerHTML = '좋아요 ' + response.list[i].totalLike + '개';
					    span.appendChild(heartIcon);
					    anotherCol12Div.appendChild(button);
					    anotherCol12Div.appendChild(span);

					    // Append all children to the row div
					    rowDiv.appendChild(col1Div);
					    rowDiv.appendChild(colDiv);
					    rowDiv.appendChild(col12Div);
					    rowDiv.appendChild(anotherCol12Div);
					    commentList.appendChild(rowDiv);
					}
				}
			}
		}
		
		//post
		xhr.open("post", "./getCommentList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send();
	}
	
	function addLike(comment_id) {
	
	console.log(comment_id);
	
	const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				if (response.ok != null) {
					getCommentList();
				}
			}
		}
		
		//post
		xhr.open("post", "./addLike");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("comment_id="+comment_id);

	}

	function formatDate(date) {
		var yyyy = date.getFullYear();
		var MM = ('0' + (date.getMonth() + 1)).slice(-2); // Months are zero based
		var dd = ('0' + date.getDate()).slice(-2);
		var hh = ('0' + date.getHours()).slice(-2);
		var mm = ('0' + date.getMinutes()).slice(-2);

		return yyyy + '/' + MM + '/' + dd + ' ' + hh + ':' + mm;
	}
</script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		initializeMap();
		getAddresList();
		getCommentList();
		
		var isDown = false;
		var startX;
		var scrollLeft;

		var userListContainer = document.querySelector('.user-list-container');

		userListContainer.addEventListener('mousedown', function(e) {
			isDown = true;
			startX = e.pageX - userListContainer.offsetLeft;
			scrollLeft = userListContainer.scrollLeft;
		});

		userListContainer.addEventListener('mouseleave', function() {
			isDown = false;
		});

		userListContainer.addEventListener('mouseup', function() {
			isDown = false;
		});

		userListContainer.addEventListener('mousemove', function(e) {
			if (!isDown)
				return;
			e.preventDefault();
			var x = e.pageX - userListContainer.offsetLeft;
			var walk = (x - startX) * 3; // 스크롤 속도 조절
			userListContainer.scrollLeft = scrollLeft - walk;
		});
	});
</script>
<script type="text/javascript">
	function getAddresList() {
		var plan_id = '${map.plan.plan_id}';
		var placeAddressList = [];
		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				// js 작업//

				if (response.list != null) {
					console.log(response.list);

					for ( var i in response.list) {
						placeAddressList.push(response.list[i].placeDto);
					}
					addMarkers(placeAddressList);
				}
			}
		}

		//post
		xhr.open("post", "./getAddresList");
		xhr.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xhr.send("plan_id=" + plan_id);

	}

	function initializeMap() {
		var mapContainer = document.getElementById('map');
		var mapOption = {
			center : new kakao.maps.LatLng(37.499630, 127.030504), // 위도, 경도
			// draggable: false, 드래그 설정(true: 가능, false: 불가능)
			level : 3
		};

		map = new kakao.maps.Map(mapContainer, mapOption);
	}

	// 줌 인 버튼 클릭 시 호출되는 함수
	function zoomIn() {
		map.setLevel(map.getLevel() - 1);
	}

	// 줌 아웃 버튼 클릭 시 호출되는 함수
	function zoomOut() {
		map.setLevel(map.getLevel() + 1);
	}

	function addMarkers(placeDtoList) {
		var geocoder = new kakao.maps.services.Geocoder();
		var bounds = new kakao.maps.LatLngBounds();

		// Promise로 각 주소를 좌표로 변환하는 비동기 작업을 관리합니다.
		var promises = placeDtoList
				.map(function(placeDto, index) {
					return new Promise(
							function(resolve) {
								geocoder
										.addressSearch(
												placeDto.plan_place_address,
												function(result, status) {
													if (status === kakao.maps.services.Status.OK) {
														var coords = new kakao.maps.LatLng(
																result[0].y,
																result[0].x);

														var content = '<div style="background-color: white; border-radius: 15px; padding: 5px; width: 100%; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3); position: relative; font-weight: 700;">'
																+ '<span style="background-color: #DB4465; border-radius: 50%; width: 30px; height: 30px; padding: 5px; display: inline-flex; align-items: center; justify-content: center;"><i class="bi bi-geo-alt-fill" style="font-size: 20px; color: white;"></i></span>'
																+ ' '
																+ placeDto.plan_place_name
																+ '<div style="position: absolute; bottom: -8px; left: 10px; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid white;"></div>'
																+ '</div>';

														// CustomOverlay를 생성합니다.
														var mainOverlay = new kakao.maps.CustomOverlay(
																{
																	position : coords,
																	content : content,
																	yAnchor : 0.7,
																	xAnchor : 0.1
																});

														// CustomOverlay를 지도에 표시합니다.
														mainOverlay.setMap(map);

														bounds.extend(coords);

														resolve();
													} else {
														resolve();
													}
												});
							});
				});

		// 모든 주소가 좌표로 변환되면 지도의 범위를 업데이트합니다.
		Promise.all(promises).then(function() {
			map.setBounds(bounds);
		});
	}
</script>
<style type="text/css">
.img-wrapper {
	height: 400px;
	width: 100%;
	overflow: hidden;
}

.banner {
	object-fit: cover;
	height: 100%;
	width: 100%;
	border-radius: 0 0 0.4rem 0.4rem;
}

.content-wrapper {
	margin-top: 5em;
}

.planning-title {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 2em;
	font-weight: 700;
}

.card {
	font-family: 'Noto Sans KR', sans-serif;
	padding: 22px 22px 22px 22px;
	margin: 30px 10px 0 10px;
	font-size: 1.1em;
	font-weight: 600;
}

.card-content {
	margin-top: 2px;
	font-size: 0.7em;
	font-weight: 500;
}

.planning-content {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 1.2em;
	margin-bottom: 1em;
}

.commit {
	background-color: #DB4465;
	font-size: 1.2em;
	font-weight: 400;
	border-radius: 0.375rem;
	color: white;
	height: 50px;
	border: none;
}

.profile {
	font-family: 'Noto Sans KR', sans-serif;
	padding: 40px 40px 0 40px;
	border: 1px solid lightgrey;
	border-radius: 0.4rem;
	margin: 15px 15px 10px 15px;
}

.user-thumbnail {
	border-radius: 50%;
	border: 2px solid #DB4465;
	margin-right: 10px;
	width: 50px;
	height: 50px;
}

.user-list-container {
	overflow-x: auto;
	cursor: pointer;
	overflow: hidden;
}

.user-list {
	display: flex;
	list-style-type: none;
	padding: 0;
	margin-top: 8px;
}

.card-wrapper {
	position: relative;
	margin-bottom: 25px;
	padding-bottom: 30px;
}

.card-wrapper i {
	color: #DB4465;
}

.card-wrapper::after {
	content: '';
	position: absolute;
	height: 1px;
	width: 97%;
	left: 10px; /* 왼쪽 정렬 */
	bottom: 0; /* 아래쪽 정렬 */
	background-color: lightgrey;
}

#mapContainer {
	position: relative;
	width: 100%;
	height: 100%; /* 필요한 높이로 수정해주세요 */
}

#map {
	width: 100%;
	height: 100%;
	border-radius: 0.375rem;
}

#zoomButtons {
	position: absolute;
	bottom: 10px; /* 필요에 따라 수정해주세요 */
	right: 10px; /* 필요에 따라 수정해주세요 */
	z-index: 1;
}

#zoomInButton, #zoomOutButton {
	border: none;
	width: 40px;
	height: 36px;
	font-size: 25px;
	background-color: white;
}

#zoomInButton {
	border-radius: 0.375rem 0.375rem 0 0;
}

#zoomOutButton {
	border-radius: 0 0 0.375rem 0.375rem;
}

.comment-wrapper {
	position: relative;
}

.comment::placeholder {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 0.8em;
	color: lightgrey;
}

.comment-info {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 0.8em;
	color: #9C9A9A;
}

.comment-button {
	font-family: 'Noto Sans KR', sans-serif;
	position: absolute;
	top: 8px;
	right: 20px;
	border: none;
	color: #DB4465;
}

.comment-reply {
	border: none;
	font-size: 0.8em;
	padding: 0;
	color: #999999;
}

.comment-love {
	font-size: 0.8em;
	color: #999999;
}

.bi-heart {
	margin-left: 5px;
	font-size: 0.9em;
}
</style>
<title>모집 디테일 페이지</title>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		
		<div class="row">
			<div class="col">
				<div class="row">
					<div class="col img-wrapper">
						<img class="banner" alt="배너" src="/uploadFiles/${map.plan.plan_thumbnail}">
					</div>
				</div>
				<div class="row content-wrapper">
					<div class="col-8" style="padding-right: 40px;">
						<div class="row">
							<div class="col main-col">
								<span class="planning-title">${map.planningDto.planning_title}</span>
								<div class="row card-wrapper">
									<div class="col card d-flex justify-content-center">
										<div class="row">
											<div class="col-1 d-flex align-items-center me-3">
												<i class="bi bi-people-fill fs-4"></i>
											</div>
											<div class="col">
												<div>모집인원</div>
												<div class="card-content">${map.planningDto.planning_member}명</div>
											</div>
										</div>
									</div>
									<div class="col card d-flex justify-content-center">
										<div class="row">
											<div class="col-1 d-flex align-items-center me-3">
												<i class="bi bi-calendar-check fs-4"></i>
											</div>
											<div class="col">
												<div>여행날짜</div>
												<div class="card-content" id="planning-date">07-07 ~
													07-10</div>
											</div>
										</div>
									</div>
									<div class="col card d-flex justify-content-center">
										<div class="row">
											<div class="col-1 d-flex align-items-center me-3">
												<i class="bi bi-compass fs-4"></i>
											</div>
											<div class="col">
												<div>모집위치</div>
												<div class="card-content">${map.planningDto.planning_start_point}</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col planning-content">${map.planningDto.planning_content}</div>
								</div>
								<div class="row" style="height: 500px;">
									<div class="col">
										<div id="mapContainer">
											<div class="map shadow" id="map"></div>

											<div id="zoomButtons">
												<div class="row">
													<div class="col">
														<button class="d-flex align-items-center justify-content-center" id="zoomInButton" onclick="zoomIn()">+</button>
														<button class="d-flex align-items-center justify-content-center" id="zoomOutButton" onclick="zoomOut()">-</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row" style="margin: 20px 0;">
									<div class="col p-0">
										<hr>
									</div>
								</div>
								<div class="row">
									<div class="col-12 mb-3 comment-info">
										<span class="board-info"></span>
									</div>
									<div class="col mb-3 comment-wrapper">
										<input class="form-control comment p-2" type="text" placeholder="댓글을 입력해주세요.">
										<button class="comment-button" type="button" onclick="createCommentFunc()">작성</button>
									</div>
								</div>
								<div class="row">
									<div class="col comment-list"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="profile">
							<div class="row">
								<div class="col-2 me-1">
									<img class="user-thumbnail" alt="썸네일" src="/uploadFiles/profileImage/${map.user.user_image}">
								</div>
								<div class="col">
									<div class="row">
										<div class="col">${map.user.user_nickname}</div>
									</div>
									<div class="row">
										<div class="col">
											<div id="user-profile">20대 · 남성</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row mt-5">
								<div class="col d-grid">
									<div class="mb-1" style="font-weight: 500;">
										<i class="bi bi-exclamation-circle-fill" style="color: #DB4465;"></i> 지금 동행을 신청해보세요!
									</div>
									<button class="commit">동행 신청하기</button>
								</div>
							</div>
							<div class="row" style="margin-top: 40px;">
								<div class="col">함께하는 동행</div>
							</div>
							<div class="row">
								<div class="col">
									<div class="user-list-container">
										<ul class="user-list">
											<li><img class="user-thumbnail" alt="썸네일" src="https://via.placeholder.com/40x40"></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="../common/bottomNavi.jsp"></jsp:include>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>