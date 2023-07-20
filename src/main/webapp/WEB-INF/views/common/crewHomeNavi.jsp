<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<div
				class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark">
				<a href="#"
					class="align-items-center text-center mb-3">
					<img src="/uploadFiles/crewFiles/crewthumbnail/${crewDto.crew_thumbnail }" class="bi pe-none me-2" width="150" height="150">
						<use xlink:href="/travel/crew/crewhome/${crewDto.crew_domain }"></use>
				</a>
				<span class="text-center crewname">${crewDto.crew_name }</span>
				<div class="row">
					<div class="col">
						멤버 ${membersize } / 20　・　리더 ${masterName }
					</div>
				</div>
				<c:choose>
					<c:when test="${!empty crewMemberDto}">
						<button class="btn btn-success">글쓰기</button>
					</c:when>
					<c:when test="${!empty applied}">
						<button class="btn btn-success">가입신청중</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-success">가입하기</button>
					</c:otherwise>
				</c:choose>
				<hr>
				<ul class="nav nav-pills flex-column mb-auto">
					<li class="nav-item"><a href="/travel/crew/crewhome/${crewDto.crew_domain }" class="nav-link text-white"  id="crewmain"
						aria-current="page"> <svg class="bi pe-none me-2" width="16"
								height="16">
								<use xlink:href="#home"></use>
							</svg> 게시글
					</a></li>
					<li><a href="/travel/crew/crewhome/${crewDto.crew_domain }/notice" class="nav-link text-white"  id="crewnotice"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#speedometer2"></use>
							</svg> <i class="bi bi-bookmark-star"></i> 공지</i>
					</a></li>
					<li><a href="#" class="nav-link text-white"  id="crewcalendar"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#grid"></use>
							</svg> <i class="bi bi-calendar2-date"> 일정</i>
					</a></li>
					<li><a href="/travel/crew/crewhome/${crewDto.crew_domain }/crewmember" class="nav-link text-white" id="crewmember"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#table"></use>
							</svg> <i class="bi bi-people-fill"> 멤버</i>
					</a></li>
					<li><a href="#" class="nav-link text-white"  id="crewshop"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#grid"></use>
							</svg> <i class="bi bi-basket2"> 상점</i>
					</a></li>
					<li><a href="#" class="nav-link text-white"  id="crewchat"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#people-circle"></use>
							</svg> <i class="bi bi-chat-dots"> 채팅</i>
					</a></li>

				</ul>

			</div>