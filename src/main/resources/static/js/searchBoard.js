//검색 기능
function searchInfo(){
//	길이 관련
	var searchData = $('#search').val();
	if(searchData.length < 2){
		alert('최소 두글자 이상 입력해주세요');
		return false;
	}
}