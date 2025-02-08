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
            font-family: "Noto Sans KR", sans-serif;
            color: white;
        }
        body, html {
            width: 100%;
            height: 100%;
        }
        body {
            display: flex;
            flex-direction: column;
            background-color: #121212;;
        }
        header {
            width: 100%;
            margin-top: 20px;
            text-align: center;
        }
        header>h1 {
            font-size: 50px;
        }
        header>h3 {
            color: #FFF480;
        }
        main {
            width: 40%;
            margin:0 auto;
        }
        #profileForm {
            display: flex;
            flex-direction: column;
            width: 600px;
            margin: 10px auto;
            padding: 20px;
        }
        #profileForm>div {
            width: 100%;
        }
        #firstDiv {
            display: flex;
            flex-wrap:wrap;
            justify-content:space-between;
            align-items: center;
        }
        #firstDiv button {
        	position:relative;
        	background:none;
        	border:none;
        }
        #firstDiv button:hover {
        	background:#ffffff3a;
        	cursor: pointer;
        }
        #firstDiv img:first-of-type {
        	width:100px;
        	height:100px;
        	margin-top: 10px;
        	border-radius:50%;
        }
        #firstDiv input[type="radio"] {
        	display:none;
        }
        .imgChecked {
        	position:absolute;
        	width:60px;
        	height:60px;
        	top:25px;
        	left:25px;
        	z-index:10;
        }
        fieldset {
            height: 390px;
            margin-top: 20px;
            padding: 10px 20px;
            border: 1px solid #7e7e7e;
            border-radius: 5px;
        }
        fieldset>div {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            padding: 3px;
        }
        #genreDiv label {
            width: 80px;
            height: 30px;
            margin: 5px;
            border-radius: 5px;
            background-color: #FFF4808e;
            color: black;
            font-weight: 500;
            text-align: center;
            line-height: 27px;
            cursor: pointer;
            user-select: none;
        }
        .genreCheckBox {
            display: none;
        }
        fieldset #artistDiv {
            height: 50px;
            border: 1px solid white;
        }
        fieldset #musicDiv {
            height: 50px;
            border: 1px solid white;
        }
        #lastDiv {
            height: 130px;
            margin-top: 20px;
        }
        #lastDiv textarea {
            display: inline-block;
            width: 100%;
            height: 100px;
            margin-top: 5px;
            padding: 10px;
            background-color: transparent;
            border: 1px solid #7e7e7e;
            border-radius: 5px;
            resize: none;
        }
        textarea:focus {
           outline : none;
        }
        
        #profileForm input[type="submit"] {
            width: 250px;
            height: 60px;
            margin: 20px auto;
            border-radius: 50px;
            background-color: #fff480;
            color: black;
            font-size: 25px;
            font-weight: 600;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            transform: scale(1.03, 1.06);
            transition-duration: 0.3s;
        }
    </style>
</head>

<body>
    <header>
        <a href="<c:url value='/'/>"><img src="<c:url value='/resources/image/icon/logo.png'/>" width="120px"></a>
        <h1>프로필 생성하기</h1>
        <h3>거의 다 됐습니다!</h3>
    </header>
    <main class="scroll">
        <form id="profileForm" method="post" name="profileForm" action="<c:url value='/regist'/>" onsubmit="return formCheck()">
        	<input type="hidden" name="page" value="3">
           	<input type="hidden" id="email" name="email" value="${user.email }">
           	<input type="hidden" name="pwd" value="${user.pwd }">
           	<input type="hidden" name="name" value="${user.name }">
       		<input type="hidden" name="birth" value="${user.birth }">
           	<input type="hidden" name="gender" value="${user.gender }">
        	<input type="hidden" name="agreed" value='${user.agreed}'>
            <h4>프로필 사진 선택하기...</h4>
            <div id="firstDiv">
                <c:forEach begin="1" end="10" var="i">
	                <button type="button" class="imgBtn"><img src="<c:url value='/resources/image/profile/default_${i}.png'/>"></button>
	                <input type="radio" class="profileImg" name="profileImg" value="/resources/image/profile/default_${i}.png">
                </c:forEach>
            </div>

            <fieldset>
                <legend><h3>선택하기</h3></legend>
                <h4>장르</h4>
                <div id="genreDiv">
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="POP">팝</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="ROCK">록</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="HIPHOP">힙합</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="RNB">R&B</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="BLUES">블루스</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="JAZZ">재즈</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="CLASSICAL">클래식</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="EDM">EDM</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="HOUSE">하우스</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="DISCO">디스코</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="FUNK">펑크</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="COUNTRY">컨트리</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="FOLK">포크</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="KPOP">K-Pop</label>
					<label class="genreLabel"><input type="checkbox" class="genreCheckBox" name="genre" value="INDIE">인디</label>
                </div>
                <h4>아티스트</h4>
                <div id="artistDiv">
                	<div id="recommendDiv-artist">추천 아티스트</div>
                	<input type="search" id="searchInput-artist" class="searchInput" placeholder="검색하기">
                </div>
                <h4>곡</h4>
                <div id="musicDiv">
                	<div id="recommendDiv-music">추천 음악</div>
                    <input type="search" id="searchInput-music" class="searchInput" placeholder="검색하기">
                </div>
            </fieldset>
            <input type="submit" value="완료!"></input>
        </form>
    </main>
    <script>
        const genreEle = document.getElementsByClassName("genreCheckBox");
        const genreLabelEle = document.getElementsByClassName("genreLabel");

        /* 장르를 누르면 배경색이 바뀌고 연결된 checkbox가 checked 됨 */
        for(let i=0; i<genreEle.length; i++) {
        genreLabelEle[i].addEventListener("click", function() {
                if(genreEle[i].checked) {
                    genreEle[i].checked=false;
                    genreLabelEle[i].style.backgroundColor="#FFF4808e";
                }
                else {
                    genreEle[i].checked=true;
                    genreLabelEle[i].style.backgroundColor="#FFF480";
                }
            }); 
        }

         const profileImg = document.getElementsByClassName("profileImg");
         const imgBtn = document.getElementsByClassName("imgBtn");
         const imgChecked = document.createElement('img');
         const srcNode = document.createAttribute('src');
         srcNode.value= contextPath+"/resources/image/icon/checked.png";
         imgChecked.setAttributeNode(srcNode);
         imgChecked.classList.add('imgChecked');
         
         for(let i=0; i<imgBtn.length; i++) {
        	 imgBtn[i].addEventListener("click", function() {
				this.appendChild(imgChecked);
				// appendChild() 메서드는 DOM 트리에서 요소를 이동시킨다. 즉, imgChecked 요소가 이미 DOM 트리에 존재하는 경우 appendChild()를 사용하면 그 요소가 현재 위치에서 새로운 위치로 이동함.
				// 그러므로 새로운 부모에 추가될 때 기존 부모에서 자동으로 제거된다.
				profileImg[i].checked=true;
				this.childNodes[0].style.opacity="0.5";
				for(let i2=0; i2<imgBtn.length; i2++) {
					if(i2==i) {continue;}
					imgBtn[i2].childNodes[0].style.opacity="1.0";
				}
        	 });
        	 
         }
        
        function formCheck() {
        	let isValid = false;
        	for(let i=0; i<profileImg.length; i++) {
        		if(profileImg[i].checked==true) {
        			isValid = true;
        		}
        	}
            if(isValid) {
            	return true;
            } else {
            	return false;
            }
        }
    </script>
</body>
</html>