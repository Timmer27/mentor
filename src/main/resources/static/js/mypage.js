//버튼대신 파일
$('#profileButton').click(function(){
	$('input[name=profilePic]').click();
})

$(document).ready(function() {
    $("#profilePic").on("change", handleImgFileSelect);
});

// 사진 미리보기 구현
function handleImgFileSelect(e) {
    var file = e.target.files;
	var reg = /(.*?)\/(jpg|jpeg|png)$/;
 
    if (!file[0].type.match(reg)) {
        alert("jpg, jpeg, png 파일만 가능합니다");
//		file 값을 지움        
        $('#profilePic').val('');
        return false;
    }	
    var reader = new FileReader();
    reader.onload = function(e) {
        $("#profile").attr("src", e.target.result);
    }
    reader.readAsDataURL(file[0]);
}

//사진 변경
function changeProfilePic(){
	if($('#profilePic').val() == ""){
		alert('사진을 업로드해주세요')
		return false;
	}
	
	var formData = new FormData()
	var inputFile = $('input[name=profilePic]')[0].files[0];
	console.log(inputFile);
	formData.append("file", inputFile);
	
	$.ajax({
		data: formData,
		dataType: 'json',
		caches: false,
		enctype: 'multipart/form-data',
		processData: false,
		contentType: false, 		
		method: 'post',
		url: '/main/profileChange',
		success:function(res){
			if(res.result){
				alert('변경 완료!');
				history.go(0);
			}
			else{
				alert('변경 실패')
			}
		}
	});
	
}

//본인정보 div태그 슬라이드 효과
function slideinputs(){
	$('#modifyInfo').slideToggle();
}

//본인정보 변경 
function modifyInfo(){
/*	var inputs = document.querySelectorAll('input[type=text]');
	var nameList = [];
//  값이 있는 input의 name값을 추출
 	for(var i = 0; i<inputs.length; i++){
		var ip = inputs[i];
		if($(ip).val() != ""){
			nameList.push($(ip).attr('name'));
		}
	}
	
// list로 받아온 name값만 DB에 업데이트
 	for(var i = 0; i<nameList.length; i++){
	}
	*/
	
//비번에 특수문자 포함 시 alert
	var specialChar = /[`~!@#$%^&*|\'\";:\/?]/;

	if(specialChar.test($('#password').val())){
		alert('비밀번호에는 특수문자를 포함하실 수 없습니다');
		return false;
	}
	
// 비밀번호가 동일하지 않을 시 return
	var p1 = $('#password').val();
	var p2 = $('#password2').val();

	if(p1!=p2){
		alert('비밀번호가 동일하지 않습니다');
		return false;
	}
	
//	변경 비밀번호가 동일할 시 return
	var p1 = $('#currentPW').val();
	var p2 = $('#password').val();
	if(p1==p2){
		alert('변경할 비밀번호가 동일합니다');
		return false;
	}
	
//	변경 비밀번호 길이 제한
	var p2 = $('#password').val();
	if(p2.length < 7){
		alert('비밀번호를 7자 이상으로 입력해주세요');
		return false;
	}
	
	
	var d = $('#modifyInfo').serialize();
	$.ajax({
		data: d,
		dataType: 'json',
		method: 'post',
		caches: false,
		url: '/main/modify',
		success:function(res){
			if(res.result == 'dupnickname'){
				alert('닉네임이 중복됩니다 :(')
				return false;
			}
			if(res.result == 'CWPassword'){
				alert('현재 비밀번호가 틀립니다')
				return false;
			}
			if(res.result == 'success'){
				alert('변경 완료')
				history.go(0);
			}
			else{
				alert('변경 실패')
				return false
			}
		},
		error:function(request){
			console.log(request.responseText)
			return false;
		}
	})
	return false;
	
	
}
