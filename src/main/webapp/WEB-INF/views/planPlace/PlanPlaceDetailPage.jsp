<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>


//SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
document.addEventListener("DOMContentLoaded", function() {
	Kakao.init('93ae12d4c0f00044228cbd5b5f2f588b'); // 여기에 JavaScript 키를 붙여넣으세요.

    // SDK 초기화 여부를 판단합니다.
	console.log(Kakao.isInitialized());
});

function logout() {
    Kakao.Auth.logout(function() {
        console.log('로그아웃이 완료되었습니다.');
        // 로그아웃이 완료되면 서버 측 로그아웃 URL로 리다이렉트
        location.href = '/travel/logoutProcess';
    });
}
	
	const planPlaceId = new URLSearchParams(location.search).get("plan_place_id");
	
	function ajaxTemplete() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
			}
		}
		
		//get
		xhr.open("get", "요청 url?파라미터=값");
		xhr.send();
		
		//post
		xhr.open("post", "요청 url");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("파라미터 = 값");
	}
	
	//로그인 상태 확인
	let sessionUserId = null;
	
	function getUserId() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				if (response.result == "success") {
					
					sessionUserId = response.userId;
				}
			}
		}
		
		xhr.open("get", "/travel/getUserId", false);
		xhr.send();
	}
	
	//댓글 등록
	function registerComment() {
		
		console.log("함수는 실행돼~");
		
		if (sessionUserId == null) {
			
			return;
			
		}
		
		const commentBox = document.getElementById("commentBox");
		const commentBoxValue = commentBox.value;
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				commentBox.value = "";
				
				resetCommentList();
			}
		}
		
		
		
		xhr.open("post", "./registerComment");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("plan_place_id=" + planPlaceId + "&plan_place_user_comment=" + commentBoxValue);
	
	}
	
	//좋아요 액션
	function clickHeart() {
		
		if (sessionUserId == null) {
			
			if (confirm("로그인을 하셔야 이용하실 수 있습니다. 로그인 하시겠습니까?")) {
				
				location.href = "/travel/login";
				
			}
			
			return;
		}
		
		console.log("hello");
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				resetHeart();
				resetCountOfHeart()
				
			}
		}
		
		xhr.open("get", "./clickHeart?plan_place_id=" + planPlaceId);
		xhr.send();
		
		
	}
	
	//좋아요 상태 최신화
	function resetHeart() {
		
		if (sessionUserId == null) return;
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const heartBox = document.getElementById("heartBox");
				
				if (response.heartStatus == null) {
					
					heartBox.classList.remove("bi-heart-fill");
					heartBox.classList.add("bi-heart");
					
				} else {
					
					heartBox.classList.remove("bi-heart");
					heartBox.classList.add("bi-heart-fill");
				}
			}
		}
		
		xhr.open("get", "./checkHeartStatus?plan_place_id=" + planPlaceId);
		xhr.send();
		
	}
	
	//좋아요 갯수 최신화
	function resetCountOfHeart() {
		
		console.log("hello");
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const countHeartBox = document.getElementById("countHeart");
				
				countHeartBox.innerText = response.heartCount;
			}
		}
		
		xhr.open("get", "./checkHeartCount?plan_place_id=" + planPlaceId);
		xhr.send();
		
	}
	
	//댓글 갯수 최신화
	function resetCountOfComment() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const countCommentBox = document.querySelectorAll(".commentCount");
				
				countCommentBox.innerText = response.commentCount;
			}
		}
		
		xhr.open("get", "./checkCommentCount?plan_place_id=" + planPlaceId);
		xhr.send();
	}
	
	function resetCommentList() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const commentListBox = document.getElementById("commentListBox");
				
				commentListBox.innerHTML = "";
				
				for(data of response.commentList) {
					const rowDiv1 = document.createElement("div");
					rowDiv1.setAttribute("class", 'row mt-2');
					commentListBox.appendChild(rowDiv1);
				
					const colDiv1 = document.createElement("div");
					colDiv1.setAttribute("class", "col-auto pe-0");
					rowDiv1.appendChild(colDiv1);
					
					const imgDiv1 = document.createElement("img");
					imgDiv1.setAttribute("class", "userImage");
					imgDiv1.setAttribute("src", "/uploadFiles/profileImage/" + data.userDto.user_image);
					colDiv1.appendChild(imgDiv1);
					
					const colDiv2 = document.createElement("div");
					colDiv2.setAttribute("class", "col");
					rowDiv1.appendChild(colDiv2);
					
					const rowDiv2 = document.createElement("div");
					rowDiv2.setAttribute("class", "row");
					colDiv2.appendChild(rowDiv2);
					
					const colDiv3 = document.createElement("div");
					colDiv3.setAttribute("class", "col");
					rowDiv2.appendChild(colDiv3);
					
					const spanDiv1 = document.createElement("span");
					spanDiv1.style.fontSize = "0.9em";
					spanDiv1.style.fontWeight = "500";
					spanDiv1.textContent = data.userDto.user_nickname;
					colDiv3.appendChild(spanDiv1);
					
					const rowDiv3 = document.createElement("div");
					rowDiv3.setAttribute("class", "row");
					colDiv2.appendChild(rowDiv3);
					
					const colDiv4 = document.createElement("div");
					colDiv4.setAttribute("class", "col");
					rowDiv3.appendChild(colDiv4);
					
					const spanDiv2 = document.createElement("span");
					spanDiv2.style.fontSize = "0.9em";
					spanDiv2.style.fontWeight = "500";
					spanDiv2.textContent = data.planPlaceCommentDto.plan_place_user_comment;
					colDiv4.appendChild(spanDiv2);
					
					const rowDiv4 = document.createElement("div");
					rowDiv4.setAttribute("class", "row mt-1");
					colDiv2.appendChild(rowDiv4);
					
					const colDiv5 = document.createElement("div");
					colDiv5.setAttribute("class", "col");
					rowDiv4.appendChild(colDiv5);		
										
					const regDate = data.planPlaceCommentDto.plan_place_reg_date;
					const date = new Date(parseInt(regDate)); // parseInt를 사용하여 숫자로 변환
					const year = date.getFullYear();
					const month = String(date.getMonth() + 1).padStart(2, '0');
					const day = String(date.getDate()).padStart(2, '0');
					const hours = String(date.getHours()).padStart(2, '0');
					const minutes = String(date.getMinutes()).padStart(2, '0');

					const formattedDate = `${year}.${month}.${day} ${hours}:${minutes}`;

					const spanDiv3 = document.createElement("span");
					spanDiv3.style.fontSize = "0.75em";
					spanDiv3.style.color = "gray";
					spanDiv3.textContent = formattedDate;
					colDiv5.appendChild(spanDiv3);
					
					const hrDiv1 = document.createElement("hr");
					hrDiv1.setAttribute("class", 'my-2 hrStyle');
					commentListBox.appendChild(hrDiv1);
					
				}
			}
		}
		
		xhr.open("get", "./commentList?plan_place_id=" + planPlaceId);
		xhr.send();
	}
	
	window.addEventListener("DOMContentLoaded", function() {
		
		getUserId();
		resetHeart();
		resetCountOfHeart();
		resetCountOfComment();
		resetCommentList();
		
	});
	
