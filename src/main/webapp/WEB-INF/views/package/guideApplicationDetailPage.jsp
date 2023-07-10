<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>플랜 참가 신청 페이지</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=99e2d84aee0718d5faa9b9e1821fca6b&libraries=services"></script>

<script>

var map;
var coords;
var marker; // 마커 변수
var infowindow; // 인포윈도우 변수
var startPoint = '${map.guidePlanningDto.guide_planning_start_point}'; // 최초 모집장소



const guidePlanningId = new URLSearchParams(location.search).get("guide_planning_id");



function map(){
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};

	 map = new kakao.maps.Map(container, options);
	 startPointLocation();

}

function showPlace(item) {
	  // 전달받은 element 내에서 .placeName 클래스를 가진 요소를 찾습니다.
	  var placeAddressElement = item.querySelector('.address');
	  var address = placeAddressElement.value;
	  search(address);
	}
	


function startPointLocation() {

	// Geocoder 객체 생성
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색
	geocoder.addressSearch(startPoint,function(result, status) {
						// 정상적으로 검색이 완료됐으면
						if (status === kakao.maps.services.Status.OK) {
							var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

							// 마커가 이미 존재하는 경우, 마커의 위치를 변경
							if (marker) {
								marker.setPosition(coords);
							} else {
								// 처음 마커를 생성하는 경우
								marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});
							}

							var content = '<div style="width:150px; text-align:center; padding:6px 0;">' + startPoint + '</div>';

							// 인포윈도우가 이미 존재하는 경우, 인포윈도우의 내용을 변경
							if (infowindow) {
								infowindow.setContent(content);
							} else {
								// 처음 인포윈도우를 생성하는 경우
								infowindow = new kakao.maps.InfoWindow({
									content : content
								});
							}

							// 인포윈도우 오픈
							infowindow.open(map, marker);

							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
							map.setLevel(4);
						}
					});
};

function showStart(){

	var address = startPoint;
	search(address);
}


function search(keyword) {

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder
			.addressSearch(
					keyword,
					function(result, status) {
						// 정상적으로 검색이 완료됐으면
						if (status === kakao.maps.services.Status.OK) {
							coords = new kakao.maps.LatLng(result[0].y,
									result[0].x);

							// 마커가 이미 존재하는 경우, 마커의 위치를 변경
							if (marker) {
								marker.setPosition(coords);
							} else {
								// 처음 마커를 생성하는 경우
								marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});
							}

							var content = '<div style="width:150px; text-align:center; padding:6px 0;">'
									+ keyword + '</div>';

							// 인포윈도우가 이미 존재하는 경우, 인포윈도우의 내용을 변경
							if (infowindow) {
								infowindow.setContent(content);
							} else {
								// 처음 인포윈도우를 생성하는 경우
								infowindow = new kakao.maps.InfoWindow({
									content : content
								});
							}

							infowindow.open(map, marker);

							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
							map.setLevel(3);
						}
					});
}

function planningDay() {
	  var planningDay = document.querySelector(".planningDay");
	  var guidePlanningStartDate = new Date(Date.parse('${map.guidePlanningDto.guide_planning_start_date}'));

	  var planDayListSize = ${map.planDayListSize - 1};

	  var guidePlanningEndDate = new Date(guidePlanningStartDate.getTime() + (planDayListSize * 24 * 60 * 60 * 1000));

	  planningDay.innerText = formatPlanningDate(guidePlanningStartDate) + ' - ' + formatPlanningDate(guidePlanningEndDate);
	  planningDay.style.fontWeight = "bold";
	}

	function formatPlanningDate(date) {
	  const year = date.getFullYear().toString().slice(-2);
	  const month = (date.getMonth() + 1).toString().padStart(2, '0');
	  const day = date.getDate().toString().padStart(2, '0');
	  const dayOfWeek = getDayOfWeek(date);
	  return year + '.' + month + '.' + day + ' (' + dayOfWeek + ')';
	}

	function getDayOfWeek(date) {
	  const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
	  const dayOfWeek = daysOfWeek[date.getDay()]; // 0부터 일요일
	  return dayOfWeek;
	}



	function calculateDate(startDate, planDay) {
		  const start = new Date(startDate);
		  const calculatedDate = new Date(start.getTime() + (planDay - 1) * 24 * 60 * 60 * 1000);
		  return formatPlanningDate(calculatedDate);
		}
		
		function info() {
			
            const parentCol = document.querySelector('.scrollBar'); 
		    const xhr = new XMLHttpRequest();

		    xhr.onreadystatechange = function() {
		        if (xhr.readyState === 4 && xhr.status === 200) {
		            const response = JSON.parse(xhr.responseText);

		            if (response.list != null) {
		   

		                for ( data of response.list) {
		                	 const row1 = document.createElement("div");
		                     row1.classList.add('row', 'mt-4', 'row1');
		                     parentCol.appendChild(row1);

		                     const row1col1 = document.createElement("div");
		                     row1col1.classList.add('row1col1','col');
		                     row1.appendChild(row1col1);

		                     const grandChildCol1 = document.createElement('div');
		                     grandChildCol1.classList.add('grandChildCol');
		                     row1col1.appendChild(grandChildCol1);

		                     const iconSpan = document.createElement('span');
		                     iconSpan.classList.add('childSpan', 'bi', 'bi-brightness-high', 'me-2');
		                     grandChildCol1.appendChild(iconSpan);

		                     const textSpan = document.createElement('span');
		                     textSpan.classList.add('childSpan');
		                     textSpan.innerText = 'DAY' + data.planDay.plan_day;
		                     grandChildCol1.appendChild(textSpan);

		                     const textAfterCircle = document.createElement('span');
		                     textAfterCircle.classList.add('planDay');
		                     textAfterCircle.innerText = calculateDate(response.guidePlanningDto.guide_planning_start_date, 
		                    		 data.planDay.plan_day);
		                     row1col1.appendChild(textAfterCircle);
		                     
		                     for ( place of data.placeList){
		                    	 const row2 = document.createElement('div');
			                     row2.classList.add('row2','row','mt-2');
			                     row2.setAttribute('onclick', 'showPlace(this)');
			                   
			                     row1col1.appendChild(row2);
			                  
			                     const row2col1 = document.createElement('div');
			                     row2col1.classList.add('row2col1', 'col');
			                     row2.appendChild(row2col1);
			                     
			                     const placesIcon = document.createElement('span');
			                     placesIcon.classList.add('pi','bi' , 'bi', 'bi-' + (data.placeList.indexOf(place) + 1) + '-circle-fill')
			                     row2col1.appendChild(placesIcon);
			                     
			                     const  places = document.createElement('span');
			                     places.classList.add('myPlace');
			                     places.innerText  = place.planPlace.plan_place_name + '(' + place.planCityName +')';
			                     placesIcon.appendChild(places);
			                     
			                     const address = document.createElement('input');
			                     address.classList.add('address');
			                     address.setAttribute('type', 'hidden');
			                     address.value = place.planPlace.plan_place_address; 
			                     row2.appendChild(address); 
			                     
			                   
		                    	 
		                     }
		                }
		                
		            }
		        }
		    }

		    xhr.open("POST", "./guideApplicationDetailInfo");
		    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		    xhr.send("guide_planning_id=" + guidePlanningId);
		}
		
		

	
