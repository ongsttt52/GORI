<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href='${pageContext.request.contextPath}/css/classes.css'>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://kit.fontawesome.com/f87116b39f.js" crossorigin="anonymous"></script>
<style>
	body,html {
		width:100%;
		height:100%;
		margin: 0;
		background: #171717;
		color:white;
	}
	section {
		width:400px;
		height: 100%;
		margin:15px auto;
		overflow-x:hidden;
		overflow-y:visible;
	}
	section>div {
		display:flex;
		width:1200px;
		height:100%;
	}
	section>div>div{
		width:400px;
		height:100%;
		padding-left:40px;
		text-align:left;
	}
	input[type="submit"] {
		width: 320px;
	    height: 50px;
	    margin-top: 20px;
	    background-color: #fff480;
	    border-radius: 50px;
	    outline: none;
	    border:none;
	    color: black;
	    font-size: 17px;
	    font-weight: 700;
	    cursor: pointer;
	}
	input[type="text"], input[type="password"] {
		width: 320px;
	    height: 45px;
	    margin: 10px auto;
	    padding: 0 10px;
	    outline:none;
	    border:1px solid gray;
	    border-radius: 5px;
	    background-color: #171717;
	    color:white;
	    font-size: 15px;
	}
	label>h4 {
		margin-bottom: 0;
	}
	#div2{
	}
	#div3{
	}
	.langBtn {
		background:none;
		border:none;
		margin: 10px 10px 0 0;
		color:white;
		font-weight:1000;
		font-size:25px;
		cursor:pointer;
	}
	.page {
		font-size:20px;
		font-weight: 800;
	}
	#msg1, #msg3, #msg4 {
		display:none;
		width:330px;
	    padding: 10px;
		background: red;
	    color: white;
	    font-size: 15px;
	    font-weight: 500;
	}

</style>
</head>
<body>
	<section>
		<div id="div0">
			<div id="div1">
				<img src="./media/image/icon/logo.png" width="90px"><br>
				<button type="button" class="langBtn"><i class="fa-solid fa-arrow-left" style="color: #ffffff;"></i></button><span class="page">1/3</span>
				<h1>비밀번호를 재설정하세요.</h1>
				<p>GORI 계정에 연결된 이메일 주소를 입력해주시면 이메일을 보내드리겠습니다.</p>
				<p id="msg1"><i class="fa-solid fa-circle-exclamation"></i> 연결된 이메일이 없습니다. 확인 후 다시 시도해주세요.</p>
				<form id="form1" method="post" action="">
					<label><h4>이메일 주소</h4>
						<input class="inputText" type="text" id="email" name="email" >
					</label>
					<input type="submit" id="submitBtn" value="보내기">
				</form>
			</div>
			<div id="div2">
				<img src="./media/image/icon/logo.png" width="90px"><br>
				<button type="button" class="langBtn"><i class="fa-solid fa-arrow-left" style="color: #ffffff;"></i></button><span class="page">2/3</span>
				<h1>비밀번호를 재설정하세요.</h1>
				<p>인증번호 전송됨 (미구현)</p>
				<form id="form2" action="">
					<label><h4>인증번호</h4>
						<input type="text" name="num">
					</label>
					<input type="submit" value="인증하기">
				</form>
			</div>
			<div id="div3">
				<img src="./media/image/icon/logo.png" width="90px"><br>
				<button type="button" class="langBtn"><i class="fa-solid fa-arrow-left" style="color: #ffffff;"></i></button><span class="page">3/3</span>
				<h1>비밀번호를 재설정하세요.</h1>
				<p>새로운 비밀번호를 입력하세요.<br><span style="font-weight:1000; font-size:17px;">영어 소문자, 영어 대문자, 숫자, 특수문자(!@#$)가 모두 포함되어야 하며 10자 이상 25자 이하</span>여야 합니다.</p>
				<p id="msg3"><i class="fa-solid fa-circle-exclamation"></i> 비밀번호가 서로 틀립니다.</p>
				<p id="msg4"><i class="fa-solid fa-circle-exclamation"></i> 비밀번호를 조건에 맞게 설정해주세요.</p>
				<form method="post" action="forgot?page=3" onsubmit="return formCheck(this)">
					<input type="hidden" id="emailHidden" name="email" value="">
					<label>새 비밀번호
						<input class="inputText" type="password" id="pwd" name="pwd"> 
					</label>
					<label>비밀번호 확인
						<input class="inputText" type="password" id="pwdCheck" name="pwdCheck">
					</label>
					<input type="submit" value="변경!">
				</form>			
			</div>
		</div>
	</section>
	<script>
		$('#form1').submit(function(e) {
			e.preventDefault(); // 기본 폼 제출 동작 막음
			let submited = false;
			let value = $('#email').val();
			$.ajax({
				type:'POST',
				url:'/GORI/forgot?page=1',	
				data:{email:value},
				dataType:'json',
				success: function(result) {
					console.log(result.res);
					if(result.res == "notFound") {
						$('#msg1').show();
						submited = false;
					} else {
						$('#msg1').hide();
						submited = true;
						$('#div0').css('transform','translateX(-400px)').css('transition', 'transform 0.5s ease-in-out');
						// AJAX 요청은 비동기적으로 실행되기 때문에 요청이 끝나기 전에 바깥의 코드가 먼저 실행될 수 있다. 따라서 애니메이션 코드를 바깥에 두었을 때 제대로 작동하지 않을 수 있음
					}
				}, error: function(request, status, error) {console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)}
			});
			console.log(submited);
			
		});
		$('#form2').submit(function(e) {
			e.preventDefault(); // 기본 폼 제출 동작 막음
			$('#div0').css('transform','translateX(-800px)').css('transition', 'transform 0.5s ease-in-out');
		});
		
		$('.langBtn').click(function(e) {
			console.log($(e.target).nextAll('.page')); // 브라우저는 이벤트가 발생한 가장 구체적인 요소에서 이벤트를 트리거하므로 e.target은 i를 가리킨다. this는 이벤트 핸들러가 바인딩된 (직접적으로 이벤트가 연결된) 요소를 가리키기 때문에 this를 사용하면 됨
			if($(this).nextAll('.page').text() == '3/3') {
				$('#div0').css('transform','translateX(-400px)').css('transition', 'transform 0.5s ease-in-out');
			} else {
				$('#div0').css('transform','translateX(0)').css('transition', 'transform 0.5s ease-in-out');
			}
		});
		
		// 비밀번호 확인
		const pwdReg= /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$])[A-Za-z0-9!@#$]{10,25}$/;
		let pwdToggle = false;
		let checkToggle = false;
		function formCheck(form) {
			if(!pwdReg.test($('#pwd').val())) {
				$('#msg4').show();
				pwdToggle = false;
			} else {
				$('#msg4').hide();
				pwdToggle = true;
			}
			if($('#pwd').val() != $('#pwdCheck').val()) {
				$('#msg3').show();
				checkToggle = false;
			} else {
				$('#msg3').hide();
				checkToggle = true;
			}
			// $('#emailHidden').val() = $('#email').val(); val() 메서드는 값을 설정하거나 호출하는 메서드 이므로
			$('#emailHidden').val($('#email').val()); // 의 형태로 사용해야한다
			if(pwdToggle && checkToggle) {
				return true;
			} else {
				return false;
			}
		}
	</script>
</body>
</html>