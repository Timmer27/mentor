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
<link rel="stylesheet" href="/css/mypage.css">
<link rel="stylesheet" href="/css/roommateMypage.css">
<link rel="stylesheet" href="/css/roommateInfo.css?<%=System.currentTimeMillis()%>">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- mapBox -->
<link href='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.css' rel='stylesheet' />

<!-- 아울 캐러셀 불러오기, 제이쿼리 보다 밑에 있어야 합니다. -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.theme.default.min.css">

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
    <div class="" style="height: 80rem; background-color: #dcdcdc57;">
		
		<main class="d-flex col-8 m-auto" style="height: 100%">
			<div class="col-3 d-flex flex-column m-auto" style="height: 63rem;">
				<div class="col-12">
					<div class="col-12 d-flex flex-column infoBox">
						<div style="height: 240px; margin: auto;">
							<img alt="" src="${profile_image}" id="profile" width="180px" height="180px" style="">
						</div>
						<div class="text-center">
							<div style="margin-bottom: 10px">
								<span class="text-center nickname">${nickName}</span><span>님 안녕하세요!</span>
							</div>
							<button class="btn btn-dark profileButton" id='profileButton' type="button">사진 변경</button>
							<div>
								<span style="margin-right: 5px;">변경 후</span>
								<a href="javascript:changeProfilePic()" style="text-decoration: underline; color: #318dff;">적용</a>
								<span style="margin-left: 5px;">을 눌러주세요</span>
							</div>
							<input type="file" id='profilePic' name="profilePic"  accept="image/jpeg, image/png, image/jpg" style="visibility: hidden;">
						
						</div>
					</div>
				</div>
				
				<div class="col-12">
					<div class="col-12 d-flex flex-column">
						<div class="infoBox modifyInfo">
							<a href="/main/mypage${userType}" id="modifyB">멘토링</a>
						</div>
						<div class="infoBox modifyInfo">
							<a href="/roommate/myRoommate" id="modifyB">마이 룸메이트</a>
						</div>
						<div class="infoBox modifyInfo">
							<a href="javascript:slideinputs()" id="modifyA">개인정보 변경하기</a>
						</div>
						<form id='modifyInfo' style="display: none" class="infoBox inputBox" onsubmit="return modifyInfo()">
							<div class="inputText">
								현재 비밀번호
								<input class="modifyInput" type="password" id='currentPW' name='currentPW' placeholder="변경할 비밀번호를 입력하세요" required="required">
							</div>
							<div class="inputText">
								비밀번호
								<input class="modifyInput" type="password" id='password' name='password' placeholder="변경할 비밀번호를 입력하세요"  required="required">
							</div>
							<div class="inputText">
								비밀번호 재입력
								<input class="modifyInput" type="password" id='password2' name='password2' placeholder="변경할 비밀번호를 재입력하세요"  required="required">
							</div>
							<div class="inputText">
								닉네임
								<input class="modifyInput"  type="text" name='nickname' value="${nickName}" placeholder="변경할 닉네임을 입력하세요[Optional]">
							</div>
							<div class="inputText">
								이메일 주소
								<input class="modifyInput"  type="email" name='email' value="${modifyInfo.email}" placeholder="변경할 이메일 주소를 입력하세요[Optional]" style="font-size: 13px;">
							</div>
							<div class="inputText">
								나라
								<input class="modifyInput"  type="text" name='country' value="${modifyInfo.country}"  placeholder="변경할 나라를 입력하세요[Optional]">
							</div>
							<div class="inputText">
								도시
								<input class="modifyInput"  type="text" name='city' value="${modifyInfo.city}"  placeholder="변경할 도시를 입력하세요[Optional]">
							</div>
							<div class="text-center mt-3">
								<button class="btn btn-dark" type="submit" name='modify' style="width: 65px; height: 36px;">변경</button>
							</div>
						</form>
						
					</div>
				</div>			
			</div>			
			
			<div class="col-8 m-auto mx-4" style="border: 2px solid #13131380;">
				<div style="background-color: #5e5e5e;">
					<a href="javascript:history.back()">
					<img alt="" src="/image/backwhite.png" width="70px" style="margin-left: 10px; padding: 7px;">
					</a>
				</div>	
				<div style="height: 56rem; overflow: auto" id="a_tags">
					<div class="col-12" id="msg_box">
						<div class="col-12 d-flex flex-column" >
						
						<span style="visibility: hidden;" id="boardNum">${boardNum}</span>
							
								<c:forEach var="chathistory" items="${chathistory}">
								<c:set var="userChat" value="${chathistory.sendUserNum}${chathistory.sendUserType}" />
									<c:if test="${userTest!=userChat}">
										<div id="toClone">						
											<div class="d-flex col-11">
												<div class="d-flex col-2 pic" style="justify-content: end; width: 13%;">
													<div class="picBox" style="height: 50px; width: 50px">
														<img alt="/image/user.png" src="/upload/${chathistory.sendProfile}" class="col-2 chatprofile">
													</div>
												</div>
												<div class="d-flex chat col-8 pt-2 pb-2" style="width: 52%;">
													<div class="d-flex flex-column chat_log col-10">
														<div class="chatContent">
															${chathistory.textContent}
															<span id="sendUserType" style="visibility: hidden;">${chathistory.sendUserType}</span>
															<span id="sendUserNum" style="visibility: hidden;">${chathistory.sendUserNum}</span>
														</div>
													</div>
												</div>
											</div>
											<div class="chatDate date_box col-10 text-end" id="date_box" style="width: 61%;">
												${chathistory.textDate}
											</div>
										</div>
									</c:if>
									<c:if test="${userTest==userChat}">
										<div id="toClonetwo">						
											<div class="d-flex col-12 sendBox" style="">
												<div class="d-flex chat col-7 pt-2 pb-2" style="width: 52%;">
													<div class="d-flex flex-column chat_log col-10">
														<div class="chatContent">
															${chathistory.textContent}
														</div>
													</div>
												</div>
												<div class="d-flex col-1 picsend" style="width: 13%;">
													<div class="picBox" style="height: 50px; width: 50px">
														<img alt="/image/user.png" src="/upload/${chathistory.sendProfile}" class="col-2 chatprofile">
													</div>
												</div>
											</div>
											<div class="chatDatesend col-12" >
										 		<div class="date_box" style="width: 76%;">
													${chathistory.textDate}
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							<!-- 채팅창 박스 -->		
							</div>			
						</div>			
					</div>			
				
					<!-- 인풋 박스 -->		
				<div class="d-flex" style="height: 100%; width: 100%;">
					<div style="height: 4rem; width: 100%;">
						<div class="d-flex" style="height: 100%;">
							<textarea class="col-10" type="text" id='textContent' name='textContent' onkeypress="enterkey()" style="border: 1px solid #afafaf;"></textarea>
							<button class="sendButton" id="sendButton" onclick="return sendChat()" >전송</button>
						</div>
					</div>	
				</div>	
				
			</div>			
		</main>
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
    
<script src="/js/mypage.js?<%=System.currentTimeMillis()%>>"></script>
<script src="/js/roommatemypage.js?<%=System.currentTimeMillis()%>>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>