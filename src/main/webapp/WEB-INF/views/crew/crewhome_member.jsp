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


<script>
function getProfile(user_image, user_nickname,crew_member_log_date) {
	var profilemodal = bootstrap.Modal.getOrCreateInstance("#profilemodal");

	console.log(crew_member_log_date)
	
	var crew_member_log_date= crew_member_log_date;
	var user_image = user_image;
	
	crew_member_log_date = crew_member_log_date.replace("KST", "");
	var date = new Date(crew_member_log_date);
	
	let day = date.getDate()
	let month = date.getMonth() + 1
	let year = date.getFullYear()
	
	if (month < 10) {
	  month = '0' + month; // 1자리 수인 경우 앞에 0을 붙임
	}
	if (day < 10) {
	  day = '0' + day; // 1자리 수인 경우 앞에 0을 붙임
	}
	
	
	document.getElementById("modalprofileimage").innerHTML = `<img src="/uploadFiles/profileImage/\${user_image }" width="180" height="180" class="rounded-circle" >`
	document.getElementById("modalprofilename").innerHTML = `<span>\${user_nickname}</span>`;
	document.getElementById("modalprofilejoindate").innerHTML = `<span>since \${year}.\${month}.\${day}.`;
	profilemodal.show();
	
	
	var getallpostofmember = document.getElementById("getallpostofmember");
	getallpostofmember.addEventListener("click", function() {
		var user_id = user_image.split('.')[0];
		$.ajax({
            url: "/travel/crew/getallpostofmember",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                "user_id": user_id
            }),
            success: function(response) {
            	getpostlist(response);
            },
            error: function(err) {
                console.error("이름 확인 실패", err);
            }
        });
	})
}

