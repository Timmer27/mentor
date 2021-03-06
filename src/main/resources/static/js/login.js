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
	//체크된 값이 없어서 null일 시 알람 반환
	if($('input[name=answer]:checked').val() == null){
		alert('멘토, 멘티 로그인 형식을 선택해주세요')
		return;
	}

	var userType = $('input[name=answer]:checked').val();
	window.Kakao.Auth.login({
		success: function() {
			window.Kakao.API.request({ // 사용자 정보 가져오기 
				url: '/v2/user/me',
				success: function(res){
					var formData = new FormData();
					
					formData.append("id", res.id)
					formData.append("nickname", res.properties.nickname)
					formData.append("profile_image", res.properties.profile_image)
					formData.append("email", res.kakao_account.email)
					formData.append("gender", res.kakao_account.gender)
					formData.append("userType", userType)

					$.ajax({
						data: formData,
						dataType: 'text',
						url: '/loginRegister/login',
						caches: false,
						method: 'post',
						processData: false,
						contentType: false, 
						success:function(res){
							if(res){
								sessionStorage.setItem("id", formData.id);
								location.href="/main"
							}
							else{
								alert('회원가입을 먼저 해주세요');
								location.href="/loginRegister/register"
							}
						},
						error:function(request, error){
							console.log(request.responseText + "  " + error);
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

//웹 로그인
function weblogin(){
	
	//체크된 값이 없어서 null일 시 알람 반환
	if($('input[name=answer]:checked').val() == null){
		alert('멘토, 멘티 로그인 형식을 선택해주세요')
		return;
	}

	var formData = new FormData();
	
	formData.append("userType", $('input[name=answer]:checked').val());
	formData.append("id", $('#id').val());
	formData.append("password", $('#password').val());
	
	$.ajax({
		data: formData,
		dataType: 'json',
		method: 'post',
		caches: false,
		processData: false,
		contentType: false, 
		url:'/loginRegister/webLogin',
		success:function(res){
			if(res.result){
				sessionStorage.setItem("id", formData.id);
				location.href="/main"
			}
			else{
				alert('아이디/비밀번호가 틀립니다.');
				return false;
			}
		},
		error:function(request){
			console.log(request.responseText)
		}
	});
	return false;
}

//구글 로그인 - init을 실행시켜서 onSignin 메서드를 동작시키고 프로필 정보를 받아옴
function init() {

	gapi.load('auth2', function() {		
		gapi.auth2.init();
		options = new gapi.auth2.SigninOptionsBuilder();
		options.setPrompt('select_account');
        // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
        // 인스턴스의 함수 호출 - element에 로그인 기능 추가
        // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
		gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
	})
}

//구글 로그인
function onSignIn(googleUser) {
	
	
	//체크된 값이 없어서 null일 시 알람 반환
	if($('input[name=answer]:checked').val() == null){
		alert('멘토, 멘티 로그인 형식을 선택해주세요')
		return;
	}
	
	var userType = $('input[name=answer]:checked').val();
	var access_token = googleUser.getAuthResponse().access_token

	$.ajax({
    	// people api를 이용하여 프로필 및 생년월일에 대한 선택동의후 가져온다.
		url: 'https://people.googleapis.com/v1/people/me'
        // key에 자신의 API 키를 넣습니다.
		, data: {personFields:'birthdays', key:'AIzaSyAAjQ4Hu6mgu0Xo9L_KHluxlmoC39k-weI', 'access_token': access_token}
		, method:'GET'
	})
	.done(function(e){
        //프로필을 가져온다.
		var profile = googleUser.getBasicProfile();
		
		//ajax로 서버와 로그인 연동
		var formData = new FormData();
		formData.append("id", profile.FW);
		formData.append("profile_image", profile.eN);
		formData.append("nickname", profile.tf);
		formData.append("email", profile.tv);
		formData.append("userType", userType)
		
/*		console.log(profile.FW) //아이디
		console.log(profile.tf) //풀네임
		console.log(profile.tv) //이메일
		console.log(profile.eN) //프로필 사진 */
		
		$.ajax({
			data: formData,
			dataType:'json',
			url:'/loginRegister/Googlelogin',
			method:'post',
			caches: false,
			processData: false,
			contentType: false, 
			success:function(res){
				if(res.result){
					sessionStorage.setItem("id", formData.id);					
					location.href="/main"
				}
				else{
					alert('회원가입을 먼저 해주세요');
					location.href="/loginRegister/register"
				}
			},
			error:function(request, error){
				console.log(request.responseText + "  " + error);
			}
		});
	})
	.fail(function(e){
		alert('구글 로그인 실패');
		console.log(e);
	})
}

function onSignInFailure(t){		
	console.log(t);
}

/*//회원가입 가입 종류에 따른 display 변경
document.querySelector('#mentor').addEventListener('click', function(){
	document.getElementById('idbox').style.visibility = "visible";
	document.getElementById('idbox').style.maxHeight = "600px";
	
	document.getElementsByClassName('chooseBox')[0].style.height = "150px";
	document.getElementsByClassName('chooseBox')[1].style.height = "150px";

	document.getElementById('typeBox').style.height = "25%";
})

//회원가입 가입 종류에 따른 display 변경 - 양식맞춰 변경할 것
document.querySelector('#menti').addEventListener('click', function(){
	document.getElementById('idbox').style.visibility = "visible";
	document.getElementById('idbox').style.maxHeight = "600px";
	
	document.getElementsByClassName('chooseBox')[0].style.height = "150px";
	document.getElementsByClassName('chooseBox')[1].style.height = "150px";

	document.getElementById('typeBox').style.height = "25%";
})*/



    
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



