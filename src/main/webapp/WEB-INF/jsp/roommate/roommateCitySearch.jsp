<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="/css/main.css?<%=System.currentTimeMillis()%>">
<link rel="stylesheet" href="/css/roommateCity.css?<%=System.currentTimeMillis()%>">
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
    <div class = "d-flex" style='border-bottom: 1px solid #6d6d6d1a;'>
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
					
					<c:if test="${userType == 'menti'}">
						<li><a class="dropdown-item" href="/main/mypageMenti">마이페이지</a></li>
					</c:if>
					
					<c:if test="${userType == 'mentor'}">
						<li><a class="dropdown-item" href="/main/mypageMentor">마이페이지</a></li>
					</c:if>
					
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
    <div class='col-10 d-flex mb-2 mt-2 m-auto mainBanner'> 

		<div class="d-flex col-10 mainSub">
			<div class='col-2 text-center'>
				<a href='/main/mentoring'>
					<div class="text-center categoriText">멘토링</div>
				</a>
			</div>
			<div class='col-2 text-center'>
				<a href='/roommate'>
					<div class="text-center categoriText">룸메이트</div>
				</a>
			</div>
			<div class='col-2 text-center'>
				<a href='/univInfo'>
					<div class="text-center categoriText">유학정보</div>
				</a>	
			</div>
			<div class='col-2 text-center'>
				<a href='/board'>
					<div class="text-center categoriText">자유게시판</div>
				</a>
			</div>
        </div>
            
    </div>    
	
	<hr>
	
    <!-- main 시작 -->	

	<!-- 나라, 도시 표출 -->
	<p class="text-center col-11 m-auto regionTitle">
		<a href="/roommate"><img alt="" src="/image/back.png" width="50px" style="margin-right: 10px;"></a>
		<img alt="" src="/image/map.png" width="50px" style="margin-right: 10px;">
		<span>${selectedCountry}, ${cityName}</span>
	</p>
	
	<!-- 룸메 배너 -->
	<div class="col-11 m-auto mt-4 d-flex" style="place-content: center;">
		<div class="col-10 m-auto mt-4 d-flex flex-column">
			<c:forEach var="roommateList" items="${roommateList}">
				<a class="col-9 m-auto mt-4 mb-4 d-flex boardBox" href="/roommate/brl?num=${roommateList.num}">
					<div class="imgBox col-3">
						<img class="cardImg" alt="pic" src="/upload/${roommateList.thumbPic}">
					</div>
					
					<div class="d-flex flex-column col-8" style="">
						<div class="boardTitle">
							<span class="title">
								${roommateList.boardTitle}
							</span>				
							<div class="address">
								<img alt="" src="/image/home-address.png" width="17px">
								${roommateList.address}
							</div>				
						</div>
						
						<div class="infoBox">
							<div class="expenses d-flex">
								<div class="">
									월세 <span class="security">${roommateList.expense}</span>
								</div>
								<div class="seperator">|</div>			
								<div class="">
									보증금 <span class="security">${roommateList.securityDeposit}</span>
								</div>			
							</div>			
		
							<div class="d-flex subInfo col-12">
								<div class="" style="width: 10%;">
									${roommateList.beds} beds
								</div>				
								<div class="" style="width: 10%;">
									${roommateList.bath} bath
								</div>				
								
								<div class="col-4" style="width: 28%;">
									${roommateList.postDate}
								</div>				
								<div class="" style="width: 8%;">
								<img alt="view" src="/image/view.png" width="17px">
									<c:if test="${roommateList.view!=null}">
										<span style="margin: 0px 5px 0px">${roommateList.view}</span>
									</c:if>
									<c:if test="${roommateList.view==null}">
										<span style="margin: 0px 5px 0px">0</span>
									</c:if>
								</div>				
								
								<div style="width: 13%;">
									<span style="margin: 0px 5px 0px">성별:</span> ${roommateList.gender}
								</div>
							</div>
						</div>				
						
					</div>				
				</a>
			</c:forEach>
		</div>
		
		<!-- 검색창, 등록버튼 표출 -->
		<div class="d-flex col-2 text-center" style="margin-top: 4rem;">
			<div class="buttonBox sticky-top shadow">
			<p class="text-center mt-2 pb-2 rmTitle" style="">룸메이트 찾으러가기</p>
			
			<!-- search button -->
				<form class="col-10 mb-3 input-groups m-auto mt-2" method="get" action="/roommate/search">
					<input type="hidden" name="selectedCountry" value="${selectedCountry}">
					<input type="hidden" name="cityName" value="${cityName}">
					<div class="input-group mb-3">
						<input id='search' name='search' type="search" class="form-control" min="2" placeholder="키워드 검색" aria-label="Recipient's nickname" aria-describedby="button-addon2">
						<button id="searchButton" class="btn btn-outline-dark" type="submit">검색</button>
					</div>				
				</form>
				
				<button type="button" class="btn" id="postButton">
					<a href="/roommate/newpost" style="color: white">
						등록하기
					</a>
				</button>
			</div>
		</div>
		
	</div>
						
	<div class="d-flex pageNum col-11 m-auto text-center">
		<c:forEach var="roommateListPageNum" items="${roommateListPageNum}">
			<a class="nums" href="/roommate/${cityName}?selectedCountry=${selectedCountry}&num=${roommateListPageNum}&search=${search}">
				${roommateListPageNum}
			</a>
		</c:forEach>
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
    
<script src="/js/roommate.js?<%=System.currentTimeMillis()%>>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>