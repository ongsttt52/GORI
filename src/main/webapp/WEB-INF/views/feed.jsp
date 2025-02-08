<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GORI</title>
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/feed.css'/>?ts=<%= System.currentTimeMillis() %>">
<script src="<c:url value='/resources/js/functions-feed.js'/>?ts=<%= System.currentTimeMillis() %>"></script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="./include-navi.jsp"/>
		
		<jsp:include page="./include-playlist.jsp"/>
		
		<jsp:include page="./include-quelist.jsp"/>
		
		<jsp:include page="./include-toolBar.jsp"/>
		
		<main>
			<div id="main-feed" class="sectionWrapper">
				<div id="feed-left">
					<div id="feed-left-header">
						<a href="<c:url value='/feed'/>" class="mainTitle">피드</a>
						<p class="alertMsg">수정됐습니다!</p>
						<button type=button id="searchFeedButton" class="hover-scale">피드검색 <i class="fa-solid fa-magnifying-glass" style="color: #fff480;"></i></button>
					</div>
					<div id="feed-left-main" class="scroll">
						<c:choose>
							<c:when test="${fn:length(map.list) > 0}">
								<c:forEach items="${map.list}" var="f" varStatus="loop">
									<div class="feedDiv" data-feed-idx="${f.idx}" data-music-idx="${f.musicIdx}" data-user-idx="${f.userIdx}">
										<div class="feedDiv-top">
											<div class="feedDiv-user">
												<div>
													<img src="<c:url value='${f.userImg}'/>" class="imgPreview">
													<a href="user" style="margin-right:10px;">${f.userName}</a>
															<span style="margin-right:15px;">${f.diffString}</span>
													<button type="button" class="feedButton dropdownButton hover-scale"><i class="fa-solid fa-ellipsis"></i></button>
													<div class="dropdown-div">
														<c:choose>
															<c:when test="${empty sessionScope.user}">
																<p>로그인 후 이용가능합니다.</p>
															</c:when>
															<c:when test="${sessionScope.user.idx == f.userIdx}">
																<button type="button" class="feed-modifyButton">수정하기</button>
																<button type="button" class="feed-deleteButton">삭제하기</button>
															</c:when>
															<c:otherwise>
																<button type="button" class="feed-shareButton">공유하기</button>
																<button type="button" class="feed-followButton">팔로우하기</button>
																<button type="button" class="feed-reportButton">신고하기</button>
															</c:otherwise>
														</c:choose>
													</div>
												</div>
												<button type=button class="showCommentButton hover-scale" data-feed-idx="${f.idx}" data-toggle="false"><i class="fa-regular fa-comment"></i></button>
											</div>
											<div class="feedDiv-content">
												<textarea readonly>${f.content}</textarea>
											</div>
										</div>
										<div class="feedDiv-bottom">
											<img src="${f.musicImg}" class="imgPreview">
											<div>
												<a href="<c:url value='/view/music/${f.musicIdx}'/>">${f.musicName}</a>
												<span class="subText">${f.artistName}</span>
											</div>
											<c:choose>
											<c:when test="${f.previewUrl eq 'null'}">
												<div><span>준비중</span></div>
											</c:when>
											<c:otherwise>
												<div><button type="button" data-preview="${f.previewUrl}">재생하기</button></div>
											</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
								<div>
								<c:if test="${map.ph.showPrev}">&lang;</c:if>
								<c:forEach begin="${map.ph.beginPage}" end="${map.ph.endPage}" var="i">
									<c:choose>
									<c:when test="${i eq map.ph.sc.page}">
										<a href="<c:url value='/feed?field=${map.ph.sc.field}&keyword=${map.ph.sc.keyword}&page=${i}&pageSize=${map.ph.sc.pageSize}'/>" class="pageButton currentPage">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="<c:url value='/feed?field=${map.ph.sc.field}&keyword=${map.ph.sc.keyword}&page=${i}&pageSize=${map.ph.sc.pageSize}'/>" class="pageButton">${i}</a>
									</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${map.ph.showNext}">&rang;</c:if>
								</div>
							</c:when>
							<c:otherwise>
								<p>결과가 없습니다...</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div id="feed-right">
					<!-- swiper -->
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<!-- slide0 -->	
							<div id="writeFeed-search" class="swiper-slide">
								<p class="subTitle-selected">피드 쓰기</p>
								<c:choose>
									<c:when test="${empty sessionScope.user}">
									<div class="sessionRequired">
										<p>피드는 회원만 작성 가능합니다.</p>
										<a href="<c:url value='/login?toUrl=${pageContext.request.requestURL}'/>" class="inputSubmit" style="width:100px; height:40px;">로그인하기</a>
									</div>
									</c:when>
									<c:otherwise>
										<input type="text" id="writeFeed-searchInput" class="searchInput" name="searchWord" placeholder="노래 검색하기...">
										<div id="writeFeed-searchResult" class="searchResult scroll"></div>
									</c:otherwise>
								</c:choose>
								
							</div>
							<!-- slide1 -->
							<div id="writeFeed-formDiv" class="swiper-slide">
								<p class="subTitle-selected">피드 쓰기</p>
								<div id="writeFeed-selected"></div>
								<form id="writeFeed-form" method="post" action="<c:url value='/feed'/>" onsubmit="return formCheck(this);">
									<input type="hidden" id="userIdx" name="userIdx" value="${sessionScope.user.idx}">
									<input type="hidden" id="musicIdx" name="musicIdx">
									<p>내용</p>
									<textarea id="writeFeed-text" name="content" rows="10" cols="50" placeholder="무슨 생각 중이신가요?" maxlength="255"></textarea>
									<span class="wordLength"><span>0</span>/255</span>
									<input type="submit" id="writeFeed-submit" class="inputSubmit" value="작성!" style="width:70px; height:35px;" >
									<div id="writeFeed-modify-div" style="display:none">
										<input type="submit" id="writeFeed-modify-submit" class="inputSubmit" value="수정하기" style="width:100px; height:35px;" >
										<button type="button" id="writeFeed-modify-cancle">취소</button>
									</div>
									<p class="notValidMsg">내용을 입력해주세요.</p>
								</form>
							</div>
							<!-- slide2 -->
							<div id="searchFeed" class="swiper-slide">
								<p class="subTitle-selected">피드 검색하기</p>
								<div id="searchFeed-buttons">
									<button type="button" class="button-option button-selected" data-field="content">내용</button>
									<button type="button" class="button-option" data-field="name">작성자</button>
									<button type="button" class="button-option" data-field="tag">태그</button>
								</div>
								<input type="text" id="searchFeed-searchWord" class="searchInput" placeholder="피드 검색하기">
								<p>또는</p>
								<input type="text" id="searchFeed-searchMusic" class="searchInput" name="searchWord" placeholder="음악으로 검색하기">
								<div id="searchFeed-searchResult" class="searchResult scroll"></div>
								<div id="searchFeed-selected"></div>
								<div>
									<button id="searchFeed-submit" class="inputSubmit">검색</button>
									<button type="reset" id="searchFeed-cancle">취소</button>
								</div>
							</div>
						</div><!-- swiper-wrapper -->
					</div><!-- swiper -->
				</div> <!-- feed-right -->
				<div id="feed-comment">
					<p class="subTitle-selected">댓글 쓰기</p>
					<div id="feed-comment-main">
						<c:choose>
							<c:when test="${empty sessionScope.user}">
								<div class="sessionRequired">
									<p>댓글은 회원만 작성 가능합니다.</p>
									<a href="<c:url value='/login?toUrl=${pageContext.request.requestURL}'/>" class="inputSubmit" style="width:100px; height:40px;">로그인하기</a>
								</div>
							</c:when>
							<c:otherwise>
								<div id="writeComment">
									<form id="writeComment-form" name="writeComment" method="post">
										<div id="writeComment-user">
											<div>
												<img src="<c:url value='${sessionScope.user.profileImg}'/>" class="imgPreview">
												<span>${sessionScope.user.name}</span>
											</div>
											<input type="submit" class="inputSubmit" style="width: 60px; height: 30px; font-size: 15px;" value="작성하기">
										</div>
										<textarea id="writeComment-text" name="comment" placeholder="댓글을 입력하세요." maxlength="255"></textarea>
										<div>
											<span class="notValidMsg">내용을 입력해주세요.</span>
											<span class="wordLength"><span>0</span>/255</span>
										</div>
									</form>
								</div>
							</c:otherwise>
						</c:choose>
						<p class="subTitle-selected">댓글</p>
						<div id="commentContainer" class="scroll"></div>
					</div>
				</div> <!-- feed-comment -->
			</div>
		</main>
	</div>
	<script>
		$(document).ready(function() {
			if(${not empty message} && ${message eq 'SUCCESS'}) {
				const message = '피드가 작성되었습니다.';
				showMessage(message);
			}
		});
	
		let lastClickedButton = null; 
		
		// Swiper
		var feedRightSwiper = new Swiper('.swiper-container', {
			speed: 500,
			effect: 'slide',
			allowTouchMove: false // 슬라이드 드래그 비활성화
		});
		
		// 드롭다운 메뉴 끄기
		$(document).on('click', function(event) {
			const target = $(event.target);
			if(!target.closest('.dropdown-div').length && !target.hasClass('.dropdownButton')) {
				$('.dropdown-div').hide();
			} 
		});		
		
		// 음악 검색
		$('#writeFeed-searchInput, #searchFeed-searchMusic').on('input', function(event){
			const searchWord = $(event.target).val().trim();
			const searchResult = $(event.target).parent().find('.searchResult');
			
			if(searchWord.length == 0) {
				searchResult.empty();
				// 추천
			} else {
				$.ajax({
					type:'GET',
					url:'${pageContext.request.contextPath}/search/'+searchWord,
					data:{},
					success:function(result) {
						searchResult.empty();
						if(result.list.length == 0 && searchWord.length != 0) {
							let div = '<p>결과가 없습니다...</p>';
							searchResult.append(div);
						} else {
							$.each(result.list,function(index, music) {
								let div = createPreview('music', music);
								searchResult.append(div);
							});
						}
					}, error:function(error) {
						console.log(error);
					}
				});
			}
		});
		
		// 음악 선택
		$('#writeFeed-searchResult, #searchFeed-searchResult').on('click', '.musicPreview', function(event) {
			const target = $(event.currentTarget);
			const clone = target.clone();
			if(feedRightSwiper.activeIndex == 2) {
				$('#searchFeed-searchResult').hide();
				$('#searchFeed-selected').append(clone);
			} else {
				$('#musicIdx').val(target.data('id'));
				$('#writeFeed-selected').append(clone);
		        feedRightSwiper.slideTo(1);
			}
		});
		// 음악 선택 취소
		$('#writeFeed-selected, #searchFeed-selected').on('click', '.musicPreview', function(event) {
			$(this).remove();
			if(feedRightSwiper.activeIndex == 2) {
				$('#searchFeed-searchResult').show();
			} else {
				feedRightSwiper.slideTo(0);
			}
		});
		
		
		// 피드 검색
		$('#searchFeedButton').on('click', function(event) {
			if(lastClickedButton != null) lastClickedButton.click();
			$(this).data('toggle', true);
			feedRightSwiper.slideTo(2);
		});
		
		$('#searchFeed').on('click', function(event) {
			const target = $(event.target);
			// 검색 조건 선택
			if(target.hasClass('button-option')) {
				target.parent().find('.button-selected').removeClass('button-selected');
				target.addClass('button-selected');
			// 검색
			} else if(target.is($('#searchFeed-submit'))) {
				const searchField = $('#searchFeed-buttons').find('.button-selected').data('field');
				const searchWord = $('#searchFeed-searchWord').val().trim();
				const musicIdx = ($('#searchFeed-selected').find('.musicPreview').length > 0) ? $('#searchFeed-selected .musicPreview').data('id') : '';
				const queryString = '?field='+searchField+'&keyword='+searchWord+'&musicIdx='+musicIdx;
				
				window.location.href='${pageContext.request.contextPath}/feed'+queryString;
			}
			else if(target.is($('#searchFeed-cancle'))) {
				feedRightSwiper.slideTo(0);
			}
		});
		
		
		// 댓글
		// commentDiv 생성 함수
		function createCommentDiv(comment) {
			let dropdown = '';
			if(comment.userIdx === currentUserIdx) {
				dropdown = `
	                <button type="button" class="comment-modifyButton">수정하기</button>
	                <button type="button" class="comment-deleteButton">삭제하기</button>
	                `;
			} else {
				dropdown = `
					<button type="button" class="comment-followButton">팔로우하기</button>
					<button type="button" class="comment-reportButton">신고하기</button>
				`;
			}
			
		    if (comment.isDeleted) {
		        return '<div class="commentDiv">삭제된 댓글입니다.</div>';
		    } 
		    else {
		        return `
		            <div class="commentDiv" data-comment-idx="${'${comment.idx}'}">
		                <div class="commentDiv-user">
		                    <div>
		                        <img src="${pageContext.request.contextPath}${'${comment.userImg}'}" class="imgPreview">
		                        <span>${'${comment.userName}'}</span>
		                        <span class="subText">${'${comment.diffString}'}</span>
		                        <button type="button" class="commentButton dropdownButton hover-scale"><i class="fa-solid fa-ellipsis"></i></button>
		                    </div>
		                    <div class="dropdown-div">${'${dropdown}'}</div>
		                </div>
		                <textarea class="commentDiv-content" readonly>${'${comment.content}'}</textarea>
		            </div>
		        `;
		    }
		} // function
		
		// 댓글 보기
		$('.showCommentButton').click(function(event) {
			let thisIdx = $(this).closest('.feedDiv').data('feed-idx'); // 가장 가까운 피드의 idx 저장
			
			// 버튼을 처음 눌렀을때
			if(lastClickedButton == null) { 
				$('#feed-right').toggle()
				$('#feed-comment').toggle();
				$(this).data('toggle', true);
				$(this).html('<i class="fa-solid fa-comment"></i>');
			// n번째 눌렀을때 
			} else {
				let lastIdx = lastClickedButton.closest('.feedDiv').data('feed-idx'); // 이전에 눌렀던 피드의 idx
				
				// 켜진 버튼 또 눌렀을 때
				if(lastIdx==thisIdx) { 
					$('#feed-right').toggle()
					$('#feed-comment').toggle();
					$(this).data('toggle', false);
					$(this).html('<i class="fa-regular fa-comment"></i>');
					$('#commentContainer').empty();
					lastClickedButton = null;
				// 다른 버튼 눌렀을 때
				} else { 
					$(this).data('toggle', true);
					lastClickedButton.data('toggle', false); 
					lastClickedButton.html('<i class="fa-regular fa-comment"></i>');
					$(this).html('<i class="fa-solid fa-comment"></i>');
				}
			}
			
			// 댓글창이 켜졌을 때
			if($(this).data('toggle')) {
				getComments(thisIdx);
				lastClickedButton = $(this);
			}		
		});
		
		// 댓글 쓰기
		$('#writeComment-form').submit(function(event) {
			event.preventDefault();
			
			const content = $('#writeComment-text').val();
			const feedIdx = lastClickedButton.closest('.feedDiv').data('feed-idx');
			
			// 유효성 검사
			if(!formCheck(this)) return;
			
			$.ajax({
				type:'POST',
				url:'${pageContext.request.contextPath}/feed/'+feedIdx+'/comments',
				data:{userIdx:currentUserIdx, content:content},
				success:function(result) {
					getComments(feedIdx);
	                $('#writeComment-text').val('');
	                $('#writeComment-text').removeClass('notValid');
	                $(event.currentTarget).find('.notValidMsg').hide();
				}, error:function(error) {
					console.log(error.responseText);
				}
			});
		});
		
		$('#writeFeed-text, #writeComment-text').on('input', function(event) {
			$(this).removeClass('notValid');
			$(this).parent().find('.notValidMsg').hide();
			let count = $(this).parent().find('.wordLength>span');
			let length = $(this).val().length;
			count.text(length);
			if(length == 255) {
				$('.wordLength').css('color', 'red');
			} else {
				$('.wordLength').css('color', 'var(--text-color-weak)');
			}
		});
		
		// 피드 댓글 상호작용
		// 폼체크
		function formCheck(form) {
			// 피드 쓰기
			if(form === $('#writeFeed-form').get(0)) { // JQuery객체.get(0) -> 자바스크립트 객체로 변환 가능
				if(form.content.value === null || form.content.value.trim().length === 0) {
					$('#writeFeed-text').addClass('notValid');
					$('#writeFeed-form .notValidMsg').show();
					return false;
				}
			// 댓글 쓰기
			} else if(form === document.getElementById("writeComment-form")) {
				if(form.comment.value === null || form.comment.value.trim().length === 0) {
					$('#writeComment-text').addClass('notValid');
					$('#writeComment-form .notValidMsg').show();
					return false;
				} 
			}
			return true;
		}
		
		
		// 피드 수정,삭제
		/* 	feedButtonDiv.addEventListener('click', function(event) {
				this.style('display', 'none');
			},false) 
			-> getElementsByClassName 메서드는 동일한 클래스를 가진 모든 요소를 HTMLCollection으로 반환, 
			feedButtonDiv가 배열이므로 addEventListener를 적용할 수 없으며 특정 요소를 지정한 후에 가능하다
		*/
		
		// 피드버튼(...) 클릭
		$('.feedButton').click(function(event) {
			event.stopPropagation();
			$(this).parent().children('.dropdown-div').toggle();
		});
		
		// 피드-수정하기
		$('.feed-modifyButton').click(function(event) {
			// 댓글창이 켜져있는 경우 마지막 클릭한 댓글버튼을 클릭 -> 댓글창 닫힘
			if(lastClickedButton != null) {
				lastClickedButton.click();
			}
			
			// 피드쓰기 슬라이드의 activeIndex(현재 보이는 창의 인덱스)가 0일 경우 1로 슬라이드
			if(feedRightSwiper.activeIndex != 1) {
				feedRightSwiper.slideTo(1);
			}
			
			// 피드 정보 가져오기 
			const feedDiv = $(this).closest('.feedDiv');
			let musicIdx = feedDiv.data('music-idx');
			let feedIdx = feedDiv.data('feed-idx');
			
			let content = feedDiv.find('.feedDiv-content div').text().trim();
			let title = feedDiv.find('.feedDiv-bottom>div>a').text().trim();
			let artist = feedDiv.find('.feedDiv-bottom>div>span').text().trim();
			let albumImg = feedDiv.find('.feedDiv-bottom>img').attr('src');
			
			$('#writeFeed-selected').html(`
			<div class="musicPreview previewDiv text-overflow" data-id="${'${musicIdx}'}" data-name="${'${title}'}">
				<img src="${'${albumImg}'}" class="imgPreview">
				<div>
					<span>${'${title}'}</span>
					<span class="subText">${'${artist}'}</span>
				</div>
			</div>`);
			$('#writeFeed-text').text(content);
			
			// 피드쓰기 창 재활용을 위해 텍스트 변경
			$('#writeFeed-search').find('.subtitle-selected').text('수정중...');
			$('#writeFeed-formDiv').find('.subtitle-selected').text('수정중...');
			$('#writeFeed-submit').hide();
			$('#writeFeed-modify-div').show();
			$('#writeFeed-modify-submit').attr('data-feed-idx', feedIdx);
		});
		
		// 취소
		$('#writeFeed-modify-cancle').on('click', modifyCancle);
		function modifyCancle() {
			$('#writeFeed-search').find('.subtitle-selected').text('피드 쓰기');
			$('#writeFeed-formDiv').find('.subtitle-selected').text('피드 쓰기');
			$('#writeFeed-submit').show();
			$('#writeFeed-modify-div').hide();
			$('#writeFeed-searchResult').html('');
			$('#writeFeed-selected').html('');
			$('#writeFeed-text').val('');
			$('#writeFeed-text').removeClass('notValid');
			$('#writeFeed-form').find('.notValidMsg').hide();
			$('#writeFeed-searchInput').val('');
			feedRightSwiper.slideTo(0);
		}
		// 수정하기 submit
		$('#writeFeed-modify-submit').on('click', function(event) {
			event.preventDefault();
			// 수정중인 피드, 선택한 음악, 입력한 텍스트 가져오기
			const feedIdx = $(this).attr('data-feed-idx');
			const feedDiv = $('.feedDiv[data-feed-idx="'+feedIdx+'"]');
			const musicIdx = $('#writeFeed-selected').find('.musicPreview').data('id');
			const text = $('#writeFeed-text').val().trim();
			if($('#writeFeed-text').val() === null || $('#writeFeed-text').val().trim().length === 0) {
				$('#writeFeed-text').addClass('notValid');
				$('#writeFeed-form').find('.notValidMsg').show();
				return false;
			} else {
				$.ajax({
					type:'PUT',
					url:'${pageContext.request.contextPath}/feed/'+feedIdx,
					data:JSON.stringify({musicIdx:musicIdx, content:text}),
					contentType:"application/json",
					success:function(result) {
						alert('수정되었습니다.');
						window.location.href='${pageContext.request.contextPath}/feed'+window.location.search;				
					}, error: function(request, status, error) { alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)}
				});
			}
		});
		
		// 삭제하기
		$('.feed-deleteButton').on('click', function() {
			const feedIdx = $(this).closest('.feedDiv').data('feed-idx');
			if(confirm('정말 삭제하시겠습니까?')) {
				$.ajax({
					type:'DELETE',
					url:'${pageContext.request.contextPath}/feed/'+feedIdx,
					success:function(result) {
						alert('삭제되었습니다.');
						window.location.href='${pageContext.request.contextPath}/feed'+window.location.search;
					}, error:function(error) {
						console.log(error.responseText);
					}
				});
			}
		});
			
		// 댓글 수정, 삭제
		$('#commentContainer').on('click', function(event) {
			let target = $(event.target); // 실제 클릭된 요소를 가리킴, this일 경우 이벤트가 실제로 걸려있는 commentContainer를 가리킴
			let method;
			let commentIdx;
			let commentText = '';
			let feedIdx = lastClickedButton.data('feed-idx'); // 마지막 클릭했던 댓글보기 버튼의 feed-idx
			let msg;
			
			if(target.parent().hasClass('commentButton')) {  // $('.commentButton')은 해당 클래스를 가진 모든 객체집합이므로 단일 객체와 비교할 수 없음
				event.stopPropagation();
				target.closest('.commentDiv').find('.dropdown-div').toggle(); // 드롭다운 메뉴를 토글
			// 수정하기 클릭
			} else if(target.hasClass('comment-modifyButton')) {
				const commentDiv = target.closest('.commentDiv');
				commentDiv.find('.commentDiv-content').hide();
				commentDiv.append(`
						<textarea id="commentDiv-modifyContent" placeholder="내용을 입력하세요." stlye="width:100%; height:80px; padding:10px;"></textarea>
						<div>
							<input type="submit" id="comment-modifySubmit" class="inputSubmit" value="수정하기" style="width:70px; font-size:15px;">
							<button type="button" id="comment-modifyCancle">취소</button>
						</div>`);
			// 수정하기 submit
			} else if(target.is($('#comment-modifySubmit'))) {
				if(confirm('수정하시겠습니까?')) {
					method = 'PUT';
					commentIdx = target.closest('.commentDiv').data('comment-idx');
					commentText = $('#commentDiv-modifyContent').val();
					msg = '수정되었습니다.';
				}
			// 수정하기 취소
			} else if(target.is($('#comment-modifyCancle'))) {
				const commentDiv = target.closest('.commentDiv');
				commentDiv.find('#commentDiv-modifyContent').remove();
				commentDiv.find('div:last-of-type').remove();
				commentDiv.find('.commentDiv-content').show();
			// 삭제하기 클릭
			} else if(target.hasClass('comment-deleteButton')) {
				if(confirm('정말 삭제하시겠습니까?')) {
					method = 'DELETE';
					commentIdx = target.closest('.commentDiv').data('comment-idx');
					msg = '삭제되었습니다.';
				}
			}
			// doing이 null또는 undefined가 아니면 조건문 진입
			if(method) {
				$.ajax ({
					type: method,
					url:'${pageContext.request.contextPath}/feed/'+feedIdx+'/comment/'+commentIdx,
					data:JSON.stringify({content:commentText}),
					contentType:'application/json',
					success:function(result) {
						// $(this).html(''); -> ajax 메서드의 success 콜백 안에서의 this는 ajax 설정 객체를 가리키므로 이 this는 commentContainer를 더이상 참조하지 않는다
						getComments(feedIdx);
						alert(msg);
					}, error:function(error) {console.log(error);}
				});
			}
		});
		
		
		// 신고하기
		$('.feed-reportButton, .comment-reportButton').on('click', function(event) {
			
		});
	</script>
</body>
</html>