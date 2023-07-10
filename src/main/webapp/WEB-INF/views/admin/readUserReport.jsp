<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col-md-2  mt-3 ">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-md-9 offset-md-1">
				<c:choose>
				<c:when test="${map.userReportDto.user_report_status eq '미처리'}">
				<div class="row mt-5">
					<h3>신고 상세 페이지</h3>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<dl class="row">
					  <dt class="col-sm-2">신고 대상</dt>
					  <dd class="col-sm-10">${map.reportedUserDto.user_email}
					  </dd>
					  
					  <dt class="col-sm-2">플랜 계획 번호</dt>
					  <dd class="col-sm-10">${map.userReportDto.planning_id}
					  </dd>
					
					  <dt class="col-sm-2">신고 유형</dt>
					  <dd class="col-sm-10">
					    <p>${map.userReportDto.user_report_type}</p>
					  </dd>
					  
					  <dt class="col-sm-2">상세 설명</dt>
					  <dd class="col-sm-10">
					    <p>${map.userReportDto.user_report_desc}</p>
					  </dd>
					  
					  <dt class="col-sm-2">첨부 파일</dt>
					  <dd class="col-sm-10">
					    <p>${map.userReportDto.user_report_attached}</p>
					  </dd>
					</dl>
				</div>
				<div class="row">
				<form  method="post" action="restrictUserProcess">
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">제한 사유</label>
					  <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="user_restrict_reason"></textarea>
					</div>
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">제한 방식</label>
					</div>
					<div class="mb-3">
					  <select class="form-select" aria-label="Default select example" name = "user_report_status">
					  <option value="로그인 제한" selected>로그인 제한</option>
					  <option value="1">One</option>
					  <option value="2">Two</option>
					  <option value="3">Three</option>
					</select>
					</div>
					
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="user_restrict_duration" id="flexRadioDefault1" value="3">
					  <label class="form-check-label" for="flexRadioDefault1">
					    3
					  </label>
					  일
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="user_restrict_duration" id="flexRadioDefault2" value="7" >
					  <label class="form-check-label" for="flexRadioDefault2">
					    7
					  </label>
					  일
					  </div>
					  <div class="form-check">
					  <input class="form-check-input" type="radio" name="user_restrict_duration" id="flexRadioDefault2" value="15">
					  <label class="form-check-label" for="flexRadioDefault2">
					    15
					  </label>
					  일
					</div>
					  <div class="form-check">
					  <input class="form-check-input" type="radio" name="user_restrict_duration" id="flexRadioDefault2" value="30">
					  <label class="form-check-label" for="flexRadioDefault2">
					    30
					  </label>
					  일
					</div>
					<div class="mt-3">
						<input type="hidden" value="${map.userReportDto.user_report_id}" name="user_report_id">
						<input type="hidden" value="${map.userReportDto.reported_user_id}" name="user_id">
						<button class="btn btn-primary" type="submit">제한</button>
						<button type="button" class="btn btn-primary" onclick = "location.href='./userReportPage'">뒤로가기</button>
					</div>
				</form>
				</div>
				</c:when>
				
				<c:otherwise>
					<div class="row mt-5">
					<h3>${map.reportedUserDto.user_email}님의 제한 상세정보</h3>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<dl class="row">
					  <dt class="col-sm-2">제한 방식</dt>
					  <dd class="col-sm-10">${map.userReportDto.user_report_status}</dd>
					
					  <dt class="col-sm-2">총 제한일</dt>
					  <dd class="col-sm-10">
					    <p>${map.memberRestrictDto.user_restrict_duration}</p>
					  </dd>
					  
					  <dt class="col-sm-2">제한 일자</dt>
					  <dd class="col-sm-10">
					    <p><fmt:formatDate value="${map.memberRestrictDto.user_restrict_start_date}" pattern="yyyy-MM-dd" /></p>
					  </dd>
					  
					  <dt class="col-sm-2">해제 예정일</dt>
					  <dd class="col-sm-10">
					    <p><fmt:formatDate value="${map.memberRestrictDto.user_restrict_end_date}" pattern="yyyy-MM-dd" /></p>
					  </dd>
					  
						<dt class="col-sm-2">제한 이유</dt>
					  <dd class="col-sm-10">
					    <p>${map.memberRestrictDto.user_restrict_reason}</p>
					  </dd>
					  
					</dl>
					
					
				</div>
					<button type="button" class="btn btn-primary" onclick = "location.href='./userReportPage'">뒤로가기</button>
				</c:otherwise>
				</c:choose>
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>