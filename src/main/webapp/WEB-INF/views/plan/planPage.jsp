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
<title>플래너 페이지</title>
<style >
 
</style>

<script>

function submitModal(){
   
   const formData = new FormData();
   
    // 플래너 제목, 설명, 썸네일, 공개 여부 값 가져오기
    const planTitle = document.getElementById('plan_title').value;
    const planContent = document.getElementById('plan_content').value;
    const planThumbnail = document.getElementById('plan_thumbnail').files[0];
    
    // FormData에 값 추가
    formData.append('plan_title', planTitle);
    formData.append('plan_content', planContent);
    formData.append('img', planThumbnail);

    const xhr = new XMLHttpRequest();
    
    xhr.open('POST', './registerPlanProcess');
    xhr.send(formData);
    
    
    xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response = JSON.parse(xhr.responseText);
         
         const redirectUrl = response.redirectUrl;
         
         if(redirectUrl){
            window.location.href = redirectUrl;
         }else {
            console.log('리다이렉트할 URL이 없습니다.');
         }
         
         // js 작업..
      }else {
         console.log('에이잭스 요청 실패')
      }
   }
}

function createModal() {

    // 모달 요소 생성
    var modalDiv = document.createElement('div');
    modalDiv.classList.add('modal');
    modalDiv.classList.add('fade');
    modalDiv.id = 'dynamicModal';
    modalDiv.setAttribute('data-bs-backdrop', 'static');
    modalDiv.setAttribute('data-bs-keyboard', 'false');
    modalDiv.setAttribute('tabindex', '-1');
    modalDiv.setAttribute('aria-labelledby', 'dynamicModalLabel');
    modalDiv.setAttribute('aria-hidden', 'true');

    // 모달 다이얼로그 생성
    var modalDialogDiv = document.createElement('div');
    modalDialogDiv.classList.add('modal-dialog');
    modalDialogDiv.classList.add('modal-dialog-centered');
    modalDialogDiv.classList.add('modal-dialog-scrollable');
    modalDialogDiv.classList.add('modal-lg');

    // 모달 콘텐츠 생성
    var modalContentDiv = document.createElement('div');
    modalContentDiv.classList.add('modal-content');

    // 모달 헤더 생성
    var modalHeaderDiv = document.createElement('div');
    modalHeaderDiv.classList.add('modal-header');

    // 모달 제목 생성
    var modalTitleH1 = document.createElement('h1');
    modalTitleH1.classList.add('modal-title');
    modalTitleH1.classList.add('fs-5');
    modalTitleH1.id = 'dynamicModalLabel';
    modalTitleH1.innerText = 'MAKE MY PLAN';

    // 모달 닫기 버튼 생성
    var closeButton = document.createElement('button');
    closeButton.type = 'button';
    closeButton.classList.add('btn-close');
    closeButton.setAttribute('data-bs-dismiss', 'modal');
    closeButton.setAttribute('aria-label', 'Close');
    closeButton.setAttribute('onclick', 'removeModal()');

    // 모달 바디 생성
    var modalBodyDiv = document.createElement('div');
    modalBodyDiv.classList.add('modal-body');

    // 모달 바디내 container생성
    var containerDiv = document.createElement('div');
    containerDiv.classList.add('container');
    modalBodyDiv.appendChild(containerDiv);

    // 모달 바디내 container내 row 생성
    var rowDiv = document.createElement('div');
    rowDiv.classList.add('row');
    containerDiv.appendChild(rowDiv);

    // 모달 바디내 container내 row내 col1 생성
    var col1Div = document.createElement('div');
    col1Div.classList.add('col');
    rowDiv.appendChild(col1Div);

   //플랜 제목
    var row0 = document.createElement('div');
    row0.classList.add('row');
    row0.classList.add('mt');
    col1Div.appendChild(row0);

    var row0Col1 = document.createElement('div');
    row0Col1.classList.add('col');
    row0.appendChild(row0Col1);

    var row0Col1Icon = document.createElement('i');
    row0Col1Icon.classList.add('bi');
    row0Col1Icon.classList.add('bi-check-circle');
    row0Col1Icon.classList.add('me-1');
    row0Col1.appendChild(row0Col1Icon);

    var row0Col1Span = document.createElement('input');
    row0Col1Span.setAttribute('type', 'text');
    row0Col1Span.setAttribute('id', 'plan_title');
    row0Col1Span.setAttribute('class', 'form-control rounded shadow-sm');
    row0Col1Span.setAttribute('name', 'plan_title');
    row0Col1Span.setAttribute('placeholder', '플랜 제목');
    row0Col1.appendChild(row0Col1Span);

    //플랜 설명
    var row1 = document.createElement('div');
    row1.classList.add('row');
    row1.classList.add('mt-4');
    col1Div.appendChild(row1);

    var row1Col1 = document.createElement('div');
    row1Col1.classList.add('col');
    row1.appendChild(row1Col1);

    var row1Col1Icon = document.createElement('i');
    row1Col1Icon.classList.add('bi');
    row1Col1Icon.classList.add('bi-check-circle');
    row1Col1Icon.classList.add('me-1');
    row1Col1.appendChild(row1Col1Icon);

    var row1Col1Span = document.createElement('textarea');
    row1Col1Span.setAttribute('class', 'form-control rounded shadow-sm');
    row1Col1Span.setAttribute('id', 'plan_content');
    row1Col1Span.setAttribute('name', 'plan_content');
    row1Col1Span.setAttribute('placeholder', '간단한 플랜 설명');
    row1Col1Span.setAttribute('value','plan_content');
    row1Col1.appendChild(row1Col1Span);

    // 썸네일
    var row2 = document.createElement('div');
    row2.classList.add('row');
    row2.classList.add('mt-4');
    col1Div.appendChild(row2);

    var row2Col1 = document.createElement('div');
    row2Col1.classList.add('col');
    row2.appendChild(row2Col1);

    var row2Col1Icon = document.createElement('i');
    row2Col1Icon.classList.add('bi');
    row2Col1Icon.classList.add('bi-check-circle');
    row2Col1Icon.classList.add('me-1');
    row2Col1.appendChild(row2Col1Icon);
    
    var row2Col1IconSpan = document.createElement('span')
    row2Col1IconSpan.innerText = '플랜 썸네일'
    row2Col1IconSpan.style.fontStyle = 'normal'; // 기울임체 해제 // 글꼴을 보통으로 설정
    row2Col1IconSpan.style.opacity = '0.75';
    row2Col1Icon.appendChild(row2Col1IconSpan);
    
    var row2Col1Div = document.createElement('div');
    row2Col1Div.classList.add('mt-2');
    row2Col1Icon.appendChild(row2Col1Div);
    

    var row2Col1Span = document.createElement('input');
    row2Col1Span.setAttribute('type', 'file');
    row2Col1Span.setAttribute('class', 'form-control-file rounded shadow-sm ');
    row2Col1Span.setAttribute ('name', 'img');
    row2Col1Span.setAttribute ('id', 'plan_thumbnail');
   
    row2Col1Span.setAttribute('accept', 'image/*');
    row2Col1.appendChild(row2Col1Span);
    
   //등록 버튼
   var submitButton = document.createElement('button');
   submitButton.type = 'submit';
   submitButton.classList.add('btn');
   submitButton.classList.add('btn-primary');
   submitButton.style.position = 'absolute';
   submitButton.style.bottom = '10px';
   submitButton.style.right = '10px';
   submitButton.style.background = 'navy';
   submitButton.style.color = 'white';
   submitButton.style.textDecoration = 'none';
   submitButton.style.border = 'none';
   submitButton.innerText = '등록';
   submitButton.setAttribute('onclick', 'submitModal()');
   col1Div.appendChild(submitButton);
   
    // 모달 요소 구성
    modalHeaderDiv.appendChild(modalTitleH1);
    modalHeaderDiv.appendChild(closeButton);

    modalContentDiv.appendChild(modalHeaderDiv);
    modalContentDiv.appendChild(modalBodyDiv);

    modalDialogDiv.appendChild(modalContentDiv);

    modalDiv.appendChild(modalDialogDiv);

    // 모달을 추가할 요소 찾기 (예시로는 body로 가정)
    var targetElement = document.body;

    // 모달 추가
    targetElement.appendChild(modalDiv);
    
}
 
 
function showModal() {
    createModal();
    modal = new bootstrap.Modal(document.getElementById('dynamicModal'));
    modal.show();
}
 
