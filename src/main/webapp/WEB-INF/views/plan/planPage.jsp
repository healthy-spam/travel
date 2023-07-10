<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
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
                        planCardBox.querySelector(".user-name").innerText = plan.userDto.user_nickname;
                        planCardBox.querySelector(".user-img").src = "/uploadFiles/profileImage/"+ plan.userDto.user_image;
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
                }
            }
        }
    }

    xhr.open("get", "./getSearchPlanList?type="+searchType+"&word="+searchText);
    xhr.send();
}

window.addEventListener("DOMContentLoaded", () => {
    planCardBoxOriginal = document.getElementById('planCardBox').cloneNode(true);
    planSearch();
});

</script>

<style type="text/css">
/* 	body {
	  height: 100%;
	  margin: 0;
	  background: linear-gradient(#f5d3df 0%, #f5d3df 10%, #ffffff 30%, #ffffff 100%);
	  /* background: linear-gradient(#ff335f 0%, #ff335f 10%, #ffffff 30%, #ffffff 100%); */
	} */
	
	.btn-l{
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
 	}
 	
 	.reserveButton {
        width: 200px;
        height: 45px;
        background: linear-gradient(to right, #ff335f, #e31c41, #ff1843, #e7104a);
        border-radius: 15px;
        border: solid hidden;
        color: rgb(255, 255, 255);
        font-weight: bold;
        font-size: 15px;
        margin-top : 10px;
    }
    
    .imgText{
    	margin-top: 150px;
    	color: white;
    }
</style>

</head>
<body >

	<div class="container">

		<div class="row">
			<div class="col" >
				<jsp:include page="../common/topNavi.jsp"></jsp:include>  	
			</div>
		</div>
	
		<div class="row mt-1 ">
			<div class="col-12 p-0">
				<p class="m-0">Let's Go!</p>
			</div>
		</div>
	
		<div class="row ">
			<div class="col-12 p-0">
				<p class="h2">다른 여행자들의 일정을 참고해 나만의 여행을 계획해보세요!</p>
			</div>
		</div>
	 
		<div class="row mt-3" style="background-image: url('/travel/resources/img/plan7.PNG'); background-size: 100%; min-height: 400px; width: auto; background-repeat: no-repeat;">
				
			<div class="p-0">
	
				<div class="col">
	
					<div class="row">
						<div class="col-1"></div>
						<div class="col">
							<p class="h2 imgText">나만의 일정을 만들어서 공유하고 떠나보세요.</p>
						</div>
					</div>
	
					<div class="row mt-3 ">
						<div class="col-2">&nbsp;</div>
						<div class="col">
	
							<a class=" btn d-grid reserveButton text-canter" onclick="showModal();">플래너 시작하기</a>
	
						</div>
						<div class="col-5">&nbsp;</div>
					</div>
							
				</div>
	
			</div>
	
		</div>

	
		<div class="row mt-4">
			<div class="col-12">
	      		<!-- <img alt="" src="/travel/resources/img/planBanner.PNG" style="width: 100%; height: 100%"> -->
	      		<p class="h4">준비중인 여행자들의 플래너</p>
	      	</div>
		</div>
      
		<div class="row mt-2">
		    
		    <div class="col">
		        <input onchange="planSearch()" type="text" class="form-control" id="plan_search_text_box">
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
	            
				<div class="card h-100" style="border-radius: 15px; border: none;"  onclick="" >
					<div class="text-center">
						<a class="readPlan" href=""> 
						<img src="" class="card-img-top plan-thumbnail img-fluid" style=" width: 370px; height: 260px;">
						</a>
					</div>
					
					<div class="card-body pt-2">
					
						<div class="row">
	                  		<div class="col-9">
								<p class="h5 plan-title m-0" style="font-weight: bold; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">
								${map.planDto.plan_title}
								</p>          		
							</div>
	                  		<div class="col text-end">
								<p class="m-0"><img src="/travel/resources/img/copy-icon.png" style="width: 1rem"> 1</p>
	                  		</div>
	                  	</div>
	                  	
	                  	<div class="row">
							<div class="col-7">
								<p class="card-text plan-content m-0" style="font-size: 14px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${map.planDto.plan_content}</p>
							</div>
	                  	</div>
	                  	
						<div class="row mt-2">					
							<div class="col">
							    <div class="row">
							        <div class="col-2">
							            <img class="user-img border border-danger-subtle " src="" style="width: 2rem; height: 2rem; border-radius: 50%;"/>${map.userDto.user_nickname}
							        </div>
							        <div class="col-3 ps-0">
							            <p class="card-text user-name text-secondary" style="margin-top: 5px; font-size: 1rem;"></p>                  		
							        </div>
							    </div>
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