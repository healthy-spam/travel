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
				<div class="row mt-5">
					<h3>회원 신고 내역</h3>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<table class="table table-sm h-75">
					  <thead class="table-dark">
					    <tr>
					      <th scope="col"></th>
					      <th scope="col">신고자</th>
					      <th scope="col">신고 대상</th>
					      <th scope="col">세부 내용</th>
					      <th scope="col">처리 상태</th>
					      <th scope="col">신고일</th>
					    </tr>
					  </thead>
					  <c:forEach var="list" items="${list}">
					  <tbody>
					    <tr>
					      <th scope="row">${list.userReportDto.user_report_id}</th>
					      <td>${list.reportingUserDto.user_email}</td>
					      <td>${list.reportedUserDto.user_email}</td>
					      <td><a href="./readUserReport?id=${list.userReportDto.user_report_id}">보기</a></td>
					      <td>${list.userReportDto.user_report_status}</td>
					      <td><fmt:formatDate value="${list.userReportDto.user_report_reg_date}" pattern="yyyy-MM-dd" /></td>
					    </tr>
					  </tbody>
					  </c:forEach>
					</table>
					
				</div>
				
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>