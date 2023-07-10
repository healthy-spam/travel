<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<c:url value="/resources/css/crew/crewmemberlist.css" />">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.subtitle {
		font-size: 15px;
	}
	.c_gn {
        color: #2e9901 !important;
        font-style:normal;
        font-weight: bold;
	}
</style>

<script>

function searchmember() {
	var searchcont = document.getElementById('memberSearch').value;
	if(searchcont!=null) {
		$.ajax({
	    	type: "POST",
	    	contentType: "application/json",
	    	url: "/travel/crew/crewsetting/membersearch",
	    	data: JSON.stringify({
	      	"searchcont": searchcont
	    	}),
	    	success: function(res) {
	    		if(res.length==0) {
	    			alert("해당하는 멤버가 없습니다.");
	    			document.getElementById('memberSearch').value ="";
	    		} else {
	    			getAllMembers(res);
	    		}
	    		
	    	},
	    	error: function(err) {
	      		console.log("실패", err);
	    	}
	  	});
	} else {
		alert("검색어를 입력하세요.");
	}
}

function checkall() {
  var checkboxes = document.querySelectorAll('.checkboxes'); // 모든 체크박스를 선택합니다.
  var checkallCheckbox = document.getElementById('checkAll'); // 전체 선택 체크박스를 가져옵니다.
  
  // 전체 선택 체크박스의 상태에 따라 모든 체크박스를 선택하거나 해제합니다.
  for (var i = 0; i < checkboxes.length; i++) {
    checkboxes[i].checked = checkallCheckbox.checked;
  }
}


function handleSelectedMembers() {
	  var checkboxes = document.querySelectorAll('.checkboxes'); // 모든 개별 체크박스를 선택합니다.
	  var selectedMembers = []; // 선택된 멤버들의 ID를 담을 배열
	  
	  // 개별 체크박스를 순회하면서 선택된 체크박스들을 처리합니다.
	  for (var i = 0; i < checkboxes.length; i++) {
	    var checkbox = checkboxes[i];
	    if (checkbox.checked && checkbox.id != 'checkAll') {
	      selectedMembers.push(checkbox.id.replace('checkbox', '')); // 체크박스 ID로부터 멤버 ID를 추출하여 배열에 추가합니다.
	    }
	  }
	  
	  if (selectedMembers.length === 0) {
	    alert('선택된 멤버가 없습니다.');
	    return;
	  }
	  
	  if (confirm("강제 탈퇴 처리하시겠습니까?")) {
		  var memberIds = selectedMembers; // 선택된 멤버 ID 배열

		  // AJAX 요청을 통해 서버로 데이터 전송
		  $.ajax({
		    type: "POST",
		    contentType: "application/json",
		    url: "/travel/crew/crewsetting/managesecede",
		    data: JSON.stringify({
		      "memberIds": memberIds
		    }),
		    success: function(res) {
		    	alert("탈퇴 처리 완료되었습니다.");

		    	getAllMembers(res);
		    },
		    error: function(err) {
		      console.log("실패", err);
		    }
		  });
		}

	}
	
