<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		.btn-gradient {background: linear-gradient(to right, #db2566, #f2075a, #f5228c);}
</style>

</head>
<body>
	
	<div class="container-fluid">
	
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
	</div>
	
		<div class="row mx-5">
	    	<div class="col">
		        <ul style="list-style: none; display: flex; margin: 0; padding: 0; ">
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: rgb(90, 90, 90); margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">시골</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">상징적 도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">도시도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">도시도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">도시도시</span>
		          </li>
		          <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">도시도시</span>
		          </li>
		           <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">도시도시</span>
		          </li>
		           <li style="display: flex; flex-direction: column; align-items: center; padding: 10px 35px 10px 0px">
		            <span>
		              <i style="font-size: 20px;" class="bi bi-shop-window"></i>
		            </span> 
		            <span style="font-size: 13px; font-weight: 600; color: gray; margin-top: 5px;">도시도시</span>
		          </li>
		        </ul>
	      	</div>
   		</div>
		<div class="row mx-5">
			<div class="col">
				<div class="row">
					<div class="col text-center">
        					<c:if test="${!empty sessionuser}">
								<a style="border-radius: 20px; color: white; position: fixed; z-index: 9999; bottom: 5%; left: 50%; transform: translate(-50%, -50%);" class="btn btn-gradient" href="./hotelRegisterPage1"><span>나만의 숙소 등록하기</span></a>
							</c:if>
        				</div>
				</div>
				<div class="row mt-2 mb-5">
					<c:forEach items="${hotelList}" var="hotelList" varStatus="status">
						<div class="col-2">
							<div class="card" style="border: none;">
								<div class="row">
									<div class="col">
										<a href="./hotelDetailPage?hotel_id=${hotelList.hotelDto.hotel_id}">
											<img alt="" src="/uploadFiles/mainImage/${hotelList.hotelDto.hotel_main_image}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">
										</a>
									</div>
								</div>
								<div class="row py-2">
									<div class="col">
										<div class="row align-items-center">
											<div class="col-auto pb-0 m-0">
												<span class="fw-bold" style="font-size: 14px;">${hotelList.hotelDto.hotel_title}</span>
											</div>
											<c:choose>
												<c:when test="${!empty hotelList.hotelReviewPointCount}">
													<div class="col text-end">
														<i class="bi bi-star-fill" style="color: #fcc203; font-size: 14px;"></i>
														<span class="p-0 fw-bold" style="font-size: 14px;">${hotelList.hotelReviewPointCount}</span>
														<span style="font-size: 14px;">(</span><span style="font-size: 14px;">${hotelList.hotelReviewCount}</span><span>)</span>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col text-end">
														<i class="bi bi-star-fill" style="color: #b8b8b8; font-size: 14px;"></i>
														<span style="font-size: 14px;" class="p-0 fw-bold">0</span>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="row">
											<div class="col">
												<div class="card-text p-0">
													<span style="color: gray; font-size: 14px;">${hotelList.hotelCategoryDto.hotel_category_title}</span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-auto pe-0">
												<span style="color: gray; font-size: 14px;"><fmt:formatDate value="${hotelList.hotelDto.hotel_reserve_start_date}" pattern="MM월 dd일" /></span>
											</div> 
											<div class="col-auto px-0">
												<span style="color: gray; font-size: 14px;">~</span>
											</div>
											<div class="col-auto ps-0">
												<span style="color: gray; font-size: 14px;"><fmt:formatDate value="${hotelList.hotelDto.hotel_reserve_end_date}" pattern="MM월 dd일" /></span> 
											</div>
										</div>
										<div class="row">
											<div class="col-auto pe-0" >
												<span style="font-size: 14px; font-weight: bold;">\</span>
											</div>
											<div class="col-auto px-0">
												<span style="font-size: 14px; font-weight: bold;">${hotelList.hotelDto.hotel_price}</span>
											</div>
											<div class="col-auto p-0">
												<span style="font-size: 14px;">/</span>
											</div>
											<div class="col-auto p-0">
												<span style="font-size: 14px;">박</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
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