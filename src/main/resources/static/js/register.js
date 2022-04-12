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

//닉네임 중복확인
function checkNicknameMentor(){
	checkNickname('mentor');
}
//아이디 중복확인
function checkIdmentor(){
	checkId('mentor');
}

//프로필 사진 선택기능
$(function () {
	$('#picButton').click(function (e) {
		e.preventDefault();
/*		$('#file').click();*/
	});
});

//프로필 사진 업로드 기능
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
})

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

//웹 회원가입
function webRegister(){

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

//카카오톡 회원가입 메서드
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

