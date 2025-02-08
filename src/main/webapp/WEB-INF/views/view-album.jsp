<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GORI</title>
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/view-album.css'/>?ts=<%= System.currentTimeMillis() %>">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="./include-navi.jsp"/>
		
		<jsp:include page="./include-playlist.jsp"/>
		
		<jsp:include page="./include-quelist.jsp"/>
		
		<jsp:include page="./include-toolBar.jsp"/>
		
		<main>
			<div class="sectionWrapper">
				<div id="albumView-wrapper" class="scroll" data-id="${map.album.albumId}">
					<div id="albumView" class="view">
						<div id="albumView-top">
							<img src="${map.album.albumImg}" class="imgPreview">
							<div>
								<div>
									<span>앨범</span>
									<span>${map.album.albumName}</span>
								</div>
								<div>
									<img src="${map.album.profileImg}" class="imgPreview">
									<a href="<c:url value='/artist/${map.album.artistId}'/>">${map.album.artistName}</a>
									<span>•</span>
									<span>${map.album.releaseDate}</span>
									<span>•</span>
									<span>${map.album.genre}</span>
								</div>
							</div>
						</div>	
						<div id="albumView-buttons">
							<button type="button" class="playButton"><i class="fa-solid fa-circle-play"></i></button>
						</div>
						<div id="albumView-bottom">
							<div>
								<span class="subText">#</span>
								<div><span class="subText">제목</span></div>
							</div>
							<c:forEach items="${map.mList}" var="music">
								<div class="musicView" data-idx="${music.idx}" data-title="${music.title}" data-artist_id="${music.artistId}" data-artist-name="${music.artistName}" data-album_id="${music.albumId}" data-album-img="${music.albumImg}" data-popularity="${music.popularity}" data-duration="${music.duration}" data-preview-url="${music.previewUrl}">
									<span class="subText">${music.trackNumber}</span>
									<div>
										<span>${music.title}</span>
										<span class="subText">${music.artistName}</span>
									</div>
									<div>
										<span class="subText">${music.likedCount}</span>
										<span class="subText">${music.durationString}</span>
									</div>
									<div style="position:relative;">
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
								</div>
							</c:forEach>
						</div>
					</div>
					<div id="otherAlbums">
						<h2>아티스트의 다른 앨범</h2>
						<div>
							<c:forEach items="${map.others}" var="music">
								<div class="albumDiv contentDiv" data-id="${music.albumId}" data-artist-id="${object.artistId}">
									<div>
										<img src="<c:url value='${music.albumImg}'/>">
										<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
									</div>
									<a href="<c:url value='/album/${music.albumId}'/>" class="text-overflow-2">${music.albumName}</a>
									<span class="subText text-overflow-2">${music.artistName}</span>
								</div>
							</c:forEach>
						</div>
					</div>
					<div id="similarAlbums">
						<h2>이 앨범과 유사한 앨범</h2>
						<div>
							<c:forEach items="${map.similars}" var="music">
								<div class="albumDiv contentDiv" data-id="${music.albumId}" data-artist-id="${music.artistId}">
									<div>
										<img src="<c:url value='${music.albumImg}'/>">
										<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
									</div>
									<a href="<c:url value='/album/${music.albumId}'/>" class="text-overflow-2">${music.albumName}</a>
									<a href="<c:url value='/artist/${music.artistId}'/>" class="subText text-overflow-2">${music.artistName}</a>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script src="<c:url value='/resources/js/functions-view.js'/>?ts=<%= System.currentTimeMillis() %>"></script>
	<script>
		// 앨범 전체 재생
		$('#albumView-buttons').on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			
			if(button.hasClass('playButton')) {
				const albumId = target.closest('#albumView-wrapper').data('id');
				playMusicsInContent('album', albumId);
			}
		});
	
		// musicView 버튼
		$('.musicView').on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			const music = target.closest('.musicView').data();
			
			// 재생
			if(button.hasClass('playButton')) {
				addMusicToQuelist(music, currentUserIdx)
		        .then(() => {
		            // 성공적으로 추가되었을 때만 클릭 동작 실행
		            const mList = $('#quelist-list .musicPreview');
		            playNewMusic(mList.length - 1);
		        })
		        .catch(error => {
		            console.log(error);
		            showMessage(errorMessage);
		        });
				
			// 좋아요
			} else if(button.hasClass('likeButton')) {
				if(!button.data('is-liked')) {
					userLikeMusic(music.idx)
					.then(result => {
						button.html('<i class="fa-solid fa-heart" style="color: #fff480;"></i>');
						button.data('is-liked', true);
						showMessage('좋아요 표시한 곡에 추가되었습니다.');
					})
					.catch(error => {
						console.log(error);
						showMessage(errorMessage);
					});
				} else {
					userNotLikeMusic(music.idx)
					.then(result => {
						button.html('<i class="fa-regular fa-square-plus"></i>');
						button.data('is-liked', false);
						showMessage('좋아요 표시한 곡에서 삭제되었습니다.');
					})
					.catch(error => {
						console.log(error);
						showMessage(errorMessage);
					});
				}
			} else if(button.hasClass('dropdownButton')) {
				button.parent().find('.dropdown-div').show();
			
			// 재생목록에 추가
			} else if(button.hasClass('addToQuelist')) {
				addMusicToQuelist(music, currentUserIdx)
				.then(() => {
					
				})
				.catch(error => {
					console.log(error);
					showMessage(errorMessage);
				});
			// 플레이리스트에 추가
			} else if(button.hasClass('addToPlaylist')) {
				createPlaylistModal(music.idx);
				
			// 피드 작성하기
			} else if(button.hasClass('writeFeed')) {
				const div = createFeedModal(music);
				target.closest('.musicView').append(createModal(div));
			}
		});
	</script>
</body>
</html>