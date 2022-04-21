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

//검색 길이 제한 기능
function searchInfo(){
//	길이 관련
	var searchData = $('#search').val();
	if(searchData.length < 2){
		alert('최소 두글자 이상 입력해주세요');
		return false;
	}
}

//룸메이트 세부페이지 슬라이드 배너 기능
let slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
	let i;
	let slides = document.getElementsByClassName("mySlides");
	let dots = document.getElementsByClassName("demo");
	let captionText = document.getElementById("caption");
	if (n > slides.length) {slideIndex = 1}
	if (n < 1) {slideIndex = slides.length}
	for (i = 0; i < slides.length; i++) {
		slides[i].style.display = "none";
	}
	for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
	}
	slides[slideIndex-1].style.display = "block";
	dots[slideIndex-1].className += " active";
  //captionText.innerHTML = dots[slideIndex-1].alt;
}


//지도 검색창 value 입력 후 기본위치로 설정

//coordinates 전역변수, list형식으로 넣어야 됨
var coordinates = [];
$(document).ready(function(){
	var cityName = $('#cityName').html();
	$.ajax({
		dataType:'json',
		caches:false,
		method:'post',
		url:'/roommate/getCoordinates?cityName='+cityName,
		success:function(res){
			coordinates.push(res.lng);
			coordinates.push(res.lat);
			
			//지도 api 출력
			mapboxgl.accessToken = 
			'pk.eyJ1IjoiZHM3Nzg2IiwiYSI6ImNsMXc4aXRiMDBiYjAzZG8xbGVsMWFicXAifQ.IvWuhchffiyU7UBww6cHzw';
			
			const map = new mapboxgl.Map({
				container: 'map',
				style: 'mapbox://styles/mapbox/streets-v11',
				center: coordinates,
				zoom: 10
			});
			
			// Add the control to the map.
			map.addControl(
				new MapboxGeocoder({
					accessToken: mapboxgl.accessToken,
					mapboxgl: mapboxgl
				})
			);
						
			//	도시 이름은 검색창에 센스로 넣어놓자
			$('input[type=text]').val(cityName)
		}
	})
})

//슬라이드 토글 효과 - 연락하기
$('#contactPerson').click(function(e){
	$('#personaInfo').slideToggle();
})


//룸메 게시글 좋아요 클릭 기능
function likePost(){
     // display : none가 아닐 경우
	if($('#likeBox').is(":visible")){
		$.ajax({
			//일단 로그인이 되었는지를 확인함
			url: '/loginRegister/idCheck',
			caches: false,
			method: 'post',
			dataType:'json',
			success:function(res){
				
				if(res){
					document.getElementById('likeBox').style.display = "none";
					document.getElementById('likedBox').style.display = "inline-block";
					var formData = new FormData();
					
					formData.append("boardNum", $('#boardNum').text());
					
					$.ajax({
						data: formData,
						url: '/roommate/like',
						caches: false,
						method: 'post',
						processData: false,
						contentType: false,
						error:function(request){
							console.log(request.responseText);
						}
					})	
				}
			},
			error:function(request){
				alert('로그인을 해주세요');
				location.href="/loginRegister/login"
			}
		})	
	}
}

//룸메 게시글 좋아요 취소 기능
function likePostRevert(){
	if(window.confirm('정말로 취소할까요?')){
		
		document.getElementById('likedBox').style.display = "none";
		document.getElementById('likeBox').style.display = "inline-block";
		var formData = new FormData();
		
		formData.append("boardNum", $('#boardNum').text());
		
		$.ajax({
			data: formData,
			url: '/roommate/likerevert',
			caches: false,
			method: 'post',
			processData: false,
			contentType: false,
			error:function(request){
				console.log(request.responseText);
			}
		})	
	}
}

//글쓰기 기능
function newpost(){
	
	$.ajax({
		//일단 로그인이 되었는지를 확인함
		url: '/loginRegister/idCheck',
		caches: false,
		method: 'post',
		dataType:'json',
		success:function(res){
			location.href="/roommate/newpost"
		},
		error:function(request){
			alert('로그인을 해주세요');
			location.href="/loginRegister/login"
		}
	})
}