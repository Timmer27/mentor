Kakao.init('fd09236192d5711c591370f1b856f03e');

var nickDup = false;
var idDup = false;
var mentor = 'mentor';


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

//멘토 닉네임 중복확인
function checkNicknameMentor(){
	checkNickname('mentor');
}
//멘토 아이디 중복확인
function checkIdmentor(){
	checkId('mentor');
}

//멘티 닉네임 중복확인
function checkNicknameMenti(){
	checkNickname('menti');
}
//멘티 아이디 중복확인
function checkIdmenti(){
	checkId('menti');
}

/*//프로필 사진 업로드 기능
$(document).ready(function(){
	$('#picButton').on('click', function(e){
		var formData = new FormData();
		var inputFile = $('input[name=profile_picture]')[0].files[0];
		
		formData.append("picture", inputFile);
		
		console.log(inputFile);
		console.log(formData.picture)
		
		$.ajax({
			data: formData,
			dataType: 'json',
			url:'/loginRegister/uploadProfile',
			method:'post',
			enctype: 'multipart/form-data',
			cache: false,
			processData: false,
			contentType: false,
			success:function(result){
				console.log(result)
			}			
						
		});	
	});
})*/

//프로필 사진 선택기능
$(function () {
	$('#picButton').click(function (e) {
		//기본기능을 막고 file을 클릭함
		e.preventDefault();
		$('#file').click();
	});
});

//이미지 미리보기
var sel_file;
 
$(document).ready(function() {
    $("#file").on("change", handleImgFileSelect);
});
 
function handleImgFileSelect(e) {
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);
 
	var reg = /(.*?)\/(jpg|jpeg|png)$/;
 
    filesArr.forEach(function(f) {
        if (!f.type.match(reg)) {
            alert("jpg, jpeg, png 파일만 가능합니다");
            return;
        }	
        sel_file = f;
 
        var reader = new FileReader();
        reader.onload = function(e) {
            $("#img").attr("src", e.target.result);
        }
        reader.readAsDataURL(f);
    });
}


//멘토웹 회원가입
function webRegisterMenti(){
	webRegister('menti');
}

//멘토웹 회원가입
function webRegisterMentor(){
	webRegister('mentor');
}

