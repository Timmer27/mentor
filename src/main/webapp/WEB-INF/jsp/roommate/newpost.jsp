<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/newpost.css">
<link rel="stylesheet" href="/css/roommatenewpost.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- mapBox -->

<title>글쓰기</title>
</head>
<body>
<!-- top -->
    <div class = "d-flex" style='border-bottom: 1px solid #6d6d6d8a;'>
        <div class='col-lg-1' style="padding-left: 12px; margin: auto;">
			<a href="/main"><img src="/image/logo.png" alt="" style='width: 75px; margin-left: 15px;'></a>
        </div>
        <div class = "d-flex col-lg-7" style="color: #000000ab;">
			<c:if test="${userType==null}">
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						멘톨후기
					</p></a>
				</div>      
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						사용방법
					</p></a>
				</div>  
			</c:if>            
			<c:if test="${userType eq 'mentor'}">
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						멘토하기
					</p></a>
				</div>      
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						멘톨후기
					</p></a>
				</div>      
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						사용방법
					</p></a>
				</div>  
			</c:if>
			<c:if test="${userType eq 'menti'}">
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						질문하기
					</p></a>
				</div>      
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						멘톨후기
					</p></a>
				</div>      
				<div class = "col-lg-1 bann_box mx-1">
					<a href="#"><p class="bannerSub">
						사용방법
					</p></a>
				</div>  
			</c:if>
        </div>
        <div class="d-flex col-lg-4 lgBox" style="place-content: end; padding-right: 30px; align-items: center;">
	        <!-- search button -->
	        <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
				<input type="search" class="form-control" placeholder="Search..." style="display: inline; width: 70%; margin-right: 6px" aria-label="Search">
		        <button class="btn btn-outline-dark" type="submit">검색</button>
	        </form>
		
	        <c:if test="${id==null}">
	        
	        <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #2a3339bf;">
				<a href = "/loginRegister/login"><p class="bannerSub" style="color: white;">
				로그인
				</a>
	        </div>
	        <div class = "col-lg-2 bann_box mx-1 lgBox" style="background-color: #4598ace3;">
				<a href = "/loginRegister/register"><p class="bannerSub" style="color: white;">
				회원가입
				</a>
	        </div>
			</c:if>

	        <!-- profile & login button -->
			<c:if test="${id!=null}">
	            <div class="dropdown text-end">
	            	<c:if test="${profile_image eq '/image/upload/0'}">
						<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle pt-2" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
			            	<img src="/image/user.png" alt="프로필" width="50" height="50" class="rounded-circle">
						</a>
					</c:if>
	            	<c:if test="${profile_image != '/image/upload/0'}">
						<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle pt-2" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
			            	<img src="${profile_image}" alt="프로필" width="50" height="50" class="rounded-circle">
						</a>
					</c:if>
				<ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1" style="min-width: 6rem; font-size: 0.9rem;">
					<li><div style="padding-bottom: 13px; padding-top: 0;" id="pointshow" class="dropdown-item">${nickName}님 환영합니다</div></li>
					
					<c:if test="${userType == 'menti'}">
						<li><a class="dropdown-item" href="/main/mypageMenti">마이페이지</a></li>
					</c:if>
					
					<c:if test="${userType == 'mentor'}">
						<li><a class="dropdown-item" href="/main/mypageMentor">마이페이지</a></li>
					</c:if>
					
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="/loginRegister/logout">로그아웃</a></li>
					<li><div id="pointshow" class="dropdown-item">
						<img alt="point" src="/image/gem.png" height="20px" width="20px"/>
						 : <span id='cPoint' style="color: red;">${currentPoint}</span> </div></li>
					<li><div id="pointshow" class="dropdown-item">
						<img alt="명예" src="/image/cube.png" height="20px" width="20px"/>
					 : <span style="color: red;">${currentRepPoint}</span> </div></li>
				</ul>
		  		</c:if>
	        </div>
        </div>
    </div>
    
    <!-- 메인 시작 -->
    <form id='newpostInfo' class ="col-6 mt-4 m-auto mainBanner" style="min-height: 136rem; height: auto;"> <!-- onsubmit="return newpostwrite();" -->
    	<!-- method="post" action="/roommate/savePost"  enctype="multipart/form-data"  -->
    	<div class="d-flex" style="align-items: center;">
	    	<label for="country" id='chooseNation'>나라를 선택해주세요</label>
	    	<div class="categoriBox mb-2">
	    	
				<select style="width: 13rem;" id="country" name="country" class="form-control" required="required">
				    <option value="Afghanistan">Afghanistan</option>
				    <option value="Åland Islands">Åland Islands</option>
				    <option value="Albania">Albania</option>
				    <option value="Algeria">Algeria</option>
				    <option value="American Samoa">American Samoa</option>
				    <option value="Andorra">Andorra</option>
				    <option value="Angola">Angola</option>
				    <option value="Anguilla">Anguilla</option>
				    <option value="Antarctica">Antarctica</option>
				    <option value="Antigua and Barbuda">Antigua and Barbuda</option>
				    <option value="Argentina">Argentina</option>
				    <option value="Armenia">Armenia</option>
				    <option value="Aruba">Aruba</option>
				    <option value="Australia">Australia</option>
				    <option value="Austria">Austria</option>
				    <option value="Azerbaijan">Azerbaijan</option>
				    <option value="Bahamas">Bahamas</option>
				    <option value="Bahrain">Bahrain</option>
				    <option value="Bangladesh">Bangladesh</option>
				    <option value="Barbados">Barbados</option>
				    <option value="Belarus">Belarus</option>
				    <option value="Belgium">Belgium</option>
				    <option value="Belize">Belize</option>
				    <option value="Benin">Benin</option>
				    <option value="Bermuda">Bermuda</option>
				    <option value="Bhutan">Bhutan</option>
				    <option value="Bolivia">Bolivia</option>
				    <option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
				    <option value="Botswana">Botswana</option>
				    <option value="Bouvet Island">Bouvet Island</option>
				    <option value="Brazil">Brazil</option>
				    <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
				    <option value="Brunei Darussalam">Brunei Darussalam</option>
				    <option value="Bulgaria">Bulgaria</option>
				    <option value="Burkina Faso">Burkina Faso</option>
				    <option value="Burundi">Burundi</option>
				    <option value="Cambodia">Cambodia</option>
				    <option value="Cameroon">Cameroon</option>
				    <option value="Canada">Canada</option>
				    <option value="Cape Verde">Cape Verde</option>
				    <option value="Cayman Islands">Cayman Islands</option>
				    <option value="Central African Republic">Central African Republic</option>
				    <option value="Chad">Chad</option>
				    <option value="Chile">Chile</option>
				    <option value="China">China</option>
				    <option value="Christmas Island">Christmas Island</option>
				    <option value="Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
				    <option value="Colombia">Colombia</option>
				    <option value="Comoros">Comoros</option>
				    <option value="Congo">Congo</option>
				    <option value="Congo, The Democratic Republic of The">Congo, The Democratic Republic of The</option>
				    <option value="Cook Islands">Cook Islands</option>
				    <option value="Costa Rica">Costa Rica</option>
				    <option value="Cote D'ivoire">Cote D'ivoire</option>
				    <option value="Croatia">Croatia</option>
				    <option value="Cuba">Cuba</option>
				    <option value="Cyprus">Cyprus</option>
				    <option value="Czech Republic">Czech Republic</option>
				    <option value="Denmark">Denmark</option>
				    <option value="Djibouti">Djibouti</option>
				    <option value="Dominica">Dominica</option>
				    <option value="Dominican Republic">Dominican Republic</option>
				    <option value="Ecuador">Ecuador</option>
				    <option value="Egypt">Egypt</option>
				    <option value="El Salvador">El Salvador</option>
				    <option value="Equatorial Guinea">Equatorial Guinea</option>
				    <option value="Eritrea">Eritrea</option>
				    <option value="Estonia">Estonia</option>
				    <option value="Ethiopia">Ethiopia</option>
				    <option value="Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option>
				    <option value="Faroe Islands">Faroe Islands</option>
				    <option value="Fiji">Fiji</option>
				    <option value="Finland">Finland</option>
				    <option value="France">France</option>
				    <option value="French Guiana">French Guiana</option>
				    <option value="French Polynesia">French Polynesia</option>
				    <option value="French Southern Territories">French Southern Territories</option>
				    <option value="Gabon">Gabon</option>
				    <option value="Gambia">Gambia</option>
				    <option value="Georgia">Georgia</option>
				    <option value="Germany">Germany</option>
				    <option value="Ghana">Ghana</option>
				    <option value="Gibraltar">Gibraltar</option>
				    <option value="Greece">Greece</option>
				    <option value="Greenland">Greenland</option>
				    <option value="Grenada">Grenada</option>
				    <option value="Guadeloupe">Guadeloupe</option>
				    <option value="Guam">Guam</option>
				    <option value="Guatemala">Guatemala</option>
				    <option value="Guernsey">Guernsey</option>
				    <option value="Guinea">Guinea</option>
				    <option value="Guinea-bissau">Guinea-bissau</option>
				    <option value="Guyana">Guyana</option>
				    <option value="Haiti">Haiti</option>
				    <option value="Heard Island and Mcdonald Islands">Heard Island and Mcdonald Islands</option>
				    <option value="Holy See (Vatican City State)">Holy See (Vatican City State)</option>
				    <option value="Honduras">Honduras</option>
				    <option value="Hong Kong">Hong Kong</option>
				    <option value="Hungary">Hungary</option>
				    <option value="Iceland">Iceland</option>
				    <option value="India">India</option>
				    <option value="Indonesia">Indonesia</option>
				    <option value="Iran">Iran</option>
				    <option value="Iraq">Iraq</option>
				    <option value="Ireland">Ireland</option>
				    <option value="Isle of Man">Isle of Man</option>
				    <option value="Israel">Israel</option>
				    <option value="Italy">Italy</option>
				    <option value="Jamaica">Jamaica</option>
				    <option value="Japan">Japan</option>
				    <option value="Jersey">Jersey</option>
				    <option value="Jordan">Jordan</option>
				    <option value="Kazakhstan">Kazakhstan</option>
				    <option value="Kenya">Kenya</option>
				    <option value="Kiribati">Kiribati</option>
				    <option value="North Korea">North Korea</option>
				    <option value="South Korea">South Korea</option>
				    <option value="Kuwait">Kuwait</option>
				    <option value="Kyrgyzstan">Kyrgyzstan</option>
				    <option value="Lao People's Democratic Republic">Lao People's Democratic Republic</option>
				    <option value="Latvia">Latvia</option>
				    <option value="Lebanon">Lebanon</option>
				    <option value="Lesotho">Lesotho</option>
				    <option value="Liberia">Liberia</option>
				    <option value="Libyan Arab Jamahiriya">Libyan Arab Jamahiriya</option>
				    <option value="Liechtenstein">Liechtenstein</option>
				    <option value="Lithuania">Lithuania</option>
				    <option value="Luxembourg">Luxembourg</option>
				    <option value="Macao">Macao</option>
				    <option value="Macedonia, The Former Yugoslav Republic of">Macedonia, The Former Yugoslav Republic of</option>
				    <option value="Madagascar">Madagascar</option>
				    <option value="Malawi">Malawi</option>
				    <option value="Malaysia">Malaysia</option>
				    <option value="Maldives">Maldives</option>
				    <option value="Mali">Mali</option>
				    <option value="Malta">Malta</option>
				    <option value="Marshall Islands">Marshall Islands</option>
				    <option value="Martinique">Martinique</option>
				    <option value="Mauritania">Mauritania</option>
				    <option value="Mauritius">Mauritius</option>
				    <option value="Mayotte">Mayotte</option>
				    <option value="Mexico">Mexico</option>
				    <option value="Micronesia, Federated States of">Micronesia, Federated States of</option>
				    <option value="Moldova, Republic of">Moldova, Republic of</option>
				    <option value="Monaco">Monaco</option>
				    <option value="Mongolia">Mongolia</option>
				    <option value="Montenegro">Montenegro</option>
				    <option value="Montserrat">Montserrat</option>
				    <option value="Morocco">Morocco</option>
				    <option value="Mozambique">Mozambique</option>
				    <option value="Myanmar">Myanmar</option>
				    <option value="Namibia">Namibia</option>
				    <option value="Nauru">Nauru</option>
				    <option value="Nepal">Nepal</option>
				    <option value="Netherlands">Netherlands</option>
				    <option value="Netherlands Antilles">Netherlands Antilles</option>
				    <option value="New Caledonia">New Caledonia</option>
				    <option value="New Zealand">New Zealand</option>
				    <option value="Nicaragua">Nicaragua</option>
				    <option value="Niger">Niger</option>
				    <option value="Nigeria">Nigeria</option>
				    <option value="Niue">Niue</option>
				    <option value="Norfolk Island">Norfolk Island</option>
				    <option value="Northern Mariana Islands">Northern Mariana Islands</option>
				    <option value="Norway">Norway</option>
				    <option value="Oman">Oman</option>
				    <option value="Pakistan">Pakistan</option>
				    <option value="Palau">Palau</option>
				    <option value="Palestinian Territory, Occupied">Palestinian Territory, Occupied</option>
				    <option value="Panama">Panama</option>
				    <option value="Papua New Guinea">Papua New Guinea</option>
				    <option value="Paraguay">Paraguay</option>
				    <option value="Peru">Peru</option>
				    <option value="Philippines">Philippines</option>
				    <option value="Pitcairn">Pitcairn</option>
				    <option value="Poland">Poland</option>
				    <option value="Portugal">Portugal</option>
				    <option value="Puerto Rico">Puerto Rico</option>
				    <option value="Qatar">Qatar</option>
				    <option value="Reunion">Reunion</option>
				    <option value="Romania">Romania</option>
				    <option value="Russian Federation">Russian Federation</option>
				    <option value="Rwanda">Rwanda</option>
				    <option value="Saint Helena">Saint Helena</option>
				    <option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
				    <option value="Saint Lucia">Saint Lucia</option>
				    <option value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
				    <option value="Saint Vincent and The Grenadines">Saint Vincent and The Grenadines</option>
				    <option value="Samoa">Samoa</option>
				    <option value="San Marino">San Marino</option>
				    <option value="Sao Tome and Principe">Sao Tome and Principe</option>
				    <option value="Saudi Arabia">Saudi Arabia</option>
				    <option value="Senegal">Senegal</option>
				    <option value="Serbia">Serbia</option>
				    <option value="Seychelles">Seychelles</option>
				    <option value="Sierra Leone">Sierra Leone</option>
				    <option value="Singapore">Singapore</option>
				    <option value="Slovakia">Slovakia</option>
				    <option value="Slovenia">Slovenia</option>
				    <option value="Solomon Islands">Solomon Islands</option>
				    <option value="Somalia">Somalia</option>
				    <option value="South Africa">South Africa</option>
				    <option value="South Georgia and The South Sandwich Islands">South Georgia and The South Sandwich Islands</option>
				    <option value="Spain">Spain</option>
				    <option value="Sri Lanka">Sri Lanka</option>
				    <option value="Sudan">Sudan</option>
				    <option value="Suriname">Suriname</option>
				    <option value="Svalbard and Jan Mayen">Svalbard and Jan Mayen</option>
				    <option value="Swaziland">Swaziland</option>
				    <option value="Sweden">Sweden</option>
				    <option value="Switzerland">Switzerland</option>
				    <option value="Syrian Arab Republic">Syrian Arab Republic</option>
				    <option value="Taiwan">Taiwan</option>
				    <option value="Tajikistan">Tajikistan</option>
				    <option value="Tanzania, United Republic of">Tanzania, United Republic of</option>
				    <option value="Thailand">Thailand</option>
				    <option value="Timor-leste">Timor-leste</option>
				    <option value="Togo">Togo</option>
				    <option value="Tokelau">Tokelau</option>
				    <option value="Tonga">Tonga</option>
				    <option value="Trinidad and Tobago">Trinidad and Tobago</option>
				    <option value="Tunisia">Tunisia</option>
				    <option value="Turkey">Turkey</option>
				    <option value="Turkmenistan">Turkmenistan</option>
				    <option value="Turks and Caicos Islands">Turks and Caicos Islands</option>
				    <option value="Tuvalu">Tuvalu</option>
				    <option value="Uganda">Uganda</option>
				    <option value="Ukraine">Ukraine</option>
				    <option value="United Arab Emirates">United Arab Emirates</option>
				    <option value="United Kingdom">United Kingdom</option>
				    <option value="United States">United States</option>
				    <option value="United States Minor Outlying Islands">United States Minor Outlying Islands</option>
				    <option value="Uruguay">Uruguay</option>
				    <option value="Uzbekistan">Uzbekistan</option>
				    <option value="Vanuatu">Vanuatu</option>
				    <option value="Venezuela">Venezuela</option>
				    <option value="VietNam">VietNam</option>
				    <option value="Virgin Islands, British">Virgin Islands, British</option>
				    <option value="Virgin Islands, U.S.">Virgin Islands, U.S.</option>
				    <option value="Wallis and Futuna">Wallis and Futuna</option>
				    <option value="Western Sahara">Western Sahara</option>
				    <option value="Yemen">Yemen</option>
				    <option value="Zambia">Zambia</option>
				    <option value="Zimbabwe">Zimbabwe</option>
				</select>
	    	</div>
    	</div>


   		<div id="cityDiv" class="d-flex">
	   		<div id="chooseNation">
	   			도시를 선택해주세요
			</div>
	    	<div>
		    	<!-- 동적 도시 리스트 출력 -->
				<select style="width: 13rem;" id="city" name="city" class="form-control" required="required" disabled="disabled">
				    <option class="default" value="none">나라를 먼저 선택해주세요</option>
				</select>
	    	</div>
    	</div>
    	
    	<div class="content">
    		<div class="col-12 m-auto mt-3 pb-4">
    			<input type="text" id="title" name="boardTitle" maxlength="100" placeholder="제목을 입력하세요" required="required">
    		</div>
    		<div class="col-12 m-auto">
    			<textarea id="contentInfo" name="boardContent" maxlength="1500" required="required" placeholder="내용을 입력해주세요"></textarea>
    		</div>
    	</div>
    	
    	<hr style="color: #a7a6a6;">
	
		<div class="requiredInfo">
			<p class="title">
				추가정보
			</p>
	
	    	<div>
		    	<div class="d-flex inputGroup">
			    	<div class="inputText">
			    		월세
			    	</div>
			    	<input class="col-3 inputs" type="number" id="expense" name="expense" required="required">
			    	<span id="currencySpan"></span>
			    	<span id="" style="font-size: 12px; color: #6e6e6eab; padding-left: 12px;">기본통화는 $입니다</span>
		    	</div>
		    	
		    	<div class="d-flex inputGroup">
			    	<div class="inputText">
			    		보증금
			    	</div>
			    	<input class="col-3 inputs" type="number" id="securityDeposit" name="securityDeposit" required="required">
		    	</div>
		    	
		    	<div class="d-flex inputGroup">
			    	<div class="inputText">
			    		썸네일
			    	</div>
			    	<input class="col-3 inputs" type="file" id="thumbPic" name="thumbPic" accept="image/jpeg, image/png, image/jpg" style="width: 27%; font-size: 13px; border: none">
			    	<div style="width: 19%;">
			    		<div style="font-size: 12px; text-align: center;">
					    	미리보기
			    		</div>
			    		<img id='preView' style="width: 100%; height: 100%" src="/image/user.png">
			    	</div>
		    	</div>
		    	
		    	<div class="d-flex inputGroup">
			    	<div class="inputText">
			    		상세주소
			    	</div>
			    	<input class="col-3 inputs" type="text" name="address" id="address" required="required" style="width: 60%;">
		    	</div>
		    	
		    	<div class="d-flex inputGroup">
			    	<div class="inputText">
			    		이메일
			    	</div>
			    	<input class="col-3 inputs" type="email" name="email" id="email" required="required" style="width: 40%;">
		    	</div>
		    	
		    	<div class="d-flex inputGroup">
			    	<div class="inputText">
			    		전화번호
			    	</div>
			    	<input class="col-3 inputs" type="text" name="phone" id="phone"  required="required" style="width: 40%;">
		    	</div>
		    	
		    	<div class="inputGroup">
		    	
			    	<div class="inputText" style="width: 31%; margin-bottom: 12px;">
			    		침실 | 욕실 숫자
			    	</div>
			    	
		    		<div class="d-flex col-12" style="">
			    		<div class="d-flex col-2" style="">
			    			<img alt="beds" src="/image/bed.png"  style="width: 38px; margin: 0px 8px;">
					    	<input class="inputs" name="beds" id="beds"  type="number" style="width: 45px;" required="required">
			    		</div>
			    		<div class="d-flex col-2">
			    			<img alt="bath" src="/image/bath.png" style="width: 31px; height: 33px; margin: 0px 8px;" >
					    	<input class="inputs" name="bath" id="bath" type="number" style="height:36px; width: 45px;" required="required">
			    		</div>
		    		</div>
		    	
		    	</div>
	
		    	<div>
			    	<div class="d-flex inputGroup" style="border: none;">
				    	<div class="inputText" style="width: 30%;">
				    		입주자 성별
				    	</div>
			    	</div>
			    	<div class="col-5 pb-2 inputText" style="width: 100%; margin-bottom: 20px; border-bottom: 1px solid #95959582;">
				    	<span>남</span> <input class="col-1" type="radio" name="gender" value="남" style="width: 4%">
				    	<span>여</span> <input class="col-1" type="radio" name="gender" value="여" style="width: 4%">
				    	<span>무관</span> <input class="col-1" type="radio" name="gender" value="여" style="width: 4%">
			    	</div>
		    	<div>
		    	
		    	<div class="inputGroup">
			    	<div class="inputText" style="width: 100%;">
			    		기타 [추가 입주 조건]
			    	</div>
			    	<textarea id="condition" name="condition" placeholder="[optional...]" style="resize: none; width: 98%;"></textarea>
		    	</div>
	
		    	<p class="title">
		    		추가 사진
		    	</p>
	    	</div>
	    	
	    	<div class="savePost">
			    <input type='file' id='btnAtt' name="files" multiple='multiple' accept="image/jpeg, image/png, image/jpg">
			    
			    <div id='att_zone'
			    	data-placeholder='방을 소개할 수 있는 추가사진을 첨부해주세요 :) [파일 선택버튼 클릭 or 드래그]'></div>
				</div>
				<div class="text-center">
	    			<button class="btn btn-dark" id="postSave" type="button" style="width: 100px;">저장</button>
		    	</div>
	    	</div>
    	
		</div>
    	
   	</div>
    
    </form>
    <!-- 메인 끝 -->
    
    <!-- footer -->
    <div class="container">
        <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
            <div class="col-md-4 d-flex align-items-center">
            <a href="/" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
                <svg class="bi" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
            </a>
            <span class="text-muted">멘톨</span>
            </div>
        
            <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
            <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#twitter"/></svg></a></li>
            <li class="ms-3"><a class="text-muted" href="	#"><svg class="bi" width="24" height="24"><use xlink:href="#instagram"/></svg></a></li>
            <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#facebook"/></svg></a></li>
            </ul>
        </footer>
    </div>

<script src="/js/roommatenewpost.js?<%=System.currentTimeMillis()%>>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>