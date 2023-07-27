<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=818488f03bbc3c53eaa216d3aaf39e13&libraries=services"></script>
    
    
    
    <style>

    .registerButton {
        /* 박스 모델 관련 스타일 */
        width: auto;
        height: auto;
        background-image: linear-gradient(98deg,#4f4f4f,#4f4f4f);
        border-radius: 5px;
        border: none;
        padding: 8px 12px;
        color: white;
        font-size: 0.8em;
        font-weight: 600;
    }
    
    .registerButton:hover {
        /* 박스 모델 호버 관련 스타일 */
        background-image: linear-gradient(98deg,#4f4f4f,#333333);
    }
    
    .exitButton {
    	/* 박스 모델 관련 스타일 */
    	width: auto;
        height: auto;
        background-color: white;
        border-radius: 5px;
        border: 1px solid #c4c4c4;
        padding: 8px 12px;
        color: gray;
        font-size: 0.8em;
        font-weight: 600;
        text-decoration: none;
    }
    
    .exitButton:hover {
    	/* 박스 모델 관련 스타일 */
		background-color: #e6e6e6;
		color: #696969;
    }

    .searchButton {
        /* 박스 모델 관련 스타일 */
        width: 5em;
        height: 100%;
        background-color: rgb(239, 239, 239);
        border-radius: 5px;
        border: none;
        color: black;
        font-size: 0.8em;
        font-weight: 600;
    }

    .searchButton:hover {
        /* 박스 모델 호버 관련 스타일 */
        background-color: rgb(223, 223, 223);
    }



    select {
        /* 박스 모델 관련 스타일 */
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;

        /* 폰트 스타일 */
        font-size: 0.9em;
        color: #333;

        /* 드롭다운 화살표 모양 설정 */
        background-image: url('down_arrow.png');
        background-repeat: no-repeat;
        background-position: right center;
        background-size: 20px 20px;
    }

    .titleBox2 {
        /* 박스 모델 관련 스타일 */
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 100%;

        /* 폰트 스타일 */
        font-size: 0.9em;
        color: #a7a7a7;

        /* 플레이스홀더 스타일 */
        ::placeholder {
            color: #4f4f4f;
            border: 1px solid rgb(165, 165, 165);

        }
    }

    .addressBox {
         /* 박스 모델 관련 스타일 */
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 100%;

        /* 폰트 스타일 */
        font-size: 0.9em;
        color: #404040;

    }


    textarea {
        /* 박스 모델 관련 스타일 */
        padding: 8px;
        border: 1px solid rgb(229, 229, 229);
        border-radius: 5px;
        resize: vertical; /* 수직 리사이즈 허용 */
        width: 100%;

        /* 폰트 스타일 */
        font-size: 0.9em;
        color: #333;

        /* 플레이스홀더 스타일 */
        ::placeholder {
            color: #999;
        }
    }   

    .noticeBox {
        /* 박스 모델 관련 스타일 */
        background-color: #f1f1f1;
        width: 100%;
        padding: 12px 25px;
        border: 1px solid rgb(229, 229, 229);
        border-radius: 5px;

        /* 폰트 스타일 */
        font-size: 0.9em;
        color: #4f4f4f;
    }

    input[type="file"] {
        display: none;
    }

    .fileLabel {
        /* 박스 모델 관련 스타일 */
        display: inline-block;
        padding: 8px 35px;
        border: 1px solid rgb(229, 229, 229);
        border-radius: 5px;
        cursor: pointer;

        /* 폰트 스타일 */
        font-size: 0.9em;
        color: #333;
    }

    .fileLabel:hover {
        /* 박스 모델 호버 관련 스타일 */
        background-color: #f1f1f1;
    }

    .imageNoticeBox {
        /* 폰트 스타일 */
        font-size: 0.8em;
        color: gray;
    }

    .titleBox {
         /* 폰트 스타일 */
        font-size: 1.5em;
        font-weight: 600;
    }
    </style>
</head>

<body>

<div class="container">
	<div class="row fw-bold justify-content-center">
			<div class="col-10">
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

    <div class="row justify-content-center">
        <div class="col-10">
            <form action="./registerPlaceProcess" method="post" enctype="multipart/form-data">
                <div class="row align-items-center mt-5">
                    <div class="col">
                        <span class="titleBox">플레이스 등록하기</span>
                    </div>
                    <div class="col pe-0 text-end">
                        <a href="/travel/planPlace/placePage" class="exitButton">나가기</a>
                    </div>
                    <div class="col-auto">
                        <button class="registerButton">등록</button>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-auto">
                        <select name="plan_city_id" id="">
                            <option value="">도시를 선택하세요</option>
                            <c:forEach items="${cityCategoryList}" var="list">
                              <option value="${list.planCityDto.plan_city_id}">
                                  ${list.planCityDto.plan_city_name}
                              </option>
                          </c:forEach>
                        </select>
                    </div>
                    <div class="col">
                        <input class="titleBox2" name="plan_place_name" type="text" placeholder="제목을 입력해 주세요.">
                    </div>
                </div>
                <div class="row my-3">
                    <div class="col">
                        <div class="noticeBox">
                            <span>모든 게시글 사진 첨부 필수 + 삭제 금지 (30일 활동 정지)</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <textarea name="plan_place_content" id="" rows="20em" placeholder="내용을 입력하세요."></textarea>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col">
                        <input type="file" name="mainImage" id="fileInput">
                        <label for="fileInput" class="fileLabel">메인 사진 선택</label>
                        <span class="imageNoticeBox">플레이스 메인 화면에 표시됩니다 (필수 1장 선택)</span>
                    </div>
                    <div class="col">
                        <input type="file" name="detailImages" accept="image/*" id="fileInput2" multiple>
                        <label for="fileInput2" class="fileLabel">상세 사진 선택</label>
                        <span class="imageNoticeBox">플레이스 게시글 화면에 표시됩니다</span>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col">
                        <input class="addressBox" type="text" name="plan_place_address" id="addressInput" placeholder="주소를 입력하세요.">
                    </div>
                   <!--  <div class="col-auto ps-0">
                        <button class="searchButton" id="searchButton">검색</button>
                    </div> -->
                </div>
            </form>
        </div>
    </div>
</div>

   


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
    crossorigin="anonymous"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
window.onload = function(){
    document.getElementById("addressInput").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("addressInput").value = data.address; // 주소 넣기
                document.getElementById("addressInput").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
</body>

</html>