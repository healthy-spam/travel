<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=db6c20ca60db131bdca5b89e7568dc3f&libraries=services"></script>
<title>플래너 상세보기 페이지</title>
<script type="text/javascript">

    var map;
    var marker; // 마커 변수
    var infowindow; // 인포윈도우 변수
    var markers = [];
    let polyline = null;

    
    const planId = new URLSearchParams(location.search).get("id");

    console.log(planId);

    function map(){
        // 지도 api
        var container = document.getElementById('map');
        var options = {
        center: new kakao.maps.LatLng(35.5665, 126.9780),
        level: 13
        };

        map = new kakao.maps.Map(container, options);
    }


    function loadDay() {
        const xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function() {
           if (xhr.readyState === 4) {
              if (xhr.status === 200) {
                 const response = JSON.parse(xhr.responseText); 

                 const dayList = document.getElementById("templete_day"); // dayList 변수 선언
                 let firstDayId;

                 for(let i = 0; i < response.data.length; i++){
                    const dayDto = response.data[i];

                    if (i === 0) { // 첫번째 반복일 때 firstDayId에 저장
                        firstDayId = dayDto.plan_day_id;
                    }

                    const newNode = document.createElement('li'); // 새로운 'li' 요소 생성
                    newNode.innerHTML = '<a class="dropdown-item day-text">' + 'DAY ' + dayDto.plan_day + '</a>'; // 'li' 요소에 'a' 태그와 텍스트 삽입
                    newNode.querySelector(".dropdown-item").setAttribute("onclick", "loadMyList(" + dayDto.plan_day_id + ")");
                    dayList.appendChild(newNode);
                 }

                 // 첫번째 day에 대한 명소 목록을 로드합니다.
                 if (firstDayId !== undefined) {
                    loadMyList(firstDayId);
                 }
              }
           }
        }

        xhr.open("get", "./getPlanDayList2?planId=" + planId);
        xhr.send();
    }


    function loadMyList(plan_day_id){
        const xhr = new XMLHttpRequest();
        
        myDayPlaceList = [];
        
        // 모든 마커 제거
        for (let i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = []; // 마커 배열 초기화
        
        // 이전 폴리라인 제거
        if (polyline !== null) {
            polyline.setMap(null);
        }

        // 새로운 폴리라인 초기화
        polyline = new kakao.maps.Polyline({
            path: [],
            strokeWeight: 3,
            strokeColor: '#03c75a',
            strokeOpacity: 1,
            strokeStyle: 'solid'
        });        
        
        while (myDayPlaceList.length > 0) {
            myDayPlaceList.pop();
        }
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);

                    const route_col = document.getElementById("route_col");
                    const templateNode = document.getElementById("templete_my_place").cloneNode(true);

                    // "templete_my_place" 뒤에 오는 모든 노드를 제거합니다.
                    while(route_col.lastChild && route_col.lastChild.id !== "templete_my_place"){
                        route_col.removeChild(route_col.lastChild);
                    }

                    // 일정별 명소 목록이 없으면
                    if(response.myList.length == 0) {
                        const newNode = document.createElement('div');
                        newNode.classList.add("row", "mt-2", "align-items-center", "border", "p-2", "m-1");
                        newNode.innerHTML = `
                            <div class="col-12">
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col text-center">
                                        <span style="font-size: 20px; color: #03c75a; font-weight: bolder;">아직 선택된 장소가 없습니다.</span>
                                    </div>
                                </div>
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col-4">&nbsp;</div>
                                    <div class="col-4 d-grid">
                                        <a class="btn" style="background-color: #03c75a; color: white; font-weight: bolder; border-radius: 15px;" href="./registerPlanRoutePage?plan_id=${data.planDto.plan_id}">
                                            <i class="bi bi-signpost-split"></i> 루트 수정
                                        </a>
                                    </div>
                                    <div class="col-4">&nbsp;</div>
                                </div>
                                <div class="row">&nbsp;</div>
                            </div>
                        `;
                        route_col.appendChild(newNode);
                    } else {
                        let placeCounter = 0; // Counter 변수를 추가합니다.

                        for(x of response.myList){
                            for(y of x.listInner){
                                const newElementInner = templateNode.cloneNode(true);

                                // placeName, plan_place_photo, plan_place_content, and plan_place_address from the response
                                newElementInner.querySelector(".placeName").innerText = y.planPlaceDto.plan_place_name;
                                newElementInner.querySelector(".placeImage").src = "/uploadFiles/mainImage/"+y.planPlaceDto.plan_place_photo;
                                newElementInner.querySelector(".placeContent").innerText = y.planPlaceDto.plan_place_content;
                                newElementInner.querySelector(".placeAddress").innerText = y.planPlaceDto.plan_place_address;
                                newElementInner.querySelector(".place_number").innerText = ++placeCounter; // Counter를 증가시키고 place_number에 할당합니다.

                                newElementInner.querySelector(".placeName").style.fontSize = "20px";
                                newElementInner.removeAttribute("id");
                                newElementInner.classList.remove("d-none");
                                newElementInner.querySelector(".readPlace").href = "../planPlace/PlanPlaceDetailPage?plan_place_id=" + y.planPlaceDto.plan_place_id;                                
                                
                                route_col.appendChild(newElementInner);
                                
                                myDayPlaceList.push(y.planPlaceDto.plan_place_address);
                                
                                console.log(y.planPlaceDto.plan_place_photo);
                                
                                if (myDayPlaceList.length >= 2) {
                                    drawPin(myDayPlaceList[myDayPlaceList.length - 2], myDayPlaceList[myDayPlaceList.length - 1], polyline);  // polyline 객체를 인수로 전달
                                }
                            }                  
                        }  
                    }                                                 
                }
            }
        }

        xhr.open("get", "./getMyList?dayId=" + plan_day_id);
        xhr.send();
    }

    
    function search2(keyword, index) {
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
        
        // 주소로 좌표를 검색합니다
        geocoder.addressSearch( keyword, function(result, status) {
        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {
        coords = new kakao.maps.LatLng(result[0].y, result[0].x);           
        
        // 처음 마커를 생성하는 경우
        marker = new kakao.maps.Marker({
			map : map,
			position : coords
        });
        
        markers.push(marker);
        
        if (index !== myDayPlaceList.length - 1) {
			const path = polyline.getPath();
			path.push(coords);
			polyline.setPath(path);
		}

		if (index === myDayPlaceList.length - 1) {
			polyline.setMap(map);
		}        
        
        // 선의 경로에 위치 추가
		var path = polyline.getPath();
		path.push(coords);
		polyline.setPath(path);
        
        var content = '<div style="width:150px; text-align:center; padding:6px 0;">' + keyword + '</div>';
        
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
        map.setLevel(5);
                                                       
		}
        
		});
	}
     
    async function drawPin() {
        var geocoder = new kakao.maps.services.Geocoder();

        let coords = [];

        // Wrap the address search in a new Promise
        const searchAddress = (address) => new Promise((resolve, reject) => {
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    resolve(new kakao.maps.LatLng(result[0].y, result[0].x));
                } else {
                    reject(status);
                }
            });
        });

        // Use a for loop to await the address search for each address
        for (let i = 0; i < myDayPlaceList.length; i++) {
            coords[i] = await searchAddress(myDayPlaceList[i]);

            var marker = new kakao.maps.Marker({
                map: map,
                position: coords[i]
            });

            markers.push(marker);
        }

        polyline.setPath(coords);
        polyline.setMap(map);
    }

    
    window.addEventListener("DOMContentLoaded", () => {
        map();
        loadDay();        
    });

