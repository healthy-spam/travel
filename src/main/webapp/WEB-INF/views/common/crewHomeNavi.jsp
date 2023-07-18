<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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