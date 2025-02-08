<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    	/* 미디어 쿼리: 최대 화면 너비가 768px일 때 */
		@media (max-width: 768px) {
			#wrapper {
				padding: 0;
			}
		    /* 섹션 너비를 90%로 줄여서 모바일에서도 보기 좋게 */
		    #wrapper > section {
		        width: 90%;
		        height: 100%;
		        padding: 10px;
		    }
		
		    /* 폼 요소 너비를 100%로 조정 */
		    #loginForm .formDiv {
		        width: 100%;
		    }
		
		    /* 입력 필드 너비를 부모의 100%로 설정 */
		    #login-main input,
		    #login-main #btn-submit {
		        width: 90%;
		    }
		
		    /* 로그인 버튼 크기 조정 */
		    #login-link > button {
		        width: 90%;
		        height: 45px;
		    }
		
		    /* 경고 메시지 너비 조정 */
		    .alertMsg {
		        width: 90%;
		    }
		
		    /* 기타 텍스트 및 폰트 크기 조정 */
		    #login-header h1 {
		        font-size: 18px;
		    }
		
		    #login-main p {
		        font-size: 14px;
		    }
		}
        #wrapper {
        	padding: 20px 0;
        	background: rgb(40,40,40);
            background: linear-gradient(180deg, rgba(40,40,40,1) 0%, rgba(0,0,0,1) 100%);
        }
        #wrapper>section {
        	width: 700px;
        	min-height: 700px;
        	height: 100%;
        	margin: 0 auto;
        	padding: 15px 0;
        	background-color: black;
        	border-radius: 10px;
        }
		#login-header {
		    width: 100%;
		    font-size: 22px;
		    text-align: center;
		}
		.alertMsg {
			display:none;
		    width: 300px;
		    margin: 0 auto;
        	margin-bottom: 5px;
        	padding-left: 15px;
        	border-radius: 5px;
        	background-color: red;
        	font-size:15px;
        	font-weight: 300;
        	line-height: 45px;
        	text-align: left;
		}
		#login-link {
		    display: flex;
		    flex-direction: column;
		    justify-content: end;
		    width: 100%;
		    padding: 10px 0;
		}
		#login-link>button {
		    width: 45%;
		    height: 50px;
		    margin: 5px auto;
		    border: 1px solid gray;
		    border-radius: 50px;
		    font-size: 15px;
		    font-weight: 600;
		}
		#login-link img {
		    vertical-align: middle;
		    margin-right: 5px;
		    border-radius: 50%;
		}
		#login-link>button:hover {
		    border:3px solid white;
		}
		#login-main {
			width: 100%;
			height: 60%;
		}
		#login-main a:hover {
			text-decoration: underline;
		}
		#login-main hr {
		    width: 70%;
		    margin: 0 auto;
		    margin-top: 10px;
		    border: none;
	    	border-top: 0.5px solid gray;
		}
		#login-main #loginForm {
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			align-items: center;
		    position: relative;
		    width: 100%;
		    padding: 10px 0;
		}
		#login-main .formAlert  {
		    display: none;
		    margin-bottom: 10px;
		    color: red;
		    font-size: 15px;
		    font-weight: 400;
		}
		#loginForm .formDiv {
			width: 45%;
			margin: 0 auto;
			padding-top: 10px;
		}
		#login-main input {
		    width: 320px;
		    height: 45px;
		    margin-top: 5px;
		    padding: 0 10px;
		    background-color: transparent;
		    border:1px solid gray;
		    outline:none;
		    border-radius: 3px;
		    font-size: 15px;
		}
		#login-main input:focus {
		    border:2px solid white;
		}
		#login-main #rememButton {
		    position:relative;
		    width: 33px;
		    height: 16px;
		    margin : 10px auto;
		    background-color: #878787;
		    border-radius: 11px;
		    border:none;
		    vertical-align: middle;
		    transition-duration: 0.1s;
		}
		#indicator {
		    position:absolute;
		    top:2px;
		    left:3px;
		    width: 12px;
		    height: 12px;
		    border-radius: 50%;
		    background-color: black; 
		    transition-duration: 0.1s;
		}
		#rememDiv span {
		    font-size: 12px;
		    font-weight: 200;
		}
		#login-main #btn-submit {
		    width: 320px;
		    height: 50px;
		    background-color: #fff480;
		    border-radius: 50px;
		    outline: none;
		    border:none;
		    color: black;
		    font-size: 17px;
		    font-weight: 700;
		    cursor: pointer;
		    transition: transform ease 0.2s;
		}
		#btn-submit:hover {
			transform: scale(1.02, 1.02);
		}
		.rememButton-checked {
			background-color: #fff480 !important;
		}
		.indicator-checked {
			left:17px !important;
		}
		#submitDiv {
			display: flex;
			flex-direction: column;
			padding: 0;
			justify-content: space-around;
			align-items: center;
		}
		#submitDiv input {
			margin-bottom: 10px;		
		}
		#registerDiv {
			text-align: center
		}
        .pwdButton {
        	float: right;
            position: relative;
            right: 15px;
            bottom: 36px;
         	font-size: 25px;   
        }
    	
    </style>
