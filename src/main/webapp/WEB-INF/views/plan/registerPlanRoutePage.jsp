<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=db6c20ca60db131bdca5b89e7568dc3f&libraries=services"></script>
<script type="text/javascript">

	var map;
	var coords;
	var marker; // 마커 변수
	var infowindow; // 인포윈도우 변수
	
	function map(){
	   var container = document.getElementById('map');
	   var options = {
	      center: new kakao.maps.LatLng(37.562, 126.9961),
	      level: 12
	   };
	
	    map = new kakao.maps.Map(container, options);
	
	
	}

	function getPlanData() {
		
		const xhr = new XMLHttpRequest();
	
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					const response = JSON.parse(xhr.responseText);
					
					console.log(response.plan);
					
					console.log(response.plan.planDto.plan_title);
					
					const planTitle = document.getElementById("planTitle");
					
					planTitle.innerText = response.plan.planDto.plan_title; 
				}
			}
		}
		
		xhr.open("get", "./getPlan?planId="+planId);
		xhr.send();
	}

	function updatePlanDisclosure(){
	    const xhr = new XMLHttpRequest();
	    
	    const openRadio = document.querySelector('.open');
	    const closeRadio = document.querySelector('.close');
	    let planDisclosureStatus = openRadio.checked ? openRadio.value : closeRadio.checked ? closeRadio.value : null;
	    
	    console.log(planDisclosureStatus);
	    console.log(planId);
	
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4) {
	            if (xhr.status === 200) {
	                const response = JSON.parse(xhr.responseText);
	                
	                console.log(planDisclosureStatus);
	                console.log(planId);
	                
	                window.location.href = "/travel/plan/planPage";
	            }
	        }
	    }
	    
	    xhr.open("POST", "./updatePlan");
	    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    xhr.send("planId="+planId + "&planDisclosureStatus="+ planDisclosureStatus);
	}

	function showPlace(item) {
	     
	     var placeAddressElement = item.querySelector('.address');
	     var address = placeAddressElement.value;
	
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
	
		const planId =   new URLSearchParams(location.search).get("plan_id"); // 중요..
	   
		let globalCityId = null;
		let globalDayId = null;
	
		function addDay() {
			const xhr = new XMLHttpRequest();
	
			xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					const response = JSON.parse(xhr.responseText);
	               
					loadDay();
	            }
	         }
	      }
	
	      xhr.open("POST", "./registerPlanDayProcess");
	      xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	      xhr.send("plan_id=" + planId);
	   }

   function loadDay() {

      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               
               document.getElementById("day_col").innerHTML = "";
               
               for(dayDto of response.data){
                  
                  const newNode = document.getElementById("templete_day").cloneNode(true);
                  
                  
                  newNode.classList.remove("d-none");
                  newNode.removeAttribute("id");
                  newNode.setAttribute("onclick", "handleClickDay(" + dayDto.plan_day_id + ")");
                  
                  const dayText = newNode.querySelector(".day-text");
                  dayText.innerText = "DAY " + dayDto.plan_day;

                  const icon = document.createElement("i");
                  icon.classList.add("bi", "bi-trash3");
                  icon.style.fontSize = "15px";
                  icon.style.marginLeft = "10px";
               /*    icon.setAttribute("onclick", "deleteDay(" + dayDto.plan_day_id + ")"); */
                  
                  const newDayId = dayDto.plan_day_id;
                    newNode.setAttribute("id", "day_" + newDayId); // 새로운 id를 지정합니다.
                    newNode.setAttribute("onclick", "handleClickDay(" + newDayId + ")");

                  dayText.appendChild(icon);
               
                                    
                  document.getElementById("day_col").appendChild(newNode);
               }
               
               
               console.log(response);
            }
         }
      }

      xhr.open("get", "./getPlanDayList2?planId=" + planId);
      xhr.send();
   }
   