function getAllMembers(res) {
	var numnum = document.getElementById("crewmembernum");
	numnum.innerHTML = "";
	var numnumnumm = res.length;
	// 새로운 요소 생성
	  var spanElement = document.createElement("span");
	  spanElement.textContent = numnumnumm;
	  
	  // 새로운 요소를 추가
	  numnum.appendChild(spanElement);
	
	var table = document.getElementById("inner");
	table.innerHTML = "";

	for (var i = 0; i < res.length; i++) {
		  var crew_member_id = res[i].crewMemberDto.crew_member_id;
		  var user_nickname = res[i].userDto.user_nickname;
		  var user_email = res[i].userDto.user_email;
		  var postcount = res[i].postcount;
		  var commentcount = res[i].commentcount;
		  var crew_member_log_date = res[i].crewMemberDto.crew_member_log_date;
		  var user_birth = res[i].userDto.user_birth;

		  var date = new Date(crew_member_log_date);

		  let day = date.getDate();
		  let month = date.getMonth() + 1;
		  let year = date.getFullYear();

		  if (month < 10) {
		    month = '0' + month;
		  }
		  if (day < 10) {
		    day = '0' + day;
		  }

		  var birth = new Date(user_birth);

		  let day1 = birth.getDate();
		  let month1 = birth.getMonth() + 1;
		  let year1 = birth.getFullYear();

		  if (month1 < 10) {
		    month1 = '0' + month1;
		  }
		  if (day1 < 10) {
		    day1 = '0' + day1;
		  }

		  var gender = res[i].userDto.user_gender;
		  if (gender == 'M') {
		    gender = '남';
		  } else if (gender == 'F') {
		    gender = '여'
		  } else {
		    gender = '알 수 없음'
		  }

		  // <tr> 요소 생성
		  var trElement = document.createElement("tr");

		  // <th> 요소 생성
		  var thElement = document.createElement("th");
		  thElement.setAttribute("scope", "row");

		  // <input> 요소 생성
		  var inputElement = document.createElement("input");
		  inputElement.className = "form-check-input checkboxes";
		  inputElement.type = "checkbox";
		  inputElement.id = "checkbox" + crew_member_id;

		  // <th> 요소에 <input> 요소 추가
		  thElement.appendChild(inputElement);

		  // <td> 요소 생성 및 텍스트 설정
		  var tdNickname = document.createElement("td");
		  tdNickname.textContent = user_nickname + "(" + user_email + ")";
		  var tdLogDate = document.createElement("td");
		  tdLogDate.textContent = year + "-" + month + "-" + day;
		  var tdPostCount = document.createElement("td");
		  tdPostCount.textContent = postcount;
		  var tdCommentCount = document.createElement("td");
		  tdCommentCount.textContent = commentcount;
		  var tdGender = document.createElement("td");
		  tdGender.textContent = gender;
		  var tdBirth = document.createElement("td");
		  tdBirth.textContent = year1 + "-" + month1 + "-" + day1;

		  // <tr> 요소에 <th> 및 <td> 요소들 추가
		  trElement.appendChild(thElement);
		  trElement.appendChild(tdNickname);
		  trElement.appendChild(tdLogDate);
		  trElement.appendChild(tdPostCount);
		  trElement.appendChild(tdCommentCount);
		  trElement.appendChild(tdGender);
		  trElement.appendChild(tdBirth);

		  // 테이블에 <tr> 요소 추가
		  table.appendChild(trElement);
		}

	
}
</script>
</head>

<body>
	<div class="container m-5">

		<div class="row mx-5">
			<div class="card card1">
				<div class="incard m-3 mx-5">
					<div class="row mt-3">
						<div class="title">
							<strong>전체 멤버 관리</strong>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-auto">
							<label for="memberSearch" class="col-form-label">멤버 검색</label>
						</div>
						<div class="col">
							<div class="input-group mb-3">
								<input type="text" id="memberSearch" class="form-control" placeholder="닉네임이나 아이디 입력" aria-label="멤버 검색" aria-describedby="button-addon2">
								<button class="btn btn-success" id="button-addon2" onclick="searchmember()">검색</button>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="subtitle">
							<p><Strong>크루 멤버수</Strong> <em class="c_gn" id="crewmembernum">${crewsize }</em></p>
						</div>
						<div class="membertable">
							<table class="table table-sm table-hover">
								<thead class="table-light">
									<tr>
										<th scope="col">
										    <input class="form-check-input checkboxes" type="checkbox" id="checkAll" onclick="checkall()">
										</th>
										<th scope="col">닉네임(아이디)</th>
										<th scope="col">가입일</th>
										<th scope="col">게시글수</th>
										<th scope="col">댓글수</th>
										<th scope="col">성별</th>
										<th scope="col">생년월일</th>
									</tr>
								</thead>
								<tbody class="table-group-divider" id="inner">
									<c:forEach var="member" items="${member}" varStatus="status">
										<tr>
											<th scope="row">
												<input class="form-check-input checkboxes" type="checkbox" id="checkbox${member.crewMemberDto.crew_member_id}">
											</th>
											<td>${member.userDto.user_nickname }(${member.userDto.user_email })</td>
											<td>
												<fmt:formatDate value="${member.crewMemberDto.crew_member_log_date}" pattern="yyyy.MM.dd." var="formattedDate" />
												${formattedDate}
											</td>
											<td>${member.postcount }</td>
											<td>${member.commentcount }</td>
											<td>
												<c:choose>
													<c:when test="${member.userDto.user_gender == 'M' }">
														남
													</c:when>
													<c:when test="${member.userDto.user_gender == 'F' }">
														여
													</c:when>
													<c:otherwise>
														알 수 없음
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<fmt:formatDate value="${member.userDto.user_birth}" pattern="yyyy.MM.dd." var="birth" />
												${birth}
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="setting">
							<table class="table table-sm table-hover">
								<tr>
						            <td style="width:9%"><strong>선택 멤버를</strong></td>
						            <td><button class="btn btn-sm btn-success mb-1" onclick="handleSelectedMembers()">강제 탈퇴</button></td>
								</tr>
							</table>	
						</div>
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
