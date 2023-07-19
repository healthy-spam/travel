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
	function boardwrite() {
		var crew_board_title = document.getElementById("crew_board_title").value;
		var crew_board_content = document.getElementById("crew_board_content").value;
		var crew_board_visibility = document.getElementById("crew_board_visibility").value;
		
		if(crew_board_title == "") {
			alert("제목을 입력하세요");return
		}
		if(crew_board_content == "") {
			alert("내용을 입력하세요");return
		}
		
		crew_board_notice = 'N';

		
		$.ajax({
			url : "/travel/crew/crewboard/write",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify({
				"crew_board_title" : crew_board_title,
				"crew_board_content" : crew_board_content,
				"crew_board_visibility" : crew_board_visibility,
				"crew_board_notice" : crew_board_notice
				}),
				success : function(res) {
					uploadPhotos(res);
					},
					error : function(err) {
						console.error("삭제 실패",err);
						}
					});
		}

</script>

<script>
function uploadPhotos(res) {
	console.log(res);
	  var formData = new FormData();
	  var files = $('#crew_thumbnail')[0].files;

	    // 선택된 각 파일을 FormData에 추가
	    for (var i = 0; i < files.length; i++) {
	      formData.append('myFiles[]', files[i]);
	    }

	  $.ajax({
	    url: "/travel/crew/crewboard/uploadfiles",
	    type: 'POST',
	    data: formData,
	    processData: false,
	    contentType: false,
	    success: function(response) {
	      console.log('Photos uploaded successfully.');
	      alert("작성이 완료되었어요!");
	      location.reload();
	    },
	    error: function(xhr, status, error) {
	      // 오류 발생 시 처리할 코드 작성
	      console.log('Error occurred during photo upload.');
	      return;
	    }
	  });
	}

</script>

<script>
	document.addEventListener("DOMContentLoaded",function() {
		var openBoardWrite = document.getElementById("openBoardWrite");
		openBoardWrite.addEventListener("click",function() {

											//    	if(crew_member_grade_default_id <=2) {
											//			document.getElementById("checknoticesetting").innerHTML += `
											//			<div class="form-check position-absolute top-0 end-10">
											//		<input class="form-check-input " type="checkbox"
			//		name="crew_board_notice" value="Y" id="noticesetting">
											//	<label class="form-check-label" for="flexCheckDefault">공지
											//		</label>
											//	</div>
											//	`;
											//		}

											var boardwrite = bootstrap.Modal
													.getOrCreateInstance("#boardWriteModal");
											boardwrite.show();

										})
					})
</script>

<script>
function likeboard(crew_member_id, crew_board_id, board_writer_id) {
	$.ajax({
		url : "/travel/crew/likeboard",
		type : "POST",
		contentType : "application/json",
		data : JSON.stringify({
			"crew_member_id" : crew_member_id,
			"crew_board_id" : crew_board_id
		}),
		success : function(res) {
			location.reload();
		},
		error : function(err) {
			console.error("삭제 실패", err);
		}
	});
}

function dislikeboard(crew_member_id, crew_board_id, board_writer_id) {
		$.ajax({
			url : "/travel/crew/dislikeboard",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify({
				"crew_member_id" : crew_member_id,
				"crew_board_id" : crew_board_id
			}),
			success : function(res) {
				location.reload();
			},
			error : function(err) {
				console.error("삭제 실패", err);
			}
		});


}
</script>

<script>
function deleteboard(crew_board_id) {
	console.log(crew_board_id)
	    // AJAX 요청 보내기
	    if (confirm("정말 게시글을 삭제하시겠습니까?")) {
	            $.ajax({
	        url: "/travel/crew/deleteboard",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify({
	        	"crew_board_id": crew_board_id
	        }),
	        success: function(res) {
	            alert("삭제되었습니다.");
	            window.location.href = res
	        },
	        error: function(err) {
	            console.error("삭제 실패", err);
	        }
	    });

	    }
	}
</script>

