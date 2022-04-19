<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- mapBox -->
<link href='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.css' rel='stylesheet' />

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
			<c:if test="${userType == 'mentor'}">
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
			<c:if test="${userType == 'menti'}">
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
	        <!-- search button -->
	        <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
				<input type="search" class="form-control" placeholder="Search..." style="display: inline; width: 70%; margin-right: 6px" aria-label="Search">
		        <button class="btn btn-outline-dark" type="submit">검색</button>
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

	        <!-- profile & login button -->
			<c:if test="${id!=null}">
	            <div class="dropdown text-end">
	            	<c:if test="${profile_image eq '/image/upload/0'}">
						<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle pt-2" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
			            	<img src="/image/user.png" alt="프로필" width="50" height="50" class="rounded-circle">
						</a>
					</c:if>
	            	<c:if test="${profile_image != '/image/upload/0'}">
						<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle pt-2" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
			            	<img src="${profile_image}" alt="프로필" width="50" height="50" class="rounded-circle">
						</a>
					</c:if>
				<ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1" style="min-width: 6rem; font-size: 0.9rem;">
					<li><div style="padding-bottom: 13px; padding-top: 0;" id="pointshow" class="dropdown-item">${nickName}님 환영합니다</div></li>
					<li><a class="dropdown-item" href="#">마이페이지</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="/loginRegister/logout">로그아웃</a></li>
					<li><div id="pointshow" class="dropdown-item">
						<img alt="point" src="/image/gem.png" height="20px" width="20px"/>
					 : <span id='cPoint' style="color: red;">${currentPoint}</span> </div></li>
					<li><div id="pointshow" class="dropdown-item">
						<img alt="명예" src="/image/cube.png" height="20px" width="20px"/>
					 : <span style="color: red;">${currentRepPoint}</span> </div></li>
				</ul>
		  		</c:if>
	        </div>
        </div>
    </div>
    
    <!-- 메인 시작 -->
    <!-- 상단 슬라이딩 배너 -->
    <div class='container d-flex mt-4 mb-4' style='justify-content: space-around;'>
		<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" style="padding: 15px;">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="image/1.png" class="d-block w-100" alt="..." width="710px" height="440px">
<!-- 		      <div class="carousel-caption d-none d-md-block">
		        <h5>First slide label</h5>
		        <p>Some representative placeholder content for the first slide.</p>
		      </div> -->
		    </div>
		    <div class="carousel-item">
		      <img src="image/2.png" class="d-block w-100" alt="..." width="710px" height="440px">
<!-- 		      <div class="carousel-caption d-none d-md-block">
		        <h5>Second slide label</h5>
		        <p>Some representative placeholder content for the second slide.</p>
		      </div> -->
		    </div>
		    <div class="carousel-item">
		      <img src="image/3.png" class="d-block w-100" alt="..." width="710px" height="440px">