function removeModal() {
    var modal = document.getElementById('dynamicModal');
    modal.remove();
}

// 내가 작성한 플랜 목록
function myPlanList() {
    const xhr = new XMLHttpRequest();
   
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                const response = JSON.parse(xhr.responseText);

                console.log(response.planList);
                
                const planPublicList = document.getElementById("planPublicList");
                const planCardBoxOriginal = document.getElementById('planCardBox');
                
                planPublicList.innerHTML = "";
            
                for(let plan of response.planList) {

                    // 플랜이 userId가 같으면 카드를 생성
                    if(plan.planDto.plan_disclosure_status === '공개') {
                        const planCardBox = planCardBoxOriginal.cloneNode(true);
                        planCardBox.removeAttribute('id'); 
                        
                        planCardBox.querySelector(".plan-thumbnail").src = "/uploadFiles/" + plan.planDto.plan_thumbnail;
                        planCardBox.querySelector(".plan-title").innerText = plan.planDto.plan_title; 
                        planCardBox.querySelector(".plan-content").innerText = plan.planDto.plan_content;
                        //planCardBox.querySelector(".user-name").innerText = plan.userDto.user_nickname;
                        //planCardBox.querySelector(".user-img").src = "/uploadFiles/profileImage/"+ plan.userDto.user_image;
                        planCardBox.querySelector(".readPlan").href = "./readPlanPage?id="+ plan.planDto.plan_id;
                        
                        planPublicList.appendChild(planCardBox);
                        
                        
                    }
                }
                
            }
        }
    }

    xhr.open("get", "./getPlanList2");
    xhr.send();
}

