/*$(document).on('click', '.heartImogi', function(e){
	e.preventDefault();  
	$(this).css('background-color', 'gold');
	$('.heartImogi').not($(this)).css('background-color', '#fff');
})


$('.heartImogi').click(function(e){
	e.preventDefault(); 
//	클릭한 값을 아래의 옵션으로 삽입	
  	$(this).css('background-color', 'gold');
  	
//	클릭한 버튼과 값이 다르다면 또 삽입  	
  	$(this).not($(this)).css('background-color', 'black')
}) */

//textarea 자동 크기 조절
$(document).ready(function(){
	$('textarea').keyup(function(){
		$(this).css("height", "auto");
		$(this).height(this.scrollHeight);
	})
})

//댓글달기 슬라이드 토글 js - 로그인 검사
$('#writeAnswer').click(function(){
	
	$.ajax({
		dataType:'json',
		caches: false,
		method: 'post',
		url:'/loginRegister/idCheck',
		success:function(res){
			if(res.result){
				$('#replyBox').slideToggle();
			}
			else{
				alert('로그인을 먼저 해주세요');
				location.href = "/loginRegister/login"
			}
		},
		error:function(request){
			alert('로그인을 먼저 해주세요');
			location.href = "/loginRegister/login"
		}
	})
})


//검색 기능
function searchInfo(){
//	길이 관련
	var searchData = $('#search').val();
	if(searchData.length < 2){
		alert('최소 두글자 이상 입력해주세요');
		return false;
	}
}

//댓글 포스팅

function replyPost(){
	var d = $('#contentBox').serialize();
	alert(d);
	
	$.ajax({
		data:d,
		dataType:'json',
		caches: false,
		method: 'post',
		url:'/menti/saveReply',
		success:function(res){
			if(res.result){
				location.reload();
			}
			else{
				alert('저장 실패');
			}
		},
		error:function(request){
			console.log(request.responseText);
		}
	})
}