function getpostlist(response) {
	document.getElementById("memberpost").innerHTML = "";
	
	var user_nickname = response.user_nickname;
	var crewBoardList = response.crewBoardDto;
	for(var i = 0; i < crewBoardList.length; i++) {
		var board_title = crewBoardList[i].crew_board_title;
		var board_content = crewBoardList[i].crew_board_content;
		var board_regdate = crewBoardList[i].crew_board_reg_date;
		
		
		
		document.getElementById("memberpost").innerHTML += `
			<div class="container main p-4">
			<div class="row">
				<div class="col-7">
					<Strong>Hello Jon</Strong>
					<p>Hurry up and do the course now!</p>
				</div>
				<div class="col">
					<input type="text" class="form-control searchbar nonboarder"
						placeholder="Search">
				</div>
			</div>
			<div class="row">
				<div class="card boardwrite" id="openBoardWrite">
					<div class="row mx-2 mt-3">
						<div class="col-auto">
							<Strong id="Createnewpost">Create New Post</Strong>
						</div>
						<div class="col text-end">
							<i class="bi bi-three-dots"></i>
						</div>
					</div>
					<div class="row m-3" id="postwriteform">
						<textarea class="form-control postwritearea nonboarder"
							placeholder="Type a text" id="boardcontent"
							style="height: 100px"></textarea>
					</div>
					<div class="row mx-3 mb-3">
						<div class="col-auto">
							<i class="bi bi-images"></i>
						</div>
						<div class="col-auto">
							<i class="bi bi-folder-plus"></i>
						</div>
						<div class="col text-end">
							<button class="btn btn-success btn-sm">Publish</button>
						</div>
					</div>
				</div>
			</div>


			<div class="row">
				<!--여기서부터 jsp c:foreach 반복-->
						<div class="row mx-2 ">
							<div
								class="col-auto d-flex justify-content-center align-items-center">
								<img src="/uploadFiles/profileImage/${list.userDto.user_image }" alt="" width="45"
									height="45" class="rounded-circle">
							</div>
							<div class="col-auto">
								<div class="row mt-3">
									<div class="col-auto">
										<Strong class="postwriter">${list.userDto.user_nickname }</Strong>
									</div>
								</div>
								<div class="row">
									<div class="col-auto">
										<p class="postregdate">
											<fmt:formatDate value="${list.c.crew_board_reg_date }"
												pattern="yyyy-MM-dd HH:mm" var="regdate" />
											${regdate }
										</p>
									</div>
								</div>
							</div>
							<div class="col text-end mt-3">
								<i class="bi bi-three-dots"  data-bs-toggle="dropdown"></i>
								<ul class="dropdown-menu">
									<li class="dropdown-item" id="commentmodify">수정2</li>
									<li class="dropdown-item" onclick="deleteboard('${list.c.crew_board_id}')">삭제</li>
								</ul>
							</div>
						</div>
						<div class="row m-2" id="getboarddetails">
							<h5>${list.c.crew_board_title }</h5>
							<p class="postcontent">${list.c.crew_board_content }</p>
						</div>
						
						<!--  <div class="row mx-2 mb-3">
							<img src="https://github.com/mdo.png" height="500px">
						</div>-->
						
						<div class="row mx-2">
							<div class="col-auto">
								<c:choose>
									<c:when test="${empty list.liked }">
										<i class="bi bi-suit-heart"
											onclick="likeboard('${crewMemberDto.crew_member_id}', '${list.c.crew_board_id }', '${list.c.crew_member_id }')"> ${list.boardlikecount }</i>
									</c:when>
									<c:otherwise>
										<i class="bi bi-suit-heart-fill"
											onclick="dislikeboard('${crewMemberDto.crew_member_id}', '${list.c.crew_board_id }', '${list.c.crew_member_id }')"> ${list.boardlikecount }</i>
									</c:otherwise>
								</c:choose>

							</div>
							<div class="col-auto">
								<i class="bi bi-chat-left-text" onclick="getcommentlist('${list.c.crew_board_content}')"> ${list.boardcommentcount }</i>
							</div>
							<div class="col text-end">
								<i class="bi bi-bookmark-plus"></i>
							</div>
						</div>
					</div>
					<div class="commentlist card p-2" style="display: block;">
						<div class="row p-2">
							<div class="col pe-0">
								<input placeholder="댓글 내용을 입력하세요." class="postwritearea nonboarder form-control" name="board_comment_content"  id="comment-${status.index}">
							</div>
							<div class="col-auto px-3 pt-1">
								<i class="bi bi-send " onclick="writecomment('${list.c.crew_board_id}', '${status.index}')"></i>
							</div>
						</div>
						<c:choose>
							<c:when test="${list.boardcommentcount != 0 }">
								<c:forEach var="comment" items="${list.commentlist}">
									<div class="row m-2">
										<div class="col-auto px-0">
											<img
												src="/uploadFiles/profileImage/${comment.commentWriter.user_image }"
												width="35" height="35" class="rounded-circle ">
										</div>
										<div class="col me-4">
											<div class="card commentcard  p-2 ">
												<div class="row ">
													<div class="col commentwriter">
														${comment.commentWriter.user_nickname }</div>
												</div>
												<div class="row ">
													<div class="col commentcontent">
														${comment.crewBoardCommentDto.crew_comment }</div>
												</div>
												
											</div>
											<div class="row">
													<div class="col commentwritedate mt-1">
														<fmt:formatDate
															value="${comment.crewBoardCommentDto.crew_comment_date }"
															pattern="yyyy-MM-dd HH:mm" var="formattedDate" />
														${formattedDate }
													</div>
													<div class="col text-end">
														<c:if test="${comment.crewBoardCommentDto.crew_member_id == crewMemberDto.crew_member_id }">
														<i class="bi bi-three-dots" data-bs-toggle="dropdown"></i>
														  <ul class="dropdown-menu">
														    <li class="dropdown-item" id="commentmodify">수정</li>
														    <li class="dropdown-item" onclick="commentdelete('${comment.crewBoardCommentDto.board_comment_id}')">삭제</li>
														  </ul>
														</c:if>
													</div>
											</div>
										</div>
									</div>

								</c:forEach>
							</c:when>
							<c:otherwise>
							<div class="row py-5">
								<div class="col text-center nocomment">
									등록된 댓글이 없습니다.
								</div>
							</div>
							</c:otherwise>
						</c:choose>
					</div>


			</div>
		</div>
		`;
		
	}

	
}
</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var searchMemberInput = document.getElementById("searchMember");
    var crew_domain = document.getElementById("crew_domain");
    searchMemberInput.addEventListener("input", function() {
        var searchMember = searchMemberInput.value;
        
        if(searchMember === '') {
            $.ajax({
                url: "/travel/crew/getallcrewmembers",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
	                "crew_domain": crew_domain
	            }),
                success: function(response) {
                	getallcrewlist(response);
                },
                error: function(err) {
                    console.error("이름 확인 실패", err);
                }
            });
        } else {
        	console.log(searchMember);
            $.ajax({
                url: "/travel/crew/searchMember",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
	                "searchMember": searchMember,
	                "crew_domain": crew_domain
	            }),
                success: function(response) {
                	getallcrewlist(response);
                },
                error: function(err) {
                    console.error("이름 확인 실패", err);
                }
            });
        }
    });
});
</script>
<style>
body {
	background-color: #f2f2f2;
	overflow-x: hidden;
}

