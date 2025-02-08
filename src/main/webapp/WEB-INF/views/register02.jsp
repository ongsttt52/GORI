<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GORI</title>
<style>
     * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        border-collapse: collapse;  
        font-family: "Noto Sans KR", sans-serif;
        color: white;
    }
    html, body {
        position:relative;
        width: 100%;
        height: 100%;
        background: #121212;
    }
    a {
        text-decoration: underline;
        color: #FFF480;
    }
    ul {
        list-style: none;
    }
    button, input {
        border: none;
        background-color: transparent;
    }
    button {
        cursor:pointer;
    }
    hr {
        border:0;
        background-color: white;
        height: 1px;
    }
    main {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 100%;
    }
    main>header {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 65px;
        margin-top: 20px
    }
    section>div {
        width: 450px;
        height: 833px;
        padding: 0 40px;
    }
    section>div>header {
        width: 400px;
        font-size: 32px;
        text-align: center;
    }
    section h1 {
        padding-right: 30px;
    }
    #termsContainer {
        display: flex;
        flex-direction: column;
        justify-content: start;
        align-items: center;
        height: 450px;
        padding: 50px 0;
    }
    #termsContainer .terms {
        width: 320px;
        height: 60px;
        margin: 10px 0;
        padding: 15px;
        border-radius: 5px;
        background-color: #36363679;
        line-height: 30px;
    }   
    .terms:hover .label{
        border-color: #FFF480;
    }
    .termsCheckBox {
        display: none;
    }
    .label {
        display: inline-block;
        width: 20px;
        height: 20px;
        margin-right: 5px;
        border: 1px solid #7e7e7e;
        border-radius: 5px;
        text-align: center;
        line-height: 18px;
    }
    .requiredAlert {
        display: none;
        width: 80%;
        margin: 0 auto;
        color: red;
        font-size: 14px;
        font-weight: 400;
    }
    form input[type="submit"] {
        width: 100%;
        height: 55px;
        margin-top: 20px;
        border-radius: 50px;
        background-color: #FFF480;
        color: black;
        font-size: 18px;
        font-weight: 500;
        cursor: pointer;
    }
    input[value="다음"]:hover {
        transform: scale(1.03, 1.06);
        transition-duration: 0.3s;
    }
</style>
</head>

<body>
    <main>
        <header>
            <a href="<c:url value='/'/>"><img src="<c:url value='/resources/image/icon/logo.png'/>" width="120px"></a>
        </header>
        <section>
            <div>
                <header><h1>가입하고 원하는<br>음악을 감상하세요</h1></header>
                <form id="termsForm" action="<c:url value='/regist'/>" method="post" onsubmit="return formCheck()">
                	<input type="hidden" name="page" value="2">
                	<input type="hidden" id="email" name="email" value="${user.email }">
                	<input type="hidden" name="pwd" value="${user.pwd }">
                	<input type="hidden" name="name" value="${user.name }">
                	<input type="hidden" name="birth" value="${user.birth }">
                	<input type="hidden" name="gender" value="${user.gender }">
                    <div id="termsContainer">
                        <div class="terms">
                            <label class="label">
                                <i class="fa-solid fa-check" style="color: transparent"></i>
                                <input type="checkbox" class="termsCheckBox required" name="termsCheckBox">
                            </label>
                            <a href="약관">(필수) 개인정보 수집 및 이용</a>
                        </div>
                        <p class="requiredAlert">* 약관에 동의해 주세요.</p>
                        <div class="terms">
                            <label class="label">
                                <i class="fa-solid fa-check" style="color: transparent"></i>
                                <input type="checkbox" class="termsCheckBox required" name="termsCheckBox">
                            </label>
                            <a href="약관">(필수) GORI 이용 약관</a>
                        </div>
                        <p class="requiredAlert">* 약관에 동의해 주세요.</p>
                        <div class="terms">
                            <label class="label">
                                <i class="fa-solid fa-check" style="color: transparent"></i>
                                <input type="checkbox" class="termsCheckBox" name="agreed">
                            </label>
                            <span>마케팅 메시지 수신 동의(선택사항)</span>
                        </div>
                    </div>
                    <input type="submit" value="다음" >
                </form>
            </div>
        </section>
    </main>
    <script>
        const checkBoxEle = document.getElementsByClassName('termsCheckBox');
        const checkBoxRequired = document.getElementsByClassName('required');
        const iCheckEle = document.getElementsByClassName('fa-check');
        const termsDivEle = document.getElementsByClassName('terms');
        const label = document.querySelectorAll(".label");
        const requiredAlertEle = document.getElementsByClassName('requiredAlert')
		
        // 약관Div 클릭시 체크박스가 체크되도록 이벤트 추가
        for(let i=0; i<checkBoxEle.length; i++) {
            termsDivEle[i].addEventListener("click", function() {
                if(checkBoxEle[i].checked) {
                    checkBoxEle[i].checked=false;
                    label[i].style.backgroundColor="#36363679";
                    label[i].style.borderColor="#7e7e7e";
                    iCheckEle[i].style.color="transparent";
                }
                else {
                    checkBoxEle[i].checked=true;
                    label[i].style.backgroundColor="#FFF480";
                    label[i].style.borderColor="transparent";
                    iCheckEle[i].style.color="#121212";
                }
                if(i==checkBoxEle.length-1) return;
                if(checkBoxRequired[i].checked) {
                    requiredAlertEle[i].style.display="none";
                }
            });
        }
        /* 필수약관 폼체크 */
        function formCheck() {
            for(let i=0; i<checkBoxRequired.length; i++) {
                if(!checkBoxRequired[i].checked) {
                    requiredAlertEle[i].style.display="inline-block";
                    if(i==checkBoxRequired.length-1) return false;
                }
            }
            return true;
        }

    </script>
</body>
</html>