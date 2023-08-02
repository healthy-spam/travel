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
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=db6c20ca60db131bdca5b89e7568dc3f&libraries=services,clusterer,drawing"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

var map1;
var marker1;
var infowindow1;
var coords1;
var map2;
var markers = [];
let overlays = [];
let polyline = null;

var startPoint = '${map.guidePlanningDto.guide_planning_start_point}'; // 최초 모집장소
var user_id = '${sessionuser.user_id}';
var couponDiscountValue = 0;


const planId = '${map.planDto.plan_id}';


const guidePlanningId = new URLSearchParams(location.search).get("guide_planning_id");

function addThousandSeparator(number) {
	  // 숫자를 문자열로 변환
	  const numberString = number.toString();
	  
	  // 정규식을 사용하여 천 단위 구분자(쉼표) 추가
	  const numberWithSeparator = numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	  
	  return numberWithSeparator;
	}

function pay(partner_order_id, partner_user_id, item_name, total_amount) {
 const xhr = new XMLHttpRequest();

 xhr.onreadystatechange = function() {
     if (xhr.readyState === 4) {
         if (xhr.status === 200) {
             const response = JSON.parse(xhr.responseText);
             var box = response.next_redirect_pc_url;
             window.open(box);
         } else {
             
         }
     }
 }

 xhr.open("POST", "./packagePayProcess");
 xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
 xhr.send("partner_order_id=" + encodeURIComponent(partner_order_id) +
          "&partner_user_id=" + encodeURIComponent(partner_user_id) +
          "&item_name=" + encodeURIComponent(item_name) +
          "&total_amount=" + encodeURIComponent(total_amount));
}

function full(){

	swal('모집 인원 초과', ' ', 'warning'); 
	
}


function packageIn(guidePlanningId){
   	
	   const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				
					var partner_order_id = response.partner_order_id;
					var partner_user_id = response.userId;
					var item_name = response.item_name;
					var total_amount0 = response.total_amount;
					
					var total_amount = total_amount0 - couponDiscountValue;
					
				
					
					pay(partner_order_id,partner_user_id, item_name, total_amount);
					
				
				
				
				
			}
		}
		
	
		
		xhr.open("POST", "./packageIn");
		xhr.setRequestHeader("Content-TYPE","application/x-www-form-urlencoded"); 
		xhr.send("guide_planning_id=" + guidePlanningId);
	   
	   
}

function initMap1() {
	var container = document.getElementById('map1');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};

	map1 = new kakao.maps.Map(container, options);
}

function initMap2() {
	var container = document.getElementById('map2');
	var options = {
		center: new kakao.maps.LatLng(35.5665, 126.9780),
		level: 13
	};

	map2 = new kakao.maps.Map(container, options);
	
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
                newNode.innerHTML = '<a class="dropdown-item day-text text-center" style="font-weight: bolder;">' + '<i class="bi bi-send"></i>' +' Day' + dayDto.plan_day + '</a>'; // 'li' 요소에 'a' 태그와 텍스트 삽입
                newNode.querySelector(".dropdown-item").setAttribute("onclick", "loadMyList(" + dayDto.plan_day_id + "," + dayDto.plan_day + ")");
                dayList.appendChild(newNode);
             }

             // 첫번째 day에 대한 명소 목록을 로드합니다.
             if (firstDayId !== undefined) {
                loadMyList(firstDayId, 1); // 1 넣을까 말까
             }
          }
       }
    }

    xhr.open("get", "../plan/getPlanDayList2?planId=" + planId);
    xhr.send();
}

