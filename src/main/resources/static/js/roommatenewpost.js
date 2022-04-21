//나라 변경 시 도시 출력정보 변경
$('#country').change(function(){
	var selectedCountry = $(this).val();
	
	$.ajax({
		dataType:'json',
		caches:false,
		url:'/roommate?selectedCountry=' + selectedCountry,
		method:'post',
		success:function(res){
			var cityList = res.city;
			//시작 전 모든 태그의 내용을 비움
			$(".cities").empty();
			//시작 전 생성 태그를 전부 지움
			$(".cities").remove();
			for(var i=0; i<cityList.length; i++){
				//도시 숫자만큼 아래의 태그 생성
				$("<option>").attr("value",cityList[i]).attr("class","cities").appendTo("#city");
				//cities의 html값 안에 cityList의 값을 하나씩 채움
				$(".cities")[i].append(cityList[i]);
			}
		}
	})
})

//slide toggle 단 한번만 실행하기
document.querySelector('#country').addEventListener('change',function(){
	//나라 변경 시 도시 input slideToggle
	$('#cityDiv').slideToggle();
},{once : true});


//textarea 자동 크기 조절
$(document).ready(function(){
	$('textarea').keyup(function(){
		$(this).css("height", "auto");
		$(this).height(this.scrollHeight);
	})
})


//제목 길이 조절
document.querySelector('#title').addEventListener('keyup', function(){
	//최대 길이 도달 시 알람
	var textLength = $('#title').val().length;
	
	if(textLength >= 100){
		alert('최대 글자 수는 100자 입니다');
		return;	
	}
})

//제목 길이 조절 - 첨부파일이 많아지면 자동으로 조절됨
document.querySelector('#btnAtt').addEventListener('change', function(){
	var submitButton = document.querySelector('#att_zone');
	var currentHeight = 200;
	//200 130
	var buttonHeight = submitButton.scrollHeight;
	console.log(buttonHeight);
	
	if(buttonHeight>currentHeight){
		var mainarea = document.querySelector('#newpostInfo');
		var mainareaHeight = mainarea.scrollHeight;
		
	    mainarea.style.height = `${mainareaHeight + 120}px`;
	}
})
//제목 길이 조절 - 첨부파일이 많아지면 자동으로 조절됨
document.querySelector('#att_zone').addEventListener('drop', function(){
	var submitButton = document.querySelector('#att_zone');
	var currentHeight = 200;
	//200 130
	var buttonHeight = submitButton.scrollHeight;
	console.log(buttonHeight);
	
	if(buttonHeight>currentHeight){
		var mainarea = document.querySelector('#newpostInfo');
		var mainareaHeight = mainarea.scrollHeight;
		
	    mainarea.style.height = `${mainareaHeight + 120}px`;
	}
})



//파일 드롭 후 저장
imageView = function imageView(att_zone, btn){

    var attZone = document.getElementById(att_zone);
    var btnAtt = document.getElementById(btn)
    var sel_files = [];
    
    // 이미지와 체크 박스를 감싸고 있는 div 속성
    var div_style = 'display:inline-block;position:relative;'
                  + 'width: fit-content;;height:120px;margin:5px;z-index:1';
    // 미리보기 이미지 속성
    var img_style = 'width:100%;height:100%;z-index:none';
    // 이미지안에 표시되는 체크박스의 속성
    var chk_style = 'position: absolute; padding: 0; border: none; font-size: 23px; right: 0px;'
          + 'bottom: 4px; z-index: 999; background-color: rgba(255,255,255,0.1);'
          + 'color: #ff0000bd; font-weight: bold;';
  
    btnAtt.onchange = function(e){
	//첨부파일 클릭 업로드 시 확장자 유효성 검사
		var reg = /(.*?)\/(jpg|jpeg|png)$/;
	
		var files = e.target.files;
		var fileArr = Array.prototype.slice.call(files)
	
		for(f of fileArr){
          if (!f.type.match(reg)) {
              alert("jpg, jpeg, png 파일만 가능합니다");
              return;
          }
      }
		for(f of fileArr){
			imageLoader(f);
		}
    }  
    // 탐색기에서 드래그앤 드롭 사용
    attZone.addEventListener('dragenter', function(e){
 		e.preventDefault();
		e.stopPropagation();
    }, false)
    
	attZone.addEventListener('dragover', function(e){
		e.preventDefault();
		e.stopPropagation();
		this.style.backgroundColor = '#80c2ff73';
      
    }, false)
    
    /* 박스 밖으로 Drag가 나갈 때 */
	attZone.addEventListener('dragleave', function(e) {
        this.style.backgroundColor = 'white';
    });
  
  //드롭 - 확장자 유효성 검사
    attZone.addEventListener('drop', function(e){
        this.style.backgroundColor = 'white';
		var reg = /(.*?)\/(jpg|jpeg|png)$/;
		var files = {};
        var dt = new DataTransfer();
        
		e.preventDefault();
		e.stopPropagation();
		
		var files = e.dataTransfer.files;
    	for(f of files){
			if (!f.type.match(reg)) {
				alert("jpg, jpeg, png 파일만 가능합니다");
				return;
            }	
			dt.items.add(f);
			imageLoader(f);
	        btnAtt.files = dt.files;
        }
		console.log(btnAtt.files);
      }, false)
    
    /*첨부된 이미리즐을 배열에 넣고 미리보기 */
    imageLoader = function(file){
	
		sel_files.push(file);
		var reader = new FileReader();
		reader.onload = function(ee){
	
		let img = document.createElement('img')
        img.setAttribute('style', img_style)
        img.src = ee.target.result;
        attZone.appendChild(makeDiv(img, file));
      }
      reader.readAsDataURL(file);
    }
    
    /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
    makeDiv = function(img, file){
		var div = document.createElement('div')
		div.setAttribute('style', div_style)
      
		var btn = document.createElement('input')
		btn.setAttribute('type', 'button')
		btn.setAttribute('value', 'x')
		btn.setAttribute('delFile', file.name);
		btn.setAttribute('style', chk_style);
		btn.onclick = function(ev){
			
	        var ele = ev.srcElement;
	        var delFile = ele.getAttribute('delFile');
	        for(var i=0 ;i<sel_files.length; i++){
				if(delFile== sel_files[i].name){
					sel_files.splice(i, 1);      
				}
	        }
	        
	        dt = new DataTransfer();
	        for(f in sel_files){
				var file = sel_files[f];
				dt.items.add(file);
	        }
	        btnAtt.files = dt.files;
	        var p = ele.parentNode;
	        attZone.removeChild(p)
		}
		div.appendChild(img)
		div.appendChild(btn)
		
		return div
		}
	}
('att_zone', 'btnAtt')
//파일 드롭 후 저장 끝


