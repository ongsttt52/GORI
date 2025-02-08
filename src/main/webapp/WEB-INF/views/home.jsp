<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GORI</title>
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/home.css'/>?ts=<%= System.currentTimeMillis() %>">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="./include-navi.jsp"/>
		
		<jsp:include page="./include-playlist.jsp"/>
		
		<jsp:include page="./include-quelist.jsp"/>
		
		<jsp:include page="./include-toolBar.jsp"/>
		
		<main id="section-main">
			<div class="sectionWrapper">
				<div id="main-content" class="scroll">
				<div id="home-famousChart">
							<div id="home-chart-header">
								<h2>인기 차트</h2>
								<a href="<c:url value='/chart'/>" style="float:right;">더보기</a>
							</div>
							<div id="home-chart-container">
								<c:forEach items="${chart}" var="music" varStatus="loop">
									<div class="musicView" data-idx="${music.idx}" data-title="${music.title}" data-artist_id="${music.artistId}" data-artist-name="${music.artistName}" data-album_id="${music.albumId}" data-album-img="${music.albumImg}" data-popularity="${music.popularity}" data-duration="${music.duration}" data-preview-url="${music.previewUrl}" data-list-order="${music.listOrder}">
										<span class="subText">${loop.count}</span>
										<div>
											<img src="${music.albumImg}">
											<div>
												<a href="<c:url value='/album/${music.albumId}'/>">${music.title}</a>
												<a href="<c:url value='/artist/${music.artistId}'/>" class="subText">${music.artistName}</a>
											</div>
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
							</div>
						</div>
					<c:choose>
					<c:when test="${empty sessionScope.user}">
						<div id="home-famousArtist">
							<div id="home-artist-header">
								<h2>인기 아티스트</h2>
							</div>
							<div id="home-artist-container">
								<c:forEach items="${artists}" var="object">
									<div class="artistDiv contentDiv" data-id="${object.id}">
										<div>
											<img src="<c:url value='${object.profileImg}'/>">
										</div>
										<a href="<c:url value='/artist/${object.id}'/>" class="subText text-overflow-2">${object.name}</a>
									</div>
								</c:forEach>
							</div>
						</div>
						<div id="home-famousAlbum">
							<div id="home-artist-header">
								<h2>인기 앨범</h2>
							</div>
							<div id="home-album-container">
								<c:forEach items="${albums}" var="object">
									<div class="albumDiv contentDiv" data-id="${object.idx}" data-album-id="${object.albumId}" data-artist-id="${object.artistId}">
										<div>
											<img src="<c:url value='${object.albumImg}'/>">
											<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
										</div>
										<a href="<c:url value='/album/${object.albumId}'/>" class="text-overflow-2">${object.albumName}</a>
										<a href="<c:url value='/artist/${object.artistId}'/>" class="subText text-overflow-2">${object.artistName}</a>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div id="hottest-wrapper">
							<div class="home-wrapper-header">
								<h2>지금 가장 인기 있는 곡</h2>
							</div>
							<div id="hottest-container" class="home-containers">
								<c:forEach items="${hottest}" var="object">
								<div class="musicDiv contentDiv" data-id="${object.idx}" data-album-id="${object.albumId}" data-artist-id="${object.artistId}">
									<div>
										<img src="<c:url value='${object.albumImg}'/>">
										<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
									</div>
									<a href="<c:url value='/album/${object.albumId}'/>" class="text-overflow-2">${object.title}</a>
									<span class="subText text-overflow-2">${object.artistName}</span>
								</div>
							</c:forEach>
							</div>
						</div>
						<div id="recentMusic-wrapper">
							<div class="home-wrapper-header">
								<h2><a href="<c:url value=''/>">회원님을 위한 최신 음악</a></h2>
							</div>
							<div id="recentMusic-container" class="home-containers">
								<c:forEach items="${recent}" var="object">
								<div class="albumDiv contentDiv" data-id="${object.idx}" data-album-id="${object.albumId}" data-artist-id="${object.artistId}">
									<div>
										<img src="<c:url value='${object.albumImg}'/>">
										<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
									</div>
									<a href="<c:url value='/album/${object.albumId}'/>" class="text-overflow-2">${object.albumName}</a>
									<a href="<c:url value='/artist/${object.artistId}'/>" class="subText text-overflow-2">${object.artistName}</a>
								</div>
							</c:forEach>
							</div>
						</div>
						<div id="playBack-wrapper">
							<div class="home-wrapper-header">
								<h2><a href="<c:url value=''/>">다시 들어보세요</a></h2>
							</div>
							<div id="playBack-container" class="home-containers">
								<c:forEach items="${playBack}" var="object">
								<div class="albumDiv contentDiv" data-id="${object.idx}" data-album-id="${object.albumId}" data-artist-id="${object.artistId}">
									<div>
										<img src="<c:url value='${object.albumImg}'/>">
										<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
									</div>
									<a href="<c:url value='/album/${object.albumId}'/>" class="text-overflow-2">${object.albumName}</a>
									<a href="<c:url value='/artist/${object.artistId}'/>" class="subText text-overflow-2">${object.artistName}</a>
								</div>
							</c:forEach>
							</div>
						</div>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</main>
	</div>
	
	<script>
	// albumDiv-playButton 이벤트
	$('.albumDiv, .musicDiv').on({ // 이벤트를 객체형태로 적용하기
		mouseover: function(event) {
			$(this).find('.contentDiv-playButton').fadeIn(200);
		},
		mouseleave: function(event) {
			$(this).find('.contentDiv-playButton').fadeOut(200);
		}
	});
	
	// 재생목록에 추가
	$('.albumDiv-playButton').on('click', function(event) {
		/* const div = event.target.closest('.albumDiv');
		console.log(div.find('a:first-of-type')); */
		// -> find()는 jQuery의 메서드이므로 $(event.target)으로 메서드체이닝을 시작해야함, closest는 자바스크립트와 jQuery에 둘 다 있는 메서드이기 때문에 구분해서 사용할 것
		
		const albumName = $(event.target).closest('.albumDiv').find('a:first-of-type').text();
		$.ajax ({
			type:'POST',
			url:'music?mode=addList',
			data:{value:albumName},
			success:function(result) {
				result.forEach(function(m) {
					const musicDiv = createMusicDiv(m.idx, m.title, m.artist, m.albumImgPath);
					$('#queueList-list').prepend(musicDiv);
				});
			}, error:function(error) {console.log(error);}
		})
	});
	
	// 재생
	$('#right-queueList').on('click', '.music-playButton', function(event) {
		const musicDiv = $(event.target).closest('musicDiv');
		const idx = musicDiv.data('music-idx');
		const title = musicDiv.data('music-title');
		const artist = musicDiv.data('music-artist');
		const img = musicDiv.data('music-img');
		$('#toolBar-left>img').attr('src', img);
		$('#toolBar-left>div>a:first-of-type').text(title);
		$('#toolBar-left>div>a:last-of-type').text(artist);
		
		$.ajax({
			type:'POST',
			url:'music?mode=play',
			data:{idx:idx},
			success:function(result) {
				const filePath = result.filePath;
				console.log($('#toolBar-audio'));
				console.log($('#toolBar-audio source'));
				console.log($('#toolBar-audio source')).attr('src');
				$('#toolBar-audio source').attr('src', filePath);
			}, error:function(error) {console.log(error);}
		});
	});
	</script>
</body>
</html>