/*    function deleteDay(dayId) {

      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               
               loadDay();
               
            }
         }
      }

      xhr.open("get", "./deleteDay?planId=" + planId);
      xhr.send();
   } */
   
   
   
   let selectedDayElement = null; // 선택된 날짜 요소를 저장할 변수

   function handleClickDay(dayId) {
      
      
      
      
     const clickedElement = document.getElementById("day_" + dayId);

     if (selectedDayElement === clickedElement) {
       // 이미 선택된 요소를 클릭한 경우
       return;
     }
     

     if (selectedDayElement) {
       // 이전에 선택된 요소가 있는 경우
       selectedDayElement.classList.remove("selected-day");
       addTrashIcon(selectedDayElement, dayId);
       resetFontSize(selectedDayElement);
     }

     clickedElement.classList.add("selected-day");
     removeTrashIcon(clickedElement);
     setFontSize(clickedElement);

     selectedDayElement = clickedElement;
     globalDayId = dayId;
    
     loadMyList();
   }

   function addTrashIcon(element, dayId) {
        const trashIcon = document.createElement("i");
        trashIcon.classList.add("bi", "bi-trash3");
        trashIcon.style.fontSize = "15px";
        trashIcon.style.marginLeft = "10px";
       /*  trashIcon.setAttribute("onclick", "deleteDay(" + dayId + ")"); */
       element.querySelector(".day-text").appendChild(trashIcon);
      }
   function removeTrashIcon(element) {
     const trashIcon = element.querySelector(".bi-trash3");
     if (trashIcon) {
       trashIcon.remove();
     }
   }

   function resetFontSize(element) {
     const dayText = element.querySelector(".day-text");
     if (dayText) {
       dayText.style.fontSize = "30px";
       dayText.style.color = "black";
     }
   }

	function setFontSize(element) {
	  const dayText = element.querySelector(".day-text");
	  if (dayText) {
		dayText.style.fontSize = "35px";
		dayText.style.color = "white";
	  }
	}
   
   function citySearch(){
      
      const citySearchText1 = document.getElementById("city_search_text_box").value;
      const citySearchText2 = document.getElementById("city_search_select_box").value;
            
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);

               console.log(response);
                                                            
               const city_list = document.getElementById("city_list");
               city_list.innerHTML = "";
               
               for(cityDto of response.cityList) {
                  
                  const newElement = document.getElementById("templete_city").cloneNode(true);
                  newElement.querySelector(".cityName").innerText = cityDto.plan_city_name;
                  
                  newElement.querySelector(".cityName").style.fontSize = "20px";
                  
                  newElement.removeAttribute("id");
                  newElement.classList.remove("d-none");
                  newElement.setAttribute("onclick", "handleClickCity("+ cityDto.plan_city_id +")")
                  newElement.classList.add("newElement");

                  
                  city_list.appendChild(newElement);
                  
               }
            }
         }
      }

      xhr.open("get", "./getCityList2?word1=" + citySearchText1 + "&word2=" + citySearchText2);
      xhr.send();
      
   }
   
   function handleClickCity(cityId){   
      
      globalCityId = cityId;
      searchPlace();   
            
   }
   
   function searchPlace(){
      const placeSearchWord = document.getElementById("place_search_box").value; 
      
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               console.log(response);
               

               const place_list = document.getElementById("place_list");
               place_list.innerHTML = "";
               
               for(const placeDto of response.placeList) {
                  
                  const newElement = document.getElementById("templete_place").cloneNode(true);
                  newElement.querySelector(".name").innerText = placeDto.plan_place_name;
                  newElement.querySelector(".address").innerText = placeDto.plan_place_address;
                  newElement.removeAttribute("id");
                  newElement.classList.remove("d-none");
                  newElement.querySelector(".add i").setAttribute("onclick", "addPlace("+ placeDto.plan_place_id +")")
                  newElement.classList.add("newElement");
                  newElement.querySelector(".name").style.fontSize = "20px";
                  newElement.querySelector(".address").style.fontSize = "16px";
                  newElement.querySelector(".show").addEventListener("click", function() {
                       search(placeDto.plan_place_address);
                     });
                  
                  
                  place_list.appendChild(newElement);
               }
            }
         }
      }

      xhr.open("get", "./getPlaceList2?cityId=" + globalCityId + "&word=" + placeSearchWord);
      xhr.send();
            
   }
   
   function allPlace(){      
      
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
                              
               const place_list = document.getElementById("place_list");
               place_list.innerHTML = "";
               
               for(const placeDto of response.placeList) {
                  const newElement = document.getElementById("templete_place").cloneNode(true);
                  newElement.querySelector(".name").innerText = placeDto.plan_place_name;
                  newElement.querySelector(".address").innerText = placeDto.plan_place_address;
                  newElement.removeAttribute("id");
                  newElement.classList.remove("d-none");
                  newElement.querySelector(".add i").setAttribute("onclick", "addPlace("+ placeDto.plan_place_id +")")
                  newElement.classList.add("newElement");
                  newElement.querySelector(".name").style.fontSize = "20px";
                  newElement.querySelector(".address").style.fontSize = "16px";
                  newElement.querySelector(".show").addEventListener("click", function() {
                       search(placeDto.plan_place_address);
                     });
                                    
                  place_list.appendChild(newElement);
               }
            }
         }
      }

      xhr.open("get", "./getAllPlaceList2");
      xhr.send();
            
   }
        
   
   function addPlace(placeId ){
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               console.log(response);
               loadMyList();
            }
         }
      }

      xhr.open("get", "./registerPlaceProcess?plan_day_id=" + globalDayId + "&plan_city_id=" + globalCityId + "&plan_place_id=" + placeId);
      xhr.send();
   }
   
   
   function loadMyList(){
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         
         
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);

               const route_col = document.getElementById("route_col");
               route_col.innerHTML = "";                              
                              
               for(x of response.myList){
                  const newElement = document.getElementById("templete_my_city").cloneNode(true);
                  newElement.querySelector(".cityName").innerText = x.planCityDto.plan_city_name;
                  newElement.removeAttribute("id");
                  newElement.classList.remove("d-none");
                  route_col.appendChild(newElement);
                  
                  for(y of x.listInner){
                     const newElementInner = document.getElementById("templete_my_place").cloneNode(true);
                     newElementInner.querySelector(".placeName").innerText = y.planPlaceDto.plan_place_name;
                     newElementInner.querySelector(".placeName").style.fontSize = "20px";
                     newElementInner.querySelector(".address").remove();
                     newElementInner.removeAttribute("id");
                     newElementInner.classList.remove("d-none");
                     newElement.querySelector(".placeList").appendChild(newElementInner);
                  }                  
               }
                                                 
            }
         }
      }

      xhr.open("get", "./getMyList?dayId=" + globalDayId);
      xhr.send();
   }
      
   window.addEventListener("DOMContentLoaded", () => {
      loadDay();
      citySearch();
      allPlace();
      map();
      getPlanData();
   });
   
