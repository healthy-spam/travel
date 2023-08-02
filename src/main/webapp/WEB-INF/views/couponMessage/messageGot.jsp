	
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"		crossorigin="anonymous">
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
	
	#row1col5:hover {
		font-weight: bold;
	}
	
	#deleteButton:hover {
		font-weight: bold;
	}
	
	#messageInTrashTitle:hover {
		font-weight: bold;
	}
	#messageInStorageTitle:hover {
		font-weight: bold;
	}
	
	#deleteButton:hover {
		font-weight: bold;
	}
	
	#row1col2 {
		cursor : pointer;
	}
	#row1col2:hover {
		font-weight: bold;
	}
	
	.aa{
	color: #fcba03;
	}
	
	.bb {
	color: #fcba03;
	}
	
	.container-fluid {
	border:1px black;
	}
	
	.shadow1 {
		  box-shadow: inset 0 0 1px;
	}
	
	.writeBtn {
	 border-color:#03c75a;
	 border-radius: 20px;
	 background-color:#03c75a;
	 color:white;
	}
	
	.pageAction a.active {
		background-color: #03c75a;
		color: white;
		border-color: #ced4da;
	}
	
	.pageAct a:hover:not(.avtive) {
		background-color: white;
	}
	
	.search {
		background-color: white;
		color: black;
	}
	

	
	</style>
	<script type="text/javascript">
			var changeBackColor = true;
			
			const logo = document.querySelector(".navbar-brand");
			console.log(logo);
			
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
				
				// 받은 메시지 삭제
				function deleteMessageGet(messageId) {
					
					if(confirm("휴지통으로 이동시키겠습니까?")){
					const xhr = new XMLHttpRequest();
					
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							// js 작업..
							reloadMessageGet();
							
							}
						}
					//get
					xhr.open("get", "./deleteMessageGet?messageId=" + messageId);
					xhr.send();
					}
				}
				
				//보낸 메시지 삭제
				function deleteMessageSend(messageId) {
					
					if(confirm("삭제하시겠습니까?")){
					const xhr = new XMLHttpRequest();
					
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							// js 작업..
							reloadMessageSend();
							
							}
						}
					//get
					xhr.open("get", "./deleteMessageSend?messageId=" + messageId);
					xhr.send();
					}
				}
				
				function refreshMessageRead(messageId){
					
					const xhr = new XMLHttpRequest();
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							// js 작업..
							
						}
					}
					
					//get
					xhr.open("get", "./refreshMessageRead?messageId=" + messageId);
					xhr.send();
					
				}
				
				
			let mySessionId = null;
			
			
			//쪽지쓰기(모달)
			function openMessageWritePage() {
			
				
				const messageWriteModal = bootstrap.Modal.getOrCreateInstance("#messageWriteModal");
				
				messageWriteModal.show();
				
			}
			
			//받은쪽지 내용 읽기(모달)
			function openMessageGetPage(messageId, messageTitle, messageNickName, messageSendDateFormatted, messageContent) {
			
				
				const readMessageGetModal = bootstrap.Modal.getOrCreateInstance("#readMessageGetModal");
				const messageGetTitle = document.getElementById("messageGetTitle");
				const messageGetSender = document.getElementById("messageGetSender");
	  			const messageGetTime = document.getElementById("messageGetTime");
				const messageGetContent = document.getElementById("messageGetContent");
				
				messageGetTitle.textContent = messageTitle;
				messageGetSender.textContent = messageNickName;
				messageGetTime.textContent = messageSendDateFormatted;
				messageGetContent.innerHTML = messageContent.replace(/(\r\n|\n)/g, "<br>");
				
				
				refreshMessageRead(messageId);
				readMessageGetModal.show();
				getUnreadMessageCount();
				
			}
			// 보낸쪽지 내용 읽기(모달)
			function openMessageSendPage(messageTitle, messageReceiver, messageSendDateFormatted, messageContent) {
				
				
				const readMessageSendModal = bootstrap.Modal.getOrCreateInstance("#readMessageSendModal");
				const messageSendTitle = document.getElementById("messageSendTitle");
				const messageSendReceiver = document.getElementById("messageSendReceiver");
	  			const messageSendTime = document.getElementById("messageSendTime");
				const messageSendContent = document.getElementById("messageSendContent");
				
				
				messageSendTitle.textContent = messageTitle;
				messageSendReceiver.textContent = messageReceiver;
				messageSendTime.textContent = messageSendDateFormatted;
				messageSendContent.innerHTML = messageContent.replace(/(\r\n|\n)/g, "<br>");
				
				
				
				
				readMessageSendModal.show();
				
			}
			
			// 휴지통에 있는 보낸메시지 모달 읽기
			function openMessageSendInTrashPage(messageInTrashTitle, messageSendInTrashReceiver, messageSendDateFormatted, messageInTrashContent) {
				
				const readMessageSendInTrashModal = bootstrap.Modal.getOrCreateInstance("#readMessageSendInTrashModal");
				const messageSendInTrashTitle = document.getElementById("messageSendInTrashTitle");
				const messageSendInTrashReceiverModal = document.getElementById("messageSendInTrashReceiverModal");
	  			const messageSendInTrashSendTime = document.getElementById("messageSendInTrashSendTime");
				const messageSendInTrashContent = document.getElementById("messageSendInTrashContent");
				
				
				messageSendInTrashTitle.textContent = messageInTrashTitle;
				messageSendInTrashReceiverModal.textContent = messageSendInTrashReceiver;
				messageSendInTrashSendTime.textContent = messageSendDateFormatted;
				messageSendInTrashContent.innerHTML = messageInTrashContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageSendInTrashModal.show();
				
			}
			
			// 휴지통에 있는 받은메시지 모달 읽기
			function openMessageGetInTrashPage(messageInTrashTitle, messageGetInTrashSender, messageSendDateFormatted, messageInTrashContent) {
				
				const readMessageGetInTrashModal = bootstrap.Modal.getOrCreateInstance("#readMessageGetInTrashModal");
				const messageGetInTrashTitle = document.getElementById("messageGetInTrashTitle");
				const messageGetInTrashSenderModal = document.getElementById("messageGetInTrashSenderModal");
	  			const messageGetInTrashSendTime = document.getElementById("messageGetInTrashSendTime");
				const messageGetInTrashContent = document.getElementById("messageGetInTrashContent");
				
				
				messageGetInTrashTitle.textContent = messageInTrashTitle;
				messageGetInTrashSenderModal.textContent = messageGetInTrashSender;
				messageGetInTrashSendTime.textContent = messageSendDateFormatted;
				messageGetInTrashContent.innerHTML = messageInTrashContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageGetInTrashModal.show();
				
			}
			
			// 보관함에 있는 보낸메시지 모달 읽기
			function openMessageSendInStoragePage(messageInStorageTitle, messageSendInStorageReceiver, messageSendDateFormatted, messageInStorageContent) {
				
				const readMessageSendInStorageModal = bootstrap.Modal.getOrCreateInstance("#readMessageSendInStorageModal");
				const messageSendInStorageTitle = document.getElementById("messageSendInStorageTitle");
				const messageSendInStorageReceiverModal = document.getElementById("messageSendInStorageReceiverModal");
	  			const messageSendInStorageSendTime = document.getElementById("messageSendInStorageSendTime");
				const messageSendInStorageContent = document.getElementById("messageSendInStorageContent");
				
				
				messageSendInStorageTitle.textContent = messageInStorageTitle;
				messageSendInStorageReceiverModal.textContent = messageSendInStorageReceiver;
				messageSendInStorageSendTime.textContent = messageSendDateFormatted;
				messageSendInStorageContent.innerHTML = messageInStorageContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageSendInStorageModal.show();
				
			}
			
			// 보관함에 있는 받은메시지 모달 읽기
			function openMessageGetInStoragePage(messageInStorageTitle, messageGetInStorageSender, messageSendDateFormatted, messageInStorageContent) {
				
				const readMessageGetInStorageModal = bootstrap.Modal.getOrCreateInstance("#readMessageGetInStorageModal");
				const messageGetInStorageTitle = document.getElementById("messageGetInStorageTitle");
				const messageGetInStorageSenderModal = document.getElementById("messageGetInStorageSenderModal");
	  			const messageGetInStorageSendTime = document.getElementById("messageGetInStorageSendTime");
				const messageGetInStorageContent = document.getElementById("messageGetInStorageContent");
				
				
				messageGetInStorageTitle.textContent = messageInStorageTitle;
				messageGetInStorageSenderModal.textContent = messageGetInStorageSender;
				messageGetInStorageSendTime.textContent = messageSendDateFormatted;
				messageGetInStorageContent.innerHTML = messageInStorageContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageGetInStorageModal.show();
				
			}
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

			// 받은 쪽지 리스트
			function reloadMessageGet(){
				const xhr = new XMLHttpRequest();
							
							xhr.onreadystatechange = function(){
								if(xhr.readyState == 4 && xhr.status == 200){
									const response = JSON.parse(xhr.responseText);
									// js 작업..
									const targetCol = document.getElementById("targetCol");
													
									const messageType = document.getElementById("messageType");
							
									messageType.innerText = "받은 쪽지함";
									
									// 삭제 버튼 요소 선택
									const deleteButton = document.querySelector('.deleteAll .deletebtn');

									// 내용 변경
									deleteButton.textContent = '삭제';
									
									const restoreAllElements = document.querySelectorAll('.restoreAll');

									// NodeList의 각 요소에 대해 클래스를 제거
									restoreAllElements.forEach((element) => {
									  element.classList.add('d-none');
									});							

		
									
									
									// 기존의 쪽지 목록을 찾아 제거
									
									
								      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
								      existingRows.forEach(function(row) {
								        targetCol.removeChild(row);
								      });
								      
								      
								      
									
									for(let data of response.messageGetList){
									console.log(response);
									if (data.messageDto.message_status && (data.messageDto.message_status.indexOf("받은쪽지삭제") >= 0 || data.messageDto.message_status.indexOf("받은쪽지영구삭제") >= 0 )) {
										
									}else{									
										
									var messageId = data.messageDto.message_id;
									var messageNickName = data.userDto.user_nickname;
									var messageTitle = data.messageDto.message_title;
									var messageSendReceiver = data.messageDto.user_nickname;
									const messageContent = data.messageDto.message_content;
	
									var messageSendDate = new Date(data.messageDto.message_reg_date);
									
									var messageSendDateFormatted = formatDate(messageSendDate, 'yy-MM-dd hh:mm:ss');
									
									const row1 = document.createElement("div");
									row1.classList.add("row", "border-top", "border-1", "p-3");
									row1.setAttribute("id", "messageGetRow1");
									row1.setAttribute("messageSendReceiver", messageSendReceiver);
									
									const row1col1 = document.createElement("div");
									row1col1.classList.add("col-auto", "d-flex", "align-self-center");
									row1.appendChild(row1col1);
									
									const input1 = document.createElement("input");
									input1.classList.add("form-check-input");
									input1.type = "checkbox";
									input1.value = data.messageDto.message_id;
									input1.id = "flexCheckDefault";
									input1.setAttribute("onclick", "chkClicked()");
									row1col1.appendChild(input1);
									
									const row1col2 = document.createElement("div");
									row1col2.classList.add("col-auto", "d-flex", "align-self-center");
									row1col2.id ="row1col2";
									row1.appendChild(row1col2);
									
									const i1 = document.createElement("i");
									if(data.messageDto.message_status && data.messageDto.message_status.indexOf("받은쪽지보관") >= 0){
									i1.classList.add("bi", "bi-star-fill","aa");
									
									}else{
									i1.classList.add("bi", "bi-star");
									}
									i1.setAttribute("onclick", "toggleStarGet(" + messageId + ")");
									console.log(messageId);
									row1col2.appendChild(i1);
									
									const row1col3 = document.createElement("div");
									row1col3.classList.add("col-auto", "d-flex", "align-self-center");
									row1.appendChild(row1col3);
									
									const i2 = document.createElement("i");
									if(data.messageDto.message_read_date == null){
										i2.classList.add("bi", "bi-envelope");
									}else {
										i2.classList.add("bi", "bi-envelope-open");
									}
									row1col3.appendChild(i2);
									
									
									
									const row1col4 = document.createElement("div");
									row1col4.classList.add("col", "align-self-center","text-center");
									row1col4.innerText = data.userDto.user_nickname;
									row1.appendChild(row1col4);
									
									const row1col5 = document.createElement("div");
									row1col5.classList.add("col", "d-flex", "align-self-center");
									row1col5.setAttribute("id", "row1col5");
									row1col5.innerText = data.messageDto.message_title;
									row1col5.setAttribute("messageTitle", messageTitle);
									row1col5.setAttribute("messageNickName", messageNickName);
									row1col5.setAttribute("messageSendDateFormatted", messageSendDateFormatted);
									row1col5.setAttribute("messageContent", messageContent);
									row1col5.setAttribute("messageId", messageId);
									
									row1col5.setAttribute("onclick", "openMessageGetPage('" + messageId + "','" + messageTitle +
						                      "','" + messageNickName + "','" + messageSendDateFormatted + "'," +
						                      JSON.stringify(messageContent).replace(/(\r\n|\n)/g, "<br>") + ")");
									row1col5.style = "cursor : pointer"
									row1.appendChild(row1col5);
									
									
									
									
									
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
									deleteButton.setAttribute("onclick", "deleteMessageGet(" + messageId + ")");
									deleteButton.innerText = "삭제";
									deleteButton.setAttribute("id", "deleteButton");
									row1col7.appendChild(deleteButton);
									
									targetCol.appendChild(row1);
									
									
									}
									}
									
								   
								}
							}
							
							//get
							xhr.open("get", "./reloadMessageGet");
							xhr.send();
							
	
			}
			
			// 보낸 메시지 리스트
			function reloadMessageSend(){
				
				const xhr = new XMLHttpRequest();
							
							xhr.onreadystatechange = function(){
								if(xhr.readyState == 4 && xhr.status == 200){
									const response = JSON.parse(xhr.responseText);
									// js 작업..
									const targetCol = document.getElementById("targetCol");
									
									const messageType = document.getElementById("messageType")
									messageType.innerText = "보낸 쪽지함";
									
									// 삭제 버튼 요소 선택
									const deleteButton = document.querySelector('.deleteAll .deletebtn');

									// 내용 변경
									deleteButton.textContent = '삭제';
									
									const restoreAllElements = document.querySelectorAll('.restoreAll');

									// NodeList의 각 요소에 대해 클래스를 제거
									restoreAllElements.forEach((element) => {
									  element.classList.add('d-none');
									});							

		
									
									// 기존의 쪽지 목록을 찾아 제거
								      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
								      existingRows.forEach(function(row) {
								        targetCol.removeChild(row);
								      });
									
									for(data of response.messageSendList){
									if (data.message_status && (data.message_status.indexOf("보낸쪽지삭제") >= 0 || data.message_status.indexOf("보낸쪽지영구삭제") >= 0)) {
										
									}
									else{
									var messageId = data.message_id;
									var messageTitle = data.message_title;
									var messageReceiver = data.user_nickname;
									var messageContent = data.message_content;
									var messageSendDate = new Date(data.message_reg_date);
									
									var messageSendDateFormatted = formatDate(messageSendDate, 'yy-MM-dd hh:mm:ss');
									
									const row1 = document.createElement("div");
									row1.classList.add("row", "border-top", "border-1", "p-3");
									
									const row1col1 = document.createElement("div");
									row1col1.classList.add("col-auto", "d-flex", "align-self-center");
									row1.appendChild(row1col1);
									
									const input1 = document.createElement("input");
									input1.classList.add("form-check-input");
									input1.type = "checkbox";
									input1.value = data.message_id;
									input1.id = "flexCheckDefault";
									input1.setAttribute("onclick", "chkClicked()");
									row1col1.appendChild(input1);
									
									const row1col2 = document.createElement("div");
									row1col2.classList.add("col-2", "d-flex", "align-self-center");
									row1col2.id = "row1col2";
									row1col2.style = "margin-right: -104px";
									row1.appendChild(row1col2);
									
									const row1col2span = document.createElement("span");
									row1col2.appendChild(row1col2span);
									
									const istar2 = document.createElement("i");
									if(data.message_status && data.message_status.indexOf("보낸쪽지보관") >= 0){
									istar2.classList.add("bi", "bi-star-fill", "bb");
									}else{
									istar2.classList.add("bi", "bi-star");
									}
									istar2.setAttribute("id", "restoreStar");
									istar2.setAttribute("onclick", "toggleStarSend(" + messageId + ")");
									row1col2span.appendChild(istar2);
									

									
									if(data.message_read_date == null) {
									const notReadMark = document.createElement("span");
									notReadMark.classList.add("badge", "text-wrap", "bg-secondary", "ms-2");
									notReadMark.innerText = "읽지않음";	
									row1col2.appendChild(notReadMark);
									} else {
									const readMark = document.createElement("span");
									readMark.classList.add("badge", "text-wrap", "bg-primary", "ms-2");
									readMark.innerText = "읽음";
									row1col2.appendChild(readMark);
									}
									

									
									
									const row1col4 = document.createElement("div");
									row1col4.classList.add("col", "align-self-center","text-center");
									row1col4.innerText = data.user_nickname;
									row1.appendChild(row1col4);
									
									const row1col5 = document.createElement("div");
									row1col5.classList.add("col", "d-flex", "align-self-center");
									row1col5.innerText = data.message_title;
									row1col5.setAttribute("id", "row1col5");
									row1col5.setAttribute("messageTitle", messageTitle);
									row1col5.setAttribute("messageReceiver", messageReceiver);
									row1col5.setAttribute("messageContent", messageContent);
									row1col5.setAttribute("messageSendDateFormatted", messageSendDateFormatted);
									row1col5.setAttribute("onclick", "openMessageSendPage('" + messageTitle +
						                      "','" + messageReceiver + "','" + messageSendDateFormatted + "'," +
						                      JSON.stringify(messageContent).replace(/(\r\n|\n)/g, "<br>") + ")");
									row1col5.style = "cursor : pointer"
									row1.appendChild(row1col5);
									
									
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
									deleteButton.setAttribute("onclick", "deleteMessageSend(" + messageId + ")");
									deleteButton.innerText = "삭제";
									deleteButton.setAttribute("id", "deleteButton");
									row1col7.appendChild(deleteButton);
									
									targetCol.appendChild(row1);
									
									refreshStar(messageId);
										}
									
	
									}
								}
							}
							
							//get
							xhr.open("get", "./reloadMessageSend");
							xhr.send();
							
	
					
			}
			
					// 휴지통 리스트 띄우기
					function reloadTrash() {
						const xhr = new XMLHttpRequest();
						
						xhr.onreadystatechange = function(){	
							if(xhr.readyState == 4 && xhr.status == 200){
								const response = JSON.parse(xhr.responseText);
								// js 작업..
								const messageType = document.getElementById("messageType")										
								messageType.innerText = "휴지통";
								
								
								// 삭제 버튼 요소 선택
								const deleteButton = document.querySelector('.deleteAll .deletebtn');

								// 내용 변경
								deleteButton.textContent = '영구삭제';

								
								const restoreAllElements = document.querySelectorAll('.restoreAll');

								// NodeList의 각 요소에 대해 클래스를 제거
								restoreAllElements.forEach((element) => {
								  element.classList.remove('d-none');
								});							


								
								
								const userId = response.userId;
								
								const targetCol = document.getElementById("targetCol");
								

								

								
								// 기존의 쪽지 목록을 찾아 제거
							      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
							      existingRows.forEach(function(row) {
							        targetCol.removeChild(row);
							      });
								
							      
								
								
								for(data of response.list){
								//휴지통에 있는 받은 메시지를 보낸사람
								var messageGetInTrashSender = data.userDto.user_nickname;
								//휴지통에 있는 보낸 메시지의 받는사람 
								var messageSendInTrashReceiver = data.messageDto.user_nickname;
								var messageInTrashTitle = data.messageDto.message_title;
								var messageInTrashSendDate = new Date(data.messageDto.message_reg_date);
								var messageSendDateFormatted = formatDate(messageInTrashSendDate, 'yy-MM-dd hh:mm:ss');							
								var messageInTrashContent = data.messageDto.message_content;
								var messageId = data.messageDto.message_id;
								
								
								const containerDiv = document.createElement('div');
								containerDiv.classList.add('row', 'border-top', 'border-1', 'p-3');
								containerDiv.id = 'trashList';

								// 체크박스 div 생성
								const checkboxDiv = document.createElement('div');
								checkboxDiv.classList.add('col-auto', 'd-flex', 'align-self-center');
								containerDiv.appendChild(checkboxDiv);

								// 체크박스 input 생성
								const checkboxInput = document.createElement('input');
								checkboxInput.type = 'checkbox';
								checkboxInput.classList.add('form-check-input');
								checkboxInput.value = data.messageDto.message_id;
								checkboxInput.id = 'flexCheckDefault';
								checkboxInput.setAttribute("onclick", "chkClicked()");
								checkboxDiv.appendChild(checkboxInput);

								// 닉네임 div 생성
								const nicknameDiv = document.createElement('div');
								nicknameDiv.classList.add('col', 'align-self-center', 'text-center');
								nicknameDiv.id = 'messageInTrashNickName';

								// 보낸쪽지일 경우
								if(parseInt(data.messageDto.user_id) === parseInt(userId)){
									
									
									
									const messageSendMark = document.createElement("div");
									messageSendMark.classList.add("col-auto","align-self-center", "badge", "text-wrap", "bg-secondary");
									messageSendMark.innerText = "보낸쪽지";
									messageSendMark.style = "margin-left:25px";
									containerDiv.appendChild(messageSendMark);
									
									const receiverNickname = document.createElement("div");
									receiverNickname.classList.add("col", "text");
									receiverNickname.innerText = data.messageDto.user_nickname;
									receiverNickname.style = "margin-left: 20px;"
									nicknameDiv.appendChild(receiverNickname);
									
									
									
								}else{ //받는 쪽지일 경우
									const messageSendMark = document.createElement("div");
									messageSendMark.classList.add("col-auto","align-self-center", "badge", "text-wrap");
									messageSendMark.innerText = "받은쪽지";
									messageSendMark.style = "margin-left:25px; background-color:#03c75a;";
									containerDiv.appendChild(messageSendMark);
									
									const receiverNickname = document.createElement("div");
									receiverNickname.classList.add("col", "text");
									receiverNickname.innerText = data.userDto.user_nickname;
									receiverNickname.style = "margin-left: 20px;"
									
									nicknameDiv.appendChild(receiverNickname);				
								}								
								
								containerDiv.appendChild(nicknameDiv);
								
								
								
								// 제목 div 생성
								const titleDiv = document.createElement('div');
								titleDiv.classList.add('col', 'd-flex', 'align-self-center');
								titleDiv.style="margin-left:16px;"
								//보낸 메시지일 경우
								if(parseInt(data.messageDto.user_id) === parseInt(userId)){
								console.log(data.messageDto.user_id);
								console.log(userId);
								titleDiv.setAttribute("onclick", "openMessageSendInTrashPage('" + messageInTrashTitle +
					                      "','" + messageSendInTrashReceiver + "','" + messageSendDateFormatted + "'," +
					                      JSON.stringify(messageInTrashContent).replace(/(\r\n|\n)/g, "<br>") + ")");
								}else{ //받은 메시지일 경우
									titleDiv.setAttribute("onclick", "openMessageGetInTrashPage('" + messageInTrashTitle +
						                      "','" + messageGetInTrashSender + "','" + messageSendDateFormatted + "'," +
						                      JSON.stringify(messageInTrashContent).replace(/(\r\n|\n)/g, "<br>") + ")");	
								}
								titleDiv.style.cursor = 'pointer';
								titleDiv.id = 'messageInTrashTitle';
								titleDiv.innerText = messageInTrashTitle;
								containerDiv.appendChild(titleDiv);

								// 전송일 div 생성
								const sendDateDiv = document.createElement('div');
								sendDateDiv.classList.add('col', 'align-self-center', 'text-center');
								sendDateDiv.style="margin-left:30px;"
								sendDateDiv.id = 'messageInTrashSendDate';
								sendDateDiv.innerText = messageSendDateFormatted;
								containerDiv.appendChild(sendDateDiv);
																
								
								const colDiv = document.createElement("div");
								colDiv.classList.add("col-3", "text-center");
								
								const deleteButtonSpan = document.createElement("span");
								
								const deleteButton = document.createElement("button");
								deleteButton.classList.add("btn", "btn-sm", "border", "border-dark");
								deleteButton.id = "deleteButton";
								deleteButton.type = "button";
								deleteButton.innerText = "영구삭제";
								deleteButton.setAttribute("onclick", "deleteMessageInTrash(" + messageId + ")");

								deleteButtonSpan.appendChild(deleteButton);
								
								const restoreButtonSpan = document.createElement("span");
								
								const restoreButton = document.createElement("button");
								restoreButton.classList.add("btn", "btn-sm", "border", "border-dark", "ms-2");
								restoreButton.id = "restoreButton";
								restoreButton.type = "button";
								restoreButton.innerText = "복구";
								restoreButton.setAttribute("onclick", "restoreMessageInTrash(" + messageId + ")");

								restoreButtonSpan.appendChild(restoreButton);
								
								colDiv.appendChild(deleteButton);
								colDiv.appendChild(restoreButton);
								
								containerDiv.appendChild(colDiv);
								
								targetCol.appendChild(containerDiv);
								
								
								}
							}
						}
						
						//get
						xhr.open("get", "./reloadTrash");
						xhr.send();
	
			}
			
					
			function deleteMessageInTrash(messageId) {
				const xhr = new XMLHttpRequest();
				if(confirm("영구 삭제하시겠습니까?")){
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						reloadTrash();
					}
				}
				
				//get
				xhr.open("get", "./deleteMessageInTrash?messageId=" + messageId);
				xhr.send();
				}
			}
			
			
			//보관함 리스트 불러오기
			function reloadStorage() {
				const xhr = new XMLHttpRequest();
				
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						
						// 삭제 버튼 요소 선택
						const deleteButton = document.querySelector('.deleteAll .deletebtn');

						// 내용 변경
						deleteButton.textContent = '보관해제';
						
						const restoreAllElements = document.querySelectorAll('.restoreAll');

						// NodeList의 각 요소에 대해 클래스를 제거
						restoreAllElements.forEach((element) => {
						  element.classList.add('d-none');
						});							

						
						const messageType = document.getElementById("messageType")
						messageType.innerText = "보관함";
						const userId = response.userId;
						
						const targetCol = document.getElementById("targetCol");
						

						

						
						// 기존의 쪽지 목록을 찾아 제거
					      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
					      existingRows.forEach(function(row) {
					        targetCol.removeChild(row);
					      });
						
					      
						
						
						for(data of response.list){
						//보관함에 있는 받은 메시지를 보낸사람
						var messageGetInStorageSender = data.userDto.user_nickname;
						//보관함에 있는 보낸 메시지의 받는사람 
						var messageSendInStorageReceiver = data.messageDto.user_nickname;
						var messageInStorageTitle = data.messageDto.message_title;
						var messageInStorageSendDate = new Date(data.messageDto.message_reg_date);
						var messageSendDateFormatted = formatDate(messageInStorageSendDate, 'yy-MM-dd hh:mm:ss');							
						var messageInStorageContent = data.messageDto.message_content;
						var messageId = data.messageDto.message_id;
						
						
						const containerDiv = document.createElement('div');
						containerDiv.classList.add('row', 'border-top', 'border-1', 'p-3');
						containerDiv.id = 'storageList';

						// 체크박스 div 생성
						const checkboxDiv = document.createElement('div');
						checkboxDiv.classList.add('col-auto', 'd-flex', 'align-self-center');
						containerDiv.appendChild(checkboxDiv);

						// 체크박스 input 생성
						const checkboxInput = document.createElement('input');
						checkboxInput.type = 'checkbox';
						checkboxInput.classList.add('form-check-input');
						checkboxInput.value = '';
						checkboxInput.id = 'flexCheckDefault';
						checkboxDiv.appendChild(checkboxInput);

						// 닉네임 div 생성
						const nicknameDiv = document.createElement('div');
						nicknameDiv.classList.add('col', 'align-self-center', 'text-center');
						nicknameDiv.id = 'messageInStorageNickName';

						// 보낸쪽지일 경우
						if(parseInt(data.messageDto.user_id) === parseInt(userId)){
							
							
							
							const messageSendMark = document.createElement("div");
							messageSendMark.classList.add("col-auto","align-self-center", "badge", "text-wrap", "bg-secondary");
							messageSendMark.innerText = "보낸쪽지";
							messageSendMark.style = "margin-left:24px";
							containerDiv.appendChild(messageSendMark);
							
							const receiverNickname = document.createElement("div");
							receiverNickname.classList.add("col", "text", "ms-2");
							receiverNickname.innerText = data.messageDto.user_nickname;
							
							nicknameDiv.appendChild(receiverNickname);
							
							
							
						}else{ //받는 쪽지일 경우
							const messageSendMark = document.createElement("div");
							messageSendMark.classList.add("col-auto","align-self-center", "badge", "text-wrap");
							messageSendMark.innerText = "받은쪽지";
							messageSendMark.style = "margin-left:24px; background-color:#03c75a;";
							containerDiv.appendChild(messageSendMark);
							
							const receiverNickname = document.createElement("div");
							receiverNickname.classList.add("col", "text", "ms-2");
							receiverNickname.innerText = data.userDto.user_nickname;
							
							nicknameDiv.appendChild(receiverNickname);				
						}								
						
						containerDiv.appendChild(nicknameDiv);
						
						
						
						// 제목 div 생성
						const titleDiv = document.createElement('div');
						titleDiv.classList.add('col', 'd-flex', 'align-self-center');
						//보낸 메시지일 경우
						if(parseInt(data.messageDto.user_id) === parseInt(userId)){
						console.log(data.messageDto.user_id);
						console.log(userId);
						titleDiv.setAttribute("onclick", "openMessageSendInStoragePage('" + messageInStorageTitle +
			                      "','" + messageSendInStorageReceiver + "','" + messageSendDateFormatted + "'," +
			                      JSON.stringify(messageInStorageContent).replace(/(\r\n|\n)/g, "<br>") + ")");
						}else{ //받은 메시지일 경우
							titleDiv.setAttribute("onclick", "openMessageGetInStoragePage('" + messageInStorageTitle +
				                      "','" + messageGetInStorageSender + "','" + messageSendDateFormatted + "'," +
				                      JSON.stringify(messageInStorageContent).replace(/(\r\n|\n)/g, "<br>") + ")");	
						}
						titleDiv.style.cursor = 'pointer';
						titleDiv.id = 'messageInStorageTitle';
						titleDiv.innerText = messageInStorageTitle;
						containerDiv.appendChild(titleDiv);

						// 전송일 div 생성
						const sendDateDiv = document.createElement('div');
						sendDateDiv.classList.add('col', 'align-self-center', 'text-center', 'ms-2');
						sendDateDiv.id = 'messageInStorageSendDate';
						sendDateDiv.innerText = messageSendDateFormatted;
						containerDiv.appendChild(sendDateDiv);

						// 보관해제 버튼 div 생성
						const cancelRestore = document.createElement('div');
						cancelRestore.classList.add('col', 'align-self-center', 'text-center', 'ms-auto');
						
						containerDiv.appendChild(cancelRestore);

						// 보관해제 버튼 생성
						const cancelButton = document.createElement('button');
						cancelButton.classList.add('btn', 'btn-sm', 'border', 'border-dark');
						cancelButton.id = 'deleteButton';
						cancelButton.type = 'button';
						cancelButton.setAttribute("onclick", "cancelRestore(" + messageId +")");
						cancelButton.textContent = '보관해제';
						cancelRestore.appendChild(cancelButton);
						
						
						
						targetCol.appendChild(containerDiv);
						}
					}
				}
				
				//get
				xhr.open("get", "./reloadStorage");
				xhr.send();
				
				
			
		}
			
			function toggleStarGet(messageId) {
				const xhr = new XMLHttpRequest();
				console.log(messageId);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						reloadMessageGet();
					}
				}
				
				//get
				xhr.open("get", "./toggleStar?messageId=" + messageId);
				xhr.send();
				

			}
			
			function toggleStarSend(messageId) {
				const xhr = new XMLHttpRequest();
				console.log(messageId);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						reloadMessageSend();
					}
				}
				
				//get
				xhr.open("get", "./toggleStar?messageId=" + messageId);
				xhr.send();
				

			}
			
			function refreshStar(messageId){
				const xhr = new XMLHttpRequest();
				
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						const restoreStar = document.getElementById("restoreStar");
						if(response.isStored){
							

						}
					}
				}
				
				//get
				xhr.open("get", "./refreshStar?messageId=" + messageId);
				xhr.send();
				

				
			}
			// 답장
			function replyMessage(){
				
				const messageGetSender = document.getElementById("messageGetSender").textContent;
				const messageWriteSender = document.getElementById("messageWriteSender");
				messageWriteSender.value = messageGetSender;
				const messageWritetitle = document.getElementById("messageWritetitle");
				messageWritetitle.value = "";
				
				const readMessageGetModal = bootstrap.Modal.getOrCreateInstance("#readMessageGetModal");
				const messageWriteModal = bootstrap.Modal.getOrCreateInstance("#messageWriteModal");
				
				
				readMessageGetModal.hide();
				messageWriteModal.show();
				
			}
			
		    //체크박스 전체 선택 클릭 이벤트
		    function allChecked(target){

		        //전체 체크박스 버튼
		        const checkbox = document.getElementById('allCheckBox');

		        //전체 체크박스 버튼 체크 여부
		        const is_checked = checkbox.checked;

		        //전체 체크박스 제외한 모든 체크박스a
		        if(is_checked){
		            //체크박스 전체 체크
		            chkAllChecked()
		        }

		        else{
		            //체크박스 전체 해제
		            chkAllUnChecked()
		        }
		    }
		    
		    //자식 체크박스 클릭 이벤트
		    function chkClicked(){

		        //체크박스 전체개수
		        const allCount = document.querySelectorAll(".form-check-input").length;

		        //체크된 체크박스 전체개수
		        const query = 'input[name="form-check-input"]:checked'
		        const selectedElements = document.querySelectorAll(query)
		        const selectedElementsCnt = selectedElements.length;

		        //체크박스 전체개수와 체크된 체크박스 전체개수가 같으면 전체 체크박스 체크
		        if(allCount == selectedElementsCnt){
		             document.getElementById('allCheckBox').checked = true;
		        }

		        //같지않으면 전체 체크박스 해제
		        else{
		            document.getElementById('allCheckBox').checked = false;
		        }
		    }

		    //체크박스 전체 체크
		    function chkAllChecked(){
		        document.querySelectorAll(".form-check-input").forEach(function(v, i) {
		            v.checked = true;
		        });
		    }

		    //체크박스 전체 체크 해제
		    function chkAllUnChecked(){
		        document.querySelectorAll(".form-check-input").forEach(function(v, i) {
		            v.checked = false;
		        });
		    }
		    
		    function deleteSelectedMessages(){
		        // 쪽지에 대한 모든 체크박스를 가져옵니다.
		        console.log("dd")
		        const checkboxes = document.querySelectorAll(".form-check-input");

		        // 선택된 쪽지의 ID를 저장할 배열
		        const selectedMessageIds = [];
				
		        // 체크된 체크박스를 찾아냅니다.
		        checkboxes.forEach(function (checkbox) {
		            if (checkbox.checked) {
		                // data-id 속성을 사용하여 쪽지 ID를 가져와 배열에 추가합니다.
		                const messageId = checkbox.getAttribute("value");
		                selectedMessageIds.push(messageId);
		            }
		        });
		        // 선택된 쪽지를 삭제하는 실제 로직을 수행합니다. (실제 삭제 로직은 백엔드에서 구현해야 합니다)
					if (selectedMessageIds.length > 0) {
					        const messageType = document.getElementById("messageType");
					        const messageTypeText = messageType.innerText;
					        console.log(messageTypeText);
					        console.log(selectedMessageIds);
					        if (messageTypeText === "받은 쪽지함") {
					            deleteMessagesGet(selectedMessageIds); // 선택된 쪽지들을 한 번에 삭제하는 함수를 호출합니다.
					        } else if (messageTypeText === "보낸 쪽지함") {
					            // 보낸 쪽지함에 대한 삭제 로직을 수행하거나 필요한 작업을 수행합니다.
					            deleteMessagesSend(selectedMessageIds);
					        }
					    }
		    }
		    

		    function deleteMessagesGet(selectedMessageIds){
		    	// 선택된 쪽지의 개수 확인
		        const numSelectedMessages = selectedMessageIds.length;
		        // 확인 대화 상자 표시
		        const isConfirmed = confirm("선택한 " + numSelectedMessages + "개의 쪽지를 삭제하시겠습니까?");
		        if (isConfirmed) {
					const xhr = new XMLHttpRequest();
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							
							reloadMessageGet();
						}
					}
					
					//get
					xhr.open("get", "deleteMessagesGet?selectedMessageIds=" + encodeURIComponent(selectedMessageIds.join(',')));
					xhr.send();
					
				}
		    }
		    
		    function deleteMessagesSend(selectedMessageIds){
		    	// 선택된 쪽지의 개수 확인
		        const numSelectedMessages = selectedMessageIds.length;
		        // 확인 대화 상자 표시
		        const isConfirmed = confirm("선택한 " + numSelectedMessages + "개의 쪽지를 삭제하시겠습니까?");
		        if (isConfirmed) {
					const xhr = new XMLHttpRequest();
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							
							reloadMessageSend();
						}
					}
					
					//get
					xhr.open("get", "deleteMessagesSend?selectedMessageIds=" + encodeURIComponent(selectedMessageIds.join(',')));
					xhr.send();
					
				}
		    }
		    
		    function restoreMessageInTrash(messageId){
		    	const xhr = new XMLHttpRequest();
		    	if(confirm("해당 쪽지를 복구하시겠습니까?")){
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						reloadTrash();
					}
				}
				
				//get
				xhr.open("get", "restoreMessageInTrash?messageId=" + messageId);
				xhr.send();

		    	}
		    }
		    function getUnreadMessageCount() {
		    	const xhr = new XMLHttpRequest();
				
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						const unreadCount = response.count;
						
						console.log(unreadCount);
						
						const unreadMessagesAlert = document.getElementById('unread-messages-alert');
			            const unreadCountMessage = document.getElementById('unread-count-message');
						
						// 받아온 읽지 않은 쪽지의 개수가 0보다 크다면 알림 메시지를 표시
			            if (unreadCount > 0) {
			                
			            	unreadCountMessage.innerText = '읽지 않은 쪽지가 ' + unreadCount + '개 있습니다.';
			            	unreadCountMessage.classList.remove('d-none');
			            }  else {
			                // 읽지 않은 쪽지가 없는 경우 메시지를 숨김
			                unreadCountMessage.classList.add('d-none');
			            }
					}
				}
				
				//get
				xhr.open("get", "getUnreadMessageCount");
				xhr.send();
				
		    }
		    
		    setInterval(getUnreadMessageCount, 10000);
		    
		    
			
			window.addEventListener("DOMContentLoaded", function(){
				//사실상 시작 시점...
				reloadMessageGet();
				getUnreadMessageCount();
				var logoImage = document.querySelector('.navbar-brand.mb-0');
				logoImage.src = "/travel/resources/img/tripstationLOGO.png";
			});
								
		</script>
	
	</head>
	<body>
		<div class="container">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
			<div class="container-fluid border-1 border-top border-black">
	
				<div class="row">
					<div class="col-2 border-1 border-end border-black"	style="background-color: #e6e9f099; height: 100vh; width : 15%;">						
						<div class="row">
							<div class="col text-center p-3 border-2 border-bottom">
								<button class="btn writeBtn" type="button" onclick="openMessageWritePage()">쪽지쓰기</button>
							</div>
						</div>
						
						<div class="row border-2 border-bottom" onclick="reloadMessageGet()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:16px;">
								<i class="bi bi-envelope"></i>
							</div>
							<div class="col-2 p-3 text-center"
								style="-bs-border-opacity: .5; margin-left:-28px;">
								<i class="bi bi-arrow-left"></i>
							</div>
							<div class="col-6 text-start p-3" style="-bs-border-opacity: .5; margin-left:-12px;">
								받은쪽지
							</div>
						</div>
						
						<div class="row border-2 border-bottom" onclick="reloadMessageSend()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:16px;">
								<i class="bi bi-envelope"></i>
							</div>
							<div class="col-2 p-3 text-center"
								style="-bs-border-opacity: .5; margin-left:-28px;">
								<i class="bi bi-arrow-right"></i>
							</div>
							<div class="col-6 p-3 text-start"	style="-bs-border-opacity: .5; margin-left:-12px;">
								보낸쪽지
							</div>
						</div>
						
						<div class="row border-2 border-bottom" id="trashButton" onclick="reloadTrash()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:30px;">
								<i class="bi bi-trash"></i>
							</div>
							<div class="col-6 text-center p-3"
								
								style="-bs-border-opacity: .5; margin-left: -36px">휴지통
							</div>
						</div>
						
						<div class="row text-center border-2 border-bottom" id="storageButton" onclick="reloadStorage()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:30px;">
								<i class="bi bi-star-fill aa"></i>
							</div>
							<div class="col-6 text-center p-3"
								
								style="-bs-border-opacity: .5; margin-left: -36px">보관함
							</div>
						</div>
					</div>
	
					<div class="col-9 mx-4">
						<div class="row mt-2">
							<div class="col" id="targetCol">
								<div class="row mb-3 h2">
									<div class="col" id="messageType">받은 쪽지함</div>
								</div>
								<div class="row mb-2">
									<div class="col-auto mx-3 align-self-center me-0">
										<input class="form-check-input" type="checkbox" onclick="allChecked()"
											id="allCheckBox">
									</div>
	
									<div class="col-2 mt-1">
									<span class="deleteAll">
										<button class="btn btn-sm btn-default border border-dark deletebtn"
											type="button" onclick="deleteSelectedMessages()">
										삭제</button>
									</span>
									<span class="restoreAll d-none">
										<button class="btn btn-sm btn-default border border-dark"
											type="button" onclick="deleteSelectedMessages()">
										복구</button>
									</span>
									</div>
									<div class="col-6" style="margin-right:-145px;">
											
									</div>
									<div class="col-auto my-auto" style="margin-right: -10px;">
									    <i class="bi bi-search" style="padding-right:-20px;"></i>
									  </div>
									  <div class="col-auto">
									    <input type="text" id="inputPassword6" class="form-control" aria-labelledby="passwordHelpInline">
									  </div>
									  <div class="col-auto my-auto" style="margin-right:10px;">
									    <button type="button" class="btn border border-dark-sutle btn-sm search">검색</button>
									  </div>
								</div>
							</div>
						</div>
						<c:if test="${empty sessionuser}">
						dd
						</c:if>
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
				</div>
			</div>
	
		<div class="fixed-bottom" role="alert" id="unread-messages-alert">
			<div class="row">
				<div class="ms-auto col-3 alert alert-success d-none" id="unread-count-message"></div>
				<div class="col-1"></div>
			</div>	
		</div>
	
		<div class="modal fade" id="readMessageGetModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">받은 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageGetTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 사람</div>
							<div class="col" id="messageGetSender"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageGetTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageGetContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2 text-end">
							<button type="button" class="btn" onclick="replyMessage()" style="background-color: #17b75e; color: white;">답장</button>
							
						</div>
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								onclick="reloadMessageGet()" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="messageWriteModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<form action="./sendMessageProcess" method="post">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">쪽지쓰기</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">
								<label for="messageWriteSender" class="col-form-label">받는이</label>
							</div>
							<div class="col">
								<input type="text" class="form-control" id="messageWriteSender" name="user_nickname">
							</div>
						</div>
						<div class="row mt-1">
							<div class="col-3">
								<label for="title" class="col-form-label">제목</label>
							</div>
							<div class="col">
								<input type="text" class="form-control" id="messageWritetitle" name="message_title">
							</div>
						</div>
						<div class="row mt-3">
							<div class="col">
								<textarea class="form-control" id="content" rows="10" cols="30" name="message_content"></textarea>			
							</div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2 text-end">
							<button type="submit" class="btn"
								style="background-color: #17b75e; color: white;">전송</button>
	
						</div>
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								onclick="reloadMessageGet()" data-bs-dismiss="modal">닫기</button>
						</div>				
					</div>
					</form>
				</div>
			</div>
		</div>


	<div class="modal fade" id="readMessageSendModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">보낸 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageSendTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">받는 사람</div>
							<div class="col" id="messageSendReceiver"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageSendContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="modal fade" id="readMessageSendInTrashModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">삭제된 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageSendInTrashTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">받는 사람</div>
							<div class="col" id="messageSendInTrashReceiverModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageSendInTrashSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageSendInTrashContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="readMessageGetInTrashModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">삭제된 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageGetInTrashTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 사람</div>
							<div class="col" id="messageGetInTrashSenderModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageGetInTrashSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageGetInTrashContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="readMessageSendInStorageModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">보관중인 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageSendInStorageTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">받는 사람</div>
							<div class="col" id="messageSendInStorageReceiverModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageSendInStorageSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageSendInStorageContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="readMessageGetInStorageModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">보관중인 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageGetInStorageTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 사람</div>
							<div class="col" id="messageGetInStorageSenderModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageGetInStorageSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageGetInStorageContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
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