<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GORI</title>
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/view-artist.css'/>?ts=<%= System.currentTimeMillis() %>">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="./include-navi.jsp"/>
		
		<jsp:include page="./include-playlist.jsp"/>
		
		<jsp:include page="./include-quelist.jsp"/>
		
		<jsp:include page="./include-toolBar.jsp"/>
		
		<main>
			<div class="sectionWrapper">
				<div id="artistView-wrapper" class="scroll" data-id="${map.artist.id}" data-name="${map.artist.name}" data-genre="${map.artist.genre}" data-profile-img="${map.artist.profileImg}" data-monthly-listener="${map.artist.monthlyListener}">
					<div id="artistView-top" >
						<div>
							<img src="${map.artist.profileImg}" class="imgPreview">
						</div>
						<div>
							<span>아티스트</span>
							<span>${map.artist.name}</span>
							<span>팔로워 ${map.artist.followCount}</span>
						</div>
					</div>
					<div id="artistView-buttons">
						<button type="button" class="playButton"><i class="fa-solid fa-circle-play"></i></button>
						<c:choose>
						<c:when test="${map.artist.isFollowed}">
							<button type="button" class="followButton" data-is-followed="true" style="color:white;">팔로잉</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="followButton" data-is-followed="false">팔로우</button>
						</c:otherwise>
						</c:choose>
					</div>
					<div id="artistView-bottom">
						<div id="artistView-popular">
							<h1>인기</h1>
							<div>
								<c:forEach items="${map.populars}" var="music" varStatus="loop">
									<div class="musicView" data-idx="${music.idx}" data-title="${music.title}" data-artist_id="${music.artistId}" data-artist-name="${music.artistName}" data-album_id="${music.albumId}" data-album-img="${music.albumImg}" data-popularity="${music.popularity}" data-duration="${music.duration}" data-preview-url="${music.previewUrl}">
										<span class="subText">${loop.count}</span>
										<div class="text-overflow">
											<img src="${music.albumImg}"></img>										
											<a href="<c:url value='/album/${music.albumId}'/>">${music.title}</a>
										</div>
										<span class="subText" style="display:block; width: 10%;">${music.likedCount}</span>
										<span class="subText" style="display:block; width: 10%;">${music.durationString}</span>
										<div>
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
						<h2>앨범</h2>
						<div id="artistView-albums">
							<c:forEach items="${map.albums}" var="music">
								<div class="albumDiv contentDiv" data-id="${music.albumId}">
									<div>
										<img src="<c:url value='${music.albumImg}'/>">
										<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
									</div>
									<a href="<c:url value='/album/${music.albumId}'/>" class="text-overflow-2">${music.albumName}</a>
									<span class="subText text-overflow-2">${music.artistName}</span>
								</div>
							</c:forEach>
						</div>
						<h2>비슷한 아티스트</h2>
						<div id="artistView-similars">
							<c:forEach items="${map.similars}" var="artist">
								<div class="artistDiv contentDiv" data-artist-id="${artist.id}">
									<div>
										<img src="<c:url value='${artist.profileImg}'/>">
									</div>
									<a href="<c:url value='/artist/${artist.id}'/>" class="text-overflow-2">${artist.name}</a>
									<span class="subText">아티스트</span>
								</div>
							</c:forEach>
						</div>
						<h2>${map.artist.name} 플레이리스트</h2>
						<div id="artistView-playlists">
							<c:forEach items="${map.playlists}" var="playlist">
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
		$('.artistView>button').on({
			mouseover: function(event) {
				$(this).css('transform', 'scale(1.1)');
			},
			mouseleave: function(event) {
				$(this).css('transform', 'scale(1)');
			}
		});
		
		// 인기 트랙 재생
		$('#artistView-buttons').on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			
			if(button.hasClass('playButton')) {
				const artistId = target.closest('#artistView-wrapper').data('id');
				playMusicsInContent('artist', artistId);
			}
		});
		
		// $('.followButton') 아티스트 팔로우, getArtistPage 만들기...
		$('#artistView-buttons').on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			const artist = target.closest('#artistView-wrapper').data();
			
			// 팔로우
			if(button.hasClass('followButton')) {
				if(!button.data('is-followed')) {
					$.ajax({
						type:'POST',
						url:contextPath+'/user/'+currentUserIdx+'/artist/'+artist.id+'/follow',
						data:{},
						success: function(result) {
							button.css('color', 'white');
							button.text('팔로잉')
							button.data('is-followed', true);
							showMessage('팔로우 되었습니다.');
						}, error: function(error) {
							console.log(error);
							showMessage(errorMessage);
						}
					});
				} else {
					$.ajax({
						type:'DELETE',
						url:contextPath+'/user/'+currentUserIdx+'/artist/'+artist.id+'/follow',
						data:{},
						success: function(result) {
							button.css('color', 'var(--text-color-middle)');
							button.text('팔로우')
							button.data('is-followed', false);
							showMessage('팔로우가 취소되었습니다.');
						}, error: function(error) {
							console.log(error);
							showMessage(errorMessage);
						}
					})
				}
			// 드롭다운	
			} else if(button.hasClass('dropdownButton')) {
				// 필요한 버튼 생각해보기
			}
		});
		
		$('#artistView-popular').on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			const music = target.closest('.musicView').data();
			
			if(button.hasClass('playButton')) {
				addMusicToQuelist(music)
		        .then(() => {
		            const mList = $('#quelist-list .musicPreview');
		            playNewMusic(mList.length - 1);
		        })
		        .catch(error => {
		            console.log(error);
		            showMessage(errorMessage);
		        });
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
			// 드롭다운
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