</script>

<style>

	body {
		font-family: 'Noto Sans KR', sans-serif;	
	}
		
     .userImage {
		width: 2.7em; 
		height: 2.7em;
		border-radius: 50%; 
		overflow: hidden; 
	}
	
	.cardBox {
		width: auto;
		height: auto;
		border: none;
		border-radius: 10px;
		background-color: #f2f2f2;
		padding: 2em;
	}
	
	.listBox {
		background-color: #f2f2f2;
		text-decoration: none;
		padding: 0.6em 0.9em;
		border: none;
		border-radius: 5px;
		width: auto;
		height: auto;
		font-size: 0.85em;
		font-weight: 400;
		color: black;
	}
	
	.listBox:hover {
		background-color: #dbdbdb;
		color: black;
		cursor: pointer;
	}
	
	.registerBox{
		background-color: #e0ffe9;
		text-decoration: none;
		padding: 0.8em 1.2em;
		border: none;
		border-radius: 5px;
		width: auto;
		height: auto;
		font-size: 0.8em;
		font-weight: 500;
		color: #00942b;
	}
	
	.registerBox:hover{
		background-color: #ceebd6;
		color: #21472c;
		cursor: pointer;	
	}
	
	.commentContainer {
		border: 2px solid #e6e6e6;
		border-radius: 5px;
 		padding: 0.7em 1em;
	}
	
	.commentBox {
		border: none;
		outline: none;
		background: transparent;
		font-size: 0.9em;
		padding: 5px;
		width: 100%;
	}
	
	.registerCommentBox {
		color: gray;
		font-size: 0.9em;
		border: none;
		background-color: white;
	}
	
	.hrStyle {
		color: gray;
	}
		

