<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

		<div class="row">
			<span class="border border-black">
				${sessionUser.admin_nickname}님 안녕하세요
				<button type="button" class="btn btn-primary" onclick = "location.href='./adminLogoutProcess'">로그아웃</button>
			</span>
		</div>
		<div class="container">
		<div class="row mt-5">
			  <div class="col">
			  <div class="row bg-dark-subtle text-emphasis-dark">
			  	<div class="col">
			    지역관리
			    </div>
			  </div>
			    <div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="../admin/registedCityPage">지역정보</a>
				   </div>
				</div>	 
				<div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="../admin/registCityPage">지역추가</a>
				   </div>
				</div> 
				
			<div class="row bg-dark-subtle text-emphasis-dark">
			  <div class="col">
			    고객승인
			    </div>
			  </div>
			    <div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="./guideApplyPage">가이드승인</a>
				   </div>
				</div>	 
				<div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="#">호스트승인</a>
				   </div>
				</div> 
					  
			<div class="row bg-dark-subtle text-emphasis-dark">
			  <div class="col">
			    신고관리
			    </div>
			  </div>
			    <div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="./guideReportPage">가이드 신고</a>
				   </div>
				</div>	 
				<div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="#">게시글 신고</a>
				   </div>
				</div>
				<div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="./userReportPage">유저 신고</a>
				   </div>
				</div>  
				
				<div class="row bg-dark-subtle text-emphasis-dark">
			  <div class="col">
			    유저문의
			    </div>
			  </div>
			    <div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="#">유저문의</a>
				   </div>
				</div>
				
			<div class="row bg-dark-subtle text-emphasis-dark">
			  <div class="col">
			    쿠폰관리
			    </div>
			  </div>
			    <div class="row bg-body-secondary">
				   <div class="col">
					    <a class="nav-link" href="./registedCouponPage">쿠폰 정보</a>
				   </div>
				</div>	 
				<div class="row">
				   <div class="col bg-body-secondary">
					    <a class="nav-link" href="./registCouponPage">쿠폰 등록</a>
				   </div>
				</div>   
				  
				
		  </div>
		</div>
	</div>