.commentwritedate {
	font-size:12px;
}

.sidebar {
	width: 19vw;
}

.fixed-sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 18vw;
	height: 100vh;
	background-color: #fff2f8b4;
	color: white;
	padding: 20px;
}

#crewmember {
background-color: #BB2649;
}

.margin-left-col {
	margin-left: 5vw;
	/* Adjust this value to match the width of the fixed sidebar */
}


.icon {
	height: 30px;
	/* Adjust the height value as needed */
}

.bi {
	font-style: normal;
}


.sideend {
	margin: 20px;
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

.member1 {
	font-size: 20px;
	font-weight:bold;
} 

.member2 {
    font-style: normal;
    color: #bb2649;
}

.member3 {
	font-weight: bold;
	font-size: 17px;
}

.member4 {
	font-weight:bold;
	font-size:24px;
}

.modalsettingicons {
font-size: 30px
}

.settingimpls {
	font-size:13px;
	color: grey;
}
</style>




</head>

<body>
	<div class="row">
		<div class="col-2">
		<jsp:include page="../common/crewHomeNavi.jsp"></jsp:include>

		</div>
		<div class="col-6 margin-left-col">
			<div class="card mt-5" id="memberpost">
				<div class="container p-4 pb-3">
					<div class="row">
						<div class="col member1">
							<span>멤버 <em class="member2">${membersize } / 20</em></span>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<input type="search" class="form-control" placeholder="멤버 검색">
						</div>
					</div>
				</div>
				<hr>
				<div class="container px-4">
				<div class="row py-3">
					<div class="col member3">
						<span>멤버</span>
					</div>
				</div>
				<c:forEach var="memberList" items="${memberList}" varStatus="status">
					<div class="row">
						<div class="col-auto">
							<span>
								<img src="/uploadFiles/profileImage/${memberList.userDto.user_image }" width="45" height="45" class="rounded-circle" onclick="getProfile('${memberList.userDto.user_image }', '${memberList.userDto.user_nickname }', '${memberList.crewMemberDto.crew_member_log_date }')">
							</span>
						</div>
						<div class="col-auto member3 ps-1 pt-2">
							<span>${memberList.userDto.user_nickname }</span>
							<c:if test="${memberList.crewMemberDto.crew_member_grade_default_id == 1 }">
								👑
							</c:if>
						</div>
						<div class="col text-end">
							<i class="bi bi-three-dots-vertical" data-bs-toggle="dropdown"></i>
							<ul class="dropdown-menu">
								<li class="dropdown-item" onclick="getProfile('${memberList.userDto.user_image }', '${memberList.userDto.user_nickname }', '${memberList.crewMemberDto.crew_member_log_date }')">프로필 보기</li>
								<li class="dropdown-item" onclick="commentdelete('${comment.crewBoardCommentDto.board_comment_id}')">쪽지 보내기</li>
							</ul>
						</div>
					</div>
					<hr>
				</c:forEach>
			</div>
				</div>
				
		</div>
		<div class="col sideend">
			<div class="card calendarcard">
				<div id="calendar"></div>
			</div>
		</div>
	</div>	
	
	
	
<div class="modal fade" tabindex="-1" aria-hidden="true" id="profilemodal"> 
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header text-center">
        <span>프로필</span>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="container">
        	<div class="row">
        		<div class="col text-center" id="modalprofileimage">
        		</div>
        	</div>
        	<div class="row mt-4">
        		<div class="col text-center member4" id="modalprofilename">
        			<span>한교동</span>
        		</div>
        	</div>
        	<div class="row">
        		<div class="col text-center text-secondary" id="modalprofilejoindate">
        			<span>since 
        			${user_nickname }</span>
        		</div>
        	</div>
        </div>
      </div>
		<div class="row m-4">
      		<div class="col text-end pe-0 ps-5" id="getallpostofmember">
      			<div class="row text-center">
      				<div class="col">
      					<i class="bi bi-file-earmark-text modalsettingicons"></i>
      				</div>
      			</div>
      			<div class="row text-center">
      				<div class="col settingimpls">
      					작성한 글 보기
      				</div>
      			</div>
      		</div>
      		<div class="col-6 pe-5 ps-0">
      			<div class="row text-center ">
      				<div class="col">
      					<i class="bi bi-envelope-plus modalsettingicons"></i>
      				</div>
      			</div>
      			<div class="row text-center">
      				<div class="col settingimpls">
      					쪽지 보내기
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