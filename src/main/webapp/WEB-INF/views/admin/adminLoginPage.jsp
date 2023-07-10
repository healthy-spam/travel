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
            background-color: #333333; /* 검정색으로 설정 */
            color: #ffffff; /* 흰색으로 설정 */
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
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">관리자 로그인</div>
                <div class="card-body">
                    <form method="POST" action="./adminLoginProcess">
                        <div class="form-group">
                            <label for="admin_userid">아이디</label>
                            <input type="text" class="form-control" id="admin_userid" name="admin_userid" required>
                        </div>
                        <div class="form-group">
                            <label for="admin_pw">비밀번호</label>
                            <input type="password" class="form-control" id="admin_pw" name="admin_pw" required>
                        </div>
                        <button type="submit" class="btn btn-primary">로그인</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>


