<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>가이드 신청</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


</script>
<style>
 textarea.form-control {
    height: 200px;
  }
</style>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		
		<div class="row mt-3">
			<div class="col-4"></div>
			<div class="col">
				<%-- <form action="./packageRecruitmentProcess?plan_id=${plan_id}" method="post"> --%>
					<div class="row ">
						<div class="col">
							<div class="row mt-4">
								<div class="col">
								 	<label for="guide_planning_title" class="small-text label-with-margin">*가이드 이름</label>
									<input class="form-control" type="text" placeholder="가이드 이름" name="guide_planning_title">
								</div>
							</div>
							<div class="row mt-4">
								<div class="col">
									<label for="guide_planning_content" class="small-text label-with-margin">*가이드 프로필</label>
									<textarea class="form-control"  placeholder="가이드 소개글 작성해주세요" name="guide_planning_content"></textarea>
								</div>
							</div>
							
						</div>
						
					</div>
					
					<div class="row mt-3">
						<div class="col-7"></div>
						
						<div class="col d-grid">
							<button class="btn" style="background:#03c75a; color:white; font-size:20px; font-weight:bold;"name="action" value="recruit">모집하기</button>
						</div>
					</div>
				<!-- </form> -->
			</div>
			<div class="col-4"></div>
		</div>
	</div>
	<jsp:include page="../common/bottomNavi.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>