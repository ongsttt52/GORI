<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/search.css'/>?ts=<%= System.currentTimeMillis() %>">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="./include-navi.jsp"/>
		
		<jsp:include page="./include-playlist.jsp"/>
		
		<jsp:include page="./include-quelist.jsp"/>
		
		<jsp:include page="./include-toolBar.jsp"/>
		
		<main>
			<div class="sectionWrapper">
				<div id="search-container" class="scroll">
					<div>
						<div id="topResult-wrapper">
							<h2>상위 결과</h2>
							<c:choose>
								<c:when test="${empty musics}">
									<div class="emptyResult">
										<span>결과가 없습니다...</span>
									</div>
								</c:when>
								<c:otherwise>
									<div id="topResult-content" class="contentDiv" data-id="${musics[0].idx}">
										<div>
											<img src="${musics[0].albumImg}" class="imgPreview" style="width:150px; height:150px; border-radius:5px;">
											<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
										</div>
										<a href="<c:url value='/album/${musics[0].albumId}'/>" class="text-overflow">${musics[0].title}</a>
										<span>${musics[0].artistName}</span>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div id="searchResult-musics">
							<div>
								<h2>곡</h2>
								<c:if test="${not empty musics[1]}">
								<a href="<c:url value='/search/music/${albums.ph.sc.keyword}'/>" style="float:right;">더보기</a>
								</c:if>
							</div>
							<div id="searchResult-musics-content">
								<c:choose>
									<c:when test="${empty musics[1]}">
										<div class="emptyResult">
											<span>결과가 없습니다...</span>
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach items="${musics}" var="m" varStatus="loop" begin="1" end="5">
										<c:if test="${loop.count != 1}">
											<div class="musicPreview contentDiv" data-id="${m.idx}">
												<img src="${m.albumImg}" class="imgPreview" style="width:50px;">
												<div>
													<a href="<c:url value='/album/${m.albumId}'/>">${m.title}</a>
													<span class="subText">${m.artistName}</span>
												</div>
												<div>
													<c:choose>
													<c:when test="${empty m.previewUrl}">
														<span style="width:150px;">미리듣기 없음</span>
													</c:when>
													<c:otherwise>
														<button type="button" class="playButton"><i class="fa-solid fa-play"></i></button>
													</c:otherwise>
													</c:choose>
												</div>
											</div>
										</c:if>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<h2>아티스트</h2>
					<div id="searchResult-artists">
						<div id="searchResult-artists-content">
							<c:choose>
								<c:when test="${empty artists.list}">
									<div class="emptyResult">
										<span>결과가 없습니다...</span>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach items="${artists.list}" var="artist">
										<div class="artistDiv contentDiv" data-id="${artist.id}">
											<div>
												<img src="${artist.profileImg}">
											</div>
											<div>
												<a href="<c:url value='/artist/${artist.id}'/>" class="text-overflow-2">${artist.name}</a>
												<span class="subText">아티스트</span>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<h2>앨범</h2>
					<div id="searchResult-albums">
						<div id="searchResult-albums-content">
							<c:choose>
								<c:when test="${empty albums.list}">
									<div class="emptyResult">
										<span>결과가 없습니다...</span>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach items="${albums.list}" var="album">
										<div class="albumDiv contentDiv" data-id="${album.albumId}">
											<div>
												<img src="${album.albumImg}">
												<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
											</div>
											<div>
												<a href="<c:url value='/artist/${album.albumId}'/>" class="text-overflow-2">${album.albumName}</a>
												<span class="subText">앨범</span>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<h2>플레이리스트</h2>
					<div id="searchResult-playlists">
						<div id="searchResult-playlists-content">
							<c:choose>
								<c:when test="${empty playlists.list}">
									<div class="emptyResult">
										<span>결과가 없습니다...</span>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach items="${playlists.list}" var="p">
										<div class="playlistDiv contentDiv" data-id="">
											<div>
												<img src="${p.playlistImage}">
												<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
											</div>
											<div>
												<a href="<c:url value='/playlist/${p.idx}'/>" class="text-overflow-2">${p.name}</a>
												<span class="subText">플레이리스트</span>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script>
	
	</script>
</body>
</html>