</style>
    
</head>
<body>
	
	<div class="container">
		<div class="row fw-bold justify-content-center">
			<div class="col-8">
				<nav class="navbar navbar-expand-lg bg-body-tertiary">
					<div class="container-fluid p-0">
						<span class="fw-bold navbar-brand mb-0 h1" style="font-size: 30px; font-weight: 700;"> TripStation</span>
						<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav me-auto mb-2 mb-lg-0">
								<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" aria-current="page" data-bs-toggle="dropdown" href="/travel/main" aria-expanded="false">여행</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="/travel/main">맞춤여행</a></li>
										<li><a class="dropdown-item" href="/travel/package">패키지</a></li>
									</ul>
								</li>
								<li class="nav-item"><a class="nav-link" href="/travel/plan/planPage">플래너</a></li>
								<li class="nav-item"><a class="nav-link" href="#" role="button">크루</a></li>
								<li class="nav-item"><a class="nav-link" href="/travel/hotel/hotelPage" role="button">숙소</a></li>
								<li class="nav-item"><a class="nav-link" href="/travel/planPlace/placePage">플레이스</a></li>
							</ul>
							<c:choose>
								<c:when test="${!empty sessionuser}">
									<ul class="navbar-nav align-items-center">
										<li>
											<c:choose>
												<c:when test="${sessionuser.user_image != null}">
													<img alt="썸네일" src="/uploadFiles/profileImage/${sessionuser.user_image}" style="width: 2em; height: 2em; border-radius: 50%;">
												</c:when>
												<c:otherwise>
													<img alt="썸네일" src="/travel/resources/img/icon.png" style="width: 2em; height: 2em; border-radius: 50%;">
												</c:otherwise>
											</c:choose>
										</li>
										<li class="nav-item dropdown">
											<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> ${sessionuser.user_nickname} </a>
											<ul class="dropdown-menu" aria-labelledby="userDropdown">
												<li><a class="dropdown-item" href="/travel/myPage">마이페이지</a></li>
												<li><a class="dropdown-item" href="/travel/crew/main">크루페이지</a></li>
												<li><a class="dropdown-item" href="/travel/allCouponPage">쿠폰</a></li>
												<li><a class="dropdown-item" href="/travel/messageGot">쪽지</a></li>
												<li><a class="dropdown-item" href="javascript:logout();">로그아웃</a></li>
											</ul>
										</li>
									</ul>
								</c:when>
								<c:otherwise>
									<a class="nav-link" href="/travel/login">로그인</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</nav>
			</div>
		</div>
	
        <div class="row mt-5 justify-content-center">
            <div class="col-8">
            	<div class="row justify-content-end">
            		<div class="col-auto">
            			<a class="listBox">
            				<i class="bi bi-chevron-up"></i>
            				이전글
            			</a>
            		</div>
            		<div class="col-auto px-0">
            			<a class="listBox">
            				<i class="bi bi-chevron-down"></i>
            				다음글
            			</a>
            		</div>
            		<div class="col-auto">
            			<a href="/travel/planPlace/placePage" class="listBox">목록</a>
            		</div>
            	</div>
            	<hr class="my-3 hrStyle">
            	<div class="row align-items-center">
            		<div class="col-auto pe-1">
            			<span style="font-size: 0.9em; font-weight: 400; color: #00942b;">서울특별시</span>
            		</div>
            		<div class="col ps-0">
            			<i style="font-size: 0.7em;" class="bi bi-chevron-right"></i>
            		</div>
            	</div>
            	<div class="row mb-2">
            		<div class="col">
            			<span style="font-size: 1.6em; font-weight: 500;">${map.planPlaceDto.plan_place_name}</span>
            		</div>
            	</div>
                <div class="row">
                    <div class="col">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <img class="userImage" src="/uploadFiles/profileImage/${map.userDto.user_image}" alt="">
                            </div>
                            <div class="col-auto ps-0">
                                <div class="row">
                                    <div class="col">
                                        <span style="font-size: 0.9em; font-weight: 500;">${map.userDto.user_nickname}</span>
                                    </div>
                                </div>
                                <div class="row align-items-center">
                                    <div class="col">
                                        <span style="font-size: 0.75em; color: gray;"><fmt:formatDate value="${map.planPlaceDto.plan_place_reg_date}" pattern="yyyy.MM.dd HH:mm"/></span>
                                    </div>
                                    <div class="col-auto ps-0">
                                    	<span style="font-size: 0.75em; color: gray;">조회</span>
                                    	<span style="font-size: 0.75em; color: gray;">207</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="row justify-content-end" style="position: relative; top: 50%;">
                            <div class="col-auto ps-2 pe-1">
                            	<i style="font-size: 0.9em;" class="bi bi-chat"></i>
                            </div>
                            <div class="col-auto px-0">
                         		<span style="font-size: 0.9em; font-weight: 500;">댓글</span>
                         	</div>
                            <div class="col-auto px-1">
                            	<span id="commentCount" style="font-size: 0.9em; font-weight: 500;"></span>
                           	</div>
                           	<div class="col-auto ps-2 pe-0">
                           		<span style="font-size: 0.85em;">URL 복사</span>
                           	</div>
                           	<div class="col-auto ps-1">
                           		<i style="font-size: 1.2em; position: relative; bottom: 3px;" class="bi bi-three-dots-vertical"></i>
                           	</div>
                        </div>
                    </div>
                </div>
                <hr class="my-4 hrStyle">
                <div class="row mt-3 mb-5">
                    <div class="col">
                        <img style="width:100%; height: 42em; overflow: hidden; border-radius: 5px;" src="/uploadFiles/mainImage/${map.planPlaceDto.plan_place_photo}" alt="">
                    </div>
                </div>
                <div class="row py-5">
           			<div class="col">
           				<div class="row align-items-center">
           					<div class="col">
           						<div class="row">
           							<div class="col px-5">
           								<span style="font-size: 0.9em; font-weight: 500;">"${map.planPlaceDto.plan_place_content}"</span>
           							</div>
           						</div>
           					</div>
           				</div>
           			</div>
           		</div>	
   				<div class="row mt-4">
   					<div class="col text-end" >
   						<i class="bi bi-geo-alt-fill" style="color: rgb(255, 90, 90);"></i>
   						<span class="ps-0" style="font-size: 0.9em; font-weight: 500; color: gray;">${map.planPlaceDto.plan_place_address}</span>
   					</div>
   				</div>
                <c:forEach items="${detailPhotoList}" var="list">
	                <div class="row my-2">
	                    <div class="col">
	                        <img style="width: 100%; height: 42em;" src="/uploadFiles/${list.planPlacePhotoDto.plan_place_photo_link}" alt="">
	                    </div>
	                </div>
                </c:forEach>
                <div class="row mt-5">                
                    <div class="col">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <img class="userImage" src="/uploadFiles/profileImage/${map.userDto.user_image}" alt="">
                            </div>
                            <div class="col-auto px-0">
                                <span style="font-size: 0.9em; font-weight: 500;">${map.userDto.user_nickname}</span>
                            </div>
                            <div class="col-auto px-1">
                            	<span style="font-size: 0.9em;">
                            		님의 게시글 더보기
                            	</span>
                            </div>
                            <div class="col-auto ps-0">
                            	<i style="font-size: 0.8em;" class="bi bi-chevron-right"></i>
                            </div>
                        </div>
                        <div class="row mt-3 align-items-center">
                        	<div class="col-auto pe-0">
                         		<i onclick="clickHeart()" id="heartBox" class="bi bi-heart" style="font-size: 0.9em; color: red;"></i>
                         	</div>
                         	<div class="col-auto px-1">
                         		<span style="font-size: 0.85em; font-weight: 500;">좋아요</span>
                         	</div>
                         	<div class="col-auto px-1">
                                 <span id="countHeart" style="font-size: 0.85em; font-weight: 500;"></span>
                            </div>
                            <div class="col-auto ps-2 pe-1">
                            	<i style="font-size: 0.85em;" class="bi bi-chat"></i>
                            </div>
                            <div class="col-auto px-0 commentCount">
                         		<span style="font-size: 0.85em; font-weight: 500;">댓글</span>
                         	</div>
                            <div class="col-auto ps-1">
                            	<span id="commentCount" style="font-size: 0.8em; font-weight: 500;"></span>
                           	</div>
                           	<div class="col text-end pe-1">
                           		<i class="bi bi-box-arrow-up-right"></i>
                           		<span style="font-size: 0.8em;">공유</span>
                           	</div>
                           	<div class="col-auto px-2">
                           		<span style="font-size: 0.8em; color: gray;">|</span>
                           	</div>
                           	<div class="col-auto ps-1">
                           		<span style="font-size: 0.8em;">신고</span>
                           	</div>
                        </div>
                        <hr class="my-2 hrStyle">
                    </div>
                </div>
                <div class="row my-2">
                	<div class="col">
                		<span style="font-size: 1.2em; font-weight: 500;">댓글</span>
                	</div>
                </div>
                <div class="row">
                	<div id="commentListBox" class="col"></div>
                </div>
                <div class="row">
                	<div class="col">
                		<div class="row">
                			<div class="col-auto pe-0">
                				<img class="userImage" alt="" src="/uploadFiles/profileImage/${map.userDto.user_image}">
                			</div>
                			<div class="col">
                				<div class="row">
                					<div class="col">
                						<span style="font-size: 0.9em; font-weight: 500;">
                							${map.userDto.user_nickname}
                						</span>
                					</div>
                				</div>
                				<div class="row">
                					<div class="col">
                						<span style="font-size: 0.9em;">
                							테스트 댓글 입니다.
                						</span>
                					</div>
                				</div>
                				<div class="row mt-1">
                					<div class="col">
                						<span style="font-size: 0.75em; color: gray;"><fmt:formatDate value="${map.planPlaceDto.plan_place_reg_date}" pattern="yyyy.MM.dd HH:mm"/></span>
                					</div>
                				</div>
                			</div>
                		</div>
                		<hr class="my-2 hrStyle">
                	</div>
                </div>
                <div class="row my-4">
                    <div class="col">
               			<div class="commentContainer">
	                    	<div class="row">
	                    		<div class="col ps-2">
	                    			<span style="font-size: 0.9em; font-weight: 500;">${sessionuser.user_nickname }</span>
	                    		</div>
	                    	</div>
	                    	<div class="row">
	                    		<div class="col ps-1">
		                        	<input class="commentBox" id="commentBox" type="text" placeholder="댓글을 남겨보세요">
	                    		</div>
	                    	</div>
	                    	<div class="row justify-content-end">
	                    		<div class="col-auto">
		                        	<input class="registerCommentBox" onclick="registerComment()" type="button" value="등록">
	                    		</div>
	                    	</div>
                    	</div>
                    </div>
                </div>
                <div class="row justify-content-end">
                	<div class="col">
                		<a href="/travel/planPlace/registerPlacePage" class="registerBox">
                			<i style="font-size: 1.2em;" class="bi bi-pencil-square"></i>
                			글쓰기
                		</a>
                	</div>
                	<div class="col-auto">
                		<a href="/travel/planPlace/placePage" class="listBox">
                			목록
                		</a>
                	</div>
                	<div class="col-auto ps-0">
                		<a class="listBox">
                			<i class="bi bi-caret-up-fill"></i>
                			top
                		</a>
                	</div>
                </div>
                <div class="row mt-5 mb-3">
                    <div class="col">
                        <span style="font-size: 1.2em; font-weight: 500;">플레이스 인기글</span>
                    </div>
                </div>
                <div class="row mb-4">
                	<c:forEach items="${listOrderByLove}" var="list" begin="0" end="8">
	                	<div class="col-4">
	                		<div class="row">
	                			<div class="col-auto pe-0">
	                				<img style="border-radius: 5px; width: 5em; height: 4em;" alt="" src="/uploadFiles/mainImage/${list.planPlaceDto.plan_place_photo }">
	                			</div>
	                			<div class="col">
	                				<div class="row">
	                					<div class="col">
	                						<span style="font-size: 0.8em; font-weight: 500;">${list.planPlaceDto.plan_place_name }</span>	                					
	                					</div>
	                				</div>
	                				<div class="row">
	                					<div class="col">
	                						<span style="font-size: 0.8em; font-weight: 500; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_address }</span>	                					
	                					</div>
	                				</div>
	                				<div class="row">
	                					<div class="col-auto">
	                						<span style="font-size: 0.75em; color: gray;">
	                							${list.userDto.user_nickname }
	                						</span>
	                					</div>
	                					<div class="col pe-1 text-end">
	                						<i class="bi bi-heart" style="font-size: 0.7em; color: gray;"></i>	                					
	                					</div>
	                					<div class="col-auto ps-0">
	                						<span style="font-size: 0.75em; color: gray;">23</span>
	                					</div>
	                					<div class="col-auto ps-0 pe-1">
	                						<i style="font-size: 0.7em; color: gray;" class="bi bi-chat"></i>
	                					</div>
	                					<div class="col-auto ps-0">
	                						<span style="font-size: 0.75em; color: gray;">23</span>
	                					</div>
	                				</div>
	                			</div>
	                		</div>
	                		<hr class="my-3 hrStyle">
	                	</div>
                	</c:forEach>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container-fluid" >
	    <div class="row">
	        <div class="col" style="background-color: #ededed;">
	            <div class="row mt-4">
	                <div class="col"></div>
	                <div class="col-7">
	                    <div class="row">
	                        <div class="col-auto">
	                            <span style="font-size: 0.8em;">
	                                © 2023 TripStation, Inc. · 개인정보 처리방침  · 이용약관  · 사이트맵  · 환불 정책  · 회사 세부정보
	                            </span>
	                        </div>
	                        <div class="col d-flex justify-content-end">
	                            <i class="bi bi-instagram"></i>
	                            <i class="bi bi-twitter px-3"></i>
	                            <i class="bi bi-envelope"></i>
	                        </div>
	                     </div>
	                     <hr class="my-2">
	                </div>
	                <div class="col"></div>
	             </div>
	             <div class="row mb-3">
	                <div class="col"></div>
	                <div class="col-7">
	                    <span style="font-size: 0.5em; color: gray;">
	                        웹사이트 제공자: Tripstation Ireland KOREA, private unlimited company, 8 Hanover Quay Dublin 2, D02 DP23 Ireland | 이사: hoyeong shin | VAT 번호: IE982232384L | 사업자 등록 번호: IE 123125 | 연락처: terms@tripstation.com, 웹사이트, 080-822-0230 | 호스팅 서비스 제공업체: 아마존 웹서비스 | 트립스테이션은 통신판매 중개자로 트립스테이션 플랫폼을 통하여 게스트와 호스트 사이에 이루어지는 통신판매의 당사자가 아닙니다. 트립스테이션 플랫폼을 통하여 예약된 숙소, 체험, 호스트 서비스에 관한 의무와 책임은 해당 서비스를 제공하는 호스트에게 있습니다.
	                    </span>
	                </div>
	                <div class="col"></div>
	            </div>
	        </div>
    	</div>
	</div>
    



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>