<script>
function getcommentlist() {
	  var commentlist = $('.commentlist');

	  // 현재 display 속성값 확인
	  var currentDisplay = commentlist.css('display');

	  // display 속성 toggle
	  if (currentDisplay === 'block') {
	    commentlist.css('display', 'none');
	  } else if (currentDisplay === 'none') {
	    commentlist.css('display', 'block');
	  }
}

</script>

<script>
function writecomment(crew_board_id, index) {
    var crew_comment = document.getElementById('comment-' + index).value;
    console.log(crew_comment);
    
    // AJAX 요청 보내기
    $.ajax({
        url: "/travel/crew/createcomment",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            "crew_comment": crew_comment,
            "crew_board_id": crew_board_id
        }),
        success: function(res) {
        alert("작성이 완료되었어요!");
        location.reload();
        },
        error: function(err) {
            console.error("댓글 작성 실패", err);
        }
    });
}
        
</script>

<script>
function commentdelete(board_comment_id) {
    // AJAX 요청 보내기
    if (confirm("댓글을 삭제하시겠습니까?")) {
            $.ajax({
        url: "/travel/crew/deletecomment",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	"board_comment_id": board_comment_id
        }),
        success: function(res) {
            alert("댓글이 삭제되었습니다.");
            location.reload();
        },
        error: function(err) {
            console.error("댓글 삭제 실패", err);
        }
    });

    }
}
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

.margin-left-col {
	margin-left: 5vw;
	/* Adjust this value to match the width of the fixed sidebar */
}

.searchbar {
	background-color: gainsboro
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

#calendar {
	position: fixed;
	background-color: white;
	max-width: 350px;
	max-height: 350px;
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
        
        .commentlist{
        	display:none;
        }
        
        .nocomment {
        	font-size: 15px;
        }
        
        .commentcard {
        	background-color:gainsboro;
        }
        
        #crewmain {
        background-color: #17b75e;
        }
        
        .vs {
        	font-size:14px;
        }
</style>




</head>

