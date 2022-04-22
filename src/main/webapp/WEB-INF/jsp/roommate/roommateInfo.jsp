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
<link rel="stylesheet" href="/css/roommateInfo.css?<%=System.currentTimeMillis()%>">
<link rel="stylesheet" href="/css/mentor.css?<%=System.currentTimeMillis()%>">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- mapBox -->
<meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no">
<link href="https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.css" rel="stylesheet">
<script src="https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.js"></script>

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
    <main class="col-8 m-auto">
    
	    <div class="boardTitle col-11 mt-4 m-auto">
	    	
	    	<a href="javascript:history.back()" style="margin-bottom: 5px; margin-right: 10px;">
	    		<img alt="back" src="/image/back.png" style="width: 40px;">
    		</a>
	    		
	    		<span class="boldText">[제목]</span>
	    			${roommateInfo.boardTitle}
	    		<span id="boardNum" style="visibility: hidden">${boardNum}</span>
	    </div>
    
    <hr>
  
		<div class="col-12 d-flex flex-column">
		
		    <!-- thumb pics 배너 -->
			<!-- Container for the image gallery -->
	    	<c:if test="${filecheck!='none'}">
			<div class="col-11 m-auto imgBox">
			
				<!-- Full-width images with number text -->
				<c:forEach var="files" items="${files}">
					<div class="mySlides">
						<img class="imgContent" src="/upload/${files}" style="width:100%; height: 100%">
					</div>
				</c:forEach>

				
				<!-- Next and previous buttons -->
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
				<a class="next" onclick="plusSlides(1)">&#10095;</a>
				
				<!-- Image text -->
<!-- 				<div class="caption-container">
					<p id="caption"></p>
				</div> -->
				
				<!-- Thumbnail images -->
				<div class="row col-12 m-auto d-flex mt-2" style="height: 6rem; justify-content: space-between;;">
				<c:forEach var="files" items="${files}" varStatus="status">
					<div class="column">
						<img class="demo cursor imgContent" src="/upload/${files}"
						style="width:100%; height: 100%" onclick="currentSlide(<c:out value="${status.count}"/>)" alt="pic">
					</div>
				</c:forEach>
				</div>
			</div>
		    <!-- thumb pics 배너 끝 -->
			</c:if>
			
			<c:if test="${filecheck=='none'}">
			<div class="col-11 m-auto">
			</div>
			</c:if>
			
			<hr>
			<!-- 디테일 시작 -->
			<div class="col-11 m-auto mt-4 d-flex detailBox">
				<div class="col-8 detail d-flex d-column flex-column">
					<p class="col-11 contentTitle">
						상세 정보
					</p>
					<div class="col-11 contentInfo">
					${roommateInfo.boardContent}
					</div>
				</div>
				
				<div class="sticky-top contact" style="width:30%; height: fit-content;">
					<div class="col-11 m-auto" style="font-size: 20px;">
						<div class="col-12 seperator">
						
							<p class="col-12 px-1" style="font-weight: bold;">
								${roommateInfo.country}
							</p>
							<div class="mb-2" style="font-size: 16px">
								<img alt="address" src="/image/home-address.png" width="18px">
								<span id="cityName">${roommateInfo.city}</span>
							</div>

						</div>
					</div>
						
					<div class="col-11 m-auto mt-4 mb-4 d-flex prices">
						<div class="col-9 px-2">
							<span style="font-weight: bold; color: #022f6c;">
								${roommateInfo.expense}
								<span>$</span>
							</span>
						<span style="font-size: 17px; align-self: end; color: #6e6e6ed1; font-style: oblique;">
							per Month
						</span>
						</div>
					</div>
					<div class="col-11 m-auto seperator text-center" style="padding-bottom: 20px;">
						<button class="col-5 btn btn-primary" id='contactPerson'>
							연락하기
						</button>
						
							<c:if test="${like==0}">
								<button id="likeBox" type="button" onclick="return likePost();" class="col-3 btn btn-outline-danger likeButton">
									<img alt="❤" src="/image/heart.png" width="40%">
								</button>
							
								<button id="likedBox" type="button" onclick="return likePostRevert();" class="col-3 btn btn-outline-danger likeButton" style="display: none">
									<img alt="❤" src="/image/heartcolored.png" width="40%">
								</button>
							</c:if>
							
							<c:if test="${like>0}">
								<button id="likeBox" type="button" onclick="return likePost();" class="col-3 btn btn-outline-danger likeButton" style="display: none">
									<img alt="❤" src="/image/heart.png" width="40%">
								</button>
							
								<button id="likedBox" type="button" onclick="return likePostRevert();" class="col-3 btn btn-outline-danger likeButton">
									<img alt="❤" src="/image/heartcolored.png" width="40%">
								</button>
							</c:if>

						<div id="personaInfo" class="col-11 m-auto mt-4" style="display: none">
							<div class="col-12 d-flex mb-2" style="place-content: center;">
								<div class="col-1">
									<img alt="phone" src="/image/phone.png" style="width:22px;">							
								</div>
								<div class="col-11">
									<span>${roommateInfo.phone}</span>
								</div>
							</div>
							<div class="col-12 d-flex mb-2" style="place-content: center;">
								<div class="col-1">
									<img class="col-1" alt="email" src="/image/email.png" style="width:22px;">							
								</div>
								<div class="col-11" style="font-size: 13px; align-self: center;">
									<a id="emailLink" href="mailto:${roommateInfo.email}">${roommateInfo.email}</a>
								</div>								
							</div>
						</div>
					</div>
					<div class="col-11 px-1 m-auto mt-4 mb-4 d-flex flex-column seperator subinfoBox">
						<div class="col-12 d-flex" style="padding-bottom: 10px;">
							<div class="col-6">
								<span class="boldText">보증금</span>	
								<span class="values">${roommateInfo.securityDeposit}</span>
							</div>
							<div class="col-6">
								<span class="boldText">성별</span>	
								<span class="values">${roommateInfo.gender}</span>
							</div>
						</div>
						<div class="col-12 d-flex seperator" style="padding-bottom: 10px;">
							<div class="col-6">
								<span class="boldText">beds</span>
								<span class="values">${roommateInfo.beds}</span>
								<img alt="beds" src="/image/bed.png" width="20px" style="margin-bottom: 3px; margin-left: 6px">
							</div>
							<div class="col-6">
								<span class="boldText">bath</span>
								<span class="values">${roommateInfo.bath}</span>
								<img alt="beds" src="/image/bath.png" width="20px" style="margin-bottom: 3px; margin-left: 6px">
							</div>
						</div>
						
						<div class="col-12 boldText" style="margin: 20px 0px 7px 0px;">
							기타
						</div>
						<c:if test="${roommateInfo.condition==null}">
							<span>
								조건 없음
							</span>
						</c:if>
						<c:if test="${roommateInfo.condition!=null}">
							<span>
								${roommateInfo.condition}
							</span>
						</c:if>
					</div>
				</div>
			</div>
			
			<hr>
			
			<p class="col-11 m-auto">
				<span class="contentTitle">위치 검색</span>
			</p>
			<!-- mapBox -->
			<div id="map" class="mt-4 col-11 m-auto mapBox">
				<!-- map -->
			</div>
			
		</div>

    </main>
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
<!-- Load the `mapbox-gl-geocoder` plugin. -->
<script src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v5.0.0/mapbox-gl-geocoder.min.js"></script>
<link rel="stylesheet" href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v5.0.0/mapbox-gl-geocoder.css" type="text/css">

<script src="/js/roommate.js?<%=System.currentTimeMillis()%>>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>