</script>
<style>
	.selected-day {
	   background-color: #BB4465 !important;
	  
	}
	
	#addDay:hover {
	  cursor: pointer;
	}
	
	#day:hover { 
	  cursor: pointer;
	}
	
	.add:hover{
	  cursor: pointer;
	}
	
	.show:hover{
	  cursor: pointer;
	}
	
	.cityName:hover{
	  cursor: pointer;
	}
	
	#city_list {
	   
	    overflow-y: scroll; /* 세로 스크롤 사용 */
	     height: 300px; /* 스크롤의 길이를 200px로 설정 */
	}
	
	
	#place_list {
	   
	    overflow-y: scroll; /* 세로 스크롤 사용 */
	    height: 300px; /* 스크롤의 길이를 200px로 설정 */s
	}

</style>


</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>

   	<div class="row bg-light">
	    <div class="col align-items-center">			    	
	        <div class="row">
	            <div class="col">
	                <img src="/travel/resources/img/icon.png" style="width: 2rem">
	                <span id="planTitle">플래너 제목</span>
	            </div>
	        </div>			    	
	    </div>
	
	    <div class="col align-items-center">			    
	        <div class="row">
	            <div class="col">
	                <input class="form-check-input open" type="radio" name="plan_disclosure_status" value="공개">
	                <label class="form-check-label" for="plan_disclosure_status1">공개</label>
	                <input class="form-check-input close" type="radio" name="plan_disclosure_status"  value="비공개">
	                <label class="form-check-label" for="plan_disclosure_status2">비공개</label>
	            </div>
	        </div>
	    </div>
	
	    <div class="col align-items-center">
	        <div class="row">
	            <div class="col">
	                <button type="button" class="btn btn-primary" onclick="updatePlanDisclosure()">작업완료</button>
	            </div>
	        </div>
	    </div>
	</div>
   
   
   <div class="container-fluid" style="margin-top: 20px; ">
   
      <div class="row py-3" >
      
         <!-- 일차 -->
         
         <div class = "col " style="background: #fffaf0;">
            <div class="row">
               <div class="col-1" style="border-right: 2px solid #000000; border-top : 2px solid #000000;">
                  <div class="row py-3" style ="border-bottom : 2px solid #000000;">
                     <div class="col text-center" style = "font-size : 40px; font-weight:bold; ">
                        DAY
                     </div>
                  </div>
                  <div class="row py-2" style="border-bottom : 2px solid #000000;">
                     <div class="col " id="addDay" style=" font-size : 30px; font-weight:bold; display: flex; align-items: center; justify-content: center;" onclick="addDay()">
                        DAY <i class="bi bi-plus-circle-fill "  style="color: #BB4465; font-size: 30px; margin-left: 10px; " ></i>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col" id="day_col">
                     </div>
                  </div>
                  
               </div>
         
         <!-- 명소 -->
         
            <div class="col-3" style="border-right: 2px solid #000000; border-top : 2px solid #000000;">
               <div class="row py-3" style ="border-bottom : 2px solid #000000">
                  <div class="col  text-center" style = "font-size : 40px; font-weight:bold; ">My Route</div>
               </div>
               <div class="row ">
                  <div class="col " id="route_col" >
   
                  </div>
               </div>
            </div>
         
         <!-- 선택 박스 -->
      
            <div class="col-3" style="border-right: 2px solid #000000; border-top : 2px solid #000000;">
               <div class="row py-3"  style ="border-bottom : 2px solid #000000">
                  <div class="col text-center" style = "font-size : 40px; font-weight:bold; ">Tour Spot</div>
               </div>
               <!-- 시티 선택 리스트 -->
               <div class="row">
                  <div class="col">
                     <div class="row py-3">
                        <div class="col">
                           <input onkeyup="citySearch()" type="text" class="form-control" id="city_search_text_box">
                        </div>
                        <div class="col">
                           <select onchange="citySearch()" class="form-select" id="city_search_select_box">
                              <option value="">전체</option>
                              <option value="서울">서울</option>
                              <option value="경기">경기</option>
                              <option value="강원">강원</option>
                              <option value="충남">충청남도</option>
                              <option value="충북">충청북도</option>
                              <option value="경북">경상북도</option>
                              <option value="경남">경상남도</option>
                              <option value="전북">전라북도</option>
                              <option value="전남">전라남도</option>
                              <option value="제주">제주도</option>
                              
                           </select>
                        </div>
                     </div>
                     <div class="row border-bottom : 2px solid #000000;">
                        <div class="col" id="city_list">
                        </div>
                     </div>
                  </div>
               </div>
               <!-- 명소 선택 리스트 -->
               <div class="row border py-2">
                  <div class="col">
                     <div class="row py-2 my-3">
                        <div class="col">
                           <input onkeyup="searchPlace()" id="place_search_box" type="text" class="form-control" placeholder="검색">
                        </div>
                     </div>
                     <div class="row">
                        <div class="col" id="place_list">
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         
         <!-- 지도 -->
         
            <div class="col-5">
               <div class ="row">
                  <div class="col">
                     <div id="map" style="width:100%;height:850px;"></div>
                  </div>
               </div>   
            </div>
         </div>
      </div>
      
   </div>