//멘토 카카오톡 회원가입
function registerWithKakaoMentor(){
	
	window.Kakao.Auth.login({
		success: function() {
			window.Kakao.API.request({ // 사용자 정보 가져오기 
				url: '/v2/user/me',
				success: function(res){
					var formData = new FormData();
					
					formData.append("id", res.id);
					formData.append("nickname", res.properties.nickname);
					formData.append("profile_image", res.properties.profile_image);
					formData.append("email", res.kakao_account.email);
					formData.append("gender", res.kakao_account.gender);
					formData.append("userType", "mentor");
					
					$.ajax({
						data: formData,
						dataType: 'json',
						url: '/loginRegister/kakaoRegister',
						caches: false,
						method: 'post',
						processData: false,
						contentType: false, 
						success:function(res){
							if(res.result){
								alert('회원가입 완료!')
								location.href="/main";
							}
							else{
								alert('이미 회원가입이 되어있습니다');
								location.href="/loginRegister/login";
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


//멘티 카카오톡 회원가입
function registerWithKakaoMenti(){
	
	window.Kakao.Auth.login({
		success: function() {
			window.Kakao.API.request({ // 사용자 정보 가져오기 
				url: '/v2/user/me',
				success: function(res){
					var formData = new FormData();
					
					formData.append("id", res.id);
					formData.append("nickname", res.properties.nickname);
					formData.append("profile_image", res.properties.profile_image);
					formData.append("email", res.kakao_account.email);
					formData.append("gender", res.kakao_account.gender);
					formData.append("userType", "menti");
					
					$.ajax({
						data: formData,
						dataType: 'json',
						url: '/loginRegister/kakaoRegister',
						caches: false,
						method: 'post',
						processData: false,
						contentType: false, 
						success:function(res){
							if(res.result){
								alert('회원가입 완료!')
								location.href="/main";
							}
							else{
								alert('이미 회원가입이 되어있습니다');
								location.href="/loginRegister/login";
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

/*function showLoginPopup(){
    let uri = 'https://nid.naver.com/oauth2.0/authorize?' +
        'response_type=code' +                  // 인증과정에 대한 내부 구분값 code 로 전공 (고정값)
        '&client_id=cJdKbAEMtxTJgNUavIyj' +     // 발급받은 client_id 를 입력
        '&state=NAVER_LOGIN_TEST' +             // CORS 를 방지하기 위한 특정 토큰값(임의값 사용)
        '&redirect_uri=http://localhost:90/main';   // 어플케이션에서 등록했던 CallBack URL를 입력

    // 사용자가 사용하기 편하게끔 팝업창으로 띄어준다.
    window.open(uri, "Naver Login Test PopupScreen", "width=450, height=600");
}*/


/*//네이버 로그아웃
 function setLoginStatus(){

	var logout=document.getElementById('btn_logout');
	logout.addEventListener('click',(e)=>{
		e.preventDefault();
		naverLogin.logout();
		location.replace("http://localhost:90/main");
	})
}*/

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

//mentor 구글 로그인
function onSignIn(googleUser) {
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
		formData.append("userType", "mentor");
		
/*		console.log(profile.FW) //아이디
		console.log(profile.tf) //풀네임
		console.log(profile.tv) //이메일
		console.log(profile.eN) //프로필 사진 */
		
		$.ajax({
		data: formData,
		dataType:'json',
		url:'/loginRegister/GoogleRegister',
		method:'post',
		caches: false,
		processData: false,
		contentType: false, 
		success:function(res){
			if(res.result){
				alert('회원가입 성공!')
				location.href='/loginRegister/login'
			}
		},
		error:function(request){
			alert('회원가입 성공!')
			location.href="/loginRegister/login";
		}
		});
	})
	.fail(function(e){
		alert('구글 로그인 실패');
		console.log(e);
	})
}


//구글 로그인 - init을 실행시켜서 onSignin 메서드를 동작시키고 프로필 정보를 받아옴
function init2() {
	gapi.load('auth2', function() {
		gapi.auth2.init();
		options = new gapi.auth2.SigninOptionsBuilder();
		options.setPrompt('select_account');
        // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
        // 인스턴스의 함수 호출 - element에 로그인 기능 추가
        // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
		gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn2, onSignInFailure);
	})
}

//menti 구글 로그인
function onSignIn2(googleUser) {
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
		formData.append("userType", "menti");
		
/*		console.log(profile.FW) //아이디
		console.log(profile.tf) //풀네임
		console.log(profile.tv) //이메일
		console.log(profile.eN) //프로필 사진 */
		
		$.ajax({
		data: formData,
		dataType:'json',
		url:'/loginRegister/GoogleRegister',
		method:'post',
		caches: false,
		processData: false,
		contentType: false, 
		success:function(res){
			if(res.result){
				alert('회원가입 성공!')
				location.href='/loginRegister/login'
			}
		},
		error:function(request){
			alert('회원가입 성공!')
			location.href="/loginRegister/login";
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










//회원가입 메서드
function webRegister(userType){

	//중복체크 안되있을 시 alert
	if(!(idDup)){
		alert('아이디 중복확인을 먼저 해주세요');
		return;
	}
	if(!(nickDup)){
		alert('닉네임 중복확인을 먼저 해주세요');
		return;
	}

	//비번에 특수문자 포함 시 alert
	var specialChar = /[`~!@#$%^&*|\'\";:\/?]/;

	if(specialChar.test($('#password').val())){
		alert('아이디에는 특수문자를 포함하실 수 없습니다');
	}

	// 비밀번호가 동일하지 않을 시 return
	var p1 = $('#password').val();
	var p2 = $('#password2').val();

	if(p1!=p2){
		alert('비밀번호가 동일하지 않습니다');
		return;
	}
	
	// 약관동의 안했을 시
	if($('#agreement').is(":checked")==false){
		alert('약관 동의를 해주세요');
		return;
	}
	//프로필 사진 업데이트 안되있을 시 return
	if($('input[name=profile_picture]')[0].files[0] == null){
		alert('프로필 사진을 업로드 해주세요');
		return;
	}
	
	var inputFile = $('input[name=profile_picture]')[0].files[0];
	var formData = new FormData();
	
	formData.append("userType", userType);
	formData.append("nickname", $('#nickname').val());
	formData.append("id", $('#id').val());
	formData.append("password", $('#password').val());
	formData.append("profilePicture", inputFile);
	formData.append("email", $('#email').val());
	formData.append("country", $('#myInput').val());	
	formData.append("city", $('#cities').val());

	$.ajax({
		data: formData,
		dataType: 'json',
		caches: false,
		enctype: 'multipart/form-data',
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

//닉네임 확인 메서드
function checkNickname(userType){
	var formData = new FormData();
	
	formData.append("userType", userType);
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

//아이디 중복확인 메서드
function checkId(d){

	//아이디에 특수문자 포함 시 alert
	var specialChar = /[`~!@#$%^&*|\'\";:\/?]/;

	var idValue = $('#id').val();
	if(specialChar.test(idValue)){
		alert('아이디에는 특수문자를 포함하실 수 없습니다')
		return;
	}
	var formData = new FormData();

	formData.append("userType", d);
	formData.append("id", idValue);
	
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

