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
		var crew_board_notice = document.getElementById("crew_board_notice").value;
		
		if(crew_board_title == "") {
			alert("제목을 입력하세요");return
		}
		if(crew_board_content == "") {
			alert("내용을 입력하세요");return
		}
		
		
		if(crew_board_notice == null) {
			crew_board_notice = 'N';
		}
		
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
	  console.log(imageFiles.length);
	  for (var i = 0; i < imageFiles.length; i++) {
	    formData.append('photos' + i, imageFiles[i]);
	  }
	  
	  // 추가 데이터를 JSON 형식으로 전송
	  var additionalData = {
	    intValue: res // int 값을 추가하고자 할 경우
	  };
	  formData.append('additionalData', JSON.stringify(additionalData));

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

<style>
body {
	background-color: #f2f2f2;
	overflow-x: hidden;
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
	background-color: #f5f5f5
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
</style>




</head>

<body>
	<div class="row">
		<div class="col-2">
			<div
				class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark fixed-sidebar"
				style="width: 18vw; height: 100vh;">
				<a href="#"
					class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
					<img src="/uploadFiles/crewFiles/crewthumbnail/${crewDto.crew_thumbnail }" class="bi pe-none me-2" width="40" height="40">
						<use xlink:href="/travel/crew/crewhome/${crewDto.crew_domain }"></use>
					<span class="fs-4">${crewDto.crew_name }</span>
				</a>
				<hr>
				<ul class="nav nav-pills flex-column mb-auto">
					<li class="nav-item"><a href="#" class="nav-link active"
						aria-current="page"> <svg class="bi pe-none me-2" width="16"
								height="16">
								<use xlink:href="#home"></use>
							</svg> 전체글보기
					</a></li>
					<li><a href="#" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#speedometer2"></use>
							</svg> <i class="bi bi-bookmark-star"></i> 공지</i>
					</a></li>
					<li><a href="#" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#grid"></use>
							</svg> <i class="bi bi-calendar2-date"> 일정</i>
					</a></li>
					<li><a href="#" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#table"></use>
							</svg> <i class="bi bi-people-fill"> 멤버</i>
					</a></li>
					<li><a href="#" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#grid"></use>
							</svg> <i class="bi bi-basket2"> 상점</i>
					</a></li>
					<li><a href="#" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#people-circle"></use>
							</svg> <i class="bi bi-chat-dots"> 채팅</i>
					</a></li>

				</ul>
				<hr>
				<div class="dropdown">
					<a href="#"
						class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
						data-bs-toggle="dropdown" aria-expanded="false"> <img
						src="/uploadFiles/profileImage/${userDto.user_image }" alt="" width="32" height="32"
						class="rounded-circle me-2"> <strong>${userDto.user_nickname }</strong>
					</a>
					<ul class="dropdown-menu dropdown-menu-dark text-small shadow">
						<li><a class="dropdown-item" href="#">New project...</a></li>
						<li><a class="dropdown-item" href="#">Settings</a></li>
						<li><a class="dropdown-item" href="#">Profile</a></li>
						<li>
							<hr class="dropdown-divider">
						</li>
						<li><a class="dropdown-item" href="#">Sign out</a></li>
					</ul>
				</div>
			</div>
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
					<c:forEach var="list" items="${list}" varStatus="status">
						<div class="card boardlist mt-3 p-2 pb-3">
							<div class="row mx-2 ">
								<div
									class="col-auto d-flex justify-content-center align-items-center">
									<img src="/uploadFiles/${userDto.user_image }" alt="" width="45"
										height="45" class="rounded-circle">
								</div>
								<div class="col-auto">
									<div class="row mt-3">
										<div class="col-auto">
											<Strong class="postwriter">${list.user_nickname }</Strong>
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
									<i class="bi bi-three-dots"></i>
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
									<i class="bi bi-suit-heart"> ${list.boardlikecount }</i>
								</div>
								<div class="col-auto">
									<i class="bi bi-chat-left-text"> ${list.boardcommentcount }</i>
								</div>
								<div class="col text-end">
									<i class="bi bi-bookmark-plus"></i>
								</div>
							</div>
						</div>
					</c:forEach>
					<!--반복 끝-->

					<div class="card boardlist mt-3 p-2 pb-3">
						<div class="row mx-2 ">
							<div
								class="col-auto d-flex justify-content-center align-items-center">
								<img src="https://github.com/mdo.png" alt="" width="45"
									height="45" class="rounded-circle">
							</div>
							<div class="col-auto">
								<div class="row mt-3">
									<div class="col-auto">
										<Strong class="postwriter">글쓴이</Strong>
									</div>
								</div>
								<div class="row">
									<div class="col-auto">
										<p class="postregdate">2023-07-05 17:03</p>
									</div>
								</div>
							</div>
							<div class="col text-end mt-3">
								<i class="bi bi-three-dots"></i>
							</div>
						</div>
						<div class="row mx-2">
							<p class="postcontent">Lorem ipsum dolor sit amet consectetur
								adipisicing elit. Sapiente aspernatur, nisi eos dolorem libero
								iure commodi impedit temporibus iusto maiores sit repellendus
								inventore ducimus aliquam sint totam similique perferendis
								accusamus? Lorem ipsum dolor sit amet consectetur adipisicing
								elit. Inventore, eaque? Non maiores sed, illo perspiciatis sint
								dolores quisquam hic laborum obcaecati pariatur aliquid iure
								ducimus officiis eos laudantium modi possimus.</p>
						</div>
						<div class="row mx-2">
							<div class="col-auto">
								<i class="bi bi-suit-heart"> 23</i>
							</div>
							<div class="col-auto">
								<i class="bi bi-chat-left-text"> 15</i>
							</div>
						</div>
					</div>

					<div class="card boardlist mt-3 p-2 pb-3">
						<div class="row mx-2 ">
							<div
								class="col-auto d-flex justify-content-center align-items-center">
								<img src="https://github.com/mdo.png" alt="" width="45"
									height="45" class="rounded-circle">
							</div>
							<div class="col-auto">
								<div class="row mt-3">
									<div class="col-auto">
										<Strong class="postwriter">글쓴이</Strong>
									</div>
								</div>
								<div class="row">
									<div class="col-auto">
										<p class="postregdate">2023-07-05 17:03</p>
									</div>
								</div>
							</div>
							<div class="col text-end mt-3">
								<i class="bi bi-three-dots"></i>
							</div>
						</div>
						<div class="row mx-2">
							<p class="postcontent">Lorem ipsum dolor sit amet consectetur
								adipisicing elit. Sapiente aspernatur, nisi eos dolorem libero
								iure commodi impedit temporibus iusto maiores sit repellendus
								inventore ducimus aliquam sint totam similique perferendis
								accusamus? Lorem ipsum dolor sit amet consectetur adipisicing
								elit. Inventore, eaque? Non maiores sed, illo perspiciatis sint
								dolores quisquam hic laborum obcaecati pariatur aliquid iure
								ducimus officiis eos laudantium modi possimus.</p>
						</div>
						<div class="row mx-2">
							<div class="col-auto">
								<i class="bi bi-suit-heart"> 23</i>
							</div>
							<div class="col-auto">
								<i class="bi bi-chat-left-text"> 15</i>
							</div>
						</div>
					</div>





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
							<img src="https://github.com/mdo.png" alt="" width="45"
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
								<div class="col text-end">
									<input type="checkbox" class=form-check-input id="crew_board_notice" value="Y"> 공지
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
					<button type="submit" class="btn btn-primary" id="submit-btn">작성</button>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- modal end -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.13.0/Sortable.min.js"></script>
<script>
//Declare the remainingImages array in the outer scope
const remainingImages = [];
//Function to handle the file selection
function handleFileSelect(event) {
  const files = event.target.files; // Get selected files

  // Clear the preview container
  const previewContainer = document.getElementById('preview-container');
  previewContainer.innerHTML = '';


  // Loop through each selected file
  for (let i = 0; i < files.length; i++) {
    const file = files[i];
    const reader = new FileReader();

    // Closure to capture the file information
    reader.onload = (function(file) {
      return function(e) {
        // Create a preview container for each image
        const previewItem = document.createElement('div');
        previewItem.className = 'preview-item';

        // Create a preview image element
        const img = document.createElement('img');
        img.className = 'preview-image';
        img.src = e.target.result;

        // Create the delete button
        const deleteBtn = document.createElement('button');
        deleteBtn.className = 'delete-button';
        deleteBtn.innerText = 'X';

        // Add click event listener to delete the image
        deleteBtn.addEventListener('click', function() {
          previewItem.remove();
          
          // Remove the corresponding file from the remainingImages array
          const index = remainingImages.indexOf(file);
          if (index > -1) {
            remainingImages.splice(index, 1);
          }
        });

        // Append the image and delete button to the preview container
        previewItem.appendChild(img);
        previewItem.appendChild(deleteBtn);
        previewContainer.appendChild(previewItem);

        // Add the remaining image to the array
        remainingImages.push(file);
      };
    })(file);

    // Read the image file as a data URL
    reader.readAsDataURL(file);
  }
}

// Add event listener for file selection
const inputElement = document.getElementById('image-upload');
inputElement.addEventListener('change', handleFileSelect, false);

// Initialize the sortable container
const sortableContainer = document.getElementById('preview-container');
Sortable.create(sortableContainer, {
  animation: 150,
});

// Handle submit button click
const submitBtn = document.getElementById('submit-btn');
submitBtn.addEventListener('click', function() {
  // Send remaining images and order using AJAX
  const formData = new FormData();
  const previewItems = document.getElementsByClassName('preview-item');
  const order = [];
  for (let i = 0; i < previewItems.length; i++) {
    const imgSrc = previewItems[i].querySelector('.preview-image').src;
    const fileName = imgSrc.substring(imgSrc.lastIndexOf('/') + 1);
    console.log(fileName);
    order.push(fileName);
  }
  for (let i = 0; i < remainingImages.length; i++) {
    formData.append('images[]', remainingImages[i]);
  }
  formData.append('order', JSON.stringify(order));

  // Send the formData using AJAX
  const xhr = new XMLHttpRequest();
  xhr.open('POST', 'your-server-url');
  xhr.send(formData);
});

</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>