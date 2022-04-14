<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="/css/main.css?<%=System.currentTimeMillis()%>">
<link rel="stylesheet" href="/css/mentor.css?<%=System.currentTimeMillis()%>">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- mapBox -->

<title>멘톨 - 해외멘토링</title>
</head>
<body>
<!-- top -->
    <div class = "d-flex" style='border-bottom: 1px solid #6d6d6d8a;'>
        <div class='col-lg-1' style="padding-left: 12px;">
			<a href="/main"><img src="/image/logo.png" alt="" style='width: 75px; margin-left: 15px;'></a>
        </div>
        <div class = "d-flex col-lg-7" style="color: #000000ab;">
			<c:if test="${userType==null}">
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
			</c:if>            
			<c:if test="${userType eq 'mentor'}">
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						멘토하기
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
			</c:if>
			<c:if test="${userType eq 'menti'}">
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						질문하기
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
			</c:if>
        </div>
        <div class="d-flex col-lg-4 lgBox" style="place-content: end; padding-right: 30px; align-items: center;">
	        <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" style="width: 60%;">
				<input type="search" class="form-control" placeholder="Search..." aria-label="Search">
	        </form>
		
	        <c:if test="${id==null}">
	        
	        <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #2a3339bf;">
				<a href = "/loginRegister/login"><p class="bannerSub" style="color: white;">
				로그인
				</a>
	        </div>
	        <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #4598ace3;">
				<a href = "/loginRegister/register"><p class="bannerSub" style="color: white;">
				회원가입
				</a>
	        </div>
	        
			</c:if>

			<c:if test="${id!=null}">
	            <div class="dropdown text-end">
	            	<c:if test="${profile_image eq '/image/upload/0'}">
						<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
			            	<img src="/image/user.png" alt="프로필" width="50" height="50" class="rounded-circle">
						</a>
					</c:if>
	            	<c:if test="${profile_image != '/image/upload/0'}">
						<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
			            	<img src="${profile_image}" alt="프로필" width="50" height="50" class="rounded-circle">
						</a>
					</c:if>
				<ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1" style="min-width: 6rem;">
					<li><a class="dropdown-item" href="#">마이페이지</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="/loginRegister/logout">로그아웃</a></li>
				</ul>
		  		</c:if>
	        </div>
        </div>
    </div>
    
    <!-- 메인 시작 -->
    <!-- 상단 슬라이딩 배너 -->
    <div class='col-12 d-flex mb-2 mt-2 mainBanner'> 

		<div class="d-flex col-10 mainSub">
			<div class='col-2 text-center'>
				<a href='/main/mentoring'>
					<img alt="멘토링" src="/image/mortarboard.png"
					width="50px"
					>
					<div class="text-center categoriText">멘토링</div>
				</a>
			</div>
			<div class='col-2 text-center'>
				<a href='/main/board'>
					<img alt="룸메이트" src="/image/house.png"
					width="50px"
					>
					<div class="text-center categoriText">룸메이트</div>
				</a>
			</div>
			<div class='col-2 text-center'>
				<a href='/main/rommate'>
					<img alt="유학정보" src="/image/student2.png" 
					width="50px"
					>
					<div class="text-center categoriText">유학정보</div>
				</a>	
			</div>
			<div class='col-2 text-center'>
				<a href='/main/univInfo'>
				<img alt="자유게시판" src="/image/board.png"
					width="50px"
					>
					<div class="text-center categoriText">자유게시판</div>
				</a>
			</div>
        </div>
            
    </div>    
	
	<!-- 질문 쓰기 -->
	<c:if test="${userType eq 'menti'}">
		<div class="questionBox">
			<div class="mx-2">
				<a href="/menti/newpost"><button class="btn btn-light" style="background-color: #e8c4a391;"><img src="/image/edit-text.png" width="30px" height="30px" style="margin-right: 8px;">질문하기</button></a>
			</div>
			<div class="mx-2">
				<a href="#" ><button class="btn btn-light" style=" height: 44px; width: 120px; background-color: #3d2d6221;">마이멘톨</button></a>
			</div>
		</div>
	</c:if>

    <!-- 질문 board -->
    	
	<div class="contentBox">
	<p class="questionHedder col-9">미국</p>
	<div class='col-9 d-flex flex-column countries'>
		<a class="col-9 seeAll"  href="#">전체보기</a>
		<div class="d-flex flex-column col-9" style="padding: 16px; align-self: center;">
			<div class="d-flex col-12 mb-2 content">
				<div class="col-2">2022-04-13</div>
				<div class="col-7">
					오늘 운동을 뭘해야 할까요...?	
				</div>
				<div class="col-2">
					<span>100 point</span>
				</div>
				<div class="col-1">
					<img src="https://github.com/mdo.png" alt="프로필 " width="50" height="50" class="rounded-circle">
				</div>
			</div>
			<div class="d-flex col-12 mb-2 content">
				<div class="col-2">2022-04-13</div>
				<div class="col-7">
					오늘 운동을 뭘해야 할까요...?	
				</div>
				<div class="col-2">
					<span>100 point</span>
				</div>
				<div class="col-1">
					<img src="https://github.com/mdo.png" alt="프로필 " width="50" height="50" class="rounded-circle">
				</div>
			</div>
			<div class="d-flex col-12 mb-2 content">
				<div class="col-2">2022-04-13</div>
				<div class="col-7">
					오늘 운동을 뭘해야 할까요...?	
				</div>
				<div class="col-2">
					<span>100 point</span>
				</div>
				<div class="col-1">
					<img src="https://github.com/mdo.png" alt="프로필 " width="50" height="50" class="rounded-circle">
				</div>
			</div>
			<div class="d-flex col-12 mb-2 content">
				<div class="col-2">2022-04-13</div>
				<div class="col-7">
					오늘 운동을 뭘해야 할까요...?	
				</div>
				<div class="col-2">
					<span>100 point</span>
				</div>
				<div class="col-1">
					<img src="https://github.com/mdo.png" alt="프로필 " width="50" height="50" class="rounded-circle">
				</div>
			</div>
