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
<link rel="stylesheet" href="/css/questionBoard.css?<%=System.currentTimeMillis()%>">
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
					<li><div id="pointshow" class="dropdown-item">명예 포인트 : <span style="color: red;">${currentRepPoint}</span> </div></li>					
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
	<div class="contentBox">
		<div class="col-9 m-auto mt-4 questionBox">
			<div class="d-flex regionInfo">
				<div>
					${list.country},
				</div>
				<div>
					${list.city}
				</div>
			</div>
			
			<div class="d-flex col-12 titleBox">
				<div class="col-1" style="margin: 0rem 1.2rem 0rem 2rem;">
					<img alt="Q" src="/image/question.png" width="66px" height="66px">
				</div>
				<div>
					${list.boardTitle} 
				</div>
			</div>
			
			<div class="col-12 boardContentBox" >
				<div style="margin-bottom: 4rem;">
					${list.boardContent}
				</div>
				
				<!-- 첨부파일 삽입 -->
				<div class="imageattachBox">첨부파일</div>
					<div class="d-flex" style="margin: 30px 0px 20px 0px;">
						<c:forEach var="filelist" items="${fileList}">
							<img alt="files" src="${filelist}" width="200px" height="200px">
						</c:forEach>
					</div>
				
				<div class="text-center col-12 m-auto likeBox">
					<a href="#">
						<div id='imageBox' style="margin: 8px 0px 8px 0px;">
							<img alt="like" src="/image/heart.png" width="22px" height="22px">
						</div>
						<div class="mb-2 likeText" style="font-size: 14px;">
							좋아요
						</div>
						<div id='test'></div>
					</a>
				</div>
				<div class="d-flex subContent">
					<div>
						조회수 <span style="margin-left: 5px">30</span>
					</div>
					<div>	
						${list.boardDate}
					</div>
					<div>
						<a href="javascript:void(0)" class="reporthref">
							<span id='report'>신고하기</span>
							<img alt="report" src="/image/report.png" width="21px" height="21px"
							style="padding-left: 3px; padding-bottom: 3px; margin-bottom: -1px;"
							>
						</a>
					</div>
				</div>
				
		    </div>
	    </div>
	    
	    <hr>
	    
	    <c:if test="${list.boardPoint == 0}">
			<div class="contentBox">
				<div class="">
					<div class="col-9 m-auto mt-4 noticeBanner text-center d-flex">
			    		<span class="col-10">이 글에 답해주시면 채택여부에 관계없이 여러분들의 명성 포인트가 올라갑니다 :)</span>
						<button class="col-1" type="button" name='writeAnswer' id='writeAnswer' class="btn">작성하기</button>
				    </div>
			    </div>
		    </div>
	    </c:if>
	    
	    <c:if test="${list.boardPoint != 0}">
			<div class="contentBox">
				<div class="">
					<div class="col-9 m-auto mt-4 noticeBanner text-center d-flex">
			    		<span class="col-10">이 글을 통해 채택된 분에게 ${list.boardPoint} 포인트를 드립니다 :)</span>
						<button class="col-1" type="button" name='writeAnswer' id='writeAnswer' class="btn">작성하기</button>
				    </div>
			    </div>
		    </div>
	    </c:if>
	    
	    <!-- 댓글 입력창 -->
		<form class="contentBox" id='contentBox' onsubmit="return replyPost();">
			<div class="contentBox">
		    	
		    	<div class="col-9 m-auto mt-4 replyBox" id='replyBox' style="display: none">
					<div class="d-flex mentorTitle">
				    	<div style="margin-left: 20px; margin-right: 20px;">
				    	
				    	<c:if test="${profile_image=='/image/upload/0'}">
				    		<img alt="" src="/image/user.png" class="rounded-circle" width="56px" height="56px">
				    	</c:if>
				    	<c:if test="${profile_image!='/image/upload/0'}">
				    		<img alt="" src="${profile_image}" class="rounded-circle" width="56px" height="56px">
				    	</c:if>
				    	
				    	</div>
				    	<div class="d-flex flex-column" style="width: 50%;">
					    	<div class="">
					    		${nickName}
					    	</div>
					    	<div class="d-flex subProfile">
					    		<span>순위</span>
					    		<span>[102]</span>
					    		<span>|</span>
					    		<span>답변 채택 수</span>
					    		<span>3개</span>
					    		<span>|</span>
					    		<span>채택율</span>
					    		<span>30%</span>
					    	</div>
				    	</div>
		    		</div>
		    		
					<div class="m-auto" style="padding: 22px;">
			    		<textarea class="replyContent" id="replyContent" name="replyContent" maxlength="2000" placeholder="답변을 입력해주세요"></textarea>
				    </div>
				    
				    <hr>
				   	<div class="d-flex">
			    		<span style="font-size: 12px; padding-left: 10px; color: gray; width: 87%">
				    		최대 2000자까지 입력 가능합니다.
			    		</span>
			    		<button class="btn btn-dark" type="submit" name='replyAnswer' style="height: 33px;">저장</button>
				    </div>
		    		<input style="visibility: hidden;" name = "mentiNum" type="text" value ="${list.userNum}">
		    		<input style="visibility: hidden;" name = "boardNum" type="text" value ="${list.num}">
		    		<input style="visibility: hidden;" name = "id" type="text" value ="${id}">
			    </div>
		    </div>
	    </form>
	    
