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
                <li>음악 재생, 음원 검색, 재생목록, 플레이리스트 재생, 앨범 추천 등</li>
                  <img src="https://private-user-images.githubusercontent.com/177156866/411281862-b0c70550-cd04-4915-839a-d22abe122fca.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzkwNzE0NTIsIm5iZiI6MTczOTA3MTE1MiwicGF0aCI6Ii8xNzcxNTY4NjYvNDExMjgxODYyLWIwYzcwNTUwLWNkMDQtNDkxNS04MzlhLWQyMmFiZTEyMmZjYS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwOVQwMzE5MTJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0wZGY5NzJjYTgwODEyZTVkYTQ3NjUyMzMxMjU0YmFkZTJjNzkyYmJhYTg5Yzc2NGQxNjdmNGQ5MDEyZjI0MWY5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.sY6UyqnskxXURpZ-oG_QuoHiK6Pu-hXmT8EWD0JJoUY" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Login / Sign Up / Find ID / Reset Password</strong>
            <ul>
                <li>Front-End Validation</li>
                <li>SMTP-Based Temporary Password Issuance</li>
                  <img src="https://i.imgur.com/EOhnk2h.png" width="500px">
                  <img src="https://i.imgur.com/0gReaaA.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>MyPage</strong>
            <ul>
                <li>Order History / Account Information / Favorite Items</li>
                <li>Points / Inquiries</li>
                <li>Shipping Address Management / Subscription Management</li>
                  <img src="https://i.imgur.com/jprSs3o.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Order History</strong>
            <ul>
                <li>Search by Category / Information / Date</li>
                <li>Button Pagination</li>
                <li>(Detail Page) View Detailed Order Information</li>
                  <img src="https://i.imgur.com/uWez2dS.png" width="500px">
                  <img src="https://i.imgur.com/1F9HDrs.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Magazine Products</strong>
            <ul>
                <li>Search by Category</li>
                <li>Button Pagination</li>
                <li>Save to Favorites, Add to Cart</li>
                <li>Quantity Limit Based on Stock Availability</li>
                <li>Product Inquiries</li>
                  <img src="https://i.imgur.com/HvAiLXw.png" width="500px">
                  <img src="https://i.imgur.com/ZyvYTpr.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Collection Products</strong>
            <ul>
                <li>Search by Category</li>
                <li>Button Pagination</li>
                <li>Save to Favorites, Add to Cart</li>
                <li>Quantity Limit Based on Stock Availability</li>
                <li>Product Inquiries</li>
                  <img src="https://i.imgur.com/SEBBJ7A.png" width="500px">
                  <img src="https://i.imgur.com/lk5ZA2Y.png" width="500px">
                  <img src="https://i.imgur.com/Ykg3LLz.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Shopping Cart</strong>
            <ul>
                <li>Items Categorized into 'Collection Products, Magazines, Subscriptions'</li>
                <li>Quantity Limit Based on Stock Availability</li>
                <li>Remove Items, Selective Order</li>
                  <img src="https://i.imgur.com/X3XNQ2n.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Order</strong>
            <ul>
                <li>Shipping Address Book</li>
                <li>Point Usage</li>
                <li>Payment - PortOne Payment API</li>
                  <img src="https://i.imgur.com/Z2qHdfk.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Inquiries / Notices</strong>
            <ul>
                <li>Button Pagination</li>
                <li>Inquiries (Privacy Option, Password for Guest Users)</li>
                <li>Inquiry Response Notification via Email</li>
                  <img src="https://i.imgur.com/L9SYkAL.png" width="500px">
                  <img src="https://i.imgur.com/JQ5Kxsy.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Community: Records</strong>
            <ul>
                <li>Button Pagination</li>
                <li>Author Popup Page</li>
                <li>Ability to Write Comments and Collect Sentences</li>
                <li>Sharing Available (KakaoTalk Share)</li>
                  <img src="https://i.imgur.com/gfAUUD8.png" width="500px">
                  <img src="https://i.imgur.com/OwrqZtq.png" width="500px">
                  <img src="https://i.imgur.com/6G6jY0E.png" width="500px">
            </ul>
        </li>
        <br/>  
        <li>
            <strong>Community: Member Page</strong>
            <ul>
                <li>Member Popup Page (Library/Sentence Collection, Records)</li>
                <li>Member Page (Library/Sentence Collection, Records, Comments, Member Info, Inquiries/Reports)</li>
                <li>Accessible to All Users (Including Non-Members)</li>
                <li>Member Info & Inquiries/Reports: Viewable Only by the Respective My Page Member</li>
                  <img src="https://i.imgur.com/uZvLz4N.png" width="500px">
                  <img src="https://i.imgur.com/PXowwnY.png" width="500px">
            </ul>
        </li>
        <br/>  
        <li>
            <strong>Admin Page Features</strong>
            <ul>
                <li>[Member Management] Member Info, Basic Profile</li>
                <li>[Magazine Management] Magazines, Magazine Subscriptions, Newsletter Subscriptions</li>
                <li>[Community Management] Reports, Registered Books, Quotes</li>
                <li>[Collection Management] Categories, Products</li> 
                <li>[Sales/Shipping Management] Unified Orders, Returns</li>
                <li>[Inquiries / Notices] Inquiries, Announcements</li>  
                <li>[Other Management] Temporary File Management - CKEditor</li>    
            </ul>
        </li>
        <br/>      
        <li>
            <strong>Admin Page Main</strong>
            <ul>
                <li>General Statistics (Subscriptions, Orders/Returns, Unchecked Inquiries/Reports, 3 Books, Games)</li>
                <li>Chart Statistics (Sales Trends by Product Category, Subscription Trends, Number of Inquiries by Category, Top 5 Product Sales Rates)</li>
                  <img src="https://i.imgur.com/UdTSZ36.png" width="500px">
            </ul>
        </li>
        <br/>  
        <li>
            <strong>Admin Member Management</strong>
            <ul>
                <li>Search by Category / Member Personal Information</li>
                <li>Pagination</li>
                <li>Member Info Popup Page (Member Info, Shipping Address Book, Point Accumulation/Usage History, Subscription Info)</li>
                  <img src="https://i.imgur.com/6jzzJ1L.png" width="500px">
            </ul>
        </li>
        <br/>   
        <li>
            <strong>Admin Order/Shipping Management</strong>
            <ul>
                <li>Search by Period / Order Status / Order Information</li>
                <li>Pagination</li>
                <li>Order Info Popup Page</li>
                  <img src="https://i.imgur.com/9hWP3X1.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>Others</strong>
            <ul>
                <li>Automated Processing (Magazine Subscription Delivery, Newsletter Sending, Deletion of Members Exceeding 1 Month After Withdrawal, Shipping Management) - Spring Scheduler</li>
                <li>Games (Dice Game, Roulette Game)</li>
            </ul>
        </li>
        <br/>      
    </ul>
</div>
<br/>
