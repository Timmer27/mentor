<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/login.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<title>멘톨</title>
</head>
<body>
<!-- top -->
    <div class = "d-flex container" style=''>
        <div class='col-lg-1'>
           <a href="/main"><img src="/image/logo.png" alt="" style='width: 75px; margin-left: 15px;'></a>
        </div>
        <div class = "d-flex col-lg-6" style="color: #000000ab;">
            <div class = "col-lg-2 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                멘토해주기
	            </p></a>
            </div>      
            <div class = "col-lg-2 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                멘티받기
	            </p></a>
            </div>      
            <div class = "col-lg-2 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                멘톨후기
	            </p></a>
            </div>      
            <div class = "col-lg-2 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                사용방법
	            </p></a>
            </div>      
        </div>
        <div class="d-flex col-lg-5 lgBox" style="place-content: end;">
            <div class="col-lg-2 bann_box mx-1 lgBox" style="background-color: #2a3339bf;">
	            <a href="/login"><p class="bannerSub" style="color: white;">
	                로그인
	            </p></a>
            </div>
            <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #4598ace3;">
	            <a href = "/register"><p class="bannerSub" style="color: white;">
                	회원가입
	            </p></a>
            </div>
        </div>
    </div>
    
    <!-- 메인 시작 -->
	<form id='login' class="container mt-4 mb-4" onsubmit='return tryLogin();'>
		<input type="hidden" name="l" value="loginForm">
		<main id = 'loginbox' class='d-flex col-7'>

			<div class='d-flex col-5' style="flex-direction: column; place-content: center;">
				<label class='d-flex chooseBox' for="mentor">
					<img alt="" src="/image/mentor.png" class="m-auto mt-4" style="width: 75px;">
					<span style="height: 28px;">멘토로 로그인하기</span>
					<input type="radio" id="mentor" name="answer" value='mentor' style="margin: auto;">
				</label>
				<label class='d-flex chooseBox' for="menti" style="pointer">
					<img alt="" src="/image/student.png" class="m-auto mt-4" style="width: 75px;">
					<span style="height: 28px;">멘티로 로그인하기</span>
					<input type="radio" id="menti" name="answer" value="menti" style="margin: auto;">
				</label>
			</div>
						
			<div id='idbox' class="col-8 d-flex" style="flex-direction: column; place-content: center;">
				
				<h3 class="mb-4 text-center ">회원가입</h3>
				<div class="input-group mb-3">
					<input id='id' value="admin" name = 'id' type="text" class="form-control" placeholder="아이디를 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2" required="required">
				</div>
				<div class="input-group mb-3">
					<input id='password' value="1234" name="password" type="password" class="form-control" placeholder="비밀번호를 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2" required="required">
				</div>
				
				<div class = 'buttonBox'>
					<div class = "d-flex col-7" style="margin: auto; justify-content: space-evenly;">
						<button type="submit" class="btn btn btn-dark" style="height: 45px; width: 88px">로그인</button>
					    <a id="custom-login-btn" href="javascript:loginWithKakao()">
						  	<img
						    src="/image/kakao_login_large.png"
						    width="90px"
						    alt="카카오 로그인 버튼"/>
						</a>				
					</div>
					<div class="text-center" style="font-size: 13px;">
						<div>아이디가 없으신가요?</div>
						<div id='registerp'><a id='reghref' href="/loginRegister/register" style="color: #0d6efd !important;">회원가입 하러가기</a></div>
					</div>
				</div>
			</div>
			
		</main>
	</form>
    
    <!-- footer -->
    <div class="container">
        <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
            <div class="col-md-4 d-flex align-items-center">
            <a href="/" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
                <svg class="bi" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
            </a>
            <span class="text-muted">멘톨</span>
            </div>
        
            <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
            <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#twitter"/></svg></a></li>
            <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#instagram"/></svg></a></li>
            <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#facebook"/></svg></a></li>
            </ul>
        </footer>
    </div>
    
    <!-- 카카오톡 로그인 API 연동 -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    
    <script src="/js/login.js?<%=System.currentTimeMillis()%>"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>