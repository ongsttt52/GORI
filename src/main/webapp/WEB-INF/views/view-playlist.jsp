<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GORI</title>
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/view-playlist.css'/>?ts=<%= System.currentTimeMillis() %>">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="./include-navi.jsp"/>
		
		<jsp:include page="./include-playlist.jsp"/>
		
		<jsp:include page="./include-quelist.jsp"/>
		
		<jsp:include page="./include-toolBar.jsp"/>
		
		<main>
			<div class="sectionWrapper">
				<div id="playlistView-wrapper" class="scroll" data-idx="${map.playlist.idx}">
					<div id="playlistView-top" >
						<img src="${map.playlist.playlistImage}" class="imgPreview">
						<div>
							<div>
								<span>플레이리스트</span>
								<span>${map.playlist.name}</span>
							</div>
							<div>
								<a href="<c:url value='/user/${map.playlist.userIdx}'/>">${map.playlist.userName}</a>
								<span>•</span>
								<span>${map.playlistSize}곡</span>
								<span>•</span>
								<span>약 ${map.playlistDuration}</span>
							</div>
						</div>
					</div>
					<div id="playlistView-buttons">
						<button type="button" class="playButton"><i class="fa-solid fa-circle-play"></i></button>
						<c:if test="${map.playlist.userIdx eq sessionScope.user.idx}">
							<button type="button" class="modifyButton" data-toggle="false">편집</button>
						</c:if>
						<div id="playlistView-modifyDiv" style="display:none;">
							<button type="button" class="checkAll button-option">전체 선택</button>
							<button type="button" class="deleteAll inputSubmit" style="width:70px; height:40px; margin-left: 20px;">삭제</button>
						</div>
					</div>
					<div id="playlistView-bottom">
						<div>
							<span class="subText">#</span>
							<div><span class="subText">제목</span></div>
						</div>
						<c:forEach items="${map.mList}" var="music" varStatus="loop">
							<div class="musicView" data-idx="${music.idx}" data-title="${music.title}" data-artist_id="${music.artistId}" data-artist-name="${music.artistName}" data-album_id="${music.albumId}" data-album-img="${music.albumImg}" data-popularity="${music.popularity}" data-duration="${music.duration}" data-preview-url="${music.previewUrl}" data-list-order="${music.listOrder}">
								<span class="subText">${loop.count}</span>
								<div>
									<span>${music.title}</span>
									<span class="subText">${music.artistName}</span>
								</div>
								<div>
									<span class="subText">${music.likedCount}</span>
								</div>
								<div>
									<span class="subText">${music.durationString}</span>
								</div>
								<div class="musicView-buttons" style="position:relative;">
									<c:choose>
										<c:when test="${empty music.previewUrl || music.previewUrl eq 'null'}">
											<span style="font-size:14px;">준비중</span>
										</c:when>
										<c:otherwise>
											<button type="button" class="playButton" data-url="${music.previewUrl}"><i class="fa-solid fa-play"></i></button>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${music.isLiked}">
											<button type="button" class="likeButton" data-is-liked="true"><i class="fa-solid fa-heart" style="color: #fff480;"></i></button>
										</c:when>
										<c:otherwise>
											<button type="button" class="likeButton" data-is-liked="false"><i class="fa-regular fa-square-plus"></i></button>
										</c:otherwise>
									</c:choose>
									<button type="button" class="dropdownButton"><i class="fa-solid fa-ellipsis"></i></button>
									<c:choose>
										<c:when test="${empty sessionScope.user}">
											<div class="dropdown-div" style="padding: 10px;">
												<span>로그인 후</span><br><span>이용 가능합니다.</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="dropdown-div">
												<c:if test="${music.previewUrl != 'null'}">
													<button type="button" class="addToQuelist">재생목록에 추가</button>
													<button type="button" class="addToPlaylist">플레이리스트에 추가</button>
												</c:if>
												<button type="button" class="writeFeed">피드 작성하기</button>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="musicView-checkBox" style="display:none;">
									<input type="checkbox" class="checkBox">
								</div>
							</div>
						</c:forEach>
						<h2>비슷한 플레이리스트 더 보기</h2>
						<div id="playlistView-similars">
							<c:forEach items="${map.similars}" var="playlist">
								<div class="playlistDiv contentDiv" data-idx="${playlist.idx}">
									<div>
										<img src="<c:url value='${playlist.playlistImage}'/>">
										<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
									</div>
									<a href="<c:url value='/playlist/${playlist.idx}'/>" class="text-overflow-2">${playlist.name}</a>
									<span class="subText text-overflow-2">${playlist.userName}의 플레이리스트</span>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
	
	<script>
		$('#playlistView-buttons').on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			
			// 전체 재생
			if(button.hasClass('playButton')) {
				const idx = target.closest('#playlistView-wrapper').data('idx');
				playMusicsInContent('playlist', idx);
			
			// 플레이리스트 편집
			} else if(button.hasClass('modifyButton')) {
				// 추가 할 기능 : 곡 순서 변경 (드래그 앤 드롭), 플레이리스트 수정, 삭제
				if(!button.data('toggle')) {
					$('.musicView-buttons').hide();
					$('.musicView-checkBox').show();
					button.text('끝내기');
					$('#playlistView-modifyDiv').show();
					button.data('toggle', true);
				} else {
					$('.musicView-buttons').show();
					$('.musicView-checkBox').hide();
					button.text('편집');
					$('#playlistView-modifyDiv').hide();
					button.data('toggle', false);
				}
			// 전체 선택
			} else if(button.hasClass('checkAll')) {
				if(!button.hasClass('button-selected')) {
					button.addClass('button-selected');
					$('#playlistView-bottom .musicView input[type="checkbox"]').prop('checked', true);
				} else {
					button.removeClass('button-selected');
					$('#playlistView-bottom .musicView input[type="checkbox"]').prop('checked', false);
				}
			// 삭제
			} else if(button.hasClass('deleteAll')) {
				if(confirm('정말 음악을 삭제하시겠습니까?')) {
					const playlistIdx = target.closest('#playlistView-wrapper').data('idx');
					const checkedMusics = $('#playlistView-bottom .musicView input[type="checkbox"]:checked').closest('.musicView');
					console.log(checkedMusics);
					let isFailed = false;
					$.each(checkedMusics, function(index, music){
						// 추가할 기능 : 트랜잭션 처리
						console.log($(music).data('list-order'));
						deleteMusicFromPlaylist(playlistIdx, $(music).data('list-order'))
						.then(() => {
							$(music).remove();
						})
						.catch(error =>{
							isFailed = true;
							showMessage(errorMessage);
							return false;
						});
					});
					if(!isFailed) showMessage('음악이 삭제되었습니다.');
				}
			}
		});
		
	</script>
</body>
</html>