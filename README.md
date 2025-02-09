<h1>GORI</h1>

> 실시간 피드 기능이 있는 음원 스트리밍 사이트 개발 <br/>
> 기간 : 2024.10.20 - 2024.11.20 (총 31일) <br/>
> 개발 인원 : 1명 <br/>

Link : 준비중 <br/>
PDF (45p) : https://www.miricanvas.com/v/13zq274 <br/>
Download <br/>
PDF : https://drive.google.com/file/d/11CnsBAK-ZvqyB-bf3c73GXYIN9MUZ1SJ/view?usp=drive_link <br/>
er diagram : https://drive.google.com/file/d/1pkyKuoiNpd0uCI-sZpvU7cTXttRo8r0r/view?usp=drive_link <br/> 
요구사항 정의서 : https://drive.google.com/file/d/15-VETOc3EE-phL5dZS0HYTIKwtCsMX1x/view?usp=drive_link <br/>

<h1>사용된 기술 스택</h1>
<ul>
 <li>
      <img src="https://img.shields.io/badge/java-red?style=for-the-badge&logo=java&logoColor=white"> 
      <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
    </li>
    <li>
      <img src="https://img.shields.io/badge/apache tomcat-orange?style=for-the-badge&logo=apachetomcat&logoColor=white">
      <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
      <img src="https://img.shields.io/badge/myBatis-black?style=for-the-badge&logo=myBatis&logoColor=white">
    <li>
      <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
      <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"> 
      <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> 
      <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">
      <img src="https://img.shields.io/badge/fontawesome-339AF0?style=for-the-badge&logo=fontawesome&logoColor=white">
    </li>
    <li>
     그 외 : Spotify API
    </li>
</ul>

  

<h1>구현 기능</h1>
<div>
    <ul>
        <li>
            <strong>계정</strong>
            <ul>
                <li>로그인, 로그아웃, 회원가입, 비밀번호 변경</li>
                <li>쿠키를 통해 아이디 기억하기</li>
                <li>관리자 계정을 통한 회원정보 조회, 일시정지, 강제 탈퇴</li>
            </ul>
        </li>
        <li>
            <strong>음악 스트리밍</strong>
            <ul>
                <li>스포티파이 API를 통해 음원 정보를 DB에 등록</li>
                <li>음원 재생, 재생 시간 조정, 볼륨 조절, 재생목록 셔플, 반복 재생 등</li>
            </ul>
        </li>
        <li>
           <strong>음원 정보</strong>
           <ul>
               <li>앨범, 아티스트, 플레이리스트의 상세 정보 조회</li>
               <li>곡명, 앨범명, 아티스트명으로 음원 검색</li>
               <li>아티스트 팔로우, 음원 좋아요</li>
           </ul>
        </li>
        <li>
            <strong>추천 알고리즘</strong>
            <ul>
                <li>특정 앨범, 아티스트, 플레이리스트와 유사한 콘텐츠를 추천하는 알고리즘 구현</li>
                <li>특정 회원이 선호하는 아티스트, 일주일간 가장 인기있는 곡 추천</li>
            </ul>
        </li>
        <li>
            <strong>플레이리스트, 재생목록</strong>
            <ul>
                <li>재생목록에 곡 추가, 삭제, 재생목록에서 곡 관리하기</li>
                <li>플레이리스트 생성, 곡 추가, 삭제, 전체 재생 등</li>
            </ul>
        </li>
        <li>
            <strong>실시간 피드</strong>
            <ul>
                <li>특정 음원을 선택하여 메세지와 함께 실시간 피드 작성</li>    
                <li>피드 목록 페이지네이션, 피드 수정, 삭제</li>
                <li>댓글 작성, 수정, 삭제</li>
            </ul>
        </li>
        <li>
           <strong>관리자 기능</strong>
           <ul>
              <li>관리자 계정을 통해 음원, 앨범, 아티스트 정보 수정, 삭제</li>
              <li>회원정보 검색, 정렬, 열람, 비밀번호 초기화, 활동정지, 계정삭제</li>
           </ul>
        </li>
    </ul>
</div>