</script>

</head>

<body>
<div class="container">

	<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>

	<div class="row mt-2">
		<div class="col-5" style="box-shadow: 10px 0 5px -2px rgba(0, 0, 0, 0.2);">
		    <div class="row align-items-center">
		    
		        <div class="col">
		        
		            <div class="row align-items-center text-center">
		
						<div class="col-1">
						     <img src="/uploadFiles/${data.planDto.plan_thumbnail}" style="width: 40px; height: 40px;">
						</div>
		                
		                <div class="col-9 align-items-center justify-content-center">
		                
		                    <div class="row">
		                    
		                        <div class="col-5 p-0 d-flex align-items-center justify-content-center">
		                            <span class="" style="font-weight: 700; font-size: 20px;">${data.planDto.plan_title}</span>
		                        </div>
		                        
								<c:if test="${!empty sessionuser && sessionuser.user_id == data.userDto.user_id}">                                                    
		                        <div class="col-3 text-left">                                                                            
	                                <div class="dropdown">
	                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="border-radius: 15px; font-weight: 500; background-color: #03c75a; color: white;">
	                                        <i class="bi bi-gear"></i> 관리
	                                    </button>
	                                    <ul class="dropdown-menu" >
	                                        <li class="col-auto"><a class="dropdown-item" href="#"><i class="bi bi-vector-pen"></i> 정보 수정</a></li>
	                                        <li class="col-auto "><a class="dropdown-item" href="./registerPlanRoutePage?plan_id=${data.planDto.plan_id}"><i class="bi bi-signpost-split"></i> 루트 수정</a></li>
	                                        <li class="col-auto "><a class="dropdown-item" href="./deleteProcess?id=${data.planDto.plan_id}"><i class="bi bi-trash3"></i> 플래너 삭제</a></li>
	                                    </ul>
	                                </div>                                    
		                        </div>
								</c:if>
								
								<c:if test="${!empty sessionuser && sessionuser.user_id == data.userDto.user_id}">
		                     	<div class="col-4 ps-0">
		                            <c:if test="${data.planDto.plan_statuse != '모집'}">
		                                <a href="./travelRecruitmentPage?plan_id=${data.planDto.plan_id}" class="btn shadow-sm" style="background-color: #03c75a; color: white; font-weight: bolder; border-radius: 17px;" >
		                                <i class="bi bi-people"></i> 모집
		                                </a>
		                            </c:if> 
		                            <c:if test="${data.planDto.plan_statuse != '모집' && guideCheck == 1 }">
		                                <a href="../guidePackage/packageRecruitmentPage?plan_id=${data.planDto.plan_id}" class="btn shadow-sm" style="background-color: #03c75a; color: white; font-weight: bolder; border-radius: 17px;">
		                                패키지 모집
		                                </a>
		                            </c:if>
		                       	</div>
								</c:if>
								
		                       	<c:if test="${!empty sessionuser && sessionuser.user_id != data.planDto.user_id && data.planDto.plan_disclosure_status == '공개'}">
		                        <div class="col-5">
			                        <a href="./copyPlanProcess?plan_id=${data.planDto.plan_id}" class="btn shadow-sm" style="background-color: #03c75a; color: white; font-weight: bolder; border-radius: 17px;">
									<i class="bi bi-bookmark"></i> 일정 담기
			                        </a>
		                        </div>
			                    </c:if>	                    
		                    </div>
		                    
		                </div>                                
		                
		                <div class="col-2">
		                    <c:choose>
		                        <c:when test="${data.planDto.referenced_plan_id != 0}">
		                            <a class="btn" href="readPlanPage?id=${data.planDto.referenced_plan_id}">
		                                <i class="bi bi-bookmark-fill" style=" color: #03c75a; font-size: 30px;"></i> 참조한 플래너 이름
		                            </a>
		                        </c:when>
		                        <c:otherwise>
		                        	<span>&nbsp;</span>
		                            <%-- <i class="bi bi-bookmark" style=" color: #ff356b; font-size: 30px;"></i> --%>                                               
		                        </c:otherwise>
		                    </c:choose>
		                </div>                                                                                                                                                 
		                
		                
		            </div>
		            
		            
		        </div>
		        
		                                                
		    </div>
		    
		    <div class="row">
		    	<div class="col">
		    		<hr>
		    	</div>
		    </div>
		    
		    <div class="row mt-2">
		    	<!-- <div class="col-1">
		    		&nbsp;
		    	</div> -->
		    	<div class="col-12">
					<div class="dropdown-center d-grid" >
						<button class="btn dropdown-toggle" style=" color: white; font-weight: bolder; background-color: #03c75a; border-radius: 12px; font-size: 20px;" type="button" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="bi bi-calendar-check"></i> 일정별 루트 목록						 
						</button>
						<ul class="dropdown-menu" id="templete_day" style="font-size: 25px;">
							<!-- <li><a class="dropdown-item day-text" href="#"></a></li> -->
							
						</ul>
					</div>
				</div>
				<!-- <div class="col-1">
		    		&nbsp;
		    	</div> -->
		    </div>
		    
		    <div class="row mt-4">
		    	<div class="col" id="route_col">
		    	
		    		<div class="row mt-2 align-items-center border p-1 m-1 d-none" id="templete_my_place">
					    <div class="col-1 text-center">
					        <span class="place_number" style="font-weight: bolder; font-size: 20px; color: #252525;"></span>
					    </div>
					    <div class="col-4 text-center ps-0">
					        <img class="placeImage" alt="" src="" style="width: 140px; height: 90px; border-radius: 10px;">
					    </div>
					    <div class="col-7 p-0">
					        <div class="row">
					            <div class="col">
					                <span class="placeName" style="font-weight: bolder; font-size: 12px; color: #252525;"></span>                            
					            </div>                                                                                
					        </div>
					        <div class="row mt-1">
					            <div class="col">
					                <span class="placeContent" style="display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; font-size: 14px;"></span>
					            </div>
					        </div>
					        <div class="row">
					            <div class="col">
					                <span class="placeAddress" style="display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; font-size: 12px; color: #9a9a9a;"></span>
					            </div>
					        </div>
					        <div class="row mt-1">
					        	<div class="col">
					        		<a class="readPlace" href="" style="text-decoration: none;">
					        		<span class="" style="color: #ffa800; font-size: 15px; font-weight: bolder;">상세보기</span>
					        		</a>
					        	</div>
					        </div>
					    </div>                      
					</div>		    				    	
		    		
		    	</div>		
		    </div>
		    
		</div>
		
		<div class="col-7">                 	
			<div id="map" style="width: 1000px; height: 1000px"></div>
		</div>
		
	</div>
	
	<div class="row mt-1">
		<div class="col-12">
			<hr>
		</div>
	</div>
	<div class="row mt-2">
		<div class="col text-start">		
			<span>© 2023 TripStation. All rights reserved.</span>
		</div>
		<div class="col text-end">
			<span></span>
		</div>
	</div>
	
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>