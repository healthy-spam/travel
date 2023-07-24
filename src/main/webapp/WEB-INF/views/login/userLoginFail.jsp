<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: white; /* 검정색으로 설정 */
            color: black; /* 흰색으로 설정 */
        }
        .card {
            background-color: #444444; /* 짙은 회색으로 설정 */
            margin-top: 50px; /* 위쪽 여백 설정 */
        }
        .card-header {
            color: #ffffff; /* 흰색으로 설정 */
        }
        .form-control {
            background-color: #555555; /* 회색으로 설정 */
            color: #ffffff; /* 흰색으로 설정 */
        }
        .btn-primary {
            background-color: #555555; /* 회색으로 설정 */
            color: #ffffff; /* 흰색으로 설정 */
        }
    </style>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script type="text/javascript">
    
    var endDate = new Date('${memberRestrictDto.user_restrict_end_date}');
    
    function formatDate(date, format) {
    	  var year = date.getFullYear();
    	  var month = ('0' + (date.getMonth() + 1)).slice(-2);
    	  var day = ('0' + date.getDate()).slice(-2);
    	  var hours = ('0' + date.getHours()).slice(-2);
    	  var minutes = ('0' + date.getMinutes()).slice(-2);
    	  var seconds = ('0' + date.getSeconds()).slice(-2);
    	  
    	  format = format.replace('yyyy', year);
    	  format = format.replace('MM', month);
    	  format = format.replace('dd', day);
    	  format = format.replace('hh', hours);
    	  format = format.replace('mm', minutes);
    	  format = format.replace('ss', seconds);

    	  return format;
    	}
    
	var endDateFormatted = formatDate(endDate, 'yyyy-MM-dd hh:mm:ss');

    console.log(endDate);
    console.log('${memberRestrictDto.user_restrict_end_date}');
    function loginFail(){
        swal('회원님의 계정은 신고로 인해 ' + endDateFormatted + '까지 이용이 정지되었습니다.', ' sdsds', 'warning');
    }
    
    document.addEventListener("DOMContentLoaded", function(){
    	loginFail();
    });
    </script>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="alert alert-secondary" role="alert">
			  회원님의 계정은 신고로 인해 "${memberRestrictDto.user_restrict_end_date}"까지
			  이용이 정지되었습니다.
			</div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>