document.addEventListener("DOMContentLoaded", function() {
	  planningDay();
	  info();
	  map();
	});

</script>
<style>

.startPointBack {
	background-color: #d5f0ff;
	height: 34px;
	width: 34px;
	border-radius: 6px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	display: inline-flex;
}

.startDateBack {
	background-color: #d5f0ff;
	height: 34px;
	width: 34px;
	border-radius: 6px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}
.myPlace {
	font-size: 13px;
	font-weight: 600;
	padding-left: 10px;
}

.planDay {
	font-size: 16px;
	font-weight: 600;
	padding-left: 10px;
}

.grandChildCol {
	display: inline-block;
	width: 80px;
	height: 30px;
	border-radius: 30px;
	background: navy;
}

.childSpan {
	color: white;
	position: relative;
	left: 10px;
	top: 2px;
	font-size: 14px;
	font-weight: 600;
}

.bar {
	color: navy;
}
</style>

</head>
<body>
	<jsp:include page="../common/topNavi.jsp"></jsp:include>

	<div class="container-fluid p-0">
		<div class="container">
			<div class="row">
				<div class="col">
					<nav class="navbar navbar-expand-lg navbar-light">
						<div class="collapse navbar-collapse" id="navbarNav">
							<ul class="navbar-nav">
								<li class="nav-item">
									<div class="navWrapper">
										<a class="nav-link" href="/travel/main">홈</a>
									</div>
								</li>
								<li class="nav-item">
									<div class="navWrapper">
										<a class="nav-link" href="#"> <i
											class="bi bi-people-fill text-primary me-2"></i>동행
										</a>
									</div>
								</li>
								<li class="nav-item">
									<div class="navWrapper">
										<a class="nav-link" href="#"> <i
											class="bi bi-calendar-check-fill text-danger me-2"></i>일정
										</a>
									</div>
								</li>
							</ul>
						</div>
					</nav>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<hr class="mt-0 shadow">
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="row mt-3">
					<div class="col">

						<div class="map shadow" id="map"
							style="width: 500px; height: 500px;"></div>
					</div>
					<div class="col-6 scrollBar shadow">
						<div class="row text-center fw-bold">
							<div class="col">
								<span class="">${map.user.user_nickname}님의 여행일정</span>
							</div>
						</div>
						<div class="row mt-4 text-center">
							<div class="col" id="calenDarCol">
								<div class="calendarWrapper" onclick="showCalendar()">
									<span class="dayBack me-4"><i
										class="bi bi-calendar-check-fill text-danger"></i></span> <span
										class="me-2 showDay"></span>
								</div>
							</div>
						</div>
						<div class="row mt-4">
							<div class="col fs-5">
								<span class="startPointBack me-2"><i
									class="bi bi-geo-alt-fill "  style="color: #00a3ff;"></i></span> <span onclick="showStart()"
									style="font-weight: bold;">${map.guidePlanningDto.guide_planning_start_point}</span>
							</div>
						</div>
						<div class="hhh row mt-4">
							<div class="col">
								<span class="startDateBack me-2"><i
									class="bi bi-calendar-check-fill" style="color: #00a3ff;"></i></span>
								<span class="me-2 planningDay"></span>
							</div>
						</div>

						<div class="row">
							<div class="col"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>