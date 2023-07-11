<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@700&family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<script type="text/javascript">
	var searchWord = '';
	var searchType = "latest";
	var startDate = '';
	var endDate = '';
	var planningMember = '';
	
	var pageNum = 1;
	var pageSize = 10;
	var totalCount = 0;
	var isLoading = false; // 추가 데이터를 가져오는 중인지 여부를 나타내는 변수

	document.addEventListener("DOMContentLoaded", function() {
		getTravelApplicationList();
	});
	
	function clearListAndSearchTravel(button) {
		pageNum = 1;
		var mainContainer = document.getElementById('mainContainer');
		mainContainer.innerText = "";
		
		// 컨테이너 요소 선택
		var container = button.closest('.search-container');
		
		// 입력값 가져오기
		searchWord = container.querySelector('#searchWord').value;
		searchType = container.querySelector('#searchType').value;
		startDate = container.querySelector('#startDate').value;
		endDate = container.querySelector('#endDate').value;
		planningMember = container.querySelector('.count').value;
		
		getTravelApplicationList();
	}
	
	window.onscroll = function() {
		var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
		var containerHeight = document.getElementById('mainContainer').offsetHeight;
		var windowHeight = window.innerHeight || document.documentElement.clientHeight;

		if (scrollTop >= containerHeight - windowHeight && !isLoading) {
			pageNum++; // 페이지 번호를 증가시킵니다.

			if ((pageNum - 1) * pageSize < totalCount) {
				console.log(pageNum * pageSize);

				getTravelApplicationList();
			}
		}
	};
	
	function redirectDetailPage(planning_id) {
		location.href = './plan/travelApplicationDetailPage?planning_id='+planning_id;
	}
	
	function getTravelApplicationList() {
		if (isLoading) {
			return;
		}

		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);

				if (response.list != null) {
					
					console.log(response.list);
					totalCount = response.totalCount;

					var row = document.createElement('div');
					row.className = 'row mainRow';

					for ( var i in response.list) {
						console.log(response.list[i]);

						// 요소 생성
						var col = document.createElement('div');
						var cardWrapper = document.createElement('div');
						var img = document.createElement('img');
						var iconWrapper = document.createElement('div');
						var icon = document.createElement('i');
						var cardBody = document.createElement('div');
						var title = document.createElement('div');
						var content = document.createElement('div');
						var userInfo1 = document.createElement('div');

						// 클래스와 속성 설정
						col.className = 'col-3 mb-3';
						cardWrapper.className = 'cardWrapper shadow';
						cardWrapper.onclick = function() {
							redirectDetailPage(response.list[i].planning.planning_id);
						};
						img.className = 'img-fluid cardImg';
						img.src = '/uploadFiles/' + response.list[i].plan.plan_thumbnail;
						img.alt = '썸네일';
						icon.className = 'bi bi-geo-alt cardIcon';
						iconWrapper.className = 'iconWrapper';
						cardBody.className = 'card-body';
						title.className = 'title text-truncate';
						content.className = 'content mb-1 text-truncate';
						userInfo1.className = 'user-info';

						// 텍스트 내용 설정
						iconWrapper.textContent = response.list[i].list2[0].placeList[0].plan_place_address.slice(0, 2);
						title.textContent = response.list[i].planning.planning_title;
						content.textContent = response.list[i].planning.planning_content;

						// 여행 시작일 설정
						var startDate = new Date(response.list[i].planning.planning_start_date);

						// 일(day)단위로 계산
						var planDay = response.list[i].planDay;
						var dayInMilliseconds = 24 * 60 * 60 * 1000; // 1일을 밀리초로 변환
						var planDuration = planDay * dayInMilliseconds;

						// 여행 종료일 설정
						var endDate = new Date(startDate.getTime()
								+ planDuration);

						userInfo1.textContent = (startDate.getMonth() + 1) + '/' + startDate.getDate() + ' - ' + (endDate.getMonth() + 1) + '/' + endDate.getDate() + ' · ' + planDay + '일';

						// 요소 구조 생성
						cardBody.appendChild(title);
						cardBody.appendChild(content);
						cardBody.appendChild(userInfo1);
						cardWrapper.appendChild(img);
						cardWrapper.appendChild(iconWrapper);
						iconWrapper.prepend(icon);
						cardWrapper.appendChild(cardBody);
						col.appendChild(cardWrapper);
						row.appendChild(col);
						
						// 문서에 삽입
						var mainContainer = document.getElementById('mainContainer');
						mainContainer.appendChild(row);
					}
				}
				isLoading = false; // 데이터를 모두 처리한 후 isLoading 값을 false로 설정합니다.
			}
		}

		//post
		xhr.open("post", "./plan/getTravelApplicationList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var params = 'pageNum=' + pageNum + '&searchType=' + encodeURIComponent(searchType) + '&searchWord=' + encodeURIComponent(searchWord) + '&planningMember=' + planningMember + '&startDate=' + encodeURIComponent(startDate) + '&endDate=' + encodeURIComponent(endDate);
		xhr.send(params);

		isLoading = true; // 데이터를 가져오는 중임을 나타내기 위해 isLoading 값을 true로 설정합니다.
	}
