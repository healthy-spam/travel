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
			<div class="col-md-2 mt-3 ">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-md-10 offset-md-1 mx-auto">

				<div class="row mt-5">
					<h3>쿠폰 리스트</h3>
				</div>
				<div class="row d-flex justify-content-center mt-5 mx-auto">
					<table class="table h-75 w-100">
					  <thead class="table-dark">
					    <tr>
					      <th scope="col" class="col-1"></th>
					      <th scope="col" class="col-1">쿠폰 명</th>
					      <th scope="col" class="col-1">수량</th>
					      <th scope="col" class="col-4">쿠폰 공지</th>
					      <th scope="col" class="col-2">발급 기간</th>
					      <th scope="col" class="col-1">사용 종료일</th>
					      <th scope="col" class="col-1">수정</th>
					      <th scope="col" class="col-1">삭제</th>
					    </tr>
					  </thead>
					  <c:forEach var="list" items="${list}">
					  <tbody>
					    <tr>
					      <th scope="row">${list.coupon_id}</th>
					      <td>${list.coupon_title}</td>
					      <td>${list.coupon_amount}</td>
					      <td>${list.coupon_content}</td>					      
					      <td><fmt:formatDate value="${list.coupon_issue_start}" pattern="yy-MM-dd" /><br>
					      ~<fmt:formatDate value="${list.coupon_issue_end}" pattern="yy-MM-dd" />
					      </td>
					      <td><fmt:formatDate value="${list.coupon_use_end}" pattern="yyyy-MM-dd" /></td>	
					      <td><a href="./updateCouponPage?id=${list.coupon_id}">수정</a></td>
					      <td><button type="button" class="btn btn-danger btn-sm" onclick="location.href='deleteCouponProcess?id=${list.coupon_id}' ">삭제</button>
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