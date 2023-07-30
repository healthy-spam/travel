<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@100;300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/admin/leftNavi.css">
<title>Insert title here</title>
<style>
	
	.deleteColumn {
		width: 20%;
	}
	
	.nameColumn {
		width: 60%;
		margin-left:20px;
	}
	
	.indexColumn {
		width: 20%
	}
	
	.pageAction a.active {
	background-color: #ced4da;
	color: white;
	border-color: #ced4da;
	}
	
	.pageAct a:hover:not(.avtive) {
		background-color: white;
	}
	
	.page-link {
		color: black;
	}
	
</style>
</head>
<body>
<div class="container-fluid">
		<div class="row">
			<div class="col-2" id="naviBack">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-8 mx-auto">
			
				<div class="row mt-5 pageTitle border-dark-subtle border-bottom border-2">
					<div class="col">
						지역 리스트
					</div>
				</div>
				<div class="row justify-content-center mt-5">
					<table class="table table-sm h-75">
					  <thead class="table-secondary">
					    <tr>
					      <th scope="col" class ="indexColumn"></th>
					      <th scope="col" class="nameColumn" style="padding-left:15px;">도시 명</th>
					      <th scope="col" class="deleteColumn">도시 삭제</th>
					    </tr>
					  </thead>
					  <c:forEach var="list" items="${list}">
					  <tbody>
					    <tr>
					      <th scope="row">${list.plan_city_id}</th>
					      <td>${list.plan_city_name}</td>
					      <td style="padding-left:15px;"><button type="button" class="btn btn-danger btn-sm" onclick="location.href='deleteCityProcess?id=${list.plan_city_id}' ">삭제</button>
					    </tr>
					  </tbody>
					  </c:forEach>
					</table>
				</div>
				<div class="row mx-auto mt-2">
					<div class="col">
					<ul class="pagination justify-content-center pageAction">
					    <li class="page-item">
					      <a class="page-link" href="#" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <li class="page-item"><a class="page-link active" href="#">1</a></li>
					    <li class="page-item"><a class="page-link" href="#">2</a></li>
					    <li class="page-item"><a class="page-link" href="#">3</a></li>
					    <li class="page-item"><a class="page-link" href="#">4</a></li>
					    <li class="page-item"><a class="page-link" href="#">5</a></li>
					    <li class="page-item">
					      <a class="page-link" href="#" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</div>											
				</div>			
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>