let planCardBoxOriginal = null;

function planSearch() {
    const searchText = document.getElementById('plan_search_text_box').value;
    const searchType = document.getElementById('plan_search_select_box').value;

    const xhr = new XMLHttpRequest();

    console.log(searchText);
    console.log(searchType);

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const response = JSON.parse(xhr.responseText);

            const planPublicList = document.getElementById("planPublicList");

            console.log(planCardBoxOriginal);
            
            while (planPublicList.firstChild) {
                planPublicList.removeChild(planPublicList.firstChild);
            }
         
            
            for(let plan of response.planSearchList) {
                if(plan.planDto.plan_disclosure_status === '공개') {
                    const planCardBox = planCardBoxOriginal.cloneNode(true);
                    planCardBox.removeAttribute('id'); 

                    planCardBox.querySelector(".plan-thumbnail").src = "/uploadFiles/" + plan.planDto.plan_thumbnail;
                    planCardBox.querySelector(".plan-title").innerText = plan.planDto.plan_title; 
                    //planCardBox.querySelector(".plan-content").innerText = plan.planDto.plan_content;
                    planCardBox.querySelector(".user-name").innerText = plan.userDto.user_nickname;
                    planCardBox.querySelector(".user-img").src = "/uploadFiles/profileImage/"+ plan.userDto.user_image;
                    planCardBox.querySelector(".readPlan").href = "./readPlanPage?id="+ plan.planDto.plan_id;
                    
                    planPublicList.appendChild(planCardBox);
                    
                    init(); // day버튼
                }
            }
        }
    }

    xhr.open("get", "./getSearchPlanList?type="+searchType+"&word="+searchText);
    xhr.send();
}