</div>




      <div class="row d-none py-3" id="templete_my_city">
         <div class="col d-flex justify-content-center">
            <div class="card rounded shadow border mx-auto" style="width: 25rem; ">
              <div class="card-body text-center text-white" style="background-color:#BB4465;">
                <h5 class="card-title cityName" style="font-weight:bold; font-size:30px; ">Card title</h5>
              </div>
              <ul class="list-group list-group-flush placeList">
                
              </ul>
            </div>
         </div>
      </div>
      
   
   <div class="row d-none p-1 " id="templete_my_place">
      <div class="col text-center">
         <div class="row" >
            <div class="col placeName fw-bold">송리...</div>
         </div>
         <div class="row ">
            <div class="col address text-secondary" style="font-size:0.7em">주소.. 어쩌...</div>
         </div>
      </div>
   </div>

   <div class="row border-bottom py-2 d-none" id="templete_place">
      <div class="col-3">
      	이미지
      </div>
      <div class="col show">
         <div class="row">
            <div class="col name fw-bold">대충 이름</div>
         </div>
         <div class="row">
            <div class="col address text-secondary" style="font-size: 0.7em">대충 주소</div>
         </div>
      </div>
      <div class="col-2 fs-3 add"><i class="bi bi-plus-circle-fill" style="color: #BB4465;"></i></div>
   </div>


   <div class="row border-bottom py-3 d-none text-center" id="templete_city">
      <div class="col fw-bold cityName">송파구</div>
   </div>


   <div class="row d-none " id="templete_day">
      <div class="col" >
         <div class="row py-2"  style = "border-bottom: 2px solid #000000;">
            <div class="col day-text"  id="day" style=" font-size : 30px; font-weight:bold; display: flex; align-items: center; justify-content: center;">
               day 1  
            </div>
            
            <!-- <div class="col-4">
               <div class="row">
                  <div class="col"><i class="bi bi-caret-up" style="font-size: 13px;"></i></div>
               </div>
               <div class="row">
                  <div class="col"><i class="bi bi-caret-down" style="font-size: 13px;"></i></div>
               </div>
            </div> -->
         
         </div>
      </div>
      
   </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>