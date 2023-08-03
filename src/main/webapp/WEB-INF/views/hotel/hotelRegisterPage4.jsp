<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@300;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<script type="text/javascript">

const hotelTitleInput = document.querySelector("input[type='text'][name='hotel_title']");

</script>

<style>

	body {
		font-family: 'Noto Sans KR', sans-serif;	
	}

    .nextButton {
	    width: auto;
	    height: auto;
	    background-image: linear-gradient(98deg,#4f4f4f,#4f4f4f);
	    border-radius: 10px;
	    border: none;
	    color: rgb(255, 255, 255);
	    padding: 0.8em 1.2em;
	    font-size: 0.9em;
	    text-align: center;
    }
    
    .nextButton:hover {
    	background-image: linear-gradient(98deg,#4f4f4f,#333333);	
    }

	.box {
	    width: auto;
	    height: auto;
	    border: solid rgb(205, 205, 205) 1px;
	    border-radius: 10px;
	    padding: 17px 15px;
	
	}
	
	 input[type="file"] {
        display: none;
    }

    .fileLabel {
        /* 박스 모델 관련 스타일 */
        display: inline-block;
        padding: 8px 35px;
        border: 1px solid rgb(229, 229, 229);
        border-radius: 5px;
        cursor: pointer;

        /* 폰트 스타일 */
        font-size: 0.9em;
        color: #333;
    }

    .fileLabel:hover {
        /* 박스 모델 호버 관련 스타일 */
        background-color: #f1f1f1;
    }
    
    .imageNoticeBox {
        /* 폰트 스타일 */
        font-size: 0.8em;
        color: gray;
    }

	a {
    	text-decoration: none;
    	font-weight: 600;
    	color: #595959;
    }
    
    a:hover {
		text-decoration: none;
		color: black;
	}
	
</style>
</head>
<body>


 <div class="container-fluid">
        <div class="row align-items-center py-4" style="position: fixed; top: 0; width: 100%; z-index: 1;">
            <div class="col px-5">
                <img class="navbar-brand" src="/travel/resources/img/tripstationLOGO.png" style="width: 6em;">
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <div>
                    <a href="/travel/hotel/hotelPage">나가기</a>
                </div>
            </div>
        </div>
		<form action="./hotelRegisterPage4Process" method="post" enctype="multipart/form-data">
        <div class="row" style="padding-top: 100px; padding-bottom: 100px;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-3">
                    <div class="col">
                        <div style="font-size: 1.6em; font-weight: 500;">숙소 정보를 추가하세요</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 1.1em; font-weight: 500;">숙소 이름은 무엇인가요?</div>
                            </div>
                        </div>
                        <div class="row">
                           <div class="col">
                                <input id="hotel_title" name="hotel_title" class="form-control" type="text" placeholder="멋진 이름을 지어주세요">
                           </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 1.1em; font-weight: 500;">숙소를 설명해주세요</div>
                            </div>
                        </div>
                        <div class="row">
                           <div class="col">
                                <input id="hotel_content" name="hotel_content" class="form-control" type="text" placeholder="멋진 설명을 적어주세요">
                           </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 1.1em; font-weight: 500;">숙소 사진을 올려주세요</div>
                            </div>
                        </div>
                        
                        <div class="row">
                        	<div class="col">
                        		<input type="file" name="hotelMainImage" id="fileInput">
                        		<label for="fileInput" class="fileLabel">메인 사진 선택</label>
                       			<span class="imageNoticeBox">숙소 메인 화면에 표시됩니다 (필수 1장 선택)</span>
                    		</div>
                    	</div>
                    	<div class="row mt-2">
                    		<div class="col">
		                        <input type="file" name="hotelDetailImages" accept="image/*" id="fileInput2" multiple>
		                        <label for="fileInput2" class="fileLabel">상세 사진 선택</label>
		                        <span class="imageNoticeBox">숙소 상세 화면에 표시됩니다 (필수 5장이상 선택)</span>
                    		</div> 
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 1.1em; font-weight: 500;">숙소 오픈일과 마감일을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <span>오픈일</span>
                            </div>
                            <div class="col">
                                <input id="hotel_reserve_start_date" name="hotel_reserve_start_date" type="date" class="form-control">
                            </div>
                            <div class="col-auto">
                                <span>마감일</span>
                            </div>
                            <div class="col">
                                <input id="hotel_reserve_end_date" name="hotel_reserve_end_date" type="date" class="form-control">
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 1.1em; font-weight: 500;">숙소 가격을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <input id="hotel_price" name="hotel_price" type="text" class="form-control">
                            </div>
                            <div class="col-auto ps-0">
                                <img style="width: 100%; height: 1.2em; margin-bottom: 0.25em;" alt="" src="/travel/resources/img/pngegg.png/">
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="col"></div>
        </div>
                

        <div class="row align-items-center py-4" style="position: fixed; bottom: 0; width: 100%; z-index: 1;">
            <div class="col-auto px-5">
                <span style="font-size: 1em; font-weight: 500;">뒤로</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <button class="nextButton">
                    <span>다음</span>
                </button>
            </div>
        </div>
        </form>
    </div>

            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>