//Day버튼 시작
function init() {
   setDayButtonEvents();
   setScrollEvents();
   setLandmarkScrollEvents();
}

function setDayButtonEvents() {
    let buttons = document.getElementsByClassName('day-btn');

    for (let i = 0; i < buttons.length; i++) {

        buttons[i].addEventListener('click', function() {
            // 모든 버튼을 원래 색상으로 되돌림
            for (let j = 0; j < buttons.length; j++) {
                buttons[j].style.background = '';
                buttons[j].style.color = '';
                
                // Remove icon from all buttons
                let icon = buttons[j].getElementsByClassName('bi bi-send')[0];
                if (icon) {
                    buttons[j].removeChild(icon);
                }
            }

            // 클릭한 버튼의 색상을 변경하고 아이콘을 추가
            this.style.background = 'linear-gradient(to right, #ff356b, #f41b55, #ff1c59, #ff0044)';
            this.style.color = 'white';
            
            // Add icon to the clicked button
            let iconHtml = document.createElement('i');
            iconHtml.className = 'bi bi-send';
            this.prepend(iconHtml);
        });

        // 페이지 로드 시 첫 번째 버튼을 "클릭된" 상태로 만듭니다.
        if (i === 0) {
            buttons[i].click();
        }
    }
}

function setScrollEvents() {
   var scrollableDiv = document.querySelector('.scrollable-div');
   var pos = { left: 0, x: 0 };

   scrollableDiv.addEventListener('mousedown', function(e) {
      e.preventDefault();
      pos = { left: scrollableDiv.scrollLeft, x: e.clientX };
      scrollableDiv.style.cursor = 'grabbing';
      scrollableDiv.style.userSelect = 'none';

      scrollableDiv.addEventListener('mousemove', moveScroll);
   });

   scrollableDiv.addEventListener('mouseup', stopScroll);
   scrollableDiv.addEventListener('mouseout', stopScroll);

   function moveScroll(e) {
      e.preventDefault();
      if (pos) {
         var dx = e.clientX - pos.x;
         scrollableDiv.scrollLeft = pos.left - dx;
      }
   }

   function stopScroll() {
      scrollableDiv.style.cursor = 'grab';
      scrollableDiv.style.removeProperty('user-select');
      scrollableDiv.removeEventListener('mousemove', moveScroll);
      pos = null;
   }
}
//Day버튼 끝

//day별 명소 스크롤 시작
function setLandmarkScrollEvents() {
   var scrollableDiv = document.querySelector('.scrollable-div-landmark');
   var pos = { left: 0, x: 0 };

   scrollableDiv.addEventListener('mousedown', function(e) {
      e.preventDefault();
      pos = { left: scrollableDiv.scrollLeft, x: e.clientX };
      scrollableDiv.style.cursor = 'grabbing';
      scrollableDiv.style.userSelect = 'none';

      scrollableDiv.addEventListener('mousemove', moveScroll);
   });

   scrollableDiv.addEventListener('mouseup', stopScroll);
   scrollableDiv.addEventListener('mouseout', stopScroll);

   function moveScroll(e) {
      e.preventDefault();
      if (pos) {
         var dx = e.clientX - pos.x;
         scrollableDiv.scrollLeft = pos.left - dx;
      }
   }

   function stopScroll() {
      scrollableDiv.style.cursor = 'grab';
      scrollableDiv.style.removeProperty('user-select');
      scrollableDiv.removeEventListener('mousemove', moveScroll);
      pos = null;
   }
}

//day별 명소 스크롤 끝

window.addEventListener("DOMContentLoaded", () => {
    planCardBoxOriginal = document.getElementById('planCardBox').cloneNode(true);
    planSearch();
    
});

</script>

<style type="text/css">
   
