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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@100;300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<title>메인 페이지</title>
<style>
	body {
	font-family: 'Nanum Gothic', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
		
	}
	.bg{
		background-color:#c5d6c3;
	}
	
	.couponRow {
		width: 720px;
		height: 240px;
		box-shadow:2px 3px 5px 0px #2c3b29;
		border-radius: 20px;
		overflow: hidden;
	}
	
	.couponLeft {
		background-color: white;
		padding: 0;
	}
	
	.couponRight {	  
	    background-color: #bad6b4;
	    padding-top : 80px;
	}
	
	.couponTitleCol {
		margin-left : 60px;
		margin-top : 35px;
	}
	
	.couponPriceCol {
		margin-left : 60px;
		font-size : 3em;
		font-weight: bold;
	}
	
	.couponDateCol {
		color: gray;	
	}
	
	.couponTitleRow {
		height: 30%;
	}
	
	.couponPriceRow {
		height: 40%;
	}
	
	.couponDateRow {
		height: 20%;
	}
	
	.iconDown:hover {
		font-size : 32px;
	}
	
	.iconDown {
		font-size : 30px;
		cursor: pointer;
	}
	
	.textDown {
		margin-left: 30px;
	}
	
	.couponContent {
		border: solid 2px white;
		color: gray;
		border-radius: 10px;
		
	}
	
	.couponBanner {
		width: 100%;
		margin-left: 12%;
	}
	
	.mustRead {
		font-size : 1.25em;
	}
	
	.issueDateText {
		margin-left : 60px;
	}
</style>

<script type="text/javascript">
	var changeBackColor = true;
	
	
	function formatDate(date, format) {
	  var year = date.getFullYear();
	  var month = ('0' + (date.getMonth() + 1)).slice(-2);
	  var day = ('0' + date.getDate()).slice(-2);

	  format = format.replace('yy', year);
	  format = format.replace('MM', month);
	  format = format.replace('dd', day);

	  return format;
	}
	
	
	function ajaxTemplete(){
			
			const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..
				}
			}
			
			//get
			xhr.open("get", "요청 url?파라메터=값");
			xhr.send();
			
			//post
			xhr.open("post", "요청 url");
			xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
			xhr.send("파라메터=값");
		}
	
	let mySessionId = null;

	function getSessionId(){
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				// js 작업..
				if(response.result == "success"){
					mySessionId = response.userId; 
				}
			}
		}
		
		//get
		xhr.open("get", "./getMyId", false); // 딱 여기만 쓰세요...false 동기식 호출..! 권장되지 않음
		xhr.send();		
	}

	
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
	
	// 쿠폰 내용 버튼 클릭 이벤트 처리
	  var collapseButtons = document.getElementsByClassName('btn-collapse');
	  for (var i = 0; i < collapseButtons.length; i++) {
	    collapseButtons[i].addEventListener('click', handleCollapse);
	  }
	  
	  function handleCollapse(event) {
	    var targetId = event.target.getAttribute('data-bs-target');
	    var targetCollapse = document.querySelector(targetId);
	    
	    // 모든 쿠폰 내용 접기
	    var allCollapses = document.getElementsByClassName('collapse');
	    for (var i = 0; i < allCollapses.length; i++) {
	      allCollapses[i].classList.remove('show');
	    }
	    
	    // 해당 쿠폰 내용 펼치기
	    targetCollapse.classList.add('show');
	  }
	  
	  
	  function getCoupon(element){
		  
		  
		  const xhr = new XMLHttpRequest();
			
		  var couponId = element.getAttribute('data-coupon-id');
		  
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..

					refreshCoupon();
					
				}
			}
						
			//post
			xhr.open("post", "./getCoupon");
			xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
			xhr.send("couponId=" + couponId);
	  }
	  
	
	  function checkCoupon(couponId){
		  console.log(couponId);
		  
		    let couponElement = document.querySelector(`[data-coupon-id="${couponId}"]`);
		    if (couponElement === null) {
		        console.log(`쿠폰 엘리먼트를 찾을 수 없습니다. couponId: ${couponId}`);
		        return;
		    }
		  
		  const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..
						if (response.hasCoupon) {
				          // 이미 쿠폰을 받은 상태
				          textDown.innerText = "받기 완료";
				          iconDown.disabled = true;
				        } else {
				          // 쿠폰을 받지 않은 상태
				          if (response.isExpired) {
				        	  textDown.innerText = "발급기간만료";
				        	  iconDown.disabled = true;
				          } else if (response.isExhausted) {
				        	  textDown.innerText = "소진";
				        	  iconDown.disabled = true;
				          } else {
				        	  textDown.innerText = "다운로드";
				        	  iconDown.disabled = false;
				        	  }
				       	 	}
				}
			}
			
			//get
			xhr.open("get", "hasCoupon?couponId=" + couponId);
			xhr.send();
	  }
	  function refreshCoupon(){
		  	if(mySessionId == null) return;
		  	
		  		
			const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..
					for(data of response.couponList){
						const couponId = data.coupon_id;
						console.log(couponId);
						checkCoupon(couponId);
				     	 }
						}
				    }
			//get
			xhr.open("get", "./getCouponList");
			xhr.send();
			
		  
	  }
	  
	  window.addEventListener("DOMContentLoaded", function(){
			//사실상 시작 시점...
			getSessionId();
			refreshCoupon();
		});
	  
</script>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		<div class="container bg">
			<div class="row mt-5">
				<div class="col mt-4 text-center">
					<h1>이벤트 쿠폰존</h1>
				</div>
			</div>
			<div class = "row mt-2">
				<div class = "col ps-0">
					<img src = "resources/img/couponBanner3.jpg" alt="쿠폰 배너" style="width:1296px; margin:0px;">
				</div>
			</div>
			
			<div class="row mt-3 align-items-center" id="couponRep">
			  
			</div>
			
			<c:forEach var="coupon" items="${couponList}">
			
			<div class="row mt-5 mx-auto">
				<div class="col">
					<div class="row mb-3 mx-auto couponRow" style="overflow: hidden;">
					    <div class="col-md-9 couponLeft">
					        <div class="row couponTitleRow">
					        	<div class="col couponTitleCol">
					        		${coupon.coupon_title}
					        	</div>
					        </div>
					        <div class="row couponPriceRow">
					        	<div class="col couponPriceCol">
					        		${coupon.coupon_discount}원 할인
					        	</div>
					        </div>
					        <div class="row couponDateRow">
					        	<div class="col-2 issueDateText">
					        	발급기한
					        	</div>
					        	<div class="col-auto couponDateCol">
					        		<fmt:formatDate value="${coupon.coupon_issue_start}" pattern="yyyy-MM-dd" />
					        		~<fmt:formatDate value="${coupon.coupon_issue_end}" pattern="yyyy-MM-dd" />
					        	</div>
					        </div>
					    </div>
					    <div class="col-md-3 text-center couponRight">
					    	<div class="row">
					    		<div class="col iconDown"   data-coupon-id="${coupon.coupon_id}" onclick="getCoupon(this)">
					    		
					      			<i class="bi bi-download"></i>
					      		</div>
					      	<div class="row">
					      		<div class="col textDown">
					      			
					      		</div>
					      	</div>
					      	</div>
					    </div>

					  </div>
					</div>
	 			</div>
	 			<div class="row">
	 				<div class="col-6 mx-auto couponContent mb-5">
	 					<div class="row">
	 						<div class="col mustRead">
	 							꼭 읽어주세요!
	 						</div>
	 					</div>
	 					<div class="row">
	 						<div class="col">
	 							${coupon.coupon_content}
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