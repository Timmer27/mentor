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
					<li><a class="dropdown-item" href="#">마이페이지</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="/loginRegister/logout">로그아웃</a></li>
					<li><div id="pointshow" class="dropdown-item">보유 포인트 : <span style="color: red;">${currentPoint}</span> </div></li>
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
				<a href='/main/board'>
					<div class="text-center categoriText">룸메이트</div>
				</a>
			</div>
			<div class='col-2 text-center'>
				<a href='/main/rommate'>
					<div class="text-center categoriText">유학정보</div>
				</a>	
			</div>
			<div class='col-2 text-center'>
				<a href='/main/univInfo'>
					<div class="text-center categoriText">자유게시판</div>
				</a>
			</div>
        </div>
            
    </div>    
	
	<hr>
	
	<!-- searchBox  -->
	<div class="m-auto pt-4" style="width:30%;">
		<p class="text-center">
			<img alt="검색" src="/image/search.png" width="20px" height="20px">
			키워드로 검색하세요!		
		</p>
		<!-- search button -->
		<form class="col-12 mb-3 input-groups" method="post" action="/menti/search">
			<div class="input-group mb-3">
				<input id='search' name='seacrh' type="search" class="form-control" min="2" placeholder="키워드를 입력해주세요" aria-label="Recipient's nickname" aria-describedby="button-addon2">
				<button id="searchButton" class="btn btn-outline-dark" type="submit" onclick="return searchInfo();">검색</button>
			</div>				
		</form>
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
    
    <!-- States -->	
	<div class="contentBox">
		<p class="questionHedder col-9" style="border-bottom: 1px solid #41414157;">미국</p>
		<c:if test="${usaBoard[0].boardTitle==null}">	
			<div class='m-auto d-flex flex-column noBoardBox' style="height: 30rem; justify-content: center;">
				<div class="noBoard">
					아직 보여드릴 게시글이 없어요 :(
				</div>
				<div class="noBoardimg">
					<img alt="Sorry..." src="/image/shocked.png" width="130px" height="130px">
				</div>
			</div>
		</c:if>
		
		<c:if test="${usaBoard[0].boardTitle!=null}">
		<div class='col-9 d-flex flex-column countries'>
			<a class="col-9 seeAll"  href="#">전체보기</a>
			<div class="d-flex flex-column col-9 semiBox">
				<c:forEach items="${usaBoard}" var="list">
					
					<a class="d-flex col-12 mb-2 content contentselect flex-column" href="/menti/mentiboard?num=${list.num}">
						
						<div class="col-12 d-flex textTitle">
							<div>${list.country}</div>
							<span style="padding: 0px 10px 0px 10px;">|</span>
							<div>${list.city}</div>
						</div>
						<div class="col-12 d-flex textmain">
						<div class="col-2" style="padding-left: 5px;">${list.boardDate}</div>
							<div class="col-7">
								${list.boardTitle}
							</div>
						<!-- 포인트 테스트 -->
						<c:if test="${list.boardPoint=='0'}">
							<div class="col-2">
								<span>🧡</span><span style="padding-left: 10px;">point</span>
							</div>
						</c:if>
						<c:if test="${list.boardPoint!='0'}">
							<div class="col-2">
								<span>${list.boardPoint} point</span>
							</div>
						</c:if>
						
						<!-- 프로필 테스트 -->
		            	<c:if test="${fn:contains(list.profile_image, 'http')}">
							<div class="col-1">
								<img src="${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
							</div>
						</c:if>
	 	            	<c:if test="${list.profile_image!=null}">
			            	<c:if test="${list.profile_image!='0'}">
			            		<c:if test="${not fn:contains(list.profile_image, 'http')}">
									<div class="col-1">
										<img src="/upload/${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
									</div>
								</c:if>
							</c:if>
			            	<c:if test="${list.profile_image=='0'}">
								<div class="col-1">
									<img src="/image/user.png" alt="프로필 " width="50" height="50" class="rounded-circle">
								</div>
							</c:if>
						</c:if>
						
						<div class="replyBox">
							<span>
							<img class="heartImogi" alt="하트" src="/image/heart.png" width="20px" height="20px">
							</span> <span class="replyText">3</span> 
							<span class="replyImogi">
							<img class="chatImogi" alt="답글" src="/image/texting.png" width="24px" height="27px">
							</span> <span class="replyText">5</span>
						</div>
						</div>
					
					</a>
		
				</c:forEach>
				
			</div>
		</div>
	</c:if>
	</div>
	<!-- CA -->
	<div class="contentBox">
		<p class="questionHedder col-9" style="border-bottom: 1px solid #41414157;">캐나다</p>
		<c:if test="${caBoard[0].boardTitle==null}">	
			<div class='m-auto d-flex flex-column noBoardBox' style="height: 30rem; justify-content: center;">
				<div class="noBoard">
					아직 보여드릴 게시글이 없어요 :(
				</div>
				<div class="noBoardimg">
					<img alt="Sorry..." src="/image/shocked.png" width="130px" height="130px">
				</div>
			</div>
		</c:if>
		
		<c:if test="${caBoard[0].boardTitle!=null}">
		<div class='col-9 d-flex flex-column countries'>
			<a class="col-9 seeAll"  href="#">전체보기</a>
			<div class="d-flex flex-column col-9 semiBox">
			<c:forEach items="${caBoard}" var="list">
			
				<a class="d-flex col-12 mb-2 content contentselect flex-column" href="/menti/mentiboard?num=${list.num}">
						
						<div class="col-12 d-flex textTitle">
							<div>${list.country}</div>
							<span style="padding: 0px 10px 0px 10px;">|</span>
							<div>${list.city}</div>
						</div>
						<div class="col-12 d-flex textmain">
						<div class="col-2" style="padding-left: 5px;">${list.boardDate}</div>
							<div class="col-7">
								${list.boardTitle}
							</div>
						<!-- 포인트 테스트 -->
						<c:if test="${list.boardPoint=='0'}">
							<div class="col-2">
								<span>🧡</span><span style="padding-left: 10px;">point</span>
							</div>
						</c:if>
						<c:if test="${list.boardPoint!='0'}">
							<div class="col-2">
								<span>${list.boardPoint} point</span>
							</div>
						</c:if>
						
						<!-- 프로필 테스트 -->
		            	<c:if test="${fn:contains(list.profile_image, 'http')}">
							<div class="col-1">
								<img src="${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
							</div>
						</c:if>
	 	            	<c:if test="${list.profile_image!=null}">
			            	<c:if test="${list.profile_image!='0'}">
			            		<c:if test="${not fn:contains(list.profile_image, 'http')}">
									<div class="col-1">
										<img src="/upload/${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
									</div>
								</c:if>
							</c:if>
			            	<c:if test="${list.profile_image=='0'}">
								<div class="col-1">
									<img src="/image/user.png" alt="프로필 " width="50" height="50" class="rounded-circle">
								</div>
							</c:if>
						</c:if>
						
						<div class="replyBox">
							<span>
							<img class="heartImogi" alt="하트" src="/image/heart.png" width="20px" height="20px">
							</span> <span class="replyText">3</span> 
							<span class="replyImogi">
							<img class="chatImogi" alt="답글" src="/image/texting.png" width="24px" height="27px">
							</span> <span class="replyText">5</span>
						</div>
						</div>
					
					</a>
		
				</c:forEach>
				
			</div>
		</div>
	</c:if>
	</div>
	
	<!-- EU  -->
	<div class="contentBox">
		<p class="questionHedder col-9" style="border-bottom: 1px solid #41414157;">유럽</p>
		<c:if test="${eurBoard[0].boardTitle==null}">	
			<div class='m-auto d-flex flex-column noBoardBox' style="height: 30rem; justify-content: center;">
				<div class="noBoard">
					아직 보여드릴 게시글이 없어요 :(
				</div>
				<div class="noBoardimg">
					<img alt="Sorry..." src="/image/shocked.png" width="130px" height="130px">
				</div>
			</div>
		</c:if>
		
		<c:if test="${eurBoard[0].boardTitle!=null}">
		<div class='col-9 d-flex flex-column countries'>
			<a class="col-9 seeAll"  href="#">전체보기</a>
			<div class="d-flex flex-column col-9 semiBox">
			<c:forEach items="${eurBoard}" var="list">
				
				<a class="d-flex col-12 mb-2 content contentselect flex-column" href="/menti/mentiboard?num=${list.num}">
						
						<div class="col-12 d-flex textTitle">
							<div>${list.country}</div>
							<span style="padding: 0px 10px 0px 10px;">|</span>
							<div>${list.city}</div>
						</div>
						<div class="col-12 d-flex textmain">
						<div class="col-2" style="padding-left: 5px;">${list.boardDate}</div>
							<div class="col-7">
								${list.boardTitle}
							</div>
						<!-- 포인트 테스트 -->
						<c:if test="${list.boardPoint=='0'}">
							<div class="col-2">
								<span>🧡</span><span style="padding-left: 10px;">point</span>
							</div>
						</c:if>
						<c:if test="${list.boardPoint!='0'}">
							<div class="col-2">
								<span>${list.boardPoint} point</span>
							</div>
						</c:if>
						
						<!-- 프로필 테스트 -->
		            	<c:if test="${fn:contains(list.profile_image, 'http')}">
							<div class="col-1">
								<img src="${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
							</div>
						</c:if>
	 	            	<c:if test="${list.profile_image!=null}">
			            	<c:if test="${list.profile_image!='0'}">
			            		<c:if test="${not fn:contains(list.profile_image, 'http')}">
									<div class="col-1">
										<img src="/upload/${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
									</div>
								</c:if>
							</c:if>
			            	<c:if test="${list.profile_image=='0'}">
								<div class="col-1">
									<img src="/image/user.png" alt="프로필 " width="50" height="50" class="rounded-circle">
								</div>
							</c:if>
						</c:if>
						
						<div class="replyBox">
							<span>
							<img class="heartImogi" alt="하트" src="/image/heart.png" width="20px" height="20px">
							</span> <span class="replyText">3</span> 
							<span class="replyImogi">
							<img class="chatImogi" alt="답글" src="/image/texting.png" width="24px" height="27px">
							</span> <span class="replyText">5</span>
						</div>
						</div>
					
					</a>
		
				</c:forEach>
				
			</div>
		</div>
	</c:if>
	</div>
	
	
	<!-- JP -->	
	<div class="contentBox">
		<p class="questionHedder col-9" style="border-bottom: 1px solid #41414157;">일본</p>
		<c:if test="${jpBoard[0].boardTitle==null}">	
			<div class='m-auto d-flex flex-column noBoardBox' style="height: 30rem; justify-content: center;">
				<div class="noBoard">
					아직 보여드릴 게시글이 없어요 :(
				</div>
				<div class="noBoardimg">
					<img alt="Sorry..." src="/image/shocked.png" width="130px" height="130px">
				</div>
			</div>
		</c:if>
		
		<c:if test="${jpBoard[0].boardTitle!=null}">
		<div class='col-9 d-flex flex-column countries'>
			<a class="col-9 seeAll"  href="#">전체보기</a>
			<div class="d-flex flex-column col-9 semiBox">
			<c:forEach items="${jpBoard}" var="list">
			
				<a class="d-flex col-12 mb-2 content contentselect flex-column" href="/menti/mentiboard?num=${list.num}">
						
						<div class="col-12 d-flex textTitle">
							<div>${list.country}</div>
							<span style="padding: 0px 10px 0px 10px;">|</span>
							<div>${list.city}</div>
						</div>
						<div class="col-12 d-flex textmain">
						<div class="col-2" style="padding-left: 5px;">${list.boardDate}</div>
							<div class="col-7">
								${list.boardTitle}
							</div>
						<!-- 포인트 테스트 -->
						<c:if test="${list.boardPoint=='0'}">
							<div class="col-2">
								<span>🧡</span><span style="padding-left: 10px;">point</span>
							</div>
						</c:if>
						<c:if test="${list.boardPoint!='0'}">
							<div class="col-2">
								<span>${list.boardPoint} point</span>
							</div>
						</c:if>
						
						<!-- 프로필 테스트 -->
		            	<c:if test="${fn:contains(list.profile_image, 'http')}">
							<div class="col-1">
								<img src="${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
							</div>
						</c:if>
	 	            	<c:if test="${list.profile_image!=null}">
			            	<c:if test="${list.profile_image!='0'}">
			            		<c:if test="${not fn:contains(list.profile_image, 'http')}">
									<div class="col-1">
										<img src="/upload/${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
									</div>
								</c:if>
							</c:if>
			            	<c:if test="${list.profile_image=='0'}">
								<div class="col-1">
									<img src="/image/user.png" alt="프로필 " width="50" height="50" class="rounded-circle">
								</div>
							</c:if>
						</c:if>
						
						<div class="replyBox">
							<span>
							<img class="heartImogi" alt="하트" src="/image/heart.png" width="20px" height="20px">
							</span> <span class="replyText">3</span> 
							<span class="replyImogi">
							<img class="chatImogi" alt="답글" src="/image/texting.png" width="24px" height="27px">
							</span> <span class="replyText">5</span>
						</div>
						</div>
					
					</a>
		
				</c:forEach>
				
			</div>
		</div>
	</c:if>
	</div>
	
	<!-- CN -->
	<div class="contentBox">
		<p class="questionHedder col-9" style="border-bottom: 1px solid #41414157;">중국</p>
		<c:if test="${cnBoard[0].boardTitle==null}">	
			<div class='m-auto d-flex flex-column noBoardBox' style="height: 30rem; justify-content: center;">
				<div class="noBoard">
					아직 보여드릴 게시글이 없어요 :(
				</div>
				<div class="noBoardimg">
					<img alt="Sorry..." src="/image/shocked.png" width="130px" height="130px">
				</div>
			</div>
		</c:if>
		
		<c:if test="${cnBoard[0].boardTitle!=null}">
		<div class='col-9 d-flex flex-column countries'>
			<a class="col-9 seeAll"  href="#">전체보기</a>
			<div class="d-flex flex-column col-9 semiBox">
			<c:forEach items="${cnBoard}" var="list">
				
				<a class="d-flex col-12 mb-2 content contentselect flex-column" href="/menti/mentiboard?num=${list.num}">
						
						<div class="col-12 d-flex textTitle">
							<div>${list.country}</div>
							<span style="padding: 0px 10px 0px 10px;">|</span>
							<div>${list.city}</div>
						</div>
						<div class="col-12 d-flex textmain">
						<div class="col-2" style="padding-left: 5px;">${list.boardDate}</div>
							<div class="col-7">
								${list.boardTitle}
							</div>
						<!-- 포인트 테스트 -->
						<c:if test="${list.boardPoint=='0'}">
							<div class="col-2">
								<span>🧡</span><span style="padding-left: 10px;">point</span>
							</div>
						</c:if>
						<c:if test="${list.boardPoint!='0'}">
							<div class="col-2">
								<span>${list.boardPoint} point</span>
							</div>
						</c:if>
						
						<!-- 프로필 테스트 -->
		            	<c:if test="${fn:contains(list.profile_image, 'http')}">
							<div class="col-1">
								<img src="${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
							</div>
						</c:if>
	 	            	<c:if test="${list.profile_image!=null}">
			            	<c:if test="${list.profile_image!='0'}">
			            		<c:if test="${not fn:contains(list.profile_image, 'http')}">
									<div class="col-1">
										<img src="/upload/${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
									</div>
								</c:if>
							</c:if>
			            	<c:if test="${list.profile_image=='0'}">
								<div class="col-1">
									<img src="/image/user.png" alt="프로필 " width="50" height="50" class="rounded-circle">
								</div>
							</c:if>
						</c:if>
						
						<div class="replyBox">
							<span>
							<img class="heartImogi" alt="하트" src="/image/heart.png" width="20px" height="20px">
							</span> <span class="replyText">3</span> 
							<span class="replyImogi">
							<img class="chatImogi" alt="답글" src="/image/texting.png" width="24px" height="27px">
							</span> <span class="replyText">5</span>
						</div>
						</div>
					
					</a>
		
				</c:forEach>
				
			</div>
		</div>
	</c:if>
	</div>
	
	<!-- AP -->	
	<div class="contentBox">
		<p class="questionHedder col-9" style="border-bottom: 1px solid #41414157;">동남아</p>
		<c:if test="${apBoard[0].boardTitle==null}">	
			<div class='m-auto d-flex flex-column noBoardBox' style="height: 30rem; justify-content: center;">
				<div class="noBoard">
					아직 보여드릴 게시글이 없어요 :(
				</div>
				<div class="noBoardimg">
					<img alt="Sorry..." src="/image/shocked.png" width="130px" height="130px">
				</div>
			</div>
		</c:if>
		
		<c:if test="${apBoard[0].boardTitle!=null}">
		<div class='col-9 d-flex flex-column countries'>
			<a class="col-9 seeAll"  href="#">전체보기</a>
			<div class="d-flex flex-column col-9 semiBox">
			<c:forEach items="${apBoard}" var="list">
				
				<a class="d-flex col-12 mb-2 content contentselect flex-column" href="/menti/mentiboard?num=${list.num}">
						
						<div class="col-12 d-flex textTitle">
							<div>${list.country}</div>
							<span style="padding: 0px 10px 0px 10px;">|</span>
							<div>${list.city}</div>
						</div>
						<div class="col-12 d-flex textmain">
						<div class="col-2" style="padding-left: 5px;">${list.boardDate}</div>
							<div class="col-7">
								${list.boardTitle}
							</div>
						<!-- 포인트 테스트 -->
						<c:if test="${list.boardPoint=='0'}">
							<div class="col-2">
								<span>🧡</span><span style="padding-left: 10px;">point</span>
							</div>
						</c:if>
						<c:if test="${list.boardPoint!='0'}">
							<div class="col-2">
								<span>${list.boardPoint} point</span>
							</div>
						</c:if>
						
						<!-- 프로필 테스트 -->
		            	<c:if test="${fn:contains(list.profile_image, 'http')}">
							<div class="col-1">
								<img src="${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
							</div>
						</c:if>
	 	            	<c:if test="${list.profile_image!=null}">
			            	<c:if test="${list.profile_image!='0'}">
			            		<c:if test="${not fn:contains(list.profile_image, 'http')}">
									<div class="col-1">
										<img src="/upload/${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
									</div>
								</c:if>
							</c:if>
			            	<c:if test="${list.profile_image=='0'}">
								<div class="col-1">
									<img src="/image/user.png" alt="프로필 " width="50" height="50" class="rounded-circle">
								</div>
							</c:if>
						</c:if>
						
						<div class="replyBox">
							<span>
							<img class="heartImogi" alt="하트" src="/image/heart.png" width="20px" height="20px">
							</span> <span class="replyText">3</span> 
							<span class="replyImogi">
							<img class="chatImogi" alt="답글" src="/image/texting.png" width="24px" height="27px">
							</span> <span class="replyText">5</span>
						</div>
						</div>
					
					</a>
		
				</c:forEach>
				
			</div>
		</div>
	</c:if>
	</div>
	
	<!-- Middle East -->
	<div class="contentBox">
		<p class="questionHedder col-9" style="border-bottom: 1px solid #41414157;">중동</p>
		<c:if test="${meBoard[0].boardTitle==null}">	
			<div class='m-auto d-flex flex-column noBoardBox' style="height: 30rem; justify-content: center;">
				<div class="noBoard">
					아직 보여드릴 게시글이 없어요 :(
				</div>
				<div class="noBoardimg">
					<img alt="Sorry..." src="/image/shocked.png" width="130px" height="130px">
				</div>
			</div>
		</c:if>
		
		<c:if test="${meBoard[0].boardTitle!=null}">
		<div class='col-9 d-flex flex-column countries'>
			<a class="col-9 seeAll"  href="#">전체보기</a>
			<div class="d-flex flex-column col-9 semiBox">
			<c:forEach items="${meBoard}" var="list">
				
				<a class="d-flex col-12 mb-2 content contentselect flex-column" href="/menti/mentiboard?num=${list.num}">
						
						<div class="col-12 d-flex textTitle">
							<div>${list.country}</div>
							<span style="padding: 0px 10px 0px 10px;">|</span>
							<div>${list.city}</div>
						</div>
						<div class="col-12 d-flex textmain">
						<div class="col-2" style="padding-left: 5px;">${list.boardDate}</div>
							<div class="col-7">
								${list.boardTitle}
							</div>
						<!-- 포인트 테스트 -->
						<c:if test="${list.boardPoint=='0'}">
							<div class="col-2">
								<span>🧡</span><span style="padding-left: 10px;">point</span>
							</div>
						</c:if>
						<c:if test="${list.boardPoint!='0'}">
							<div class="col-2">
								<span>${list.boardPoint} point</span>
							</div>
						</c:if>
						
						<!-- 프로필 테스트 -->
		            	<c:if test="${fn:contains(list.profile_image, 'http')}">
							<div class="col-1">
								<img src="${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
							</div>
						</c:if>
	 	            	<c:if test="${list.profile_image!=null}">
			            	<c:if test="${list.profile_image!='0'}">
			            		<c:if test="${not fn:contains(list.profile_image, 'http')}">
									<div class="col-1">
										<img src="/upload/${list.profile_image}" alt="프로필 " width="50" height="50" class="rounded-circle">
									</div>
								</c:if>
							</c:if>
			            	<c:if test="${list.profile_image=='0'}">
								<div class="col-1">
									<img src="/image/user.png" alt="프로필 " width="50" height="50" class="rounded-circle">
								</div>
							</c:if>
						</c:if>
						
						<div class="replyBox">
							<span>
							<img class="heartImogi" alt="하트" src="/image/heart.png" width="20px" height="20px">
							</span> <span class="replyText">3</span> 
							<span class="replyImogi">
							<img class="chatImogi" alt="답글" src="/image/texting.png" width="24px" height="27px">
							</span> <span class="replyText">5</span>
						</div>
						</div>
					
					</a>
		
				</c:forEach>
				
			</div>
		</div>
	</c:if>
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