<!-- 			<div class="d-flex col-12 mb-2" style="    height: 5rem;
    border-bottom: 1px solid #c7c7c7;
    padding: 4px 5px 5px 20px;
    align-items: center;">
				<div class="col-2">2022-04-13</div>
				<div class="col-7">
					오늘 운동을 뭘해야 할까요...?	
				</div>
				<div class="col-2">
					<span>100 point</span>
				</div>
				<div class="col-1">
					<img src="https://github.com/mdo.png" alt="프로필 " width="50" height="50" class="rounded-circle">
				</div>
			</div> -->
			
		</div>
	</div>
	<p class="questionHedder col-9">캐나다</p>
	<div class='container d-flex' style="height: 30rem; justify-content: center;">
		
	</div>
	<p class="questionHedder col-9">유럽</p>
	<div class='container d-flex' style="height: 30rem; justify-content: center;">
		
	</div>
	<p class="questionHedder col-9">일본</p>
	<div class='container d-flex' style="height: 30rem; justify-content: center;">
		
	</div>
	<p class="questionHedder col-9">중국</p>
	<div class='container d-flex' style="height: 30rem; justify-content: center;">
		
	</div>
	<p class="questionHedder col-9">동남아</p>
	<div class='container d-flex' style="height: 30rem; justify-content: center;">
		
	</div>

	<p class="questionHedder col-9">중동</p>
	<div class='d-flex col-10 mt-4' style="height: 25rem; justify-content: space-evenly; margin: auto">
            
			<a class="col-4 questionBox" href="#">
				<div class="questionCard">
					<div class="card-title">미국, California | 거주문제</div>
					<div class="profileImage col-12 d-flex flex-column">
						<div class="questionTitle">운동 진로</div>
						<div class="questionContent">내용 : 운동을 어떻게 해야할 지 고민입니다... 사레레할까요 벤치들까요?</div>
						<div class="col-6 profileInfo">
							<span style="padding-right: 11px;">100 point</span>
							<img alt="profile pic" src="/image/logo.jpg" class="questionProfileLogo">
						</div>
					</div>
				</div>
			</a>
			<a class="col-4 questionBox" href="#">
				<div class="questionCard">
					<h5 class="card-title">2022.04.12</h5>
					
					<div class="profileImage col-12 d-flex flex-column">
						<div class="questionTitle">질문 제목</div>
						<div class="questionContent">내용 : 운동을 어떻게 해야할 지 고민입니다... 사레레할까요 벤치들까요?</div>
						<div class="col-6 profileInfo">
							<span>100 point</span>
							<img alt="profile pic" src="/image/logo.jpg" class="questionProfileLogo">
						</div>
					</div>
				</div>
			</a>
    </div>            
    </div>            
        
<!--         <div class='col-lg-12 d-flex' style="height: 25em; justify-content: center;">
            <div class='col-lg-3 col-md-3 col-sm-3 mt-4 mb-2 mx-2'>
            	<img class="card-img-top" src="/image/test.jpg" alt="">
            	<div class="card-body">
            		<h5 class="card-title">Card title</h5>
            		<p class="card-text">
            			This is a wider card with supporting text below
            		</p>
            	</div>
            </div>
            <div class='col-lg-3 col-md-3 col-sm-3 mt-4 mb-2 mx-2'>
            	<img class="card-img-top" src="/image/test.jpg" alt="">
            	<div class="card-body">
            		<h5 class="card-title">Card title</h5>
            		<p class="card-text">
            			This is a wider card with supporting text below
            		</p>
            	</div>
            </div>
            <div class='col-lg-3 col-md-3 col-sm-3 mt-4 mb-2 mx-2'>
            	<img class="card-img-top" src="/image/test.jpg" alt="">
            	<div class="card-body">
            		<h5 class="card-title">Card title</h5>
            		<p class="card-text">
            			This is a wider card with supporting text below
            		</p>
            	</div>
            </div>
        </div> -->
        

<!--     후기 및 고민방
            <div class='col-lg-3 col-md-3 col-sm-3 mt-4 mb-2 mx-2'>
            	<img class="card-img-top" src="/image/test.jpg" alt="">
            	<div class="card-body">
            		<h5 class="card-title">Card title</h5>
            		<p class="card-text">
            			This is a wider card with supporting text below
            		</p>
            	</div>
            </div>

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

<!-- mapBox -->
<!-- <script src='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.js'></script>    -->
    
<script src="/js/mentoring.js?<%=System.currentTimeMillis()%>>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>