<body>
	<div class="row">
		<div class="col-2">
			<jsp:include page="../common/crewHomeNavi.jsp"></jsp:include>
		</div>
		<div class="col-6 margin-left-col">
			<!-- <div class="row"> -->
			<!-- <div class="col-7"> -->
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
								<Strong id="Createnewpost">새 게시글 작성하기</Strong>
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
					<c:choose>
						<c:when test="${!empty list }">
												<c:forEach var="list" items="${list}" varStatus="status">
						<div class="card boardlist mt-3 p-2 pb-3">
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
										<div class="col-auto pt-1">
											<p class="postregdate">
												<fmt:formatDate value="${list.c.crew_board_reg_date }"
													pattern="yyyy-MM-dd HH:mm" var="regdate" />
												${regdate }
											</p>
										</div>
										<div class="col ps-0 pb-3">
											<c:choose>
												<c:when test="${list.c.crew_board_visibility == 'public' }">
													<i class="bi bi-globe-americas vs"></i>
												</c:when>
												<c:otherwise>
													<i class="bi bi-people-fill vs"></i>
												</c:otherwise>
											</c:choose>
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
					</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="row mt-5">
								<div class="col text-center mt-5">
									등록된 게시글이 없습니다.
								</div>
							</div>
						</c:otherwise>
					</c:choose>

					<!--반복 끝-->

				</div>
			</div>
		</div>
		<div class="col sideend">
			<div class="card calendarcard">
				<div id="calendar"></div>
			</div>
		</div>
	</div>

	<!-- Modal -->

	<div class="modal fade" id="boardWriteModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">게시글 작성</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<div class="row profile">
						<div
							class="col-auto d-flex justify-content-center align-items-center">
							<img src="/uploadFiles/profileImage/${userDto.user_image }" alt="" width="45"
								height="45" class="rounded-circle">
						</div>
						<div class="col-auto">
							<div class="row">
								<div class="col-auto">
									<Strong class="postwriter">${userDto.user_nickname }</Strong>
								</div>
							</div>
							<div class="row">
								<div class="col-auto">
									<select class="form-select form-select-sm" id="crew_board_visibility">
										<option selected value="public">전체공개</option>
										<option value="crewonly">크루공개</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row writeform">
						<div class="col">
							<div class="form-check form-switch"></div>
						</div>
						<div class="col-3" id="checknoticesetting"></div>
					</div>
					<div>
						<input type="text" class="form-control" name="crew_board_title"
							id="crew_board_title" placeholder="제목을 입력해주세요">
							<br>
						<textarea class="form-control" placeholder="오늘도 힘찬 하루를!"
							name="crew_board_content" id="crew_board_content"
							style="height: 150px" required></textarea>
					</div>
					<hr>
					<i class="bi bi-images txt"> <input type="file" id="image-upload" multiple>클릭해 사진을 추가해보세요!</i>
					
					<div id="preview-container" class="sortable-container"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" onclick="boardwrite()">작성</button>
				</div>
			</div>
		</div>
	</div>

	<!-- modal end -->
	
	
	
		<!--Modify Detail Modal -->

	<div class="modal fade" id="boardDetailModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body mx-5">

		<div class="row  mt-5 pt-5 title" id="boardDetailTitle">
			<strong>제목입니당</strong>
		</div>
		<div class="row  mt-5">
			<div class="col" id="boardDetailWriter">
			작성자
			<strong>
			작성자입니당
			</strong>
			</div>
			<div class="col text-end">
				작성일자
				<strong>
					날짜입니당
				</strong>
			</div>
		</div>
		<div class="row text-end">
			<c:choose>
				<c:when test="${userDto.user_id == sessionuser.user_id }">
				    <div class="col">
				        <div class="row justify-content-end">
				            <div class="col-auto">
				                <i class="bi bi-pencil icon-button" onclick="modifyboard()" title="modify"></i>
				            </div>
				            <div class="col-auto">
				                <i class="bi bi-trash3 icon-button" onclick="deleteboard('${crewBoardDto.crew_board_id}')" title="remove"></i>
				            </div>
				        </div>
				    </div>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="row mb-3">
			<div class="card my-3 py-3">
				<div class="content m-4">
					${crewBoardDto.crew_board_content }
				</div>
			</div>
		</div>
		<div class="row title2">
			<strong>댓글</strong>
		</div>
		<div class="row  mt-3">
			<div class="card mb-5">
				<div class="row m-2 mt-3">
					<textarea placeholder="댓글 내용을 입력하세요." class="textarea_input input_txt form-control" style="height: 100px;" name="board_comment_content" id="comment"></textarea>
				</div>
				<div class="row m-2">
					<div class="col text-end">
						<button id="writecomment" class="btn btn-success writecomment">작성하기</button>
					</div>
				</div>
			</div>
		</div>
		<div id="commentlist">
		<c:forEach var="comment" items="${commentlist}">
		
			<div class="row ">
				<div class="col commentWriter">
					<Strong>${comment.commentWriter.user_nickname }</Strong>
				</div>
				<div class="col text-end">
					<c:choose>
						<c:when test="${comment.commentWriter.user_id == sessionuser.user_id }">
							<div class="row justify-content-end">
				            	<div class="col-auto">
									<i class="bi bi-pencil icon-button" onclick="modifyboard('${comment.crewBoardCommentDto.board_comment_id}')" title="modify"></i>
								</div>
				            	<div class="col-auto">
									<i class="bi bi-trash3 icon-button" title="remove" onclick="deletecomment('${comment.crewBoardCommentDto.board_comment_id}')"></i>
								</div>
				        	</div>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			<div class="row mt-3">
				<div class="comment">${comment.crewBoardCommentDto.crew_comment }</div>
			</div>
			<div class="row mt-3">
				<div class="col">
					<Strong>
						<fmt:formatDate value="${comment.crewBoardCommentDto.crew_comment_date }" pattern="yyyy-MM-dd HH:mm" var="formattedDate" />
						${formattedDate }
					</Strong>
				</div>
				<div class="col text-end">
					
				</div>
			</div>
			<div class="row mt-3">
				<hr>
			</div>
			
		</c:forEach>
		</div>
		
		
				</div>
			</div>
		</div>
	</div>
	<!-- modal end -->
	
	
	
	
	
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.13.0/Sortable.min.js"></script>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>