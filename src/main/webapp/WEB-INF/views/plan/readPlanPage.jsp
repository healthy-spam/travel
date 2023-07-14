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

    const planId = new URLSearchParams(location.search).get("id");

    console.log(planId);

    function map(){
        // 지도 api
        var container = document.getElementById('map');
        var options = {
        center: new kakao.maps.LatLng(37.5665, 126.9780),
        level: 3
        };

        map = new kakao.maps.Map(container, options);
    }



    window.addEventListener("DOMContentLoaded", () => {

        map();

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
	                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="border-radius: 15px; font-weight: 500; background-color: #ff356b; color: white;">
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
		                                <a href="./travelRecruitmentPage?plan_id=${data.planDto.plan_id}" class="btn shadow-sm" style="background-color: #ff356b; color: white; font-weight: bolder; border-radius: 17px;" >
		                                <i class="bi bi-people"></i> 모집
		                                </a>
		                            </c:if> 
		                            <c:if test="${data.planDto.plan_statuse != '모집' && guideCheck == 1 }">
		                                <a href="../guidePackage/packageRecruitmentPage?plan_id=${data.planDto.plan_id}" class="btn shadow-sm" style="background-color: #ff356b; color: white; font-weight: bolder; border-radius: 17px;">
		                                패키지 모집
		                                </a>
		                            </c:if>
		                       	</div>
								</c:if>
								
		                       	<c:if test="${!empty sessionuser && sessionuser.user_id != data.planDto.user_id && data.planDto.plan_disclosure_status == '공개'}">
		                        <div class="col-5">
			                        <a href="./copyPlanProcess?plan_id=${data.planDto.plan_id}" class="btn shadow-sm" style="background-color: #ff356b; color: white; font-weight: bolder; border-radius: 17px;">
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
		                                <i class="bi bi-bookmark-fill" style=" color: #ff356b; font-size: 30px;"></i> 참조한 플래너 이름
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
		    	<div class="col-1">&nbsp;</div>
		    	<div class="col-10 d-grid">
					<div class="btn-group" style="background-color: #ff356b; border-radius: 18px;">
					<button class="btn btn-lg dropdown-toggle" style="color: white; font-weight: bolder;" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					<i class="bi bi-calendar-check"></i> 일정별 루트 목록
					</button>
					<ul class="dropdown-menu">
						<li>1DAY</li>
					</ul>
					</div>
				</div>
				<div class="col-1">&nbsp;</div>
		    </div>
		</div>
		
		<div class="col-7">                 	
			<div id="map" style="width: 1000px; height: 1000px"></div>
		</div>
		
	</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>