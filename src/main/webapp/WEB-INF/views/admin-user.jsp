<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GORI</title>
<link rel="stylesheet" href="<c:url value='/resources/css/nav.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>?ts=<%= System.currentTimeMillis() %>">
<script src="<c:url value='/resources/js/functions-admin.js'/>?ts=<%= System.currentTimeMillis() %>"></script>
<style>
	main .sectionWrapper {
		padding: 0 10px;
	}
	#main-nav {
		display: flex;
		flex-direction: column;
		width: 100%;
		height: 15%;
	}
	#main-nav-header{
		display: flex;
		align-items: center;
		gap: 10px;
		margin-top: 10px;
	}
	#main-nav-header a:hover {
		cursor: pointer;
		color: white;
	}
	#manageUser-search{
		display:flex;
		align-items: center;
		gap:20px;
	}
	#searchUser-input {
		width: 350px;
	}
	#manageUser-content {
		max-height:80%; 
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 10px 0;
	}
	#manageUser-columns span:hover {
		cursor: pointer;
	}
	#manageUser-table {
		width: 100%;
	}
	#manageUser-table td, #manageUser-table th {
		min-height: 50px;
		padding: 5px 10px;
		border-bottom: 1px solid var(--border-color-weak);
		text-align: center;
	}
	.manageUser:hover {
		cursor: pointer;
		background-color: var(--content-hover-color);
	}
	#user-seeMore {
		display:flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: center;
		width: 70%;
		height: 70%;
		border-radius: 5px;
	}
	#seeMore-wrapper {
		display:flex;
		width: 100%;
		height: 95%;
	}
	#seeMore-wrapper>div {
		display: flex;
		flex-direction: column;
		gap: 20px;
		width: 50%;
		height: 100%;
		padding: 20px;
		padding-right: 0;
	}
	#seeMore-wrapper>div:first-of-type {
		border-right: 1px solid var(--border-color-weak);
	}
	#seeMore-wrapper .inputSubmit {
		height: 30px;
		padding: 0 2px;
		font-size: 15px;
	}
	#user-seeMore>div:last-of-type {
		display: flex;
		justify-content: center;
		align-items: center;
		gap: 30px;
		width: 100%;
		padding: 10px 0;
	}