</head>
<body>
    <div id="wrapper">
        <section>
            <div id="login-header">
                <a href="<c:url value='/'/>"><img src="<c:url value='/resources/image/icon/logo.png'/>" width="100px"></a>
                <h1>GORI에 로그인하기</h1>
                <div id="form-invalidMsg" class="alertMsg">
                    <p>잘못된 사용자 이름 또는 비밀번호입니다.</p>
                </div>
            </div>
            <div id="login-link">
                <button type="button" id="btn-google" onclick=""><img src="https://accounts.scdn.co/sso/images/new-google-icon.72fd940a229bc94cf9484a3320b3dccb.svg">Google로 계속하기</button>
                <button type="button" id="btn-naver" onclick=""><img src="https://accounts.scdn.co/sso/images/new-facebook-icon.eae8e1b6256f7ccf01cf81913254e70b.svg">facebook으로 계속하기</button>
                <button type="button" id="btn-apple" onclick=""><img src="https://accounts.scdn.co/sso/images/new-apple-icon.e356139ea90852da2e60f1ff738f3cbb.svg">Apple로 계속하기</button>
            </div>
            <div id="login-main">
                <hr>
            	<form id="loginForm" name="loginForm" method="post" action="<c:url value='/login'/>" onsubmit="return formCheck(this)">
	                <div id="emailDiv" class="formDiv">
	                    <p>이메일 또는 사용자 이름</p>
	                    <input type="text" id="input-email" name="email" placeholder="이메일 또는 사용자 이름" value='${empty cookie ? "" : cookie.email.value}' autocomplete="username"> <!-- 작은따옴표가 없으면 공백값이 들어갔을때 값이 없어지는 경우가 생김 -->
	                    <p class="formAlert">이메일을 입력해주세요.</p>
	                </div>
	                <div id="pwdDiv" class="formDiv">
	                    <p>비밀번호</p>
	                    <input type="password" id="input-password" name="pwd" placeholder="비밀번호" autocomplete="current-password">
                        <button type="button" class="pwdButton" data-toggle="false"><i class="fa-regular fa-eye-slash" style="color: #fff480;"></i></button>
	                    <p class="formAlert">비밀번호를 입력해주세요.<br></p>
	                </div>
	                <div id="rememDiv" class="formDiv">
	                    <c:choose>
		                    <c:when test="${empty cookie.email}">
		                	    <button type="button" id="rememButton">
		                        	<span id="indicator"></span>
		                    	</button>
		                    	<input type="checkbox" id="checkbox-rememberMe" class="displayNone" name="rememberMe"> 
		                    	<span>내 정보 기억하기</span>
		                    </c:when>
		                    <c:otherwise>
			                    <button type="button" id="rememButton" class="rememButton-checked">
		                        	<span id="indicator" class="indicator-checked"></span>
			                    </button>
			                    <input type="checkbox" id="checkbox-rememberMe" class="displayNone" name="rememberMe" checked> 
			                    <span>내 정보 기억하기</span>
		                    </c:otherwise>
	                    </c:choose>
	                </div>		
	                <div id="submitDiv" class="formDiv">
	                    <input type="submit" id="btn-submit" value="로그인하기">
                        <a href="javascript:void(0)" id="forgotPwd">비밀번호를 잊었나요?</a>
                        <!-- javascript:void(0) -> 링크 클릭 시 페이지가 이동하지 않도록 막음 -->
	                </div>
	                <div id="registerDiv" class="formDiv">
	                	<hr style="width:100%; margin-bottom:15px;">
	                	<span style="font-size: 14px; color:rgb(179, 179, 179)">계정이 없나요? </span><a href="<c:url value='/regist'/>">GORI에 가입하기</a>
            		</div>
                </form>
            </div>
        </section>
    </div>
    <script>
    	const emailInputEle = document.getElementById('input-email');
        const pwdInputEle = document.getElementById('input-password');
        const formAlertEle = document.getElementsByClassName('formAlert')
    	const btnRemEle = document.getElementById('rememButton');
        
        if(!${empty msg}) alert(${msg});
        
        /* 폼 유효성 체크 */
        function formCheck(frm) {
        	// $('#loginForm').preventDefault(); -> preventDefault를 사용하려면 이벤트 객체를 전달받아야 함
        	event.preventDefault();
            let isValid = true;
            
            if(emailInputEle.value.length == 0) {
                formAlertEle[0].style.display="block"
                isValid = false;
            }
            if(pwdInputEle.value.length == 0) {
                formAlertEle[1].style.display="block";
                isValid = false;
            }
            if(!isValid) {
            	return false;
            }
            
            const email = frm.email.value;
            const pwd = frm.pwd.value;
            
            // 이메일,비밀번호 체크
            $.ajax({
        		type: 'POST',
        		url: contextPath+'/login/check',
        		data: {email:email, pwd:pwd},
        		success: function(result) {
        			if(result === 'SUCCESS') {
        				frm.submit();
        			} else if(result == "FAIL") {
        				$('#form-invalidMsg').show();
        			} else if(result === 'DENIED') {
        				alert('비활성화된 계정입니다.');
        			} else {
        				throw new Error();
        			}
        		}, error: function(error) {console.log(error);}
        	});
            // isValid 값을 변경하는 AJAX 요청이 비동기적으로 처리되기 때문에 return isValid;가 호출될 때 AJAX 요청이 완료되지 않을 수 있음
            return false; // AJAX 요청이 완료될 때까지 폼 제출을 막음
        }
	
        /* formCheck 경고문구를 keydown 이벤트로 없애기 */
        emailInputEle.addEventListener('keydown', function() {
            formAlertEle[0].style.display = "none";
        });
        pwdInputEle.addEventListener('keydown', function() {
            formAlertEle[1].style.display = "none";
        });
        
        document.addEventListener('DOMContentLoaded', function() {
        });
        
        
        // 내 정보 기억하기
        const checkRemEle = document.getElementById('checkbox-rememberMe');
        const indicatorEle = document.getElementById('indicator');
        
        btnRemEle.addEventListener("click", function() {
        	if(checkRemEle.checked==true) {
                checkRemEle.checked = false;
                indicatorEle.classList.remove("indicator-checked");
                btnRemEle.classList.remove("rememButton-checked");
            }
        	else {
        		checkRemEle.checked = true;
                indicatorEle.classList.add("indicator-checked");
                btnRemEle.classList.add("rememButton-checked");
        	}
        });
        
        // 비밀번호 표시하기
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
    	
    	// 비밀번호 찾기
    	$('#forgotPwd').click(function() {
    		// 팝업 띄우기
    		window.open('forgot', 'forgotYourPassWord?', 'width=450, height=550');
    	});
    </script>
</body>
</html>