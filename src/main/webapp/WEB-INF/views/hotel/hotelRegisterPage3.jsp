<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
   
        .reserveButton {
        width: auto;
        height: auto;
        background: linear-gradient(to right, rgb(60, 60, 60), rgb(36, 36, 36), rgb(46, 46, 46), rgb(46, 46, 46));
        border-radius: 10px;
        border: none;
        color: rgb(255, 255, 255);
        padding: 10px 30px;
        font-weight: 600;
        font-size: 16px;
        text-align: center;
    }

    .box {
        width: auto;
        height: auto;
        border: solid rgb(205, 205, 205) 1px;
        border-radius: 10px;
        padding: 17px 15px;

    }
    </style>
</head>
<body>

<div class="container-fluid">
        <div class="row align-items-center py-4">
            <div class="col px-5">
                <span style="color: #e7104a; font-size: 25px; font-weight: 600;">LOGO</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <div>
                    <span>나가기</span>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col"></div>
            <div class="col">
                <div class="row my-3">
                    <div class="col">
                        <div style="font-size: 28px; font-weight: 600;">숙소 기본 사항 작성하기</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row my-4">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙박 가능한 인원은 몇 명인가요?</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">게스트</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">-</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">4</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">+</div>
                            </div>
                        </div>
                        <hr class="my-3">
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">침실</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">-</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">4</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">+</div>
                            </div>
                        </div>
                        <hr class="my-3">
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">욕실</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">-</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">4</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">+</div>
                            </div>
                        </div>
                        <hr class="my-3">
                        <div class="row">
                            <div class="col">
                                <div style="font-size: 16px; font-weight: 500;">침대</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">-</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">4</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">+</div>
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 체크인, 체크아웃 시간을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">체크인</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">
                                    <select class="form-control">
                                        <option>00:00</option>
                                        <option>01:00</option>
                                        <option>02:00</option>
                                        <option>03:00</option>
                                        <option>04:00</option>
                                        <option>05:00</option>
                                        <option>06:00</option>
                                        <option>07:00</option>
                                        <option>08:00</option>
                                        <option>09:00</option>
                                        <option>10:00</option>
                                        <option>11:00</option>
                                        <option>12:00</option>
                                        <option>13:00</option>
                                        <option>14:00</option>
                                        <option>15:00</option>
                                        <option>16:00</option>
                                        <option>17:00</option>
                                        <option>18:00</option>
                                        <option>19:00</option>
                                        <option>20:00</option>
                                        <option>21:00</option>
                                        <option>22:00</option>
                                        <option>23:00</option>
                                        <option>24:00</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">체크아웃</div>
                            </div>
                            <div class="col-auto">
                                <div style="font-size: 16px; font-weight: 500;">
                                    <select class="form-control">
                                        <option>00:00</option>
                                        <option>01:00</option>
                                        <option>02:00</option>
                                        <option>03:00</option>
                                        <option>04:00</option>
                                        <option>05:00</option>
                                        <option>06:00</option>
                                        <option>07:00</option>
                                        <option>08:00</option>
                                        <option>09:00</option>
                                        <option>10:00</option>
                                        <option>11:00</option>
                                        <option>12:00</option>
                                        <option>13:00</option>
                                        <option>14:00</option>
                                        <option>15:00</option>
                                        <option>16:00</option>
                                        <option>17:00</option>
                                        <option>18:00</option>
                                        <option>19:00</option>
                                        <option>20:00</option>
                                        <option>21:00</option>
                                        <option>22:00</option>
                                        <option>23:00</option>
                                        <option>24:00</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 위치를 알려주세요</div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="col"></div>
        </div>
                

        <div class="row align-items-center py-4">
            <div class="col-auto px-5">
                <span style="font-size: 16px; font-weight: 600;">뒤로</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <div class="reserveButton">
                    <span>다음</span>
                </div>
            </div>
        </div>
    </div>

            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>

</body>
</html>