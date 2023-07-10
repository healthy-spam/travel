<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<style type="text/css">
		.btn-gradient {background: linear-gradient(to right, #ca4fff, #4e33ff, #696bff);}
</style>

</head>
<body>

    <div class="container-fluid background">
	    <div class="container">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
		
        <div class="row">
            <div class="col text-center">
                <span>카테고리</span>
            </div>
        </div>
        <div class="row">
        	<div class="col text-center">
        		<c:if test="${!empty sessionuser}">
					<a style="border-radius: 20px; color: white; position: fixed; z-index: 9999; bottom: 5%; left: 50%; transform: translate(-50%, -50%);" class="btn btn-gradient" href="./registerPlacePage"><span>나만의 명소 등록하기</span></a>
				</c:if>
        	</div>
        </div>
        <div class="row mx-5 my-3">
            <div class="col">
                <div class="row">
                	<c:forEach items="${planPlaceList}" var="list">
                    <div class="col-2 mb-4">
                        <div class="card" style="border: none;">
                            <div class="row">
                                <div class="col">
                                    <a href="./PlanPlaceDetailPage?plan_place_id=${list.planPlaceDto.plan_place_id}">
                                        <img src="/uploadFiles/mainImage/${list.planPlaceDto.plan_place_photo}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">
                                    </a>
                                </div>
                            </div>
                            <div class="row align-items-center my-2">
                                <div class="col-auto">
                                    <span style="font-size: 14px; font-weight: bold; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_name}</span>
                                </div>
                                <div class="col text-end pe-1">
                                    <c:choose>
                                    	<c:when test="${!empty sessionuser}">
                                    		<a href="./clickLoveProcess1?plan_place_id=${list.planPlaceDto.plan_place_id}" class="bi bi-heart-fill" style="${list.searchPlanPlaceLoveDto != null ? 'color: #ff4f78; font-size: 12px;' : 'color: gray; font-size: 12px;'}"></a>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<a href="/travel/login" class="bi bi-heart-fill" style="color: gray; font-size: 14px;"></a>
                                    	</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-auto p-0">
                                	<span style="font-size: 14px; font-weight: bold">${list.loveCount}</span>
                                </div>
                                <div class="col-auto pe-1">
                                    <i style="font-size: 14px;"class="bi bi-chat"></i>
                                </div>
                                <div class="col-auto ps-0">
                                	<span style="font-size: 14px; font-weight: bold">${list.commentCount}</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 14px; color: gray; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_content}</span>
                                </div>
                            </div>
                            <div class="row my-2">
                                <div class="col">
                                    <span style="font-size: 14px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_address}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                     </c:forEach>
                </div>
                <div class="row">
                    <div class="col"></div>
                </div>
            </div>
        </div>
    </div>
    





	<%-- <div class="container">
		<div class="row">
			<div class="col">
			</div>
		</div>
		<div class="row mt-4 justify-content-end">
			<div class="col">
				<h4>#플레이스</h4>
			</div>
			<div class="col-auto p-0">
			<c:if test="${!empty sessionuser}">
				<a class="btn btn-outline-dark" href="./registerPlacePage">나만의
					명소 등록하기</a>
			</c:if>
			</div>
		</div>
		<div class="row mt-2 card">
			<div class="col"></div>
			<div class="col-12 text-center">
				<div class="row mt-3">
					<div class="col mx-3 d-flex justify-content-end">
						<div class="dropdown">
  							<button class="btn btn-outline-dark dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
    							필터
  							</button>
 							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    						<li><a class="dropdown-item" href="../planPlace/placePage?sortType=recent">최신순</a></li>
    						<li><a class="dropdown-item" href="../planPlace/placePage?sortType=love">인기순</a></li>
    						<li><a class="dropdown-item" href="../planPlace/placePage?sortType=comment">댓글많은순</a></li>
  							</ul>
						</div>
					</div>
				</div>
				<div class="row">
					<c:forEach items="${planPlaceList}" var="list">
						<div class="col mt-3 d-flex justify-content-center">
							<div class="card" style="width: 17rem; height: 25rem; position: relative;">
								<div class="row">
									<div class="col">
										<a href="./PlanPlaceDetailPage?plan_place_id=${list.planPlaceDto.plan_place_id}">
											<img src="/uploadFiles/mainImage/${list.planPlaceDto.plan_place_photo}" class="card-img img-fluid">
										</a>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<div class="card-body" style="overflow: hidden;">
											<h5 class="card-title text-start" style="font-size: 1.0rem; font-weight: bold; margin-bottom: 0.5rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_name}</h5>
											<p class="card-text text-start"
												style="font-size: 0.8rem; line-height: 1.2; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
												${list.planPlaceDto.plan_place_content}</p>
											<p class="card-text text-start"
												style="font-size: 0.6rem; line-height: 1.2; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
												${list.planPlaceDto.plan_place_address}</p>
											<c:choose>
												<c:when test="${!empty sessionuser}">
													<p class="card-text text-end" 
												style="font-size: 1.0rem; line-height: 1.2; white-space: nowrap; overflow: hidden;"><a href="./clickLoveProcess1?plan_place_id=${list.planPlaceDto.plan_place_id}" class="${list.searchPlanPlaceLoveDto != null ? 'bi-heart-fill text-danger' : 'bi-heart text-danger'}"></a> ${list.loveCount} <i class="bi bi-chat-dots"></i> ${list.commentCount}</p>
												</c:when>
												<c:otherwise>
													<p class="card-text text-end" 
												style="font-size: 1.0rem; line-height: 1.2; white-space: nowrap; overflow: hidden;"><a href="../login" class="${list.searchPlanPlaceLoveDto != null ? 'bi-heart-fill text-danger' : 'bi-heart text-danger'}"></a> ${list.loveCount} <i class="bi bi-chat-dots"></i> ${list.commentCount}</p>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="row mb-5"></div>
			</div>
		</div>
		<div class="col"></div>
	</div> --%>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>