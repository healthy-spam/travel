	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<title>메인 페이지</title>
	<script type="text/javascript">
		var changeBackColor = true;
		
		function changeBackGround() {	
			if (changeBackColor) {
				var container = document.querySelector('.container-fluid');
				container.style.backgroundColor = '#444444';
				
				var otherElements = container.querySelectorAll(':not(.container)');
				otherElements.forEach(function(element) {
					element.style.color = 'white';
				});
				changeBackColor = false;
			} else {
				var container = document.querySelector('.container-fluid');
				container.style.backgroundColor = 'white';
				
				var otherElements = container.querySelectorAll(':not(.container)');
				otherElements.forEach(function(element) {
					element.style.color = 'black';
				});
				changeBackColor = true;
			}
			
			
		}
	</script>

	</head>
	<body>
		<div class="container-fluid">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
			<div class="container m-0">

					<div class="row mt-5 mb-3">
					 <div class="col-2 rounded ms-4" style = "background-color : #e8e8e8; height : 100vh;">
					 	<div class = "row">
					 		<div class = "col p-3 bg-secondary text-white text-center rounded-top">
					 			쪽지함
					 		</div>
					 	</div>
					 	<div class = "row">
					 		<div class = "col text-center p-3 border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<button class="btn btn-defualt btn-lg border border-dark" type="button" onclick ="location.href='./writeMessage'">쪽지쓰기</button>
					 		</div>
					 	</div>
					 	<div class = "row border-bottom">
					 		<div class="col-1 p-3 border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<i class="bi bi-envelope"></i>
					 		</div>
					 		<div class="col-2 p-3 border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<i class="bi bi-arrow-left" style="margin-left: -8px;"></i>
					 		</div>
					 		<div class="col p-3 border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<a class="dropdown-item" href="./messageGot">받은쪽지</a>
					 		</div>
					 	</div>
					 	<div class = "row">
					 		<div class="col-1 p-3 border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<i class="bi bi-envelope"></i>
					 		</div>
					 		<div class="col-2 p-3 border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<i class="bi bi-arrow-right" style="margin-left: -8px;"></i>					 			
					 		</div>
					 		<div class="col p-3 border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<a class="dropdown-item" href="./messageWrote">보낸쪽지</a>
					 		</div>
					 	</div>
					 	<div class = "row">
					 		<div class="col p-3 text-center border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<a class="dropdown-item" href="./messageWrote">쪽지보관함</a>
					 		</div>
					 	</div>
					 	<div class = "row">
					 		<div class="col p-3 text-center border-secondary border-2 border-bottom" style="--bs-border-opacity: .5;">
					 			<a class="dropdown-item" href="./messageWrote">스팸쪽지함</a>
					 		</div>
					 	</div>
					 </div>

					 <div class = "col-9 mx-4">
					  <div class = "row">
					  	<div class = "col">
					  		<div class = "row">
						  		<div class = "col-auto mx-2">
						  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
						  		</div>

						  		<div class = "col-auto">
								 	<button class="btn btn-sm btn-defualt border border-dark" type="button" onclick ="location.href='./deleteMessageProcess'">삭제
								 	</button>						  			
						  		</div>
					  		</div>
						  
							  <c:forEach var="list" items="${list}">
							  <div class="row mt-3 border-top border-1 p-2">
								    <div class="col-auto d-flex align-items-center">
								        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								    </div>
								    <div class="col-auto d-flex align-items-center mt-2">
								        <i class="bi bi-star"></i>
								    </div>
								    <div class="col-auto d-flex align-items-center mt-2">
								        <i class="bi bi-envelope"></i>
								    </div>
								    <div class="col d-flex align-items-center mt-2">
								        ${list.userDto.user_nickname}
								    </div>
								    <div class="col d-flex align-items-center mt-2">
								        <a href="./readMessageGot?id=${list.messageDto.message_id}">${list.messageDto.message_title}</a>
								    </div>
								    <div class="col d-flex align-items-center mt-2">
								        <fmt:formatDate value="${list.messageDto.message_reg_date}" pattern="yy-MM-dd hh:mm:ss" />
								    </div>
								    <div class="col d-flex align-items-center mt-2">
								        <div class="col btn-col btn-sm d-flex align-items-center mt-2">
								            <button class="btn btn-sm btn-defualt border border-dark" type="button" onclick="location.href='./deleteMessageProcess'">삭제</button>
								        </div>
								    </div>
								</div>
							  </c:forEach>
							</div>
						  </div>
					</div>
				 </div>
			</div>
			</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	</body>
	</html>