<h1>Images</h1>
<div>
    <ul>
        <li>
            <strong>메인 화면</strong>
            <ul>
                <li>음악 재생, 음원 검색, 재생목록, 플레이리스트 재생, 인기 차트, 앨범 추천 등</li>
                  <img src="https://private-user-images.githubusercontent.com/177156866/411281862-b0c70550-cd04-4915-839a-d22abe122fca.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzE0NTIsIm5iZiI6MTczOTA3MTE1MiwicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgxODYyLWIwYzcwNTUwLWNkMDQtNDkxNS04MzlhLWQyMmFiZTEyMmZjYS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzE5MTJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0wZGY5NzJjYTgwODEyZTVkYTQ3NjUyMzMxMjU0YmFkZTJjNzkyYmJhYTg5Yzc2NGQxNjdmNGQ5MDEyZjI0MWY5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.sY6UyqnskxXURpZ-oG_QuoHiK6Pu-hXmT8EWD0JJoUY" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>로그인, 회원가입</strong>
            <ul>
                <li>프론트 유효성 검사</li>
                <li>아이디 중복검사</li>
                  <img src="[https://i.imgur.com/EOhnk2h.png](https://private-user-images.githubusercontent.com/177156866/411282048-3cda303e-4a4f-42ce-ad68-6056c37d887f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzE0NTIsIm5iZiI6MTczOTA3MTE1MiwicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMDQ4LTNjZGEzMDNlLTRhNGYtNDJjZS1hZDY4LTYwNTZjMzdkODg3Zi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzE5MTJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lMTk5Zjg4ZjU5MTZjMWZkNWZlN2ZjMGFlNWI5NTNiZmNmMzQzYmY3MjdlZDExZTgwMTBlZjAxNjQzZDUxZmJlJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.61DN8hK4GroeaAc0AyCU_t89GEWD3h8ZXqR3fxqDm0Y)" width="500px">
                 <img src="[https://i.imgur.com/jprSs3o.png](https://private-user-images.githubusercontent.com/177156866/411282010-610f91df-a5a9-4e7a-967b-4e3142ef0b64.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzE3NzMsIm5iZiI6MTczOTA3MTQ3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMDEwLTYxMGY5MWRmLWE1YTktNGU3YS05NjdiLTRlMzE0MmVmMGI2NC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI0MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03ZTNhNWVhZWIyNzQ4MjFiOTcxN2Q4NGZiODk5ZmYwZmQxOThlOTFiOTdmZDIyYzljYjg3OTQxNDY4OTE1MzM1JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.beqxvB-Ic8GfBhmpwB9dQliToabYjcXptUusRLOoei4)" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>회원가입</strong>
            <ul>
                <li>Order History / Account Information / Favorite Items</li>
                <li>Points / Inquiries</li>
                <li>Shipping Address Management / Subscription Management</li>
                  <img src="https://i.imgur.com/jprSs3o.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>앨범, 아티스트 정보</strong>
            <ul>
                <li>앨범 트랙 및 아티스트 정보 조회</li>
                <li>앨범 트랙 전체 재생, 음원 좋아요, 아티스트 팔로우</li>
                <li>유사한 앨범, 플레이리스트 추천</li>
                  <img src="https://private-user-images.githubusercontent.com/177156866/411282825-0f8d0bbe-85d1-4c2c-976c-5ecb1ead664d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzIwNzMsIm5iZiI6MTczOTA3MTc3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyODI1LTBmOGQwYmJlLTg1ZDEtNGMyYy05NzZjLTVlY2IxZWFkNjY0ZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI5MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jOThiYTA0ZWJkZjA0MTQzYjc4MTBkZmRjNjM4NTVkMjI5NTZlMGZiZGJmOWJlMzBjYWUwYTAyMWVmMzYzMzNmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.C-YCUhltQuCSsTd0kt9SBdwnzII2cuFMjfXBE2n8Wos" width="500px">
                  <img src="https://private-user-images.githubusercontent.com/177156866/411282123-e492a6d1-eddc-4aba-93f3-588b6164963d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzE3NzMsIm5iZiI6MTczOTA3MTQ3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMTIzLWU0OTJhNmQxLWVkZGMtNGFiYS05M2YzLTU4OGI2MTY0OTYzZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI0MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05NWFhZjc0MmI0YjA0ZWMyYjQ4OWM0ODQxMzgzZGQ5NGExZGVmZGFiNjdkY2FiODc3MzQyY2ZkZjkzNTYyODcwJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.at1o7ShN0hjX3Q2-jAilAoNS1ER3fwoyzJsZf8w3azQ" width="500px">
                  <img src="[https://i.imgur.com/1F9HDrs.png](https://private-user-images.githubusercontent.com/177156866/411282161-9f9c1b65-14a6-40b2-ae57-8a4851327ded.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzE3NzMsIm5iZiI6MTczOTA3MTQ3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMTYxLTlmOWMxYjY1LTE0YTYtNDBiMi1hZTU3LThhNDg1MTMyN2RlZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI0MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hNGJlY2I2NGJhY2ZmMWU5MTRlNzI4ZDI5MjdlNjZiNTE0MDZjZWQxYzhlMDkyMDkzZDY1YWFkYTg3Njg3Njg2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.NrHP1wLLVNMdaZUY7AE9vHzB8_q1bTcVr8qrvB2mMao)" width="500px">
                  <img src="[https://i.imgur.com/HvAiLXw.png](https://private-user-images.githubusercontent.com/177156866/411282204-7ce367b1-c7a1-42ee-bd49-804f5d582961.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzE3NzMsIm5iZiI6MTczOTA3MTQ3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMjA0LTdjZTM2N2IxLWM3YTEtNDJlZS1iZDQ5LTgwNGY1ZDU4Mjk2MS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI0MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yYTY3YWNjOWM4MDExZWQwOGRiYWM1NzA3ZGFmNzJjOWMyYzdlMzUxYWUzZmQxNzViNGFiZWFlNDJmYjJkZWM0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.bJM5QIMb1stXS4JjmW2ff1sekWTOhIb2fwBak5wwVb0)" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 기능</strong>
            <ul>
                <li>Spotify API를 통해 아티스트, 앨범 검색</li>
                <li>선택한 아티스트, 앨범 정보 데이터베이스에 저장</li>
                <li>음악, 회원정보를 검색해 정보 조회 및 수정, 삭제 가능</li>
                  <img src="[https://i.imgur.com/HvAiLXw.png](https://private-user-images.githubusercontent.com/177156866/411282273-30755f95-a13a-408b-a7c1-29010a3b2e7d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzIwNzMsIm5iZiI6MTczOTA3MTc3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMjczLTMwNzU1Zjk1LWExM2EtNDA4Yi1hN2MxLTI5MDEwYTNiMmU3ZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI5MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xMTY4Y2ZkNmZlOWNkM2ExZDU4MDc1M2Q5ODlhNzdlNjk4MTUyN2ZlNTA0NTI5Nzk1NzA0MWY2ZmZmYWM2OWVkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.9ejWs_GfPPOcVFTqdqSfvB_o0GmiA8CTlePnWbASf30)" width="500px">
                  <img src="[https://i.imgur.com/SEBBJ7A.png](https://private-user-images.githubusercontent.com/177156866/411282302-45ce0f2f-5daf-43e8-abda-f4ebfbe04ca7.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzIwNzMsIm5iZiI6MTczOTA3MTc3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMzAyLTQ1Y2UwZjJmLTVkYWYtNDNlOC1hYmRhLWY0ZWJmYmUwNGNhNy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI5MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03YjM0Mjg4MGI2YmQ2NjQ0NmYzYWYxZjc0YTIyYWJjOWQxOWFlODY1ZjcwNDBlZjc1NDQ0NDg3YjBmNDRhYmM5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.F7sXw4aBU834-ll3zJafmjRNduOWqvcm6xbs53vubGE)" width="500px">
                  <img src="https://private-user-images.githubusercontent.com/177156866/411282379-e8be5bc4-06eb-43cf-a7c8-ae0ba2200d34.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzIwNzMsIm5iZiI6MTczOTA3MTc3MywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMzc5LWU4YmU1YmM0LTA2ZWItNDNjZi1hN2M4LWFlMGJhMjIwMGQzNC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzI5MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lZmRlMmQ4N2JhYjRlYmM5NmY2Mjk4NGQyYmFkNWU3NDBmNTNhYjczYTlmODNmMDgyODUwYmY2OTA5NDZhNzAwJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.F8mayjfyjaQQCWfInUO6l-byEKWu_sbZTHOeHRVtTBY" width="500px">
                  <img src="[https://i.imgur.com/SEBBJ7A.png](https://private-user-images.githubusercontent.com/177156866/411282389-a3697fe5-ef5d-4e47-a247-2a8352336659.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzIzMjcsIm5iZiI6MTczOTA3MjAyNywicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgyMzg5LWEzNjk3ZmU1LWVmNWQtNGU0Ny1hMjQ3LTJhODM1MjMzNjY1OS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzMzNDdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03ODUwYTNiMGI1M2ZlZTUxNGQ2ODNhNTE2ZjM1NzNmMDRhMTdhYTFmMzYzNDYyYTlkYzE2ZjY4NWI5M2IwODEzJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.8DebpoL-6liM4P4bloWEYqz7E2zHOhkZnfEGENH712M)" width="500px">
            </ul>
        </li>
        <br/>
    </ul>
</div>
<br/>