</script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
						var startDatePicker = flatpickr("#startDate", {
							dateFormat : "Y/m/d",
							locale : flatpickr.l10ns.ko, // 한국어 로케일을 설정
							onChange : function(selectedDates, dateStr,
									instance) {
								endDatePicker.set("minDate", dateStr);
							}
						});

						var endDatePicker = flatpickr(
								"#endDate",
								{
									dateFormat : "Y/m/d",
									locale : flatpickr.l10ns.ko, // 한국어 로케일을 설정
									position : "below", // Force the position of the calendar to open below the input
									onOpen : function() {
										document.querySelector('#endDate').style.marginBottom = '200px';
									},
									onClose : function() {
										document.querySelector('#endDate').style.marginBottom = '0px';
									},
									onChange : function(selectedDates, dateStr,
											instance) {
										startDatePicker.set("maxDate", dateStr);
									}
								});
					});

	function calc(change) {
		// input 요소 가져오기
		var inputElement = document.querySelector(".count");
		// 현재 값 가져오기
		var currentValue = parseInt(inputElement.value);
		// 변경된 값 계산
		var newValue = currentValue + change;
		// 값이 음수가 되지 않도록 조정
		newValue = Math.max(0, newValue);
		// 값 적용
		inputElement.value = newValue;
	}
</script>
<style>
.iconWrapper {
	background-color: white;
	position: absolute;
	left: 10px;
	top: 10px;
	padding: 3px;
	border-radius: 0.375rem;
}

.card-body {
	padding: 10px;
}

.cardImg {
	height: 220px;
	border-radius: 0.375rem;
}

.title {
	font-size: 1.6em;
	margin-bottom: 0.3em;
}

.content, .user-info {
	font-size: 0.9em;
	color: #363535;
}

.cardWrapper {
	position: relative;
	width: 18rem;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	cursor: pointer;
}

.cardWrapper:hover .iconWrapper {
	background: #DB4465;
	color: white;
}

.cardWrapper:hover .cardIcon {
	color: white;
}

.mainRow {
	padding-left: 20px;
}

.image-container {
	position: relative;
	width: 100%;
	height: 70%; /* 이미지의 높이를 원하는 값으로 조정 */
}

.image-container img {
	width: 100%;
	height: 100%; /* 이미지의 세로 비율을 유지하면서 가로에 맞춤 */
	object-fit: cover; /* 이미지가 전부 보이도록 조정 */
}

.title-container {
	position: absolute;
	z-index: 1;
	top: 150px;
	color: white;
}

.search-container {
	font-family: 'Noto Sans KR', sans-serif;
	position: absolute;
	z-index: 1;
	background-color: white;
	width: 100%;
	height: 10em;
	top: 620px;
	border-radius: 0.4rem;
	padding: 10px;
}

h1 {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 4em;
}

.container.header .navbar-nav .nav-link, .container.header .navbar-brand
	{
	color: white;
	font-family: 'Noto Sans KR', sans-serif;
}

select {
	appearance: none /* 화살표 없애기 */
}

i {
	color: #DB4465;
}

button {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
<title>메인 페이지</title>
</head>
<body>
	<div class="container-fluid p-0">
		<div class="container">
			<div class="container header" style="position: absolute; z-index: 1;">
				<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
				
				<div class="row">
					<div class="col">
						<div class="title-container">
							<h1>최고의 동행 파트너를 찾아보세요ㅁㄴㅁㅇㅁㅇㄴㅁㅇㄴㅁㅇ</h1>
							<span style="font-weight: 400; font-size: 1.4em;">함께하는 여행의 즐거움을 더욱 풍부하게 만들어줄 파트너를 찾아보세요</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="search-container">
							<div class="row">
								<div class="col-10">
									<div class="row">
										<div class="col">
											<span
												style="color: #CCCCCC; font-size: 0.8em; margin-left: 10px;">제목
												검색</span> <input class="form-control py-0" id="searchWord"
												type="text" placeholder="서울 관광"
												style="border: none; font-size: 1.4em;">
										</div>
									</div>
									<div class="row mt-4">
										<div class="col">
											<span
												style="color: #CCCCCC; font-size: 0.8em; margin-left: 10px;">정렬</span>
											<div style="margin-left: 10px; margin-top: 5px;">
												<i class="bi bi-funnel-fill"></i>
												<select id="searchType" style="border: none;">
													<option value="latest">최신순</option>
													<option value="old">오래된순</option>
													<option value="application">신청순</option>
												</select>
											</div>
										</div>
										<div class="col">
											<span
												style="color: #CCCCCC; font-size: 0.8em; margin-left: 10px;">가는
												날</span>
											<div class="d-flex justify-content-center"
												style="margin-left: 10px; margin-top: 5px;">
												<i class="bi bi-calendar-check me-1"></i> <input
													id="startDate" type="text" name="planning_start_date"
													placeholder="날짜 입력" style="border: none;">
											</div>
										</div>
										<div class="col">
											<span
												style="color: #CCCCCC; font-size: 0.8em; margin-left: 10px;">오는
												날</span>
											<div class="d-flex justify-content-center"
												style="margin-left: 10px; margin-top: 5px;">
												<i class="bi bi-calendar-check me-1"></i> <input
													id="endDate" type="text" name="planning_end_date"
													placeholder="날짜 입력" style="border: none;">
											</div>
										</div>
										<div class="col">
											<span
												style="color: #CCCCCC; font-size: 0.8em; margin-left: 10px;">모집
												인원</span>
											<div class="d-flex justify-content-center"
												style="margin-left: 10px; margin-top: 5px;">
												<i class="bi bi-people-fill me-1"></i> <input class="count"
													type="text" placeholder="인원" name="planning_member"
													style="border: none;">
											</div>
										</div>
									</div>
								</div>
								<div class="col" style="margin-top: 60px;">
									<div class="row">
										<div class="col d-grid px-5">
											<button class="btn" style="background-color: #DB4465; color: white; border-radius: 5rem;" onclick="clearListAndSearchTravel(this)">검색</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col p-0">
				<div class="image-container">
					<img alt="back" src="/travel/resources/img/back.png">
				</div>
			</div>
		</div>
		<div class="container" id="mainContainer"></div>
	</div>
	<jsp:include page="../common/bottomNavi.jsp"></jsp:include>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>