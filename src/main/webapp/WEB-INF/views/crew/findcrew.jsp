<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value="/resources/css/crew/findcrew.css" />">

<title>메인 페이지</title>
<style>
.btn {
background-color: #DB4465;
color: white;
}

.crewinfo {
font-size: 16px
}
</style>
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
			
	document.addEventListener("DOMContentLoaded", function(event) {
	    var opencrewhome = document.getElementById("opencrewhome");
	    opencrewhome.addEventListener("click", function() {
	        var crew_domain = document.getElementById("crew_domain").value;
	        window.open("/travel/crew/crewhome/"+crew_domain, "pop", "width=1350px,height=750px,location=no")
	    });
	});


</script>
</head>
<body>
	<div class="container-fluid">
	<div class="container">
				<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
				</div>
	</div>
	<div class="container py-5 px-5">
        <div class="row mb-3">
        	<div class="col">
        		<h1>내 크루</h1>
        	</div>
        </div>
        <div class="row">
        	<div class="col">
				<div class="card">
				  <div class="card-body">
				  	<c:choose>
			            <c:when test="${empty crewDto}">
			               <h4>아직 가입한 크루가 없으시군요!</h4>
			               <br><br>
			               <div class="row">
				               <div class="col-10">
					               <h6>크루를 생성할 수도 있어요.</h6>
				               </div>
				               <div class="col">
					               <a href="/travel/crew/createcrew"><button type="button" class="btn">크루 생성하기</button></a>
				               </div>
			               </div>			               
			            </c:when>
			            <c:when test="${!empty crewDto && !empty applied}">
			            <h4>현재 가입신청 중이에요.</h4>
			               <br><br>
			               <div class="row">
			               	<div class="col-6">
			               		<strong>크루명</strong>
			               	</div>
			               	<div class="col">
			               		${crewDto.crew_name }
			               	</div>
			               </div>
			               <div class="row">
			               	<div class="col-6">
			               		<Strong>가입 신청 일자</Strong>
			               	</div>
			               	<div class="col">
								<fmt:formatDate value="${applied.crew_member_log_date}" pattern="yyyy-MM-dd" var="formattedDate" />
									${formattedDate}
			               	</div>
			               </div>
			               <br>
			               <hr>
			               <div class="row">
				               <div class="col-10">
					               <h6>가입 승인 결과는 여기에 표시 될 거예요.</h6>
				               </div>
				               <div class="col">
					               <a href="/travel/crew/crewhome/${crewDto.crew_domain }"><button type="button" class="btn">크루 홈 이동</button></a>
				               </div>
			               </div>			               
			            </c:when>
			            <c:otherwise>
			            	<div class="row">
			            		<div class="col">
			            			<h4><strong>${crewDto.crew_name}</strong></h4>
			            		</div>
			            		<div class="col text-end">
			            			<button class="btn btn-sm" id="checkmycrewlog">나의 크루 내역</button>
			            		</div>
			            	</div>
			               <hr>
				           <div class="card-body">
				           	<div class="row">
				           		<div class="col-9 crewinfo mt-4">
				           			<div class="row">
		                           		<div class="col-6">
		                           			크루마스터
		                           		</div>
		                           		<div class="col card-text">
		                           			<strong>${master}</strong>
		                           		</div>
		                           	</div>
		                           	<div class="row">
		                           		<div class="col-6">
		                           			인원수
		                           		</div>
		                           		<div class="col card-text">
		                           			<strong>${crewamount} / 20</strong>
		                           		</div>
		                           	</div>
		                           	<div class="row">
		                           		<div class="col-6">
		                           			나의 직위
		                           		</div>
		                           		<div class="col card-text">
		                           			<strong>${myGrade}</strong>
		                           		</div>
		                           	</div>
		                           	<div class="row">
		                           		<div class="col-6">
		                           			나의 기여포인트
		                           		</div>
		                           		<div class="col card-text">
		                           			<strong>${myPoint}</strong>
		                           		</div>
		                           	</div>

				           		</div>
				           		<div class="col">
				           			<img src="/uploadFiles/crewFiles/crewthumbnail/${crewDto.crew_thumbnail}" width="200" height="200">
				           		</div>
				           	</div>
	                         <div class="row mt-3">
		                           		<input type="hidden" id="crew_domain" value="${crewDto.crew_domain }">
		                           		<button class="btn" id="opencrewhome" style="background-color: #DB4465; color: white;">크루 홈 이동</button>
		                           	</div>

	                        </div>
			            </c:otherwise>
			         </c:choose>
				  </div>
				</div>
			</div>
        </div>
        <div class="row mt-5 mb-3 ">
        	<div class="col">
        		<h1>활동중인 크루 리스트</h1>
        	</div>
        </div>
        <div class="row">
            <c:forEach var="crew" items="${crewList}" varStatus="status">
                <div class="col-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">${crew.crew.crew_name}</h5>
                            <hr>
                            <div class="row">
                            	<div class="col-4">
                            		크루 마스터
                            	</div>
                            	<div class="col ">
                            		<p class="card-text"><strong>${crew.mastername}</strong></p>
                            	</div>
                            </div>
                             
                            <p class="card-text">${crew.crew.crew_desc}</p>
                            <div class="row">
                            	<div class="col">
		                            <form id="crewForm" method="Post" action="/travel/crew/crewhome/${crew.crew.crew_domain }">
										  <input type="hidden" name="crewDomainInput" value="${crew.crew.crew_domain }">
										  <button type="submit" class="hidden-button"><i class="bi bi-house"></i></button>
										  
									</form>
                            	</div>
                            	<div class="col text-end">
                            	<c:choose>
                            		<c:when test="${empty crewDto }">
                            		<form method="Post" action="/travel/crew/join/${crew.crew.crew_domain}">
                            			<input type="hidden" value="${crew.crew.crew_id }" name="crew_id">
                            			<button type="submit" class="btn btn-sm text-white"> 가입하기</button>
                            		</form>
                            		</c:when>
                            		<c:otherwise>
                            		</c:otherwise>
                            	</c:choose>
                            	</div>
                            
                            </div>

                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>