/*    .btn-l{
    width:200px;
    height: 40px;
    background: linear-gradient(to right, #f5d3df, #f5d3df, #f5d3df, #f5d3df);
    border-radius: 10px;
    border: solid hidden;
    color: rgb(255, 255, 255);
    font-weight: bold;
    font-size: 15px;
    margin-top : 200px;
    /* background-color: #f5d3df */
    } */
    
    .planTitle{
       
       
    }
    
    .imgText {
	   text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
	}
    
    .scrollable-div {
       overflow: hidden; /* 스크롤을 숨깁니다 */
   }

   .scrollable-div::-webkit-scrollbar {
   /* Chrome, Safari, Edge */
      display: none;
   }

   .scrollable-div-landmark {
       overflow: hidden; /* 스크롤을 숨깁니다 */
   }

   .scrollable-div-landmark::-webkit-scrollbar {
   /* Chrome, Safari, Edge */
      display: none;
   }
   
   .my-button {
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
    transition: all 0.3s ease;
	}
	
	
	
	.my-button:active {
	    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
	    transform: translateY(0px);
	}
</style>

</head>
<body >

   <div class="container">

      <jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
    
    <div class="row">
    	<div class="col-12">
    		      
			<div class="row-auto mt-3" style="background-image: url('/travel/resources/img/plan7re.jpg'); background-size: 100%; min-height: 400px; width: auto; background-repeat: no-repeat; border-radius: 13px">
            
            	<div class="col-3">&nbsp;</div>   
                        
	            <div class="col">
	   
	               <div class="row planTitle">
	               
	                  <div class="col-1">&nbsp;</div>
	                  
	                  <div class="col">	                    
	                     
	                     <div class="row">
	                        &nbsp;
	                     </div>
	                     <div class="row">
	                        &nbsp;
	                     </div>
	                      <div class="row">
	                        &nbsp;
	                     </div>
	                     
	                     <div class="row">
	                        <div class="col">
	                           <h2 class="imgText mb-0" style="font-weight: bolder; font-size: 48px; color: white;">여행의 시작</h2>
	                        </div>
	                     </div>
	                     
	                     <div class="row mt-0">
	                     	<div class="col">
	                     		<h2 class="imgText" style="font-weight: bolder; font-size: 48px; color: white;">TripStation</h2>		
	                     	</div>
	                     </div>
	                     <div class="row mt-3">
	                        <div class="col">
	                           <h3 class="m-0" style="font-size: 20px; font-weight: 500; color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">다른 여행자들과 공유한 일정을 참조하거나</h3>
	                        </div>
	                     </div>
	                     <div class="row">
	                        <div class="col">
	                           <h3 class="" style="font-size: 20px; font-weight: 500; color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">당신만의 특별한 여행 계획을 세우세요.</h3>
	                        </div>
	                     </div>	                     	                    
	                     
	                  </div>
	                  
	                  <div class="col">
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	<div class="row">&nbsp;</div>
	                  	 <div class="row">
	                        <div class="col-2">&nbsp;</div>
	                        <div class="col">         
	                           <a class="btn btn-lg d-grid align-items-center my-button" onclick="showModal();" style="border-radius: 20px; background: linear-gradient(to right, #ff356b, #f41b55, #ff1c59, #ff0044); font-size: 20px; color: white; font-weight: bolder; border: 0px;">플래너 작성하기</a>         
	                        </div>	                        
	                        <div class="col-4">&nbsp;</div>
	                     </div>
	                     <div class="row">&nbsp;</div>
	                  </div>
	                  
	               </div>                        
	                     
	            </div>
   
            	<div class="col-6">&nbsp;</div>
   
			</div>
		</div>
	</div>
          
	<div class="row mt-3">
          
          <div class="col-4">
             <div class="input-group border" style="border-radius: 7px;">
                 <span class="input-group-text" id="basic-addon1" style="background-color: white; border: 0;">
                     <i class="bi bi-search"></i>
                 </span>
                 <input type="text" class="form-control" placeholder="어디로 여행가시나요?" aria-label="Search" aria-describedby="basic-addon1" onchange="planSearch()" id="plan_search_text_box" onfocus="this.placeholder = ''" onblur="this.placeholder = '어디로 여행가시나요?'" style="border: 0;">
             </div>
         </div>

          
          <div class="col-2">
              <select onchange="planSearch()" class="form-select" id="plan_search_select_box">
                  <option value="">전체</option>
                  <option value="title">제목</option>
                  <option value="content">내용</option>
                  <option value="titleAndContent">제목+내용</option>
              </select>
          </div>
          
          <div class="col-2"></div>
          
      </div>
   
	<div class="row mt-2" id="planPublicList">
         
         <div class="col-3 mt-2 m-0" id="planCardBox">
               
            <div class="card h-100 mt-1 shadow-lg" style="border-radius: 15px; border: none; "  onclick="" >
            
				<div class="flex-row mt-3 border shadow" style="border-radius: 10px; position: absolute; top: 5px; left: 50%; transform: translate(-50%, 0%); width: 90%; background-color: white;">						              
						
						

						<div class="flex-col m-1" style="  ">
							<div class="row text-center align-items-center">
								
								<!-- <div class="col-1">&nbsp;</div> -->
								
								<div class="col-2">
									<img class="user-img border-danger-subtle " src="" style="width: 2rem; height: 2rem; border-radius: 50%;"/>
								</div>
								
								<div class="col-4">
									<div class="row">
										<div class="col text-center">
											<span class="user-name text-break" style="font-size: 13px; font-weight: bolder; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">기훈</span>                        
										</div>
									</div>
									<div class="row">
										<div class="col text-center" style="line-height: 15px;">
											<span class="user-age " style="font-size: 12px; color: #e7104a; font-weight: 600; ">20대 남</span>                        
										</div>
									</div>
								</div>

								<div class="col-1 d-flex align-items-center justify-content-center">ㅣ</div>
								
								<div class="col-1 d-flex align-items-center justify-content-center">
									<i class="bi bi-calendar d-flex align-items-center justify-content-center"></i>
								</div>																										
											
								<div class="col-4 ps-0">
									<div class="row">
										<div class="col" style="font-size: 12px;">
											<span class="" style="font-weight: bolder;">여행기간</span>                        
											<span class="" style="color: #e7104a; font-weight: bolder; ">12일</span>                        
										</div>																						
									</div>
								</div>
															
							</div>
						</div>
						
						

				</div>
            
               
                  <div class="row mt-1">
                  	<div class="col">
						<img src="" class="card-img-top plan-thumbnail img-fluid" style=" width: 450px; height: 250px;">                  	
                  	</div>
                  </div>
                  
               
               
               <div class="card-body pt-2">
               
					<div class="row mt-1 align-items-center">
						<div class="col-8">
	                        <p class="h5 plan-title m-0" style="font-weight: bold; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">
	                        
	                        </p>                
						</div>
						<div class="col text-end pe-0">
							<i class="bi bi-bookmark-fill" style="width: 4rem; color: #ff356b;"></i>
						</div>
						<div class="col ps-0 align-items-center">
							<span style="font-size: 15px; font-weight: bolder;">1125</span>
						</div>
					</div>                                    
                        
                  <div class="row mt-3">               
                     <div class="col-12">
                         <div class="row scrollable-div" style="display: flex; overflow-x: auto; white-space: nowrap;">
                           <div class="col">
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day1</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day2</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day3</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day4</button>                              
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day5</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day6</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day7</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day8</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day9</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day10</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day11</button>
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day12</button>
                           </div>
                        </div>
                     </div>
                  </div>   
                        
                  <div class="row mt-3 scrollable-div-landmark" style="overflow-x: auto; white-space: nowrap;">
                     <div class="d-flex">

                        <div class="flex-col d-flex mx-1">
                           <div class="row">
                              <div class="col">
                                 <img src="/travel/resources/img/롯데타워.png" style="width: 5rem; height: 5rem; border-radius: 10px;" alt="">
                              </div>
                           </div>
                           <div class="row">                              
                              <div class="flex-col mx-2">
                                 <div class="row mt-1">
                                    <div class="col">
                                       <span style="font-weight: bolder; font-size: 14px;">롯데타워</span>                                                                      
                                    </div>
                                 </div>
                                 <div class="row mt-2">
                                    <div class="col">
                                       <span style="font-size: 10px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">서울 송파구 올림픽로 300</span>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>

                        <div class="flex-col d-flex mx-1">
                           <div class="row">
                              <div class="col">
                                 <img src="/travel/resources/img/롯데타워.png" style="width: 5rem; height: 5rem; border-radius: 10px;" alt="">
                              </div>
                           </div>
                           <div class="row">                              
                              <div class="flex-col mx-2">
                                 <div class="row mt-1">
                                    <div class="col">
                                       <span style="font-weight: bolder; font-size: 14px;">롯데타워</span>                                                                      
                                    </div>
                                 </div>
                                 <div class="row mt-2">
                                    <div class="col">
                                       <span style="font-size: 10px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">서울 송파구 올림픽로 300</span>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>

                        <div class="flex-col d-flex mx-1">
                           <div class="row">
                              <div class="col">
                                 <img src="/travel/resources/img/롯데타워.png" style="width: 5rem; height: 5rem; border-radius: 10px;" alt="">
                              </div>
                           </div>
                           <div class="row">                              
                              <div class="flex-col mx-2">
                                 <div class="row mt-1">
                                    <div class="col">
                                       <span style="font-weight: bolder; font-size: 14px;">롯데타워</span>                                                                      
                                    </div>
                                 </div>
                                 <div class="row mt-2">
                                    <div class="col">
                                       <span style="font-size: 10px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">서울 송파구 올림픽로 300</span>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>

                        <div class="flex-col d-flex mx-1">
                           <div class="row">
                              <div class="col">
                                 <img src="/travel/resources/img/롯데타워.png" style="width: 5rem; height: 5rem; border-radius: 10px;" alt="">
                              </div>
                           </div>
                           <div class="row">                              
                              <div class="flex-col mx-2">
                                 <div class="row mt-1">
                                    <div class="col">
                                       <span style="font-weight: bolder; font-size: 14px;">롯데타워</span>                                                                      
                                    </div>
                                 </div>
                                 <div class="row mt-2">
                                    <div class="col">
                                       <span style="font-size: 10px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">서울 송파구 올림픽로 300</span>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>

                     </div>
                  </div>
                        
					<div class="row mt-3">
                     <div class="col-12">
                        <div class="row">
                           <div class="col d-grid">
                              <a class="btn" style="border-radius: 15px; border-color: #ff356b; border-width: 2px; color: #ff356b; font-weight: 600;" href="">
                                 <i class="bi bi-bookmark" style="width: 1rem; filter: drop-shadow(0 0 1px #ff356b);"></i>일정담기
                              </a>
                           </div>
                           <div class="col d-grid">
                              <a class="btn readPlan" style="border-radius: 15px; border-color: #ff356b; border-width: 2px; color: #ff356b; font-weight: 600;" href="">
                                 <i class="bi bi-list-ul" style="width: 1rem; filter: drop-shadow(0 0 1px #ff356b);"></i> 상세보기
                              </a>
                           </div>
                        </div>
                     </div>
                  </div>
                           
               </div>
            </div>
                  
         </div>
            
      </div>
	
	<div class="row mt-4">
		<div class="col-12 text-center">
			<div class="row">
				<div class="col">
					<hr>
				</div>
			</div>
			<div class="row">
				<div class="col text-start">		
					<span>© 2023 TripStation. All rights reserved.</span>
				</div>
				<div class="col text-end">
					<span></span>
				</div>
			</div>
		</div>
	</div>      
	
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>