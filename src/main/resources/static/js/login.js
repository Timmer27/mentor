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
	console.log(userType);
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
					
					console.log(formData);

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
		dataType: 'text',
		method: 'post',
		caches: false,
		processData: false,
		contentType: false, 
		url:'/loginRegister/webLogin',
		success:function(res){
			if(res){
				location.href="/main"
			}
			else{
				alert('등록된 아이디가 없습니다');
				location.href="/loginRegister/register"
			}
		}
	});
}


//회원가입 가입 종류에 따른 display 변경
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
})


var nickDup = false;
var idDup = false;

//중복확인 후 값 변경 시 false
document.querySelector('#nickname').addEventListener('change', function(){
	nickDup = false;
})
document.querySelector('#id').addEventListener('change', function(){
	idDup = false;
})

//아이디 중복확인
function checkId(){

	//아이디에 특수문자 포함 시 alert
	var specialChar = /[`~!@#$%^&*|\'\";:\/?]/;

	var idValue = $('#id').val();
	if(specialChar.test(idValue)){
		alert('아이디에는 특수문자를 포함하실 수 없습니다')
		return;
	}

	var formData = new FormData();

	formData.append("userType", $('input[name=answer]:checked').val());
	formData.append("id", $('#id').val());
	
	$.ajax({
		data: formData,
		dataType: 'json',
		caches: false,
		processData: false,
		contentType: false, 		
		method: 'post',
		url: '/loginRegister/dupId',
		success:function(res){
			if(res.result){
				alert('사용 가능한 아이디입니다');
				idDup = true;
			}
			else{
				alert('사용 불가능한 아이디입니다')
			}
		}
	});
}

//닉네임 중복확인
function checkNickname(){
	var formData = new FormData();
	
	formData.append("userType", $('input[name=answer]:checked').val());
	formData.append("nickname", $('#nickname').val());
	
	$.ajax({
		data: formData,
		dataType: 'json',
		caches: false,
		processData: false,
		contentType: false, 
		method: 'post',
		url: '/loginRegister/dupNickname',
		success:function(res){
			if(res.result){
				alert('사용 가능한 닉네임입니다');
				nickDup = true;
			}
			else{
				alert('사용 불가능한 닉네임입니다')
			}
		}
	});
}

//웹 회원가입
function webRegister(){

	//중복체크 안되있을 시 alert
	if(!(idDup)){
		alert('아이디 중복확인을 먼저 해주세요')
		return;
	}
	if(!(nickDup)){
		alert('닉네임 중복확인을 먼저 해주세요')
		return;
	}

	//비번에 특수문자 포함 시 alert
	var specialChar = /[`~!@#$%^&*|\'\";:\/?]/;

	if(specialChar.test($('#password').val())){
		alert('아이디에는 특수문자를 포함하실 수 없습니다')
	}

	// 비밀번호가 동일하지 않을 시 return
	var p1 = $('#password').val();
	var p2 = $('#password2').val();

	if(p1!=p2){
		alert('비밀번호가 동일하지 않습니다')
		return;
	}

	var formData = new FormData();
	
	formData.append("userType", $('input[name=answer]:checked').val());
	formData.append("nickname", $('#nickname').val());
	formData.append("id", $('#id').val());
	formData.append("password", $('#password').val());
	formData.append("profile_image", $('#profile_image').val());
	formData.append("email", $('#email').val());

	$.ajax({
		data: formData,
		dataType: 'json',
		caches: false,
		processData: false,
		contentType: false,
		method:'post',
		url:'/loginRegister/webRegister',
		success:function(res){
			if(res.result){
				alert('회원가입 성공!');
				location.href="/loginRegister/login";
			}
			else{
				alert('회원가입 실패')
				location.href="/main";
			}
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



