<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>Insert title here</title>

<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>



<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      headerToolbar: {
          start: 'prev', // Previous button on the left side
          center: 'title', // Show the title in the center
          end: 'next' // Next button on the right side
      },
      selectable: true,
      droppable: true,
      editable: true,

    });
    calendar.render();
  });
</script>


<style>
.fc-col-header-cell-cushion{
	color: black;
	text-decoration: none;
	text-weight: bold;
}
.fc .fc-daygrid-day-number {
	color: black;
	text-decoration: none;
}
body {
	background-color: #f2f2f2;
	overflow-x: hidden;
}

.sidebar {
	position: fixed;
}

.commentwritedate {
	font-size: 12px;
}

.sidebar {
	width: 19vw;
}

.margin-left-col {
	margin-left: 5vw;
	/* Adjust this value to match the width of the fixed sidebar */
}

.icon {
	height: 30px;
	/* Adjust the height value as needed */
}

strong#Createnewpost {
	font-size: 17px;
}

.postwriter {
	font-size: 17px;
}

.postregdate {
	font-size: 13px;
	color: grey;
}

.bi {
	font-style: normal;
}

.card {
	border-style: hidden;
}

.nonboarder {
	border: none;
}

.postwritearea {
	background-color: #f5f5f5;
	font-size: 14px;
}

.nav-pills .nav-link.active {
	background-color: #BB2649;
}

.sideend {
	margin: 20px;
}

.imageContainer {
	display: flex;
	overflow-x: auto;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.imageItem {
	position: relative;
	flex: 0 0 auto;
	margin-right: 10px;
}

.imageItem img {
	width: 150px;
	height: 150px;
	object-fit: cover;
	border-radius: 5px;
}

.deleteButton {
	position: absolute;
	top: 5px;
	right: 5px;
	background-color: rgba(255, 255, 255, 0.8);
	border: none;
	border-radius: 50%;
	padding: 5px;
	font-size: 12px;
	cursor: pointer;
}

.preview-item {
	position: relative;
	display: inline-block;
}

.preview-image {
	max-width: 200px;
	max-height: 200px;
	margin: 5px;
}

.delete-button {
	position: absolute;
	top: 5px;
	right: 5px;
	padding: 2px 5px;
	background-color: red;
	color: white;
	border: none;
	border-radius: 50%;
	cursor: pointer;
}

.commentwriter {
	font-size: 14px;
	font-weight: bold;
}

.text88 {
	color: #888888;
}
.textwhite {
	color: white;
}

/* Scrollbar 커스터마이징 */
::-webkit-scrollbar {
	width: 8px;
}

::-webkit-scrollbar-track {
	background-color: #f1f1f1;
}

::-webkit-scrollbar-thumb {
	background-color: #888;
	border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
	background-color: #555;
}

.commentlist {
	display: none;
}

.nocomment {
	font-size: 15px;
}

.commentcard {
	background-color: gainsboro;
}

.textcolourdefault {
	color: #888888;
}

#crewcalendar {
	background-color: #17b75e;
		color:white;
}

.vs {
	font-size: 14px;
}

.maintopnavi {
	background-color: #f2f2f2;
}

.aa {
	margin-top: 75px;
	overflow: scroll;
}

.crewsidenavi {
	position:fixed;
	width: 208px;
    padding-bottom: 20px;
    margin-right: 18px;
}

.crewsidebar {
	background-color : white; 
	border-radius: 5px;
}


.calendarcard {
	position: fixed;
	background-color: white;
	width: 350px;
	height:  500px;
}

.chatcard {
	background-color: grey;
}

.writercard {
	background-color: green;
}

.chatarea {
	height: 80%;
	overflow-x: hidden;
	overflow-y: auto;
}
</style>



</head>

<body>

	<div class="container-fluid ">
		<div class="container fixed-top top-navi maintopnavi">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
		<div class="container aa">
			<div class="row">
				<div class="col-3 px-0">
					<aside id="info" style="transform: none;">
						<div id="infoInner" data-viewname="DBandCoverItemView" class="infoInner -sticky" style="position: relative; overflow: visible;">
							<jsp:include page="../common/crewHomeNavi.jsp"></jsp:include>
						</div>
					</aside>
				</div>
			
				<div class="col-6">

					<div class="container main p-4 card">
						<div id="calendar">
						</div>
					</div>
				</div>
				<div class="col-3 ps-4">
					<div class="card calendarcard">
						<div class="row mx-1 sticky-header">
							<div class="col p-2">
								크루 전체 채팅
							</div>
						</div>
						<div class="card chatarea">
							<c:forEach var="chat" items="${chatlist}">
								<c:choose>
									<c:when test="${chat.sender.user_id != userDto.user_id }">
										<div class="row">
											<div class="col-auto pt-3 ps-4 pe-1">
												<img src="/uploadFiles/profileImage/${chat.sender.user_image }" width="40px" height="40px" class="rounded-circle">
											</div>
											<div class="col">
												<div class="row">
													<div class="col">
														${chat.sender.user_nickname }
													</div>
												</div>
												<div class="row">
													<div class="col-auto">
														<div class="card chatcard p-1">
															${chat.chatDto.crew_chat_text }
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col">
														<fmt:formatDate value="${chat.chatDto.crew_chat_date }" pattern="MM.dd HH:mm" var="crew_chat_date" />
															${crew_chat_date }
													</div>
												</div>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="row">
											<div class="col me-2">
												<div class="row">
													<div class="col">
													</div>
													<div class="col-auto text-end">
														<div class="card writercard p-1">
															${chat.chatDto.crew_chat_text }
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col text-end">
														<fmt:formatDate value="${chat.chatDto.crew_chat_date }" pattern="MM.dd HH:mm" var="crew_chat_date" />
															${crew_chat_date }
													</div>
												</div>
											</div>
										</div>
		
									</c:otherwise>
								</c:choose>
	
							</c:forEach>
						</div>
						<div class="chatwrittingarea">
							<div class="row sticky-header">
								<div class="col-9 ms-4 px-0">
									<input type="text" class="form-control" id="chatcontent">
								</div>
								<div class="col-auto ps-0">
									<button class="btn btn-sm btn-success-outline" id="sendchat">send</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<input type="hidden" value="${crewDto.crew_domain }" id = "crew_domain">
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.13.0/Sortable.min.js"></script>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>