<!-- 댓글 숫자 검사 후 재삽입 예정  -->	    
<!-- 		<div class="contentBox">
			<div class="contentBox">
				<div class="col-9 m-auto" style="padding-top: 60px; text-align: center;">
					<img alt="loading" src="/image/loading.png" width="30px" height="30px">
				</div>
				<div class="col-9 m-auto noneBox">
			    	아직까지 작성된 답변이 없습니다. 첫번째 주인공이 되어보세요!
	    		</div>
		    </div>
	    </div> -->
	    
	    <!-- 댓글 목록 -->
		<div class="contentBox">
			<div class="contentBox">
		    	<div class="" style="width: 75%; margin: auto; padding-top: 40px;">
		    		<img alt="" src="/image/qa.png" class="" width="70px" height="70px">
		    	</div>
		    	
		    	
		    	<c:forEach items="${replyList}" var="list">
					<div class="contentBox">
						<div class="contentBox">
					    	
					    	<div class="col-9 m-auto mt-4 replyBox">
								<div class="d-flex mentorTitle">
								
							    	<c:if test="${profile_image=='/image/upload/0'}">
							    		<img alt="" src="/image/user.png" class="rounded-circle" width="56px" height="56px">
							    	</c:if>
							    	<c:if test="${profile_image!='/image/upload/0'}">
							    		<img alt="" src="${list.profile_image}" class="rounded-circle" width="56px" height="56px">
							    	</c:if>
								    	<div class="d-flex flex-column" style="width: 50%;">
									    	<div class="">
									    		${list.nickname}
									    	</div>
									    	<div class="d-flex subProfile">
									    		<span>순위</span>
									    		<span>[102]</span>
									    		<span>|</span>
									    		<span>답변 채택 수</span>
									    		<span>3개</span>
									    		<span>|</span>
									    		<span>채택율</span>
									    		<span>30%</span>
									    	</div>
								    	</div>
						    		</div>
						    		
									<div class="m-auto" style="height: auto; padding: 22px;">
										${list.mentorreplyContent}
								    </div>
								    
						    		<div class="d-flex subContent" style="width: 20%;">
						    			<span style="padding-left: 10px">작성일자</span> ${list.replyDate}
					    			</div>
								    
								    <hr>
						    		<span style="font-size: 12px; padding-left: 10px; color: gray;">
						    		</span>
							    </div>
						    </div>
					    </div>
				    </c:forEach>
				    
			    </div>
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

    
<script src="/js/mentoring.js?<%=System.currentTimeMillis()%>>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>