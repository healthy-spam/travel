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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<title>메인 페이지</title>
<style>
        .btn {
            background-color: #DB4465;
            color: white;
        }

		.card-mycrew {
			min-height:300px;
		}
        .crewinfo {
            font-size: 16px
        }


        body {
            background-color: #f2f2f2;
        }

        h1 {
            color: #333;
            font-size: 24px;
            font-weight: bold;
        }

        .card {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #fff;
        }

        .card-notitable {
            padding: 0;
            overflow-x: hidden;
            overflow-y: scroll;
        }

        .sticky-header {
        position: sticky;
        top: 0;
        background-color: #fff;
        z-index: 1;
        }
        
        .bi-bell {
        	
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
        
        .crewmember {
            font-size: 13px;
        }

        .crewmembercount{
            font-style: normal;
        }

        .crewname {
            font-size: 23px;
            font-weight: bold;
        }

        .crewlistcard {
            height: 160px;
            
        }
        .card-mycrew {
        	height: 200px;
        }
        .card-notitable {
        	height: 300px;
        }

</style>
<script type="text/javascript">


	document.addEventListener("DOMContentLoaded", function() {
	    var searchCrewInput = document.getElementById("searchCrew");
	    searchCrewInput.addEventListener("input", function() {
	        var searchCrew = searchCrewInput.value;
	        
	        if(searchCrew === '') {
	        	console.log('AAA');
                $.ajax({
                    url: "/travel/crew/getallcrewlist",
                    type: "POST",
                    success: function(response) {
                    	getallcrewlist(response);
                    },
                    error: function(err) {
                        console.error("이름 확인 실패", err);
                    }
                });
	        	
	        	
	        } else {
	        	console.log(searchCrew);
                $.ajax({
                    url: "/travel/crew/searchCrew",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
    	                "searchCrew": searchCrew
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
	
	function getallcrewlist(res) {
		document.getElementById('crewlistarea').innerHTML = ``;
		
		for(var i = 0; i < res.length; i++) {
			var crew_name= res[i].crew.crew_name;
			var crew_desc = res[i].crew.crew_desc;
			var crew_domain = res[i].crew.crew_domain;
			var crew_thumbnail = res[i].crew.crew_thumbnail;
			var crewppl = res[i].crewppl;
			
			document.getElementById('crewlistarea').innerHTML += `
				<div class="col-6">
                <div class="card crewlistcard  shadow-sm p-3 mb-3 bg-body-tertiary rounded" onclick="gocrewpage( '\${crew_domain}')">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3">
                                <img src="/uploadFiles/crewFiles/crewthumbnail/\${crew_thumbnail}" width="100px" height="100px">
                            </div>
                            <div class="col">
                                <div class="row crewname">
                                    \${crew_name }
                                </div>
                                <div class="row">
                                   \${crew_desc }
                                </div>
                                <div class="row mt-2">
                                    <div class="col text-secondary ps-0 crewmember">
                                        인원수 <em class="crewmembercount">\${crewppl } / 20</em>
                                    </div>
                                    <div class="col text-end">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			`;
		}
	}
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="container">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
	</div>
	
	
	<div class="container py-4 px-5">
		<div class="row mb-3">
			<div class="col">
				<h1>나의 크루</h1>
			</div>
		</div>
		
		
		<div class="row">
			<div class="col">
				<div class="card mb-5">
				<div class="row">
                    <div class="col-6">
                    	<div class="card card-mycrew shadow-sm bg-body-tertiary rounded">
						<c:choose>
							<c:when test="${empty crewDto}">
								<div class="card-body">
									<div class="row ">
										<div class="col py-3" style="font-size:20px">
											아직 가입한 크루가 없습니다.<br>
											나에게 맞는 크루를 찾아보세요.
										</div>
									</div>
									<div class="row">
										<div class="col text-end pt-3">
											또는 <a href="/travel/crew/createcrew">크루만들기</a>
										</div>
									</div>
									
								</div>
							</c:when>
							<c:when test="${!empty crewDto && applied == null}">
								<div class="card-body ">
	                                <div class="row">
	                                    <div class="col-3">
	                                        <img src="/uploadFiles/crewFiles/crewthumbnail/${crewDto.crew_thumbnail }" width="100px" height="100px">
	                                    </div>
	                                    <div class="col">
	                                        <div class="row crewname">
	                                            ${crewDto.crew_name }
	                                        </div>
	                                        <div class="row">
	                                            ${crewDto.crew_desc }
	                                        </div>
	                                    </div>
	                                </div>
	                                <hr>
	                                <div class="row">
	                                    <div class="col-4 text-secondary">크루마스터</div>
	                                    <div class="col">${master }</div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-4 text-secondary">인원수</div>
	                                    <div class="col">${crewamount } / 20</div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-4 text-secondary">가입일자</div>
	                                    <div class="col"><fmt:formatDate
																			value="${crewMemberDto.crew_member_log_date }"
																			pattern="yyyy.MM.dd." var="formattedDate" />
																		${formattedDate }</div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-4 text-secondary">나의 직위</div>
	                                    <div class="col">${myGrade }</div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-4 text-secondary">나의 기여포인트</div>
	                                    <div class="col">${myPoint }</div>
	                                </div>
	                                <div class="row mt-3">
	                                    <a href="/travel/crew/crewhome/${crewDto.crew_domain }"><button class="btn form-control" id="opencrewhome">크루 홈 이동</button></a>
	                                </div>
	                            </div>
							</c:when>
							<c:otherwise>
                            <div class="card-body ">
                            	<div class="row">
                            		<div class="col">
                            			현재 가입신청 중입니다.
                            		</div>
                            	</div>
                            	<hr>
                                <div class="row">
                                    <div class="col-3">
                                        <img src="/uploadFiles/crewFiles/crewthumbnail/${crewDto.crew_thumbnail }" width="100px" height="100px">
                                    </div>
                                    <div class="col">
                                        <div class="row crewname">
                                            ${crewDto.crew_name }
                                        </div>
                                        <div class="row">
                                            ${crewDto.crew_desc }
                                        </div>
                                        <div class="row">
		                                    <div class="col-4 text-secondary px-0">크루마스터</div>
		                                    <div class="col">${master }</div>
		                                </div>
		                                <div class="row">
		                                    <div class="col-4 px-0 text-secondary">인원수</div>
		                                    <div class="col">${crewamount } / 20</div>
		                                </div>
		                                <div class="row">
		                                    <div class="col-4 px-0 text-secondary">가입신청일자</div>
		                                    <div class="col">
			                                    <fmt:formatDate value="${applied.crew_member_request_date }" pattern="yyyy.MM.dd" var="formattedDate" />
													${formattedDate }
											</div>
                                		</div>
                                    </div>
                                </div>
                                <hr>

								<div class="row mt-3">
	                            	<a href="/travel/crew/crewhome/${crewDto.crew_domain }"><button class="btn form-control" id="opencrewhome">크루 홈 이동</button></a>
	                           	</div>
                            </div>
							</c:otherwise>
						</c:choose>
						</div>
					</div>
					<div class="col">
                        <div class="card card-notitable  shadow-sm bg-body-tertiary rounded">
                        	<div class="row sticky-header py-2">
                        		<div class="col-auto">
                        			<i class="bi bi-bell"> 알림</i>
                        		</div>
                        		<div class="col text-end">
                        			자세히보기
                        		</div>
                        	</div>
                        	
                        	<c:choose>
                        		<c:when test="${!empty notifications }">
                        			                        			<div class="row">
                        		<div class="col-auto">
                        			<img src="/uploadFiles/crewFiles/crewthumbnail/hangyodon.png" width="35px" height="35px" class="rounded-circle">
                        		</div>
                        		<div class="col">
                        			<div class="row">
                        				멍테일 님이 회원님의 게시글에 댓글을 남겼습니다.
                        			</div>
                        			<div class="row">
                        				2023-07-13
                        			</div>
                        		</div>
                        		<hr>
                        	</div>


                        	
                        	                        	<div class="row">
                        		<div class="col-auto">
                        			<img src="/uploadFiles/crewFiles/crewthumbnail/bowwow.png" width="35px" height="35px" class="rounded-circle">
                        		</div>
                        		<div class="col">
                        			<div class="row">
                        				멍테일 님이 회원님의 게시글에 댓글을 남겼습니다.
                        			</div>
                        			<div class="row">
                        				2023-07-13
                        			</div>
                        		</div>
                        		<hr>
                        	</div>
                        	
                        	                        	<div class="row">
                        		<div class="col-auto">
                        			<img src="/uploadFiles/crewFiles/crewthumbnail/bowwow.png" width="35px" height="35px" class="rounded-circle">
                        		</div>
                        		<div class="col">
                        			<div class="row">
                        				멍테일 님이 회원님의 게시글에 댓글을 남겼습니다.
                        			</div>
                        			<div class="row">
                        				2023-07-13
                        			</div>
                        		</div>
                        		<hr>
                        	</div>
                        		</c:when>
                        		<c:otherwise>
                        		알림이 없습니다.
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                    </div>
				</div>
				</div>
			</div>
		</div>
		
		<div class="row my-3 ">
			<div class="col-9">
				<h1>전체 크루 리스트</h1>
			</div>
			<div class="col text-end">
			
				<input type="text" class="form-control searchbar nonboarder" placeholder="크루명으로 검색" id="searchCrew">
			</div>
		</div>
		<div class="row" id="crewlistarea">
			<c:forEach var="crew" items="${crewList}" varStatus="status">
			
			<div class="col-6">
				<a href="/travel/crew/crewhome/${crew.crew.crew_domain }">
               		<div class="card crewlistcard  shadow-sm p-3 mb-3 bg-body-tertiary rounded">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3">
                                <img src="/uploadFiles/crewFiles/crewthumbnail/${crew.crew.crew_thumbnail }" width="100px" height="100px">
                            </div>
                            <div class="col">
                                <div class="row crewname">
                                    ${crew.crew.crew_name }
                                </div>
                                <div class="row">
                                    ${crew.crew.crew_desc }
                                </div>
                                <div class="row mt-2">
                                    <div class="col text-secondary ps-0 crewmember">
                                        인원수 <em class="crewmembercount">${crew.crewppl } / 20</em>
                                    </div>
                                    <div class="col text-end">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </a>
            </div>
			</c:forEach>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>