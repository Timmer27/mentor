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
document.querySelector('#replyContent').addEventListener('keyup', function(){
	let textarea = document.querySelector('#replyContent');
    let height = textarea.scrollHeight; // 높이
    
    if(height>47){
	    textarea.style.height = `${height + 6}px`;
		//mainarea.style.height = `${mainheight + 15}px`;
	    //화면도 자동 이동
	    //scrollTo(0,`${height - 550}`)
	}
})

//댓글달기 슬라이드 토글 js
$('#writeAnswer').click(function(){
	
	if(sessionStorage.getItem("id")==null){
		alert('로그인을 먼저 해주세요');
		return;
	}
	
	$('#replyBox').slideToggle();
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