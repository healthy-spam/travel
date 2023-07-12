<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=db6c20ca60db131bdca5b89e7568dc3f&libraries=services"></script>
<title>플래너 상세보기 페이지</title>
<script type="text/javascript">
   
   var map;
   
   const planId = new URLSearchParams(location.search).get("id");
   
   console.log(planId);
   
   function map(){
      // 지도 api
      var container = document.getElementById('map');
      var options = {
      center: new kakao.maps.LatLng(37.5665, 126.9780),
      level: 3
      };
      
      map = new kakao.maps.Map(container, options);
   }
   
   
   
   window.addEventListener("DOMContentLoaded", () => {
      
      map();
   
   });
</script>

</head>

<body>
   <div class="container">
   
      <jsp:include page="../common/mainTopNavi.jsp"></jsp:include>

      <div class="row">
            <div class="col">
                <div class="row align-items-center">
                
                    <div class="col">
                        <div class="row align-items-center">
                            <div class="col-auto pe-0">
                                <img src="/uploadFiles/${data.planDto.plan_thumbnail}" style="width: 60px;">
                            </div>
                            <div class="col ps-0">
                                <p class="h5 ps-0 fw-bold m-1">${data.planDto.plan_title}</p>
                            </div>
                        </div>
                    </div>
                    
               <div class="col">
                  <div class="row">
                     <div class="col">                     
                        <span id="plan_disclosure_status" class="">${data.planDto.plan_disclosure_status}</span>
                     </div>
                  </div>
               </div>
               
                    <div class="col d-flex flex-row-reverse">
                        <div class="row">
                            <div class="col">
                            <c:choose>
                               <c:when test="${data.planDto.referenced_plan_id != 0}">
                                   <a class="btn btn-primary" href="readPlanPage?id=${data.planDto.referenced_plan_id}">참조한 플래너 이름</a>
                               </c:when>
                               <c:otherwise>
                           <span>&nbsp;</span>                     
                        </c:otherwise>
                            </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col d-flex flex-row-reverse">
                        <div class="row ">    
                           <c:if test="${!empty sessionuser && sessionuser.user_id == data.userDto.user_id}">
                           
                           <div class="col">
                               <c:if test="${data.planDto.plan_statuse != '모집' && guideCheck == 1 }">
                                 <a href="../guidePackage/packageRecruitmentPage?plan_id=${data.planDto.plan_id}" class="btn btn-dark">패키지 모집</a>
                              </c:if>                              
                           </div>
                           
                     <div class="col">
                              <c:if test="${data.planDto.plan_statuse != '모집'}">
                                 <a href="./travelRecruitmentPage?plan_id=${data.planDto.plan_id}" class="btn btn-dark">모집</a>
                              </c:if>                        
                     </div>
                                                                                    
                           </c:if>
                           
                            <div class="col ">
                               <c:if test="${!empty sessionuser && sessionuser.user_id != data.planDto.user_id && data.planDto.plan_disclosure_status == '공개'}">
                                   <a href="./copyPlanProcess?plan_id=${data.planDto.plan_id}" class="btn btn-primary">참조하기</a>
                               </c:if>
                            </div>
                            
                            <c:if test="${!empty sessionuser && sessionuser.user_id == data.userDto.user_id}">
                                                    
                            <div class="col">
                                <a href="./registerPlanRoutePage?plan_id=${data.planDto.plan_id}" class="btn btn-primary">수정하기</a>
                            </div>
                            <div class="col">
                                <a href="./deleteProcess?id=${data.planDto.plan_id}" class="btn btn-primary">삭제하기</a>
                            </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      <!-- 여부분 못함 -->
      <div class="row mt-1" style="width: 110rem;">
            <div class="col">
                <div class="row">
                    <div class="col-2">

                        <div class="row ">
                            <div class="col">
                                
                                <div class="row" style="background-color: #FE1063;">
                                    <div class="col">
                                        <p class="h4 fw-bold dayList">1Day</p>
                                    </div>
                                </div>

                                <div class="row border">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col m-0 p-0">
                                                <p class="m-1 fw-light text-center">서울특별시 송파구</p>
                                            </div>
                                        </div>
                                        <div class="row mt-1 align-items-center">

                                            <div class="col-auto">
                                                
                                                <div class="row">
                                                    <div class="col text-center">
                                                        <i class="bi bi-geo-alt-fill" style="color: #FE1063;"></i>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="col-auto px-0">
                                                <img src="https://via.placeholder.com/40" alt="">
                                            </div>
                                            <div class="col ">
                                                <p class="ps-0 m-1">롯데타워</p>
                                            </div>
                                        </div>
                                        <div class="row mt-1 align-items-center">
                                            <div class="col-auto">
                                                <i class="bi bi-geo-alt-fill" style="color: #FE1063;"></i>
                                            </div>
                                            <div class="col-auto px-0">
                                                <img src="https://via.placeholder.com/40" alt="">
                                            </div>
                                            <div class="col ">
                                                <p class="ps-0 m-1">올림픽공원</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row border">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col m-0 p-0">
                                                <p class="m-1 fw-light text-center">서울특별시 강남구</p>
                                            </div>
                                        </div>
                                        <div class="row mt-1 align-items-center">
                                            <div class="col-auto">
                                                <i class="bi bi-geo-alt-fill" style="color: #FE1063;"></i>
                                            </div>
                                            <div class="col-auto px-0">
                                                <img src="https://via.placeholder.com/40" alt="">
                                            </div>
                                            <div class="col ">
                                                <p class="ps-0 m-1">파이브가이즈</p>
                                            </div>
                                        </div>
                                        <div class="row mt-1 align-items-center">
                                            <div class="col-auto">
                                                <i class="bi bi-geo-alt-fill" style="color: #FE1063;"></i>
                                            </div>
                                            <div class="col-auto px-0">
                                                <img src="https://via.placeholder.com/40" alt="">
                                            </div>
                                            <div class="col ">
                                                <p class="ps-0 m-1">중앙정보교육원</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                    
                            </div>
                        </div>

                    </div>
                    
                    <div class="col-10">
                  <div class="row">
                     <div class="col text-left ms-2">
                        
                        <div id="map" style="width: 1000px; height: 1000px"></div>
                     </div>
                  </div>
               </div>
                    
                </div>
            </div>
        </div>
      
   </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>