function loadMyList(plan_day_id, plan_day){
    const xhr = new XMLHttpRequest();
    
    myDayPlaceList = [];
    myDayPlaceNames = [];
    myDayPlacePhoto = [];
    // 모든 마커 제거
    for (let i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = []; // 마커 배열 초기화
    
    // 모든 오버레이 제거
    for (let i = 0; i < overlays.length; i++) {
        overlays[i].setMap(null);
    }
    overlays = []; // 오버레이 배열 초기화
    
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
                if(response.myList != null)  {
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
                    		
                            const dayChangeButton = document.getElementById("dayChange");
                            dayChangeButton.innerHTML = `<i class="bi bi-calendar-check"></i> Day ` +plan_day;
                            
                            newElementInner.querySelector(".placeName").style.fontSize = "20px";
                            newElementInner.removeAttribute("id");
                            newElementInner.classList.remove("d-none");
                            newElementInner.querySelector(".readPlace").href = "../planPlace/PlanPlaceDetailPage?plan_place_id=" + y.planPlaceDto.plan_place_id;                                
                            

                            route_col.appendChild(newElementInner);
                            
                            myDayPlaceList.push(y.planPlaceDto.plan_place_address);
                            myDayPlaceNames.push(y.planPlaceDto.plan_place_name);
                            myDayPlacePhoto.push(y.planPlaceDto.plan_place_photo);
                            console.log(myDayPlacePhoto);
                            
                            if (myDayPlaceList.length >= 2) {
                                drawPin(myDayPlaceList[myDayPlaceList.length - 2], myDayPlaceList[myDayPlaceList.length - 1], polyline);  // polyline 객체를 인수로 전달
                            }
                        }                  
                    }  
                }  
             
            }
        }
    }

    xhr.open("get", "../plan/getMyList?dayId=" + plan_day_id);
    xhr.send();
}


//일정별 마커와 루트
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
    }

    // Separate loop for marker creation and event listener
    for (let i = 0; i < coords.length; i++) {
        createMarker(i, coords[i]);
    }

    polyline.setPath(coords);
    polyline.setMap(map2);
}

// 일정별 루트 명소들 이름
function createMarker(i, coords) {
   var marker = new kakao.maps.Marker({
       map: map2,
       position: coords
   });

   var content = 
      '<div style="padding:5px; font-size: 11px; font-weight: bolder; background-color: white; width: 145px; border-radius: 10px; position: relative; margin-bottom: 1px; margin-left: 61px;">' 
          +'<div style="display: flex; align-items: center;">'
              +'<img style="width: 30px; height: 30px; border-radius: 50%;" src="/uploadFiles/mainImage/'+ myDayPlacePhoto[i] +'">'
              +'<span style="font-size: 11px; margin-left: 10px;">'+ myDayPlaceNames[i] +'</span>' 
          +'</div>'
          +'<div style="position: absolute; bottom: -10px; left: 30px; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid white;"></div>'
      +'</div>';


   // Create a custom overlay
   let overlay = new kakao.maps.CustomOverlay({
       content: content,
       map: map2,
       position: marker.getPosition(),
       yAnchor: 1.2
   });      

   markers.push(marker);
   overlays.push(overlay);
}
	


function startPointLocation() {
	var geocoder = new kakao.maps.services.Geocoder();

	geocoder.addressSearch(startPoint, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			coords1 = new kakao.maps.LatLng(result[0].y, result[0].x);

			if (marker1) {
				marker1.setPosition(coords1);
			} else {
				marker1 = new kakao.maps.Marker({
					map: map1,
					position: coords1
				});
			}

			var content = '<div style="width:150px; text-align:center; padding:6px 0;">' + startPoint + '</div>';

			if (infowindow) {
				infowindow.setContent(content);
			} else {
				infowindow = new kakao.maps.InfoWindow({
					content: content
				});
			}

			infowindow.open(map1, marker1);

			map1.setCenter(coords1);
			map1.setLevel(4);
		}
	});
}

function showStart() {
	var address = startPoint;
	search(address);
}





