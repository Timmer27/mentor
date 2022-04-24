// 상단 carousel 실행
$('.roommateSub').owlCarousel({
    responsive:{
        0:{
            items:3
        }
    },
    margin:40,
    loop:false,
    dots:true,
    nav:true,
    navText:
    	['<img src="/image/left-arrows.png" style="width: 21px; margin: 0px 6px; cursor: pointer;">',
    	
    	'<img src="/image/two-arrows.png" style="width: 21px; margin: 0px 6px; cursor: pointer;">'],
    navContainer: '#owlCaraouselContainer',
});
/*
//클릭 인덱스를 구해서 특정 slideToggle 실행
$('.msg_link').click(function() {
    var index=$(this).index();
        $('.toggleChat').eq(index/2).slideToggle();//use the slide animation
});
*/

//채팅보내기
function sendChat(){
	var chat = $('#textContent').val();
	var boardNum = $('#boardNum').text();
	var sendUserType = $('#sendUserType').text();
	var sendUserNum = $('#sendUserNum').text();

	//개행문자 처리
	var boardSpace = chat.replace(/\n/g, "<br/>")
	var boardSpace = chat.replace('?', '?')
	
	$.ajax({
		dataType:'json',
		caches:false,
		method:'post',
		url:'/roommate/chatSend?boardNum=' + boardNum + '&chat=' + boardSpace + '&sendUserType=' + sendUserType + '&sendUserNum=' + sendUserNum,
		success:function(res){
		
			//요소 복사
			$('#toClonetwo').clone().appendTo('#msg_box')
			var c = document.getElementsByClassName('chatContent');
			var classNum = c.length;
			
			//넣은 값을 마지막 클래스 인덱스에 넣어서 채팅창처럼 보이게 함
			$('.sendBox').css("visibility", "visible")
			
			document.getElementsByClassName('chatContent')[classNum-1].innerHTML = res.textContent
			document.getElementsByClassName('date_box')[classNum-1].innerHTML = res.textDate

			//채팅창 하단에 고정						
			$('#a_tags').scrollTop($('#msg_box')[0].scrollHeight)
			
			//챗 보내고 박스 초기화
			var button = document.getElementById("textContent");
			button.value="";
		
		},
		error:function(request){
			console.log(request.responseText);
		}
	})
	return false;
}


function enterkey() {
    // 엔터키 누를 경우 서버로 메시지 전송
    var keyCode = event.keyCode || event.which;
    // 크로스 브라우저 이벤트 호환목적 ||
    if (keyCode == 13) {
		sendChat()
    }
}