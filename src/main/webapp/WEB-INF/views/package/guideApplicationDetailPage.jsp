<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>플랜 참가 신청 페이지</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=99e2d84aee0718d5faa9b9e1821fca6b&libraries=services"></script>

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

function planprice(){
	
	var planPrice = document.querySelector(".planprice");
	planPrice.innerText = ${map.guidePlanningDto.guide_planning_price} + '원'
	    



	
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
			
            const planDetail = document.getElementById("planDetail");
		    const xhr = new XMLHttpRequest();

		    xhr.onreadystatechange = function() {
		        if (xhr.readyState === 4 && xhr.status === 200) {
		            const response = JSON.parse(xhr.responseText);

		            if (response.list != null) {
		            	
		            	for ( data of response.list) {
		            		
			            	const aaa = document.getElementById("templete_planDetail").cloneNode(true);
			            	aaa.removeAttribute("id");
			            	aaa.classList.remove("d-none");
			            	
			            	aaa.querySelector(".planDetail_Day").innerText = 'DAY' + data.planDay.plan_day;
			            	aaa.querySelector(".planDetail_Date").innerText = calculateDate(response.guidePlanningDto.guide_planning_start_date, 
		                    		 data.planDay.plan_day);
			            	
			            	planDetail.appendChild(aaa);
			            		
			            		for(place of data.placeList){
			            			
			            			const bbb = document.getElementById("templete_place").cloneNode(true);
			            			bbb.removeAttribute("id");
					            	bbb.classList.remove("d-none");
					            	const placeNameElement = bbb.querySelector(".place_name");
					            	placeNameElement.setAttribute('onclick', 'showPlace(this)');
					            	const placeIndex = data.placeList.indexOf(place) + 1;
					            	const iconClass = 'bi-' + placeIndex + '-circle-fill';

					            	const iconElement = document.createElement("span");
					            	
					            	iconElement.classList.add(iconClass);
					            	const spaceTextNode = document.createTextNode(" ");

					            	const content = place.planPlace.plan_place_name 
					            	
					            	placeNameElement.innerText = '';
					            	iconElement.appendChild(spaceTextNode);
					            	placeNameElement.appendChild(iconElement);
					            	placeNameElement.append(content);
					            	
					            	const city = document.createElement("span");
					            	
					            	city.innerText = ' (' + place.planCityName+ ')';
					            	city.style.fontSize = '15px';  // 폰트 크기를 20px로 설정
					            	city.style.color = 'gray';  // 텍스트 색상을 회색으로 설정
					            	placeNameElement.appendChild(city);
					            	
					            	const address = document.createElement('input');
				                     address.classList.add('address');
				                     address.setAttribute('type', 'hidden');
				                     address.value = place.planPlace.plan_place_address; 
				                     placeNameElement.appendChild(address); 
					            	
					             	/* const placeThumbnailElement = bbb.querySelector(".place_thumbnail");
					             	const imageUrl = ""; 


					            	const imageElement = document.createElement("img");
					            	imageElement.src = imageUrl;

					            	placeThumbnailElement.innerHTML = '';
					            	placeThumbnailElement.appendChild(imageElement);  */
					            	
					            	bbb.querySelector(".place_thumbnail").innerText = "이미지";
					            	
					            	bbb.querySelector(".place_content").innerText = place.planPlace.plan_place_content;
					            	
					            	
					            	aaa.querySelector(".planDetail_place").appendChild(bbb);
					            	
					            	
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
	  planprice();
	});

</script>
<style>

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

.packageThumbnail {
	width: 100%;
	height: 500px;
}

.packageThumbnail2 {
	width: 100%;
	height: 240px;
}

.place_thmbnail{
	width: 100%;
	height: 20px;
}

.line {
	border: none;
	border-top: 2px solid;
	color: black;
}


.table {
    width: 100%;
   height: 500px;
    border-collapse: collapse;
    vertical-align: middle;
   	border-top : 3px solid black; 
}
.table th,
.table td {
    padding: 8px;
    text-align: center;
    

}
.table th {
	background-color :#fcf0f0;
    width: 40%;
    font-size : 30px;
}
.table td {
	background-color : white;
    width: 60%;
    font-size : 20px;
    
}

.place_name:hover{
	cursor: pointer;
}


    





</style>

</head>
<body>
	<div class="container-fluid p-0">
		<div class="container">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
		<div class="row">
			<div class="col">
				<hr class="mt-0 shadow">
			</div>
		</div>
	</div>



	<div class="container">
		<!-- 패키지 소개 -->
		<div class="row mt-2">
			<div class="col">
				<div class="row mb-3">
					<div class="col" style="font-size: 50px; font-weight: bold;">
						<!-- 패키지명 -->
						${map.guidePlanningDto.guide_planning_title}
					</div>
				</div>
				<div class="row">
					<div class="col-8">
						<!-- 썸내일 -->
						<img src="/uploadFiles/${map.planDto.plan_thumbnail }"
							class="packageThumbnail">
					</div>
					<div class="col-4">
						<div class="row mb-4">
							<div class="col">

								<img src="/uploadFiles/${map.planDto.plan_thumbnail }"
									class="packageThumbnail2">

							</div>

						</div>
						<div class="row">
							<div class="col">

								<img src="/uploadFiles/${map.planDto.plan_thumbnail }"
									class="packageThumbnail2">

							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
				

<!-- 간단 표!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<div class="container mt-5">
		<div class="row">
			<div class="col-8">
				<table class="table">
				 	<tr>
				        <th><i class="bi bi-airplane-fill"></i> 패키지</th>
				        <td>${map.guidePlanningDto.guide_planning_title}</td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-calendar-check-fill"></i> 날짜</th>
				        <td class="planningDay">Mark</td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-balloon-heart-fill"></i> 방문명소</th>
				        <td>
				        <c:forEach items="${map.list}" var="mapItem">
				            <c:forEach items="${mapItem.placeList}" var="placeMap" varStatus="loop">
							    ${placeMap.planPlace.plan_place_name}
							    <c:if test="${!loop.last}">,</c:if>
							</c:forEach>
				        </c:forEach>
				        
				        </td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-flag-fill"></i> 출발장소</th>
				        <td>${map.guidePlanningDto.guide_planning_start_point}</td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-person-check-fill"></i> 모집인원</th>
				        <td>${map.packageMember}/${map.guidePlanningDto.guide_planning_member }</td>
				    </tr>
				</table>
			</div>
			<div class="col-1"></div>
			<div class="col-3 text-center shadow" style="border:solid 3px black; border-radius: 10px; background-color :#fcf0f0; ">
				<div class="row mt-3">
					<div class="col">
						<span style="font-size : 25px; font-weight:bold;">${map.user.user_nickname}</span><span style="font-size : 20px; font-weight:bold;">  가이드 님</span>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col">
						이미지
					</div>
				</div>
				<div class="row mt-5">
					<div class="col" style="font-weight:bold;">
						가이드 프로필 	가이드 프로필	가이드 프로필	가이드 프로필	가이드 프로필	가이드 프로필	가이드 프로필
					</div>
				</div>
				<div class="row mt-5 mb-5">
					<div class="col planprice" style="font-size:50px; font-weight: bold;">
						
					</div>
				</div>
				<div class="row mt-5">
					<div class="col">
						<a class="btn pay-button d-grid" href="#" role="button" onclick="pay()"
	   						 style="font-size: 30px; font-weight: bold; background-color: #BB4465; color: white;">결제</a>
					</div>
				</div>
			</div>
				
					
			
				      
				     
			
		</div>
	</div>
	
<div class="row mt-5">
	<div class="col">
		<hr class="mt-0 shadow">
	</div>
</div>

				<%-- <div class="row">
					<div class="col packageInfo ">
						<!-- 패키지 간던 설명 -->
						<div class="row mt-5">
							<div class="col d-flex justify-content-center"
								style="font-size: 20px; font-weight: bold;">
								<!-- 패키지명 -->
								<span class="badge"
									style="color: white; background-color: #304782;">${map.guidePlanningDto.guide_planning_start_point}
									출발</span> <span class="badge"
									style="color: white; background-color: #304782;">${map.packageMember}/${map.guidePlanningDto.guide_planning_member }</span>
							</div>
						</div>
						<div class="row">
							<div class="col d-flex justify-content-center"
								style="font-size: 50px; font-weight: bold;">
								<!-- 패키지명 -->
								${map.guidePlanningDto.guide_planning_title}
							</div>
						</div>
						<div class="row py-3">
							<div class="col planningDay d-flex justify-content-center"
								style="font-size: 30px; font-weight: bold;">
								<!-- 날짜, 밑에 packageInfo 에이잭스로 따올떄 같이 따오기 -->

							</div>
						</div>
						<div class="row py-3">
							<div class="col d-flex justify-content-center"
								style="font-size: 20px; color: gray;">
								<!-- 패키지 설명 -->
								${map.guidePlanningDto.guide_planning_content}
							</div>
						</div>
						<div class="row mt-3">
							<div class="col d-flex justify-content-center"
								style="color: gray;">
								<i class="bi bi-info-circle-fill" style="color: #304782"></i>
								가이드 비용, 1인 기준
							</div>
						</div>
						<div class="row">
							<div class="col planprice d-flex justify-content-center"
								style="font-size: 30px; font-weight: bold;">
								<!-- 비용 -->

							</div>
						</div>

						<div class="row mt-4">
							<div class="col d-flex justify-content-center">
								<!-- 결제 버튼 -->
								<a class="btn pay-button" href="#" role="button" onclick="pay()"
									style="font-size: 20px; font-weight: bold; background-color: #BB4465; color: white;">결제</a>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> --%>



	<div class="container" style="height: 600px;">
		<div class="row">
			<div class="col">
				<div class="row mt-3">
					<div class="col">
						<div class="row "  >
							<div class="col">
								<i class="bi-flag-fill"></i>
								<span>모집 장소 : </span>
								<span onclick="showStart()" style="font-weight: bold;">${map.guidePlanningDto.guide_planning_start_point}</span>
								
							</div>
						</div>
						<div class="row mt-5">
							<div class="col">
								<div class="map shadow" id="map" style="width: 80%; height: 500px;">
								
								</div>						
						
							</div>
						</div>					
					</div>

					<div class="col-6">
						<div class="row mt-5">
							<div class="col" id="planDetail" >
								
								
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
<div class="row d-none" id = "templete_planDetail">
	<div class="col">
		<div class="row" style=" position: sticky; top: 0;">
			<div class="col-3 planDetail_Day text-center" style=" font-size : 40px; font-weight:bold; color:white; background:#BB4465;">
					
			</div>
			<div class="col-9 planDetail_Date" style=" font-size : 40px; font-weight:bold; border-bottom:1px solid gray; background:white;">
				
			</div>
		</div>
		<div class="row">
			<div class="col planDetail_place">
			
			</div>
		</div>
	</div>
</div>		
	
	
	
<div class="row mt-5 mb-3 d-none" id="templete_place">
	<div class="col">
		<div class="row mt-3 mb-3">
			<div class="col place_name" style="font-size : 25px; font-weight:bold;">
			
			</div>
			
		</div>
		<div class="row mt-3">
			<div class="col-1">
			
			</div>
			<div class="col-3 place_thumbnail">
			
			</div>
			<div class="col place_content">
			
			</div>
		</div>

	</div>
</div>

<div class="row d-none" id="templete_place_thumbnail">
	<div class="col place_thumbnailss">
	
	</div>
</div>

	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>