function search(keyword) {
	var geocoder = new kakao.maps.services.Geocoder();

	geocoder.addressSearch(keyword, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			coords1 = new kakao.maps.LatLng(result[0].y, result[0].x);


			 var content = '<div style="background-color: white; border-radius: 15px; padding: 5px; width: 100%; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3); position: relative; font-weight: 700;">'
				+ '<span style="background-color: #03c75a; border-radius: 50%; width: 30px; height: 30px; padding: 5px; display: inline-flex; align-items: center; justify-content: center;"><i class="bi bi-geo-alt-fill" style="font-size: 20px; color: white;"></i></span>'
				+ ' '
				+ keyword
				+ '<div style="position: absolute; bottom: -8px; left: 10px; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid white;"></div>'
				+ '</div>';


			
			var mainOverlay = new kakao.maps.CustomOverlay(
					{
						position : coords1,
						content : content,
						yAnchor : 0.7,
						xAnchor : 0.1
					});

			
			mainOverlay.setMap(map1);
			
			map1.setCenter(coords1);
			map1.setLevel(3);
		}
	});
}





function planprice(){
	
	var planPrice = document.querySelector(".planprice");
	planPrice.innerText = addThousandSeparator(${map.guidePlanningDto.guide_planning_price}) + '원'
	    
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


	 
	 
	 
	
	 
	
	 
	 function showCoupon(){
		
		 
		 const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					
					
					
					const myCoupon = document.querySelector(".myCoupon");
					
					const ccc = document.createElement("option");
					ccc.classList.add("selected");
					ccc.value = 0;
					ccc.innerText="My Coupon"
					
					myCoupon.appendChild(ccc);
					 
					if (response.list != null){
						
						for ( data of response.list){
							
							const option = document.createElement("option");
							option.value = data.couponDto.coupon_discount;
						    option.innerText = data.couponDto.coupon_title + " (" +addThousandSeparator(option.value)+"원)"
						    
						    myCoupon.appendChild(option);
							
						}
						 myCoupon.addEventListener("change", function () {
						        discount(myCoupon.value);
						      });

					}
					
					
				}
			}
			
			//get
			xhr.open("get", "./getCoupon?user_id="+user_id);
			xhr.send();
	
	 }
	 
	 function discount(couponDiscount) {
		  
		
		 const guidePlanningPrice = parseFloat(${map.guidePlanningDto.guide_planning_price});

		
		  couponDiscountValue = parseFloat(couponDiscount);

		  
		  const discountPay = guidePlanningPrice - couponDiscountValue;
		  
		 var planPrice = document.querySelector(".planprice");
			planPrice.innerText = addThousandSeparator(discountPay) + '원'
		
		}
	 
	 
		 /* function info() {
			
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
					            	city.style.fontWeight = 'bold';
					            	city.style.color = 'gray';  // 텍스트 색상을 회색으로 설정
					            	placeNameElement.appendChild(city);
					            	
					            	const address = document.createElement('input');
				                     address.classList.add('address');
				                     address.setAttribute('type', 'hidden');
				                     address.value = place.planPlace.plan_place_address; 
				                     placeNameElement.appendChild(address); 
					            	
					            	
					            	bbb.querySelector(".place_thumbnail").src = "/uploadFiles/mainImage/" + place.planPlace.plan_place_photo;
					            	
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
		 
		
 */
 
 var commentList;
 
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
		xhr.open("post", "./createInitComment");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var params = "guide_planning_id=" + guidePlanningId + "&user_comment=" + encodeURIComponent(comment.value);
		xhr.send(params);
	}
 
 function formatDate(date) {
		var yyyy = date.getFullYear();
		var MM = ('0' + (date.getMonth() + 1)).slice(-2); // Months are zero based
		var dd = ('0' + date.getDate()).slice(-2);
		var hh = ('0' + date.getHours()).slice(-2);
		var mm = ('0' + date.getMinutes()).slice(-2);

		return yyyy + '/' + MM + '/' + dd + ' ' + hh + ':' + mm;
	}
 
 function guideProfile(){
	 
	 const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				
				if(response != null){
					
					console.log(response.guide.user_image);
					const guideProfile = document.querySelector(".guide_profile")
					
					const img = document.createElement('img');
				    img.classList.add('guide_thumbnail');
				    img.alt = "썸네일";
				    img.src = '/uploadFiles/profileImage/'+ response.guide.user_image;
				    img.setAttribute('data-bs-toggle', 'dropdown');
					
				    if (response.guide.user_id != '${sessionuser.user_id}') {
				    	const dropdownMenu = document.createElement('div');
					    dropdownMenu.classList.add('dropdown-menu');

					    // 드랍다운 메뉴 엘리먼트 추가
					    const dropdownItem1 = document.createElement('a');
					    dropdownItem1.classList.add('dropdown-item');
					    dropdownItem1.innerText = '신고하기';
					    
					    const dropdownItem2 = document.createElement('a');
					    dropdownItem2.classList.add('dropdown-item');
					    dropdownItem2.innerText = '쪽지보내기';
					    
					    dropdownMenu.appendChild(dropdownItem2);
					    dropdownMenu.appendChild(dropdownItem1);
					    
					    dropdownItem1.addEventListener('click', function(e) {
					        e.preventDefault();

					        // 클로저에 현재 사용자 객체를 저장
					        var currentUser = response.guide;

					        var myModalEl = document.getElementById('reportModal');
					        var myModal = new bootstrap.Modal(myModalEl, {});

					        // 모달이 보여질 때 currentUser 객체를 사용
					        myModalEl.addEventListener('shown.bs.modal', function () {
					            // 히든 인풋 필드의 값을 currentUser.user_id로 설정
					            document.getElementById('reportedUserId').value = currentUser.user_id;
					        });

					        myModal.show();
					    });
					    
					    dropdownItem2.addEventListener('click', function(e) {
					        e.preventDefault();

					        // 클로저에 현재 사용자 객체를 저장
					        var currentUser = response.list.guide;

					        var myModalEl = document.getElementById('noteModal');
					        var myModal = new bootstrap.Modal(myModalEl, {});

					        // 모달이 보여질 때 currentUser 객체를 사용
					        myModalEl.addEventListener('shown.bs.modal', function () {
					            // 히든 인풋 필드의 값을 currentUser.user_id로 설정
					            document.getElementById('notedUserNickname').value = currentUser.user_nickname;
					        });

					        myModal.show();
					    });
					    
					    guideProfile.style.cursor = 'pointer';
					    guideProfile.appendChild(dropdownMenu);
				    }
				    guideProfile.appendChild(img);
				}
			}
		}
		
		
		
		//post
		xhr.open("post", "./getGuideProfile");
		xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
		xhr.send("guide_planning_id="+guidePlanningId);
	 
	 
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
					
					var replyInputCol = null;
					
					boardInfo.innerText =  '  댓글 ' + response.list.length;
					
					for (let i in response.list) {
						
						console.log(response.list[i]);
						commentList = document.querySelector('.comment-list');
						
						var date = new Date(response.list[i].guidePlanningComment.reg_date);
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
					    img.src = '/uploadFiles/profileImage/'+response.list[i].user.user_image;
					    img.setAttribute('data-bs-toggle', 'dropdown');
					    
					    if (response.list[i].user.user_id != '${sessionuser.user_id}') {
					    	const dropdownMenu = document.createElement('div');
						    dropdownMenu.classList.add('dropdown-menu');

						    // 드랍다운 메뉴 엘리먼트 추가
						    const dropdownItem1 = document.createElement('a');
						    dropdownItem1.classList.add('dropdown-item');
						    dropdownItem1.innerText = '신고하기';
						    
						    const dropdownItem2 = document.createElement('a');
						    dropdownItem2.classList.add('dropdown-item');
						    dropdownItem2.innerText = '쪽지보내기';
						    
						    dropdownMenu.appendChild(dropdownItem2);
						    dropdownMenu.appendChild(dropdownItem1);
						    
						    dropdownItem1.addEventListener('click', function(e) {
						        e.preventDefault();

						        // 클로저에 현재 사용자 객체를 저장
						        var currentUser = response.list[i].user;

						        var myModalEl = document.getElementById('reportModal');
						        var myModal = new bootstrap.Modal(myModalEl, {});

						        // 모달이 보여질 때 currentUser 객체를 사용
						        myModalEl.addEventListener('shown.bs.modal', function () {
						            // 히든 인풋 필드의 값을 currentUser.user_id로 설정
						            document.getElementById('reportedUserId').value = currentUser.user_id;
						        });

						        myModal.show();
						    });
						    
						    dropdownItem2.addEventListener('click', function(e) {
						        e.preventDefault();

						        // 클로저에 현재 사용자 객체를 저장
						        var currentUser = response.list[i].user;

						        var myModalEl = document.getElementById('noteModal');
						        var myModal = new bootstrap.Modal(myModalEl, {});

						        // 모달이 보여질 때 currentUser 객체를 사용
						        myModalEl.addEventListener('shown.bs.modal', function () {
						            // 히든 인풋 필드의 값을 currentUser.user_id로 설정
						            document.getElementById('notedUserNickname').value = currentUser.user_nickname;
						        });

						        myModal.show();
						    });
						    
						    col1Div.style.cursor = 'pointer';
						    col1Div.appendChild(dropdownMenu);
					    }
					    
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
					    p2.style.fontSize = '0.7em';
					    p2.style.color = '#999999';
					    colDiv.appendChild(p1);
					    colDiv.appendChild(p2);

					    // Col-12 div
					    const col12Div = document.createElement('div');
					    col12Div.classList.add('col-12');
					    const div = document.createElement('div');
					    div.innerText = response.list[i].guidePlanningComment.user_comment;
					    col12Div.appendChild(div);
					    
					    // Another col-12 div
					    const anotherCol12Div = document.createElement('div');
					    anotherCol12Div.classList.add('col-12', 'mt-1');
					    
					    
					    var heartIcon = document.createElement("i");
					    heartIcon.className = response.list[i].isLove == 'ok' ? 'bi, bi-heart-fill text-danger' : 'bi, bi-heart'; 
					    heartIcon.onclick = function() {
							loginCheck();
							
							addLike(response.list[i].guidePlanningComment.guide_planning_comment_id);	
						}
					    const span = document.createElement('span');
					    span.classList.add('comment-love');
					    span.innerHTML = '좋아요 ' + response.list[i].totalLike + '개';
					    span.appendChild(heartIcon);
					    
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
		xhr.send("guide_planning_id="+guidePlanningId);
	}
 
 
 
	
	function addLike(guide_comment_id) {
	

	
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
		xhr.send("guide_planning_comment_id="+guide_comment_id);

	}
	
	function loginCheck() {
		var sessionUser = '${sessionuser}';
		if (sessionUser == '') {
			location.href = '../login';
		}
	}

 
 
	
