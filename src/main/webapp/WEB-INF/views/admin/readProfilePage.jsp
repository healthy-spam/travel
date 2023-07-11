<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col-md-2  mt-3 ">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-md-9 offset-md-1">
				<c:choose>
				<c:when test="${map.guideApplyDto.guide_apply_state eq '미승인' && empty map.guideApplyDto.guide_apply_message}">
				<div class="row mt-5">
					<h3>${map.userDto.user_email}님의 프로필</h3>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<dl class="row">
					  <dt class="col-sm-2">신청자</dt>
					  <dd class="col-sm-10">${map.guideApplyDto.guide_apply_name}
					  </dd>
					
					  <dt class="col-sm-2">프로필</dt>
					  <dd class="col-sm-10">
					    <p>${map.guideApplyDto.guide_apply_profile}</p>
					  </dd>
					  
					  <dt class="col-sm-2">신청 일자</dt>
					  <dd class="col-sm-10">
					    <p><fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" /></p>
					  </dd>
					</dl>
				</div>
				<div class="row">
				<form  method="post">
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">메시지</label>
					  <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="guide_apply_message"></textarea>
					</div>
					<div>
						<input type="hidden" value="${map.guideApplyDto.guide_apply_id}" name="guide_apply_id">
						<input type="hidden" value="${map.guideApplyDto.user_id}" name="user_id">
						<input type="hidden" value="<fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" />"  name="guide_apply_date">
						<input type="hidden" value="${map.guideApplyDto.guide_apply_profile}" name="guide_apply_profile">
						<input type="hidden" value="${map.guideApplyDto.guide_apply_name}" name="guide_apply_name">
						<input type="submit" value="승인" formaction="../admin/applyGuideProcess">
						<input type="submit" value="거절" formaction="../admin/rejectGuidePorcess">
						<button type="button" class="btn btn-primary" onclick = "location.href='./guideApplyPage'">뒤로가기</button>
					</div>
				</form>
				</div>
				</c:when>
				
				<c:when test="${map.guideApplyDto.guide_apply_state eq '거절' && !empty map.guideApplyDto.guide_apply_message }">
				<div class="row mt-5">
					<h3>${map.userDto.user_email}님의 프로필</h3>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<dl class="row">
					  <dt class="col-sm-2">신청자</dt>
					  <dd class="col-sm-10">${map.guideApplyDto.guide_apply_name}</dd>
					
					  <dt class="col-sm-2">프로필</dt>
					  <dd class="col-sm-10">
					    <p>${map.guideApplyDto.guide_apply_profile}</p>
					  </dd>
					  
					  <dt class="col-sm-2">신청 일자</dt>
					  <dd class="col-sm-10">
					    <p><fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" /></p>
					  </dd>
					  
					  
						<dt class="col-sm-2">거절 사유</dt>
					  <dd class="col-sm-10">
					    <p>${map.guideApplyDto.guide_apply_message}</p>
					  </dd>
					  
					</dl>
					
					
				</div>
					<button type="button" class="btn btn-primary" onclick = "location.href='./guideApplyPage'">뒤로가기</button>
				</c:when>
				
				<c:otherwise>
					<div class="row mt-5">
					<h3>${map.userDto.user_email}님의 프로필</h3>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<dl class="row">
					  <dt class="col-sm-2">신청자</dt>
					  <dd class="col-sm-10">${map.guideApplyDto.guide_apply_name}</dd>
					
					  <dt class="col-sm-2">프로필</dt>
					  <dd class="col-sm-10">
					    <p>${map.guideApplyDto.guide_apply_profile}</p>
					  </dd>
					  
					  <dt class="col-sm-2">신청 일자</dt>
					  <dd class="col-sm-10">
					    <p><fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" /></p>
					  </dd>
					  
					  <dt class="col-sm-2">승인일자</dt>
					  <dd class="col-sm-10">
					    <p><fmt:formatDate value="${map.guideDto.guide_reg_date}" pattern="yyyy-MM-dd" /></p>
					  </dd>
					  
						<dt class="col-sm-2">응답내용</dt>
					  <dd class="col-sm-10">
					    <p>${map.guideApplyDto.guide_apply_message}</p>
					  </dd>
					  
					</dl>
					
					
				</div>
					<button type="button" class="btn btn-primary" onclick = "location.href='./guideApplyPage'">뒤로가기</button>
				</c:otherwise>
				</c:choose>
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>