</style>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="./include-navi.jsp"/>
		
		<jsp:include page="./include-playlist.jsp"/>
		
		<jsp:include page="./include-quelist.jsp"/>
		
		<jsp:include page="./include-toolBar.jsp"/>
		
		<main>
			<div class="sectionWrapper">
				<div id="main-nav">
					<div id="main-nav-header">
						<a href="<c:url value='/admin/music'/>" class="subTitle">음악 관리</a>
						<span class="mainTitle">회원 관리</span>
						<a href="<c:url value='/admin/stats'/>" class="subTitle">통계</a>
					</div>
				</div>
				<div id="manageUser-wrapper">
					<div id="manageUser-main">
						<div id="manageUser-search">
							<select id="searchUser-select" class="selectBox">
								<option value="name">이름</option>
								<option value="email">이메일</option>
							</select>
							<input type="text" id="searchUser-input" class="inputText" placeholder="회원을 검색하세요.">
							<button type="button" id="searchUser-submit" class="inputSubmit" style="width:60px; height:30px; font-size:15px;">검색</button>
						</div>
						
						<div id="manageUser-content" class="scroll"></div>
					</div>
				</div>
			</div>
		</main>
	</div>
	
	<script>
		let detachedMain = null;
		let currentField = null;
		let currentKeyword = null;
		$('#manageUser-wrapper').on('click', function(event) {
			const target = $(event.target);
			const manageUser = target.closest('.manageUser');
			
			// 회원 검색
			if(target.is('#searchUser-submit')) {
				const id = manageUser.data('id');
				const field = $('#searchUser-select').val();
				let keyword = $('#searchUser-input').val().trim();
				if(keyword === null || keyword === undefined) keyword = "";
				currentField = field;
				currentKeyword = keyword;
				
				$.ajax({
					type:'GET',
					url:'${pageContext.request.contextPath}/admin/search/users/'+keyword,
					data:{field:field},
					success:function(result) {
						$('#manageUser-content').html('');
						if(result.list.length) {
							const div = createManageUser(result.list);
							const pageDiv = createPageDiv(result.ph);
							$('#manageUser-content').append(div);
							$('#manageUser-content').append(pageDiv);
						}
						else {
							$('#manageUser-content').append(`<div>결과가 없습니다...</div>`);
						}
						
					}, error:function(error) {
						console.log(error.responseText);
					}
				});
			// manageUser 클릭	
			} else if(manageUser.length) {
				const id = manageUser.data('id');
				$.ajax({
					type:'GET',
					url:'${pageContext.request.contextPath}/admin/user/'+id,
					data:{},
					success:function(result) {
						const manageDiv = createSeeMore(result);
						$('#manageUser-wrapper').append(manageDiv);
					}, error:function(error) {
						console.log(error.responseText);
					}
				});
			// 비밀번호 초기화
			} else if(target.is('#resetPassword')) {
				const id= target.closest('.modal-content').data('id');
				$.ajax({
					type:'PUT',
					url:'${pageContext.request.contextPath}/admin/user/'+id,
					data:JSON.stringify({doing:'resetPassword'}),
					contentType: 'application/json',
					success:function(result) {
						if(result === "SUCCESS") {
							alert('비밀번호가 123asdASD!로 초기화되었습니다.');
						}
						else alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
					}, error:function(error) {
						console.log(error.responseText);
					}
				});
			// 활동 정지
			} else if(target.is('#deactivate')) {
				const id = target.closest('.modal-content').data('id');
				const name = $('#seeMore-name').text().substring(5);
				
				let day = $('#deactivate-day').val();
				let date = new Date();
				let replace = null;
				date.setDate(date.getDate() + parseInt(day,10));
				day = day+'일';
				
				
				const locale = date.toLocaleString('ko-KR', { timeZone: 'Asia/Seoul'});
				if(confirm(name+'님을 ' + day + ' 활동정지 시키시겠습니까?')) {
					$.ajax({
						type:'PUT',
						url:'${pageContext.request.contextPath}/admin/user/'+id,
						data:JSON.stringify({doing:'deactivate', date:locale}),
						contentType: 'application/json',
						success:function(result) {
							if(result === "SUCCESS") {
								alert('활동정지되었습니다.');
								$('#deactivate-day').remove();
								replace = `<span>${'${locale}'}까지 정지됨	|</span><button type="button" id="cancle-deactivate">정지 해제</button>`;
								target.replaceWith(replace);
							}
							else alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
						}, error:function(error) {
							console.log(error.responseText);
						}
					});
				}
			// 강제 탈퇴
			} else if(target.is('#cancellation')) {
				const id = target.closest('.modal-content').data('id');
				const name = $('#seeMore-name').text().substring(5);
				
				if(confirm('정말 ' + name+'님을 강제 탈퇴시키겠습니까?')) {
					$.ajax({
						type:'DELETE',
						url:'${pageContext.request.contextPath}/admin/user/'+id,
						data:{},
						success:function(result) {
							if(result === "SUCCESS") {
								alert('탈퇴 처리되었습니다.');
								window.location.href = '${pageContext.request.contextPath}/admin/user';
							}
							else alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
						}, error:function(error) {
							console.log(error.responseText);
						}
					});
				}
			// 활동정지 해제
			} else if(target.is('#cancle-deactivate')) {
				const id = target.closest('.modal-content').data('id');
				if(confirm('활동 정지를 해제하시겠습니까?')) {
					$.ajax({
						type:'PUT',
						url:'${pageContext.request.contextPath}/admin/user/'+id,
						data:JSON.stringify({doing:'cancleDeactivate'}),
						contentType: 'application/json',
						success:function(result) {
							if(result === "SUCCESS") {
								alert('활동정지가 해제되었습니다.');
								target.parent().find('span:first-of-type').remove();
								target.replaceWith(` <button type="button" id="deactivate">활동정지</button>
						                <select id="deactivate-day" class="selectBox">
					                    <option value="1">1</option>
					                    <option value="3">3</option>
					                    <option value="7">7</option>
					                    <option value="30">30</option>
					                </select>`);
							}
							else alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
						}, error:function(error) {
							console.log(error.responseText);
						}
					});
				}
			
			} else if(target.hasClass('modal-close')) {
				target.closest('.modal-body').remove();
			}
			// 정렬
			/* } 
			else if(target.is('#manageUser-columns span')) {
				const field = target.data('field');
				let array = $.makeArray($('#manageUser-content').find('.manageUser'));
				
				if(field === "idx") {
					array.sort((a,b) => {return $(a).data('idx') - $(b).data('idx')});
				} else if (field === "email") {
				    array.sort((a, b) => {
				        const emailA = $(a).data('email').toLowerCase(); // 대소문자 구분 없이 정렬
				        const emailB = $(b).data('email').toLowerCase();
				        return emailA.localeCompare(emailB); 
				    });
				} else if (field === "name") {
				    array.sort((a, b) => {
				        const nameA = $(a).data('name').toLowerCase(); 
				        const nameB = $(b).data('name').toLowerCase();
				        return nameA.localeCompare(nameB); 
				    });
				} else if (field === "birth") {
				    array.sort((a, b) => {
				        const birthA = new Date($(a).data('birth'));
				        const birthB = new Date($(b).data('birth'));
				        return birthA - birthB;
				    });
				} else if (field === "reg_date") {
				    array.sort((a, b) => {
				        const regDateA = new Date($(a).data('reg_date'));
				        const regDateB = new Date($(b).data('reg_date'));
				        return regDateA - regDateB;
				    });
				}
				
				$('#manageUser-table').html(`<tr id="manageUser-columns"><th><span data-field="idx">번호</span></th><th><span data-field="email">이메일</span></th><th><span data-field="name">이름</span></th><th><span data-field="birth">생일</span></th><th><span data-field="reg_date">가입일</span></th></tr>`)
				console.log(array);
				$.each(array, function(index, div) {
					$('#manageUser-table').append(div);
				}); */
		});
	</script>
</body>
</html>
