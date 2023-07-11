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
		
		function formatDate(date, format) {
			  var year = date.getFullYear();
			  var month = ('0' + (date.getMonth() + 1)).slice(-2);
			  var day = ('0' + date.getDate()).slice(-2);
			  var hours = ('0' + date.getHours()).slice(-2);
			  var minutes = ('0' + date.getMinutes()).slice(-2);
			  var seconds = ('0' + date.getSeconds()).slice(-2);
			  
			  format = format.replace('yy', year);
			  format = format.replace('MM', month);
			  format = format.replace('dd', day);
			  format = format.replace('hh', hours);
			  format = format.replace('mm', minutes);
			  format = format.replace('ss', seconds);

			  return format;
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
		
		function reloadMessageGet(){
		
			const xhr = new XMLHttpRequest();
						
						xhr.onreadystatechange = function(){
							if(xhr.readyState == 4 && xhr.status == 200){
								const response = JSON.parse(xhr.responseText);
								// js 작업..

								
								for(data of response.messageGetList){
								
								var messageSendDate = new Date(data.messageDto.message_reg_date);
								
								var messageSendDateFormatted = formatDate(messageSendDate, 'yy-MM-dd hh:mm:ss');
								
								const row1 = document.createElement("div");
								row1.classList.add("row", "border-top", "border-1");
								
								const row1col1 = document.createElement("div");
								row1col1.classList.add("col-auto", "d-flex", "align-self-center");
								row1.appendChild(row1col1);
								
								const input1 = document.createElement("input");
								input1.classList.add("form-check-input");
								input1.type = "checkbox";
								input1.value = "";
								input1.id = "flexCheckDefault";
								row1col1.appendChild(input1);
								
								const row1col2 = document.createElement("div");
								row1col2.classList.add("col-auto", "d-flex", "align-self-center");
								row1.appendChild(row1col2);
								
								const i1 = document.createElement("i");
								i1.classList.add("bi", "bi-star");
								row1col2.appendChild(i1);
								
								const row1col3 = document.createElement("div");
								row1col3.classList.add("col-auto", "d-flex", "align-self-center");
								row1.appendChild(row1col3);
								
								const i2 = document.createElement("i");
								i2.classList.add("bi", "bi-envelope");
								row1col3.appendChild(i2);
								
								const row1col4 = document.createElement("div");
								row1col4.classList.add("col", "align-self-center","text-center");
								row1col4.innerText = data.userDto.user_nickname;
								row1.appendChild(row1col4);
								
								const row1col5 = document.createElement("div");
								row1col5.classList.add("col", "d-flex", "align-self-center");
								row1.appendChild(row1col5);
								
								const a1 = document.createElement("a");
								a1.href="./readMessageGot?id=" + data.messageDto.message_id;
								a1.innerText = data.messageDto.message_title;
								row1col5.appendChild(a1);
								
								const row1col6 = document.createElement("div");
								row1col6.classList.add("col", "align-self-center", "text-center", "ms-2");
								row1col6.innerText = messageSendDateFormatted;
								row1.appendChild(row1col6);
								

								
								const row1col7 = document.createElement("div");
								row1col7.classList.add("col", "align-self-center", "text-center", "ms-auto");
								row1.appendChild(row1col7);
								
								const deleteButton = document.createElement("button");
								deleteButton.classList.add("btn", "btn-sm", "border", "border-dark");
								deleteButton.type = "button";
								deleteButton.onclick = function() {
									location.href = "./deleteMessageProcess?id=" + data.messageDto.message_id;
								};
								deleteButton.innerText = "삭제";
								row1col7.appendChild(deleteButton);
								
								targetCol.appendChild(row1);
								}
								

							}
						}
						
						//get
						xhr.open("get", "./reloadMessageGet");
						xhr.send();
						

		}
		
		window.addEventListener("DOMContentLoaded", function(){
			//사실상 시작 시점...
			reloadMessageGet();
		});
							
	</script>

	</head>
	<body>
		<div class="container-fluid">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
			<div class="container-fluid">

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
					  	<div class = "col" id="targetCol">
					  		<div class = "row mb-3 h2">
					  			<div class = "col">
					  				받은 편지함
					  			</div>
					  		</div>
					  		<div class = "row">
						  		<div class = "col-auto mx-2">
						  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
						  		</div>

						  		<div class = "col-auto">
								 	<button class="btn btn-sm btn-default border border-dark" type="button" onclick ="location.href='./deleteMessageProcess'">삭제
								 	</button>						  			
						  		</div>
					  		</div>
						  
							  
						</div>
					  </div>
					</div>
				 </div>
			</div>
		</div>
		
		<div class="fixed-bottom" role="alert">
			<div class="row">
				<div class="ms-auto col-3 alert alert-success">읽지 않은 쪽지가 3개 있습니다.</div>
				<div class="col-1"></div>
			</div>
  			
		</div>		

		
		
		
		
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	</body>
	</html>