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
				<div id="main-content">
					<div id="home-famousChart">
						<div id="home-chart-header">
							<h2>인기 차트</h2>
						</div>
						<div id="home-chart-container" class="scroll" style="width:100%; height:500px;">
							<c:forEach items="${chart}" var="music" varStatus="loop">
								<div class="musicView" data-idx="${music.idx}" data-title="${music.title}" data-artist_id="${music.artistId}" data-artist-name="${music.artistName}" data-album_id="${music.albumId}" data-album-img="${music.albumImg}" data-popularity="${music.popularity}" data-duration="${music.duration}" data-preview-url="${music.previewUrl}" data-list-order="${music.listOrder}">
									<span class="subText">${loop.count}</span>
									<div>
										<img src="${music.albumImg}">
										<div>
											<span>${music.title}</span>
											<span class="subText">${music.artistName}</span>
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
				</div>
			</div>
		</main>
	</div>
</body>
</html>