document.addEventListener("DOMContentLoaded", function() {
	 guideProfile(); 
		planningDay();
		showStart()
		planprice();
		loadDay(); 
		initMap1();
		initMap2();
		showCoupon();
		getCommentList();
		
	

	});
 


</script>
<style>


 .user-thumbnail {
	border-radius: 50%;
	border: 2px solid #03c75a;
	margin-right: 10px;
	width: 50px;
	height: 50px;
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

.packageThumbnail {
	width: 100%;
	height: 500px;
}

.packageThumbnail2 {
	width: 100%;
	height: 240px;
}

.packageThumbnail3 {
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
   	border-top : 5px solid #ededed;
   	
}
.table th,
.table td {
    padding: 8px;
    text-align: center;
    

}
.table th {
	background-color :#fafafa;
    width: 20%;
    font-size : 20px;
}
.table td {
	background-color : white;
    width: 80%;
    font-size : 15px;
    
}



.comment-wrapper {
	position: relative;
}

.comment::placeholder {
	font-size: 0.8em;
	color: lightgrey;
}

.comment-info {
	font-size: 0.8em;
	color: #999999;
}

.comment-button {
	position: absolute;
	top: 8px;
	right: 20px;
	border: none;
	color: #03c75a;
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

.bi-heart,
.bi-heart-fill {
	margin-left: 0.5em;
	font-size: 0.9em;
}

.guide_thumbnail{

width : 100px; height:100px; border-radius:50px;

}

</style>

</head>
<body>
	<div class="container-fluid p-0">
		<div class="container">
			<jsp:include page="../common/mainTopNavi2.jsp"></jsp:include>
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
							<div class="col aaa">
								<img src="/uploadFiles/${map.placePhoto1 }"
							class="packageThumbnail2">

							</div>

						</div>
						<div class="row">
							<div class="col bbb">
								<img src="/uploadFiles/${map.placePhoto2}"
							class="packageThumbnail3">
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
				        <th><i class="bi bi-person-check-fill member1"></i> 모집인원</th>
				        <td>
				        <c:choose>
				        	<c:when test="${map.packageMember>=map.guidePlanningDto.guide_planning_member}">
				        		모집 완료
				        	</c:when>
				        	<c:otherwise>
				        		${map.packageMember}/${map.guidePlanningDto.guide_planning_member }
				        	</c:otherwise>
				        </c:choose>
				        </td>
				    </tr>
				</table>
			</div>
			<div class="col-1"></div>
			<div class="col-3 text-center shadow" style=" border-radius: 10px; background-color :#fafafa; ">
				<div class="row mt-3">
					<div class="col">
						<span style="font-size : 20px; font-weight:bold;">${map.guide.guide_name}</span><span style="font-size : 15px; font-weight:bold;">  가이드 님</span>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col guide_profile">
						
					</div>
				</div>
				<div class="row mt-5">
					<div class="col " style="color : gray;">
						${map.guide.guide_profile }
					</div>
				</div>
				<div class="row mt-5">
					<div class="col"  >
						<span style="font-size : 20px; font-weight: bold;">패키지 비용</span><span style="font-size : 10px; color:gray;  font-weight: bold;">(성인 1인 기준)</span>
					</div>
				</div>
				<div class="row mt-1">
					<div class="col planprice" style="font-size:40px; font-weight: bold;">
						
					</div>
				</div>
				<div class="row mt-3">
					<div class="col-1">
					</div>
					<select class="col form-select myCoupon" aria-label="Default select example">
					  
					</select>
					<div class="col-1">
					</div>
				
			
				</div>
				<div class="row mt-4 mb-5 ">
					<div class="col-3"></div>
					<div class="col-6 payButton ">
						 <c:choose>
				        	<c:when test="${map.packageMember>=map.guidePlanningDto.guide_planning_member}">
				        		<a class="btn pay-button d-grid" role="button" onclick="full()"
	   						 style="font-size: 15px; font-weight: bold; background-color: gray; color: white;">모집 완료</a>
				        	</c:when>
				        	<c:otherwise>
				        		<a class="btn pay-button d-grid" role="button" onclick="packageIn(guidePlanningId)"
	   						 style="font-size: 30px; font-weight: bold; background-color: #03c75a; color: white;">결제</a>
				        	</c:otherwise>
				        </c:choose>
						
					</div>
					<div class="col-3"></div>
				</div>
			</div>
				
					
			
				      
				     
			
		</div>
	</div>
	
<div class="row mt-5 mb-5">
	<div class="col-2">
	
	</div>
	<div class="col" style="border-top : solid 3px 	#ededed;">
	
	</div>
	<div class="col-2">
		
	</div>
</div>





	<div class="container" >
		<div class="row">
			<div class="col">
				<div class="row">
					<div class="col-6">
						<div class="row "  >
								<div class="col-1"></div>
								<div class="col">
									<i class="bi-flag-fill"></i>
									<span>모집 장소 : </span>
									<span style="font-weight: bold;">${map.guidePlanningDto.guide_planning_start_point}</span>
								</div>
								<div class="col-1"></div>
							</div>
							<div class="row mt-3" >
								
								<div class="col">
									<div class="map1 shadow" id="map1" style="width: 100%; height: 300px;">
									</div>		
								</div>				
								
								
							</div>
						<div class="row mt-5"  >
							 <div class="col">
				               <div class="dropdown-center d-grid" >
				                  <button class="btn dropdown-toggle shadow-sm" id="dayChange" style="font-weight: bolder;  border-radius: 12px; font-size: 20px; background-color: #faf7f0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
				                     <i class="bi bi-calendar-check"></i> 일정별 루트 목록                   
				                  </button>
				                  <ul class="dropdown-menu align-items-center" id="templete_day" style="font-size: 20px;">
				                     <!-- <li><a class="dropdown-item day-text" href="#"><i class="bi bi-send"></i> Day 1</a></li> -->                                          
				                  </ul>
				               </div>
				            </div>
						</div>
						<div class="row mt-3">
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
					<div class="col-1">
					</div>
					<div class="col-5">
						<div class= "row mt-5">
							<div class="col">
								<div class="map2 shadow" id="map2" style="width: 100%; height: 800px;">
								</div>	
							</div>
						</div>			
					</div>
				</div>
			</div>
		</div>
			<div class="row mt-5 mb-5">
				
				<div class="col" style="border-top : solid 3px 	#ededed;">
				
				</div>
				
			</div>
		<div class="row mt-5">
			<div class="col-2"></div>
			<div class="col">
				<div class="row">
					<div class="col-12 mb-1 comment-info d-flex justify-content-between">
						<span class="board-info"></span>
					</div>
					<div class="col mb-3 comment-wrapper" onclick="loginCheck()">
						<input class="form-control comment p-2" type="text" placeholder="댓글을 입력해주세요.">
						<button class="comment-button" style = "background:white; font-size:15px;font-weight:bold;"type="button" onclick="createCommentFunc()">작성</button>
					</div>
				</div>
				<div class="row">
					<div class="col comment-list"></div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		
	</div>
<div class="container">
		<div class="row">
			<div class="col">
				<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
					<div class="modal-dialog  modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="reportModalLabel">신고하기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="container">
									<div class="row">
										<div class="col">
											<form action="/travel/admin/userReport?user_id=${sessionuser.user_id}" method="post" enctype="multipart/form-data">
												<!-- 신고 대상자의 아이디를 담을 hidden input field 추가 -->
												<input type="hidden" id="reportedUserId" name="reported_user_id">
												
												<div class="row">
													<div class="col">
														<div class="form-floating">
															<textarea class="form-control" placeholder="#" id="floatingTextarea2" name="user_report_desc" style="height: 15em; resize: none;"></textarea>
															<label for="floatingTextarea2" style="font-size: 0.9em;">신고사유를 적어주세요. 허위 신고시 불이익이 있을 수 있습니다.</label>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col d-flex justify-content-end mt-2">
														<input class="form-control" type="file" id="imageUpload" name="reportImages" accept="image/*" multiple>
													</div>
													<div class="col-12">
														<div id="previewImages" style="display: none; overflow-x: auto; margin: 0.5em 0 0.5em 0; padding: 0.5em;"></div>
													</div>
												</div>
												<div class="row mt-2">
													<div class="col d-flex justify-content-end">
														<button type="submit" class="btn" style="background-color: #03c75a; color: white;" >신고 제출</button>
													</div>
												</div>
											</form>
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
			<div class="col">
				<div class="modal fade" id="noteModal" tabindex="-1" aria-labelledby="noteModalLabel" aria-hidden="true">
					<div class="modal-dialog  modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="noteModalLabel">쪽지보내기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="container">
									<div class="row">
										<div class="col">
											<form action="/travel/sendMessageProcess?user_id=${sessionuser.user_id}" method="post">
												<!-- 신고 대상자의 아이디를 담을 hidden input field 추가 -->
												<input type="hidden" id="notedUserNickname" name="user_nickname">

												<div class="row mb-2">
													<div class="col">
														<input name="message_title" class="form-control" type="text" placeholder="제목">
													</div>
												</div>
												<div class="row">
													<div class="col">
														<div class="form-floating">
															<textarea class="form-control" placeholder="#" id="floatingTextarea3" name="message_content" style="height: 15em; resize: none;"></textarea>
															<label for="floatingTextarea3" style="font-size: 0.9em;">스팸성 쪽지는 제재 사유가 될 수 있습니다.</label>
														</div>
													</div>
												</div>
												<div class="row mt-2">
													<div class="col d-flex justify-content-end">
														<button class="btn" style="background-color: #03c75a; color: white;" type="submit">보내기</button>
													</div>
												</div>
											</form>
										</div>
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