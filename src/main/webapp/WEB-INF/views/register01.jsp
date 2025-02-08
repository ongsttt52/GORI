<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./include.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GORI</title>
	<style>
    	main {
			display: flex;
			flex-direction: column;
            width: 100%;
            height: 100%;
            margin: 0 auto;
        }
        main>header {
        	display: flex;
        	flex-direction: column;
        	align-items: center;
        	position: relative;
            font-size: 23px;
            text-align: center;
        }
        .alertMsg {
        	margin-bottom: 5px;
        }
        #formNotValid {
		    background-color: var(--alert-red);
		}
		#emailDuplicated, #nameDuplicated {
		    background-color: var(--alert-orange);
		}
		#emailDuplicated {
			padding: 5px 0;
			padding-left: 15px;
			line-height: 30px;
		}
		#emailValid, #nameValid {
			background-color: var(--alert-green);
		}
        section #sectionDiv {
            width: 430px;
            height: 500px;
            margin: 0 auto;
            padding: 20px 20px 10px 40px;
        }
		#sectionDiv .formDiv {
			width: 100%;
			margin-bottom: 15px;
		}
        .pwdButton {
        	float: right;
            position: relative;
            right: 15px;
            bottom: 42px;
         	font-size: 25px;   
        }
        #pwdCheckUl {
            width: 100%;
            height: 50px;
            margin: 0 auto;
            text-align: left;
        }
        #pwdCheckUl li {
            display: inline-block;
            position: relative;
            width: 45%;
            height: 25px;
            color: white;
            font-size: 14px;
            font-weight: 300;
        }
        #pwdCheckUl li img {
            border-radius: 50%;
            width: 18px;
            margin: 0 10px 5px 0;
            vertical-align: middle;
            transition-duration: 1s;
        }
        #pwdCheckUl button {
            position:absolute;
            left: 0;
            top: 1px;
            width: 17px;
            height: 17px;
            background-color: #121212;
            border:1px solid #7e7e7e;
            border-radius: 50%;
            cursor: default;
        }
        .formDiv input[type="radio"] {
        	display:none;
        }
        #genderDiv {
        	display:flex;
        	justify-content:center;
        	border-collapse:collapse;
        }
        .genderButton {
            width: 34%;
            height: 30px;
            border:1px solid #7e7e7e;
        }
        .genderButton:first-of-type {
            background-color: #FFF480;
            color: black;
            font-weight: 600;
            border-right:none;
        }
        .genderButton:last-of-type {
        	border-left:none;
        }
        .genderButton:hover {
            background-color: #FFF480;
            color: black;
            font-weight: 600;
        }
        .notValidMsg {
        	display:none;
        	margin-bottom: 5px;
			color:red;
			font-weight: 400;
			font-size:14px;
        }
        #formDiv-submit {
        	display: block;
        	width: 260px;
        	height: 55px;
        	margin: 0 auto;
        	background-color: #FFF480;
        }
    </style>

