<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value="/resources/css/crew/findcrew.css" />">

<title>메인 페이지</title>

<style>
    .txt {
        margin-top: 10px;
        color: grey;
        font-size: 13px;
    }
    .BaseButton {
        display: inline-block;
        border-radius: 6px;
        box-sizing: border-box;
        font-weight: 700;
        text-align: center;
        vertical-align: top;
    }
</style>

<script type="text/javascript">
	var changeBackColor = true;
	
	function changeBackGround() {	
		if (changeBackColor) {
			var container = document.querySelector('.container-fluid');
			container.style.backgroundColor = '#444444';
			
			var otherElements = container.querySelectorAll(':not(.container)');
			otherElements.forEach(function(element) {
				element.style.color = 'white';
			});
			changeBackColor = false;
		} else {
			var container = document.querySelector('.container-fluid');
			container.style.backgroundColor = 'white';
			
			var otherElements = container.querySelectorAll(':not(.container)');
			otherElements.forEach(function(element) {
				element.style.color = 'black';
			});
			changeBackColor = true;
		}		
	}
</script>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
	</div>
	<div class="container py-5 px-5">
        <div class="row m-3">
        	<div class="col"></div>
        	<div class="col-10">
        		<h1>크루 만들기</h1>
        	</div>
    	    <div class="col"></div>
        </div>
        <form method="POST" action="crewregister">
        <div class="row">
        	<div class="col"></div>
        	<div class="col-10">
				<div class="card">
				  <div class="card-body">
				  	<div class="row">
				  		<div class="col-2">
				  			<div class="input_title mt-1"><strong class="tit">크루 이름<span class="mandatory">*</span></strong></div>
				  		</div>
				  		<div class="col">
				  			<div class="input_area"><div class="FormInputText"><input type="text" placeholder="크루 이름을 입력해주세요." title="크루이름" class="form-control" name="crew_name"></div></div>
				  		</div>
				  	</div>
				  	<hr>
					<div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">크루 주소</strong>
					        </div>
					    </div>
					    <div class="col">
					        <div class="input-group">
					            <span class="aaa me-3 mt-1">http://localhost:8181/travel/crew/</span>
					            <input type="text" class="form-control" name="crew_domain">
					        </div>
                            <p class="txt">
                                입력하지 않을 시 임의로 도메인 값이 자동 생성됩니다.
                            </p>
					    </div>
					</div>
                    <hr>
                    <div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">크루 아이콘</strong>
					        </div>
					    </div>
					    <div class="col">
					        <div class="input-group">
                                <input type="file" class="form-control-file" id="crew_thumbnail" name="crew_thumbnail">
					        </div>
					    </div>
					</div>
                    <hr>
                    <div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">크루 설명글<span class="mandatory">*</span></strong>
					        </div>
					    </div>
					    <div class="col">
					        <div class="input-group">
                                <textarea placeholder="크루 설명을 입력해주세요." class="textarea_input input_txt form-control" style="height: 60px;" name="crew_desc"></textarea>
					        </div>
                            <p class="txt">
                                입력한 내용이 크루 메인, 크루 리스트에 반영 됩니다.
                            </p>
					    </div>
					</div>
                    <hr>
                    <div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">정책 동의<span class="mandatory">*</span></strong>
					        </div>
					    </div>
                        <div class="col d-flex align-items-center">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                <label class="form-check-label" for="flexCheckDefault">
                                    크루 개인정보보호정책에 동의합니다.
                                </label>
                            </div>
                            <a href="#" class="ms-auto">자세히보기</a>
                        </div>
					</div>
                    <hr>
                    <div class="row">
                        <p class="txt">
                            크루를 상거래 목적으로 운영하는 경우, 이용약관에 따라 제재를 받을 수 있습니다.
                        </p>
                    </div>
				</div>
                <div class="row buttons pt-2">
                    <div class="col text-end">
                        <a href="#" onclick="history.back(); return false;"><button type="button" class="btn btn-outline-success">취소하기</button></a>
                    </div>
                    <div class="col ">
                        <button type="submit" class="btn btn-success">생성하기</button>
                    </div>
                </div>
			</div>
		</div>
			<div class="col"></div>
        </div>
        <input type="hidden" name="master_id" value="${sessionuser.user_id }">
        </form>
    </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>