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
<link rel="stylesheet" href="/css/register.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<title>멘톨</title>
</head>
<body>
<!-- top -->
    <div class = "d-flex" style='border-bottom: 1px solid #6d6d6d8a;'>
        <div class='col-lg-1' style="padding-left: 12px;">
           <a href="/main"><img src="/image/logo.png" alt="" style='width: 75px; margin-left: 15px;'></a>
        </div>
        <div class = "d-flex col-lg-7" style="color: #000000ab;">
            <div class = "col-lg-1 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                멘토해주기
	            </p></a>
            </div>      
            <div class = "col-lg-1 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                멘티받기
	            </p></a>
            </div>      
            <div class = "col-lg-1 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                멘톨후기
	            </p></a>
            </div>      
            <div class = "col-lg-1 bann_box mx-1">
	            <a href="#"><p class="bannerSub">
	                사용방법
	            </p></a>
            </div>      
        </div>
        <div class="d-flex col-lg-4 lgBox" style="place-content: end; padding-right: 30px;">
        
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
            <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #4598ace3;">
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
	<form id='login' class="container mt-4 mb-4"><!-- onsubmit="return webRegister();" -->
		<main id = 'loginbox' class='d-flex col-7 m-auto' style="flex-direction: column;">
			<div class=text-center style="font-size: 22px;">어떤 분으로 오셨나요?</div>
			<div class='d-flex col-12' id='typeBox'>
				<a class='col-4' href="/loginRegister/mentorRegister" style="height: 230px; margin: auto;">
					<div class="text-center userType shadow" style="">
						<img alt="" src="/image/mentor.png" class="m-auto mt-4" style="width: 90px;">
						<p style="height: 28px; margin: 50px 0px 50px 0px;">멘토로 회원가입하기</p>
					</div>
				</a>
				<a class='col-4' href="/loginRegister/mentiRegister" style="height: 230px; margin: auto;">
					<div class="text-center userType shadow" style="">
						<img alt="" src="/image/student.png" class="m-auto mt-4" style="width: 90px;">
						<p style="height: 28px; margin: 50px 0px 50px 0px;">멘티로 회원가입하기</p>
					</div>
				</a>
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
    
    <script src="/js/register.js?<%=System.currentTimeMillis()%>"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>