<!-- 		      <div class="carousel-caption d-none d-md-block">
		        <h5>Third slide label</h5>
		        <p>Some representative placeholder content for the third slide.</p>
		      </div> -->
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
		
		<!-- 랭킹 배너 -->
        <div class = "col-4 d-flex flex-column rankingBox">
        	<p class="col-12 text-center" style="border-bottom: 1px solid #95959557;">
        		<img src="/image/crown.png" width="40px" height="40px" style="margin: 0px 15px 7px 0px;"><span style="color: #d49103c9; font-weight: bold;">전설의 멘토</span>
        	</p>
			
			<div class= "d-flex col-12">
				
				<div class="col-2 text-center d-flex flex-column">
					
					<div class="col-12" style="margin: 8px 0px 25px 0px;">
						<img alt="fist" src="/image/first.png" width="50px" height="50px">
					</div>
					<div class="col-12" style="margin: 8px 0px 25px 0px;">
						<img alt="second" src="/image/second.png" width="50px" height="50px">
					</div>
					<div class="col-12" style="margin: 8px 0px 25px 0px;;">
						<img alt="thrid" src="/image/third.png" width="50px" height="50px">
					</div>
					<div class="col-12" style="margin: 8px 0px 25px 0px;">
						<img alt="fourth" src="/image/fourth.png" width="40px" height="40px">
					</div>
					
				</div>
			
			
	        	<div class="col-10 text-center ranking" style="align-items: center;">
	        		<c:forEach var="user" items="${userPointRank}">
			            <div class="mx-2 mb-4 pb-2 col-10 d-flex" style="align-items: center; border-bottom: 1px solid #a8a8a83b;">
			            	<c:if test="${fn:contains(user.profile_image, 'http')}">
				            	<div class="col-3">
					            	<img src="${user.profile_image}" alt="profile" width="52px" height="52px" style='border-radius: 50%;'>
				            	</div>
			            	</c:if>
			            	<c:if test="${!fn:contains(user.profile_image, 'http')}">
				            	<div class="col-3">
					            	<img src="/upload/${user.profile_image}" alt="profile" width="52px" height="52px" style='border-radius: 50%;'>
					            </div>
			            	</c:if>
			            	<div class="col-5">
			            		${user.nickname}
		            		</div>
		            		
			            	<div class="col-4 d-flex" style="justify-content: flex-end;">
			            		${user.earnAmount} <img alt="point" src="/image/gem.png" width="20px" height="20px" style="margin-left: 5px">
		            		</div>
		            		
			            </div>
	        		</c:forEach>
	            </div>
	
	
	        </div>
        </div>
    </div>

    <hr>
    
    <div class='container col-9 d-flex mb-2 mt-2' style="height: 120px; flex-direction: column;">

        <div class="d-flex col-9 m-auto" style="align-self: center; height: 100%">
	        <div class='col-3 text-center'>
	        	<a href='/main/mentoring'>
		        	<img alt="멘토링" src="/image/mortarboard.png"
	        		width="68px"
		        	>
		        	<p class="text-center" style="margin-top: 15px;">멘토링</p>
	        	</a>
	        </div>
	        <div class='col-3 text-center'>
   	        	<a href='/main/board'>
	        		<img alt="룸메이트" src="/image/house.png"
 					width="68px"
		        	>
		        	<p class="text-center" style="margin-top: 15px;">룸메이트</p>
					            </a>
	        </div>
	        <div class='col-3 text-center'>
	   			<a href='/main/rommate'>
	        		<img alt="유학정보" src="/image/student2.png" 
	        		width="68px"
		        	>
		        	<p class="text-center" style="margin-top: 15px;">유학정보</p>
				</a>	
	        </div>
	        <div class='col-3 text-center'>
				<a href='/main/univInfo'>
	        	<img alt="자유게시판" src="/image/board.png"
					width="68px"
		        	>
		        	<p class="text-center" style="margin-top: 15px;">자유게시판</p>
	            </a>
	        </div>
        </div>
            
    </div>    

    <!-- 후기 및 고민방 -->
    <hr>
    	
    <!-- 중단 활통 status -->
    <div class='container d-flex mb-2' style="height: auto; flex-direction: column;">

        <div class="d-flex col-10 mb-4" style="align-self: center; border-bottom: 1px solid #41414129;">
	        <div class='questionHedder col-lg-8'>
	            가입자 수
	        </div>
	       	<div class="col-2 d-flex flex-column" style="justify-content: space-around;">
		        <div class='col-lg-12'>
		           	활동 회원님들
		        </div>
		        <div class='col-lg-12'>
		            멘토님들
		        </div>
		        <div class='col-lg-12'>
		            해결된 고민
		        </div>
	       	</div>
	       	<div class="col-2 d-flex flex-column text-center" style="justify-content: space-around;">
		        
		        <c:forEach var="list" items="${userCount}">
			        <div class='col-lg-12'>
			           	${list} 명	
			        </div>
		        </c:forEach>
		        <div class='col-lg-12'>
		           	tmp
		        </div>
		        
	       	</div>
        </div>
        	
    </div>
       	
   	<!-- 지도 -->
    <div class='container d-flex' style="height: 30rem; justify-content: center;">
        <div id="map" class='col-10' style="margin-top: 14px; border-radius: 8px;">
        </div>
   	</div>

   	<p class="questionHedder col-9">오늘의 고민</p>
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
<script src='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.js'></script>   
    
<script src="/js/main.js?<%=System.currentTimeMillis()%>>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>