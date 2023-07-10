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
<script src="/travel/resources/js/crew/crewmemberlist.js"></script>
</head>

<body>
	<div class="container m-5">

		<div class="row mx-5">
			<div class="card card1">
				<div class="incard m-3 mx-5">
					<div class="row mt-3">
						<div class="title">
							<strong>가입 신청 관리</strong>
						</div>
						<div>
							<p class="txt">우리 크루에 가입을 신청한 사람입니다. 가입을 승인하거나, 거절할 수 있습니다.</p>
						<hr>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-auto">
							<label for="memberSearch" class="col-form-label">멤버 검색</label>
						</div>
						<div class="col">
							<div class="input-group mb-3">
								<input type="text" id="appliedSearch" class="form-control" placeholder="닉네임이나 아이디 입력" aria-label="멤버 검색" aria-describedby="button-addon2">
								<button class="btn btn-success" id="button-addon2" onclick="searchapply()">검색</button>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="subtitle">
							<p><Strong>가입 승인 대기자</Strong> <em class="c_gn" id="crewmembernum">${crewsize }</em>명</p>
						</div>
						<div class="membertable">
							<table class="table table-sm table-hover">
								<thead class="table-light">
									<tr>
										<th scope="col">
										    <input class="form-check-input checkboxes" type="checkbox" id="checkAll" onclick="checkall()">
										</th>
										<th scope="col">닉네임(아이디)</th>
										<th scope="col">가입신청일</th>
										<th scope="col">생년월일</th>
										<th scope="col">성별</th>
										<th scope="col">가입답변</th>
									</tr>
								</thead>
								<tbody class="table-group-divider" id="inner">
									<c:forEach var="member" items="${applied}" varStatus="status">
										<tr>
											<th scope="row">
												<input class="form-check-input checkboxes" type="checkbox" id="checkbox${member.crewMemberDto.crew_member_id}">
											</th>
											<td>${member.userDto.user_nickname }(${member.userDto.user_email })</td>
											<td>
												<fmt:formatDate value="${member.crewMemberDto.crew_member_request_date}" pattern="yyyy.MM.dd." var="formattedDate" />
												${formattedDate}
											</td>
											<td>
												<fmt:formatDate value="${member.userDto.user_birth}" pattern="yyyy.MM.dd." var="birth" />
												${birth}
											</td>
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
												${member.crewMemberDto.crew_join_request_intro }
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
						            <td style="width:9%"><button class="btn btn-sm btn-success mb-1" onclick="acceptSelectedMembers()">가입 수락</button></td>
						            <td><button class="btn btn-sm btn-success mb-1" onclick="declineSelectedMembers()">가입 거절</button></td>
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