</head>
<body>
    <main>
        <header>
            <a href="<c:url value='/'/>"><img src="<c:url value='/resources/image/icon/logo.png'/>" width="120px"></a>
            <h1>가입하고 원하는<br>음악을 감상하세요</h1>
            <p id="formNotValid" class="alertMsg" style="background-color:var(--alert-red)"><i class="fa-solid fa-circle-exclamation"></i> 모든 정보를 정확히 입력해주세요.</p>
            <p id="emailValid" class="alertMsg" data-target-name="email"><i class="fa-solid fa-check" style="color: #ffffff;"></i> 사용 가능한 이메일입니다!</p>
            <p id="emailDuplicated" class="alertMsg" data-target-name="email"><i class="fa-solid fa-circle-exclamation"></i> 이미 기존 계정과 연결된 주소입니다.<br>계속하려면 <a href="<c:url value='/login'/>" style="text-decoration:underline">로그인하세요.</a></p>
   			<p id="nameValid" class="alertMsg" data-target-name="name"><i class="fa-solid fa-check" style="color: #ffffff;"></i>사용 가능한 이름입니다!</p>
           	<p id="nameDuplicated" class="alertMsg" data-target-name="name"><i class="fa-solid fa-circle-exclamation"></i>사용중인 이름입니다.</p>
        </header>
        <section>
        	<div id="sectionDiv" class="scroll">
                <form id="regForm" name="regForm" method="post" action="<c:url value='/regist'/>" onsubmit="return formCheckOnSubmit()">
                	<input type="hidden" name="page" value="1">
                	<div id="emailDiv" class="formDiv">
	                    <label class="label">이메일 주소
	                    	<input type="text" id="email" class="inputText" name="email" placeholder="name@domain.com" autofocus>
	                    </label>
	           			<p class="notValidMsg">잘못된 형식입니다. name@domain.com의 형식으로 입력해주세요.</p>
                    </div>
                    <!--
                    oninput으로 formCheck()를 처리하니 맨 처음 글자를 입력한 상태에서 입력창을 벗어나지 않고 submit 하였을때 그냥 넘어가지는 문제 발생,
                    onkeyup로 바꾸어 키보드를 눌렀다 뗐을때 유효성이 검사되도록 변경
                    -->
                    <div id="pwdDiv" class="formDiv">
	                    <label class="label">비밀번호
	                        <input type="password" id="pwd" class="inputText" name="pwd" maxlength="25" placeholder="10~25자리의 문자+숫자+특수문자" autocomplete="new-password">    
	                        <button type="button" class="pwdButton" data-toggle="false"><i class="fa-regular fa-eye-slash" style="color: #fff480;"></i></button>
	                    </label>
	                    <p class="notValidMsg">10자 이상 입력해주세요.</p>
	                    <ul id="pwdCheckUl">
	                        <li><img src="<c:url value='/resources/image/icon/checkmark.png'/>"><button type="button"></button>숫자</li>
	                        <li><img src="<c:url value='/resources/image/icon/checkmark.png'/>"><button type="button"></button>소문자</li>
	                        <li><img src="<c:url value='/resources/image/icon/checkmark.png'/>"><button type="button"></button>대문자</li>
	                        <li><img src="<c:url value='/resources/image/icon/checkmark.png'/>"><button type="button"></button>특수문자(!@#$)</li>
	                    </ul>
                    </div>
                    <div id="pwdCheckDiv" class="formDiv">
	                    <label class="label">비밀번호 확인
	                    		<input type="password" id="pwdCheck" class="inputText" name="pwdCheck" maxlength="25" placeholder="비밀번호를 한 번 더 입력해주세요." autocomplete="current-password">
		                    	<button type="button" class="pwdButton" data-toggle="false"><i class="fa-regular fa-eye-slash" style="color: #fff480;"></i></button>
	                    </label>
                   	</div>
                   	<div id="nameDiv" class="formDiv">
                    	<label class="label">이름
                    		<input type="text" id="name" class="inputText" name="name" placeholder="이름은 프로필에 사용됩니다.">
                    	</label>
                    	
                   	</div>
                  	<div id="birthDiv" class="formDiv">
                      <label class="label">생년월일<input type="text" id="birth" class="inputText" name="birth" placeholder="YYYY-MM-DD 형식으로 입력해주세요" maxlength="10">
                      </label>
                      <p class="notValidMsg">생년월일을 YYYY-MM-DD 형식으로 입력해주세요.</p>
                    </div>
                    <div id="genderDiv" class="formDiv">
                        <button class="genderButton" type="button">남자</button>
                        <input type="radio" class="gender" name="gender" value="M" checked>
                        <button class="genderButton" type="button">여자</button>
                        <input type="radio" class="gender" name="gender" value="F">
                        <button class="genderButton" type="button">그 외</button>
                        <input type="radio" class="gender" name="gender" value="ETC">
                    </div>
                    <div id="submitDiv" class="formDiv">
                    	<input type="submit" id="formDiv-submit" class="inputSubmit" value="다음">
                    </div>
                </form>
            </div>
        </section>
    </main>
    <script>
        const emailEle = document.getElementById('email');
		const pwdEle = document.getElementById('pwd');
		const pwdCheck = document.getElementById('pwdCheck');
		const nameEle = document.getElementById('name');
		const birthEle = document.getElementById('birth');
		const genderEle = document.getElementsByClassName('gender');
		
		const emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		const pwdReg= /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$])[A-Za-z0-9!@#$]{10,25}$/; 
	    const pwdRegArr = [/(?=.*[0-9])/,/(?=.*[a-z])/,/(?=.*[A-Z])/,/(?=.*[!@#$])/];
	    const nameReg = /^[0-9a-zA-Z가-힣]{2,20}$/;
		const birthReg=/^[0-9]{4}[-][0-9]{2}[-][0-9]{2}$/;
		
		// 입력 필드와 그에 해당하는 정규식을 객체로 매핑, fields[name]의 key값이 일치하면 해당 객체를 반환하여 내용물에 접근 가능 const {element, regex} = fields[name]
		const fields = {
		    email: {
		        element: emailEle,
		        regex: emailReg
		    },
		    pwd: {
		        element: pwdEle,
		        regex: pwdReg
		    },
		    name: {
		    	element: nameEle,
		    	regex: nameReg
		    },
		    birth: {
		        element: birthEle,
		        regex: birthReg
		    }
		};
		
		// fields의 모든 key에 접근하여 element에 keydown 이벤트를 연결 
		// -> keydown 이벤트는 입력 필드에 입력값이 실제로 반영되기 전에 발생하므로, 비밀번호가 입력되기 전에 유효성 검사가 수행되어 의도한대로 동작하지 않음
		// -> 따라서 입력필드의 값이 실제로 반영된 후 발생하는 input 이벤트로 변경
		
		const keys = Object.keys(fields);
		for(let i=0; i<keys.length; i++) {
			fields[keys[i]].element.addEventListener("input", function(event) {
				formCheck(this.name, this.value);
			});
		}
		
		// 비밀번호 체크박스 끄기/켜기 
		function pwdCheckBox() {
	    	const checks = [false, false, false, false];
	    	
	    	// pwdValue의 문자열을 문자단위로 char에 저장하여 반복문 실행
	    	for (let char of pwdEle.value) {
	    		if (pwdRegArr[0].test(char)) checks[0] = true;
	    		else if (pwdRegArr[1].test(char)) checks[1] = true;
	    		else if (pwdRegArr[2].test(char)) checks[2] = true;
	    		else if (pwdRegArr[3].test(char)) checks[3] = true;
	    	}
	    	
	    	const button = document.querySelectorAll("#pwdCheckUl li button");
		    for(let i=0; i<checks.length; i++) {
		        if(checks[i]) {
		        	// 체크박스를 가리고 있는 버튼이 투명해짐
		            button[i].style.backgroundColor="transparent";
			        button[i].style.border="none";
		        }
		        else {
			        button[i].style.backgroundColor="#121212";
		            button[i].style.border="1px solid #7e7e7e";
		        }
		    }
		}
		
		// input 이벤트로 정규식 검사하기
		function formCheck(name, value) {
			// name이 fields의 키값일 경우
		    if (fields[name]) {
		        const {element, regex} = fields[name];
		        const isValid = regex.test(value);
		        const p = $(element).parent().next();
		        if(element === pwdEle) pwdCheckBox();
		        if(isValid) {
		        	$(element).removeClass('notValid');
		        	p.hide();
		        	return true;
		        } else {
		        	$(element).addClass('notValid');
		        	p.show();
		        	return false;
		        }
		    }
		}
	    
	    // 이메일, 이름 중복체크 
	    $('#email, #name').blur(function(event) {
	    	const target = $(event.currentTarget);
	    	const col = target.attr('name');
	    	const value = target.val();
            const alertMsg = $('main>header').find('[data-target-name="'+col+'"]');
			if(!fields[col].regex.test(value)) {
            	alertMsg.eq(0).hide();
            	alertMsg.eq(1).hide();
				return;
			}
            $.ajax({
                type:'POST',
                url: contextPath+'/regist/check',
                data: {col:col, value:value},
                success: function(result) {
                    if(result === "SUCCESS") {
                    	alertMsg.eq(0).show();
                    	alertMsg.eq(1).hide();
                    	target.removeClass('notValid');
                    } else if(result === "DUPLICATED") {
        				alertMsg.eq(1).show();
                    	alertMsg.eq(0).hide();
                    	target.addClass('notValid');
        	    	}
                }, error: function(error) {console.log(error);}
            });
	    });
	    
		// 폼체크
		function formCheckOnSubmit() {
			let passed = true;
			
			const date = new Date(birthEle.value);
	    	if(isNaN(date.getTime())) birthEle.classList.add('notValid');
	    	if (pwdEle.value != pwdCheck.value) pwdCheck.classList.add('notValid');
	    	
	    	const inputTexts = $('.inputText');
	    	inputTexts.each(function() {
	    		if($(this).val().length === 0) $(this).addClass('notValid');
	    		if($(this).hasClass('notValid')) passed = false;
	    	});
	    	
	    	if(!passed) $('#formNotValid').show();
	    	if(!passed) return false;
		    else return true;
		}
	    
		// 비밀번호 표시하기 버튼
		$('.pwdButton').on('click', function(event) {
			const target = $(event.currentTarget);
			const input = target.parent().find('input');
			if(!target.data('toggle')) {
				target.html('<i class="fa-regular fa-eye" style="color: #fff480;"></i>');
				input.attr('type', 'text');
				target.data('toggle', true);
			} else {
				target.html('<i class="fa-regular fa-eye-slash" style="color: #fff480;"></i>');
				input.attr('type', 'password');
				target.data('toggle', false);
			}
		});
		
		/* 성별 버튼을 눌렀을때 배경색이 바뀌고 해당 radio를 checked로 만들기 */
		const buttons = document.getElementsByClassName("genderButton")
		for(let i=0; i<buttons.length; i++) {
			buttons[i].addEventListener("click", function() {
				if(genderEle[i].checked==false) {
					genderEle[i].checked=true;
					buttons[i].style.backgroundColor="#FFF480"
		            buttons[i].style.color="black"
		            buttons[i].style.fontWeight=600;
					for(let i2=0; i2<buttons.length; i2++) {
						if(i2==i) continue;
						genderEle[i2].checked=false;
						buttons[i2].style.backgroundColor="#121212"
			            buttons[i2].style.color="white"
			            buttons[i2].style.fontWeight=500;
					}
				}
			});
		}
    </script>
</body>
</html>