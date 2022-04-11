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
        
	        <c:if test="${id==null}">
            <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #2a3339bf;">
	            <a href = "/loginRegister/login"><p class="bannerSub" style="color: white;">
	                로그인
	            </p></a>
            </div>
            <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #4598ace3;">
	            <a href = "/loginRegister/register"><p class="bannerSub" style="color: white;">
                	회원가입
	            </p></a>
            </div>
            </c:if>
            
            <c:if test="${id!=null}">
            <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #2a3339bf;">
	            <a href = "#"><p class="bannerSub" style="color: white;">
	                마이페이지
	            </p></a>
            </div>
            <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #2a3339bf;">
	            <a href = "/loginRegister/logout"><p class="bannerSub" style="color: white;">
                	로그아웃
	            </p></a>
            </div>
            </c:if>
            
        </div>
    </div>
    
    <!-- 메인 시작 -->
	<form id='login' class="container mt-4 mb-4">
		<input type="hidden" name="l" value="loginForm">
		<main id = 'loginbox' class='d-flex col-7' style="flex-direction: column;">

			<div class='d-flex col-10 m-auto' id='typeBox' style="place-content: center; height: 60%; transition-duration: 0.5s;">
				<label class='d-flex chooseBox col-4' for="mentor" style="height: 230px; margin: auto;">
					<img alt="" src="/image/mentor.png" class="m-auto mt-4" style="width: 75px;">
					<span style="height: 28px;">멘토로 회원가입하기</span>
					<input type="radio" id="mentor" name="answer" value='mentor' style="margin: auto;">
				</label>
				<label class='d-flex chooseBox col-4' for="menti" style="height: 230px; margin: auto;">
					<img alt="" src="/image/student.png" class="m-auto mt-4" style="width: 75px;">
					<span style="height: 28px;">멘티로 회원가입하기</span>
					<input type="radio" id="menti" name="answer" value="menti" style="margin: auto;">
				</label>
			</div>
						
			<div id='idbox' class="col-10 d-flex container" style="flex-direction: column; place-content: center;">
				
				<div class="col-12">
					<div class="input-group mb-3">
						<label for="nickname" class="col-3">닉네임</label><input id='nickname' value="test" name = 'nickname' type="text" class="form-control" placeholder="닉네임을 입력해주세요" aria-label="Recipient's nickname" aria-describedby="button-addon2" required="required">
						<button id = 'dupButton' class="btn btn-outline-dark" type="button" onclick='return checkNickname();' >중복확인</button>
					</div>
					<div class="input-group mb-3">
						<label for="profile_image" class="col-3">대표사진</label><input id='profile_image' name = 'profile_image' type="file" class="form-control" aria-label="Recipient's profile" aria-describedby="button-addon2">
					</div>
					<div class="input-group mb-3">
						<label for="id" class="col-3">아이디</label><input id='id' value="admin" name = 'id' type="text" class="form-control" placeholder="아이디를 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2" required="required">
						<button id = 'dupButton' class="btn btn-outline-dark" type="button" onclick='return checkId();' >중복확인</button>
					</div>
					<div class="input-group mb-3">
						<label for="password" class="col-3">비밀번호</label><input id='password' value="1234" name = 'password' type="password" class="form-control" placeholder="비밀번호를 입력해주세요" aria-label="Recipient's password" aria-describedby="button-addon2" required="required">
					</div>
					<div class="input-group mb-3">
						<label for="password" class="col-3">비밀번호 재입력</label><input id='password2' value="1234" name = 'password2' type="password" class="form-control" placeholder="동일한 비밀번호를 입력해주세요" aria-label="Recipient's password" aria-describedby="button-addon2" required="required">
					</div>
					<div class="input-group mb-3">
						<label for="password" class="col-3">이메일</label><input id='email' value="whdghtpgml@gmail.com" name="email" type="email" class="form-control" placeholder="이메일을 입력해주세요" aria-label="Recipient's email" aria-describedby="button-addon2" required="required">
					</div>
					
					<div class = 'buttonBox'>
						<div class = "d-flex col-7 mb-2" style="margin: auto;">
							<a class="btn btn btn-dark" id='registerA' href="javascript:webRegister()" style="height: 45px; width: 100%">
							<span style="vertical-align: -webkit-baseline-middle;">회원가입</span>
							</a>			
						</div>
						<div class = "d-flex col-7 mb-2" style="margin: auto; border-radius: 5px; justify-content: space-around; background-color: #fee500;">
						    <a id="custom-login-btn" href="javascript:registerWithKakao()">
							  	<img
							    src="/image/kakao_login_large.png"
							    width="90px"
							    alt="카카오 로그인 버튼"/>
								</a>	
						</div>
						<div class="text-center" style="font-size: 13px;">
							<div class="mt-2 mb-2">이미 회원이신가요?</div>
							<a id='reghref' href="/loginRegister/login" style="color: #0d6efd !important;">로그인 하러 가기</a>
						</div>
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