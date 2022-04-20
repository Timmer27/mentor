//나라 선택 후 도시, 태그 동적출력
$('#country').change(function(){
	var selectedCountry = $(this).val();
	
	$.ajax({
		dataType:'json',
		caches:false,
		url:'/roommate?selectedCountry=' + selectedCountry,
		method:'post',
		success:function(res){
			//시작 전 모든 태그의 내용을 비움
			$(".cities").empty();
			//시작 전 생성 태그를 전부 지움
			$(".cities").remove();
			
			//클래스 길이만큼 도시 출력
			var cityList = res.city;
			for(var i=0; i<cityList.length; i++){
				//도시 숫자만큼 아래의 태그 생성
				$("<a>").attr("class","cities col-1 text-center").attr("href", "/roommate/"+cityList[i]+"?selectedCountry="+selectedCountry).appendTo("#cityBox");
				$(".cities")[i].append(cityList[i]);
			}
		},
		error:function(request){
			alert(request.responseText);
		}
	})
})
