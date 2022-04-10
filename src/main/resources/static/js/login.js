// 카카오톡 API 사용하기 위한 초기화 단계
Kakao.init('fd09236192d5711c591370f1b856f03e');
// console.log(Kakao.isInitialized()); //사용자 정보 초기화 테스트 - 성공 시 true, 실패 시 init안 JS코드 재확인

// token validate 시 바로 메인으로 이동
// window.addEventListener('load', function(){
// 	if(Kakao.Auth.getAccessToken){
// 		this.location.href = "/main"
// 	}
// })

//선택에 따른 classAdd효과 - 멘토
document.querySelector('#mentor').addEventListener('click', function(){
	var boxes = document.getElementsByClassName('chooseBox');
	boxes[0].classList.add('selectedBox');
	boxes[1].classList.remove('selectedBox');
})

//선택에 따른 classAdd효과 - 멘티
document.querySelector('#menti').addEventListener('click', function(){
	var boxes = document.getElementsByClassName('chooseBox');
	
	boxes[1].classList.add('selectedBox');
	boxes[0].classList.remove('selectedBox');
})

// 카카오톡 로그인
function loginWithKakao() {
	window.Kakao.Auth.login({
		success: function() {
			window.Kakao.API.request({ // 사용자 정보 가져오기 
				url: '/v2/user/me',
				success: function(res){
					$.ajax({
						data: res,
						url: '/loginRegister/login',
						caches: false,
						method: 'post',
						success:function(){
							location.href="/main"
						}
					});
				}
			});
		},
		fail: function() {
			alert('카카오톡 로그인이 실패했습니다')
			location.href="/main"
		}
	});
}
    
	// 카톡 로그아웃, 홈페이지 세션 별도 종료 필요	  
	function kakaoLogout() {
		if (!Kakao.Auth.getAccessToken()) {
			alert('Not logged in.')
			return
		}
		Kakao.Auth.logout(function() {
			alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken())
		})
	}    



