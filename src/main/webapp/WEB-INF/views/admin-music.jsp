<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GORI</title>
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
	#searchMusic-wrapper {
		width: 100%;
		height: 85%;
		padding: 20px;
	}
	#searchMusicDiv input[type="text"] {
		background-color: white; 
		color: black; 
		padding: 10px;
	}
	#searchMusicDiv {
		height: 10%;
	}
	#searchResultDiv-artist, #searchResultDiv-album {
		display: flex;
		flex-wrap: wrap;
		width: 100%;
		max-height: 300px;
		padding: 30px 0;
	}
	#selectedMusic {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
	}
	#selectedMusic>div {
		margin-right: 20px;
	}
	#manageMusic-wrapper {
		display: none;
		width: 100%;
		height: 85%;
	}
	#manageMusic-main {
		height: 100%;
	}
	#manageMusic-header {
	}
	#manageMusic-content {
		width: 100%;
		height: 80%;
		padding: 10px 0;
	}
	#manageArtist, #manageAlbum {
		width: 100%;
		height: 100%;
	}
	#manageArtist-top, #manageAlbum-top {
		display:flex;
		align-items: center;
		width: 100%;
		padding: 0 20px;
	}
	#manageArtist-top>img, #manageAlbum-top>img {
		width: 200px;
		height: 200px;
		margin-right: 20px;
		border-radius: 5px;
	}
	#manageArtist-top>div, #manageAlbum-top>div {
		display: flex;
		flex-direction: column;
		justify-content: end;
	}
	#manageArtist-top>div>div {
		display: flex;
		gap: 10px;
	}
	#manageArtist h1, #manageAlbum h1 {
		font-size: 45px;
		font-weight: 800;
		margin-bottom: 10px;
	}
	#manageArtist-bottom {
		display: flex;
		flex-wrap: wrap;
		width: 100%;
		max-height: 50%;
	}
	#manageAlbum-bottom {
		display: flex;
		flex-direction: column;
		width: 100%;
		height: 50%;
		padding: 10px;
	}
	.manageMusic {
		display: flex;
		align-items: center;
		gap: 25px;
		width: 100%;
	}
	.manageMusic>div:first-of-type {
		flex-grow: 1;
	}
	#artistPreview {
		width: 100%;
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
						<span class="mainTitle">음악 관리</span>
						<a href="<c:url value='/admin/user'/>" class="subTitle">회원 관리</a>
						<a href="<c:url value='/admin/stats'/>" class="subTitle">통계</a>
					</div>
					<div id="main-nav-buttons">
						<button type="button" id="main-nav-searchButton" class="button-option button-selected">음악 삽입</button>
						<button type="button" id="main-nav-manageButton" class="button-option">DB 관리</button>
					</div>
				</div>
				<div id="searchMusic-wrapper" class="scroll">
					<div id="searchMusicDiv">
						가수 : <input type="text" id="artistName" class="inputSearch">
						<button type="button" id="searchMusicSubmit" class="inputSubmit">검색</button>
						<button type="button" id="insertAllSubmit" class="inputSubmit">insertAll</button>
						<select id="searchMusic-genre" class="selectBox">
							<c:forEach items="${genres}" var="g">
								<option value="${g}">${g.getKr()}</option>
							</c:forEach>						
						</select>
					</div>
					<div id="searchResultDiv-artist"></div>
					<div id="searchResultDiv-album"></div>
				</div>
				<div id="manageMusic-wrapper">
					<div id="manageMusic-main">
						<div id="manageMusic-header">
							<div>
								<select id="manageMusic-field" class="selectBox" data-current-field="">
									<option value="music">제목</option>
									<option value="album">앨범</option>
									<option value="artist">아티스트</option>
									<option value="lyrics">가사</option>
								</select>
								<input type="text" id="manageMusic-search" class="inputSearch" style="border:1px solid var(--button-color)">
								<button type="button" id="manageMusic-submit" class="inputSubmit">검색</button>
							</div>
						</div>
						<div id="manageMusic-content" class="scroll">
							<div id="manageMusic-searchResult"></div>
						</div>
					</div>
					<div id="manageMusic-artistDiv">
						<div id="artistDiv-albums"></div>
					</div>
					<div id="manageMusic-albumDiv"></div>
				</div>
			</div>
		</main>
	</div>
	
	<script>
		// insert - 아티스트 검색
		$('#searchMusicSubmit').on('click', function(event) {
		    const artistName = $('#artistName').val().trim();
	    	$.ajax({
				type:'GET',
				url:'${pageContext.request.contextPath}/admin/search/artist/'+artistName,
				success:function(result) {
					$('#searchResultDiv-artist').html('');
					$('#searchResultDiv-album').html('');
					$.each(result, function(index, artist) {
						const artistName = artist.name;
						let profileImg = '${pageContext.request.contextPath}/resources/image/profile/default.png';
						if(artist.images.length !== 0) {
							profileImg = artist.images[1].url;
						}
						const artistId = artist.id;
						let div =
						`<div>
							<div class="artistDiv" data-artist-id="${'${artistId}'}" style="width:90px; height:150px;">
								<img src="${'${profileImg}'}" style="width:70px; height:70px;">
								<div>
									<a href="#" class="text-overflow-2" onclick="event.preventDefault();">${'${artistName}'}</a>
									<span class="subText">아티스트</span>
								</div>
							</div>
							<button type="button" class="inputSubmit" style="width:50px; height:25px; font-size:13px;" data-artist-id="${'${artistId}'}">insert</button>
						</div>`;
						$('#searchResultDiv-artist').append(div);
					});
				}, error:function(error) {console.log(error);}
			});
		});
		
		// 앨범 div 생성, 아티스트 insert
		let lastClickedArtist = null;
		$('#searchResultDiv-artist').on('click', function(event) {
			const target = $(event.target);
			const artistDiv = target.closest('.artistDiv');
			
			// 아티스트의 모든 앨범 get
			if(artistDiv.length) {
				artistDiv.addClass('div-selected');
				if(lastClickedArtist != null) {
					lastClickedArtist.removeClass('div-selected');
				}
				
				const artistId = artistDiv.data('artist-id');
				const artistName = artistDiv.find('a').text();
				$.ajax ({
					type:'GET',
					url:'${pageContext.request.contextPath}/admin/search/album/'+artistId,
					success:function(result) {
						if(result.length==0) throw new Error('검색 결과 없음');
						$('#searchResultDiv-album').html('');
						$.each(result, function(index, album) {
							const albumName = album.name;
							const albumImg = album.images[1].url;
							const albumId = album.id;
							let div =
							`<div class="albumDiv" style="width:120px; height:180px;" data-album-id="${'${albumId}'}">
								<img src="${'${albumImg}'}" style="width:100px; height:100px;">
								<div>
									<a href="#" class="text-overflow-2" onclick="event.preventDefault();">${'${albumName}'}</a>
									<a href="#" class="subText text-overflow-2" onclick="event.preventDefault();">${'${artistName}'}</span>
								</div>
							</div>`;
							$('#searchResultDiv-album').append(div);
						});
					}, error: function(error) {alert('잠시 후 다시 시도해주세요.'); console.log(error);}
				});
				lastClickedArtist = artistDiv;
			}
			// 아티스트 insert
			if(target.hasClass('inputSubmit')) {
				const artistId = target.data('artist-id');
				const genre = $('#searchMusic-genre').val();
				$.ajax({
					type:'POST',
					url:'${pageContext.request.contextPath}/admin/search/artist/'+artistId,
					data:{genre:genre},
					success:function(result) {
						if(result==="SUCCESS") alert('insert succeed');
					}, error:function(error) {
						if(error.responseText==="DUPLICATED") {
							alert('이미 DB에 있는 아티스트입니다.')
						} else {
							alert('insert중 오류 발생')
						}
						console.log(error.statusText);
					}
				});
			}
		});
		
		// 모든 아티스트 insert
		$('#insertAllSubmit').on('click', function(event) {
			const target = $(event.currentTarget);	
			const insertArtists = $('#searchResultDiv-artist').find('.inputSubmit');
			insertArtists.each(function() {
				$(this).trigger('click');
			});
		});
		
		// 앨범 클릭 -> insert
		$('#searchResultDiv-album').on('click', function(event) {
			const target = $(event.target);
			const albumDiv = $(event.target).closest('.albumDiv');
			if(albumDiv.length) {
				const albumId = albumDiv.data('album-id');
				$.ajax({
					type:'POST',
					url:"${pageContext.request.contextPath}/admin/search/album/"+albumId,
					data:{},
					success:function(result) {
						if(result==="SUCCESS") alert('insert succeed');
					}, error:function(error) {
						alert('insert 중 오류 발생');
						console.log(error);
					}
				});
			}
		});
		
		// DB 관리
		let lastClickedWrapper = null;
		$('#main-nav-manageButton').on('click', function(event) {
			lastClickedWrapper = $(this);
			$(this).addClass('button-selected');
			$('#main-nav-searchButton').removeClass('button-selected');
			$('#manageMusic-wrapper').show();
			$('#searchMusic-wrapper').hide();
		});
		$('#main-nav-searchButton').on('click', function(event) {
			lastClickedWrapper = $(this);
			$(this).addClass('button-selected');
			$('#main-nav-manageButton').removeClass('button-selected');
			$('#manageMusic-wrapper').hide();
			$('#searchMusic-wrapper').show();
		});

		
		// DB 관리 - 검색
		let currentField = null;
		let currentKeyword = null;
		$('#manageMusic-submit').on('click', function(event) {
			const field = $('#manageMusic-field').val();
			let keyword = $('#manageMusic-search').val().trim();
			let url = '${pageContext.request.contextPath}/admin/manage/search/'+field+'/'+keyword;
			if(keyword === null || keyword === undefined || keyword === '') {
				url = '${pageContext.request.contextPath}/admin/manage/search/'+field;
			}				
			currentField = field;
			currentKeyword = keyword;
			
			$.ajax({
				type:'GET',
				url:url,
				data:{},
				success:function(result) {
					$('#manageMusic-searchResult').html('');
					$('#manageMusic-artistDiv').html('');
					if(result.list.length) {
						$.each(result.list, function(index, object) {
							const div = createPreview(currentField, object);
							$('#manageMusic-searchResult').append(div);
						});
						let pageDiv = createPageDiv(result.ph);
						$('#manageMusic-searchResult').append(pageDiv);
					} else {
						$('#manageMusic-searchResult').append(`<div>결과가 없습니다...</div>`);
					}
				}, error:function(jqXHR) {
					alert('잘못된 접근입니다.');
					console.log(jqXHR.responseText);
				}
			});
		});
		
		
		let detachedMain = null;
		let detachedArtist = null;
		// DB 관리
		$('#manageMusic-wrapper').on('click', function(event) {
			console.log('main',detachedMain);
			console.log('artist',detachedArtist);
			const target = $(event.target);
			const previewDiv = target.closest('.previewDiv');
			const searchResult = $('#manageMusic-searchResult');
			
			// artist_id로 album 불러옴
			if(previewDiv.hasClass('artistPreview')) {		
				const id = previewDiv.data('id'); // 아티스트의 id
				let artistObject = null;
				$.each(previewDiv, function() {artistObject = $(this).data();});
				
				$.ajax({
					type:'GET',
					url:'${pageContext.request.contextPath}/admin/manage/artist/'+id,
					data:{},
					success:function(result) {
						detachedMain = $('#manageMusic-main').detach();
						const artistManageDiv = createManageDiv('artist', artistObject);
						$('#manageMusic-artistDiv').append(artistManageDiv);
						$.each(result, function(index, object) {
							const albumDiv = createPreview('album', object);
							$('#manageArtist-bottom').append(albumDiv);
						});
					}, error:function(error) {
						console.log(error);
					}
				});
			// album의 모든 트랙 불러옴
			} else if(previewDiv.hasClass('albumPreview')) {
				const id = previewDiv.data('id');
				$.ajax({
					type:'GET',
					url:'${pageContext.request.contextPath}/admin/manage/album/'+id,
					data:{},
					success:function(result) {
						$.each(result, function(index, object) {
							if(index === 0) {
								const albumManageDiv = createManageDiv('album', object)
								$('#manageMusic-albumDiv').append(albumManageDiv);								
							}
							const div = createManageDiv('music', object);
							$('#manageAlbum-bottom').append(div);
						});
						if(detachedMain === null) detachedMain = $('#manageMusic-main').detach();
						else detachedArtist = $('#manageMusic-artistDiv').detach();
					}, error:function(error) {
						console.log(error);
					}
				});
			} else if(previewDiv.hasClass('musicPreview')) {
				const id = previewDiv.data('album_id');
				$.ajax({
					type:'GET',
					url:'${pageContext.request.contextPath}/admin/manage/album/'+id,
					data:{},
					success:function(result) {
						$.each(result, function(index, object) {
							if(index === 0) {
								const albumManageDiv = createManageDiv('album', object)
								$('#manageMusic-albumDiv').append(albumManageDiv);								
							}
							const div = createManageDiv('music', object);
							$('#manageAlbum-bottom').append(div);
						});
						if(detachedMain === null) detachedMain = $('#manageMusic-main').detach();
						else detachedArtist = $('#manageMusic-artistDiv').detach();
					}, error:function(error) {
						console.log(error);
					}
				});
			}
			// 페이지 버튼
			else if(target.hasClass('pageButton')) {
				page = target.data('page');
				const field = currentField;
				const keyword = currentKeyword;
				
				let url = '${pageContext.request.contextPath}/admin/manage/search/'+field+'/'+keyword;
				if(keyword === null || keyword === undefined || keyword === "") {
					url = '${pageContext.request.contextPath}/admin/manage/search/'+field;
				}
				$.ajax({
					type:'GET',
					url:url,
					data:{page:page},
					success:function(result) {
						$('#manageMusic-searchResult').html('');
						$('#manageMusic-artistDiv').html('');
						$.each(result.list, function(index, object) {
							const div = createPreview(field, object);
							$('#manageMusic-searchResult').append(div);
						});
						let pageDiv = createPageDiv(result.ph);
						$('#manageMusic-searchResult').append(pageDiv);
					}, error:function(jqXHR) {
						alert('잘못된 접근입니다.');
						console.log(jqXHR.responseText);
					}
				});
				
			// 뒤로가기
			} else if(target.is('#manageArtist-back')) {
				target.closest('.manageArtist').remove();
				$('#manageMusic-wrapper').prepend(detachedMain);
				detachedMain = null;
			} else if(target.is('#manageAlbum-back')) {
				target.closest('.manageAlbum').remove();
				if(detachedArtist !== null) {
					$('#manageMusic-wrapper').prepend(detachedArtist);
					detachedArtist = null;
				}
				else {
					$('#manageMusic-wrapper').prepend(detachedMain);
					detachedMain = null;
				}
			}
		});
		
		// 수정, 삭제
		$('#manageMusic-wrapper').on('click', function(event) {
			const target = $(event.target);
			let manageDiv = target.closest('.manageDiv');
			
			let field = null;
			let id = null;
			if(manageDiv.is('#manageArtist')) {
				field = 'artist';
				id = manageDiv.data('id');
			}
			else if(manageDiv.is('#manageAlbum')) {
				field = 'album';
				id = manageDiv.data('id');
			}
			else if(manageDiv.hasClass('musicDiv')) {
				field = 'music';
				id= manageDiv.data('id');
			}
			
			// 수정
			if(target.hasClass('modifyButton')) {
				let modal = createModifyDiv(field, id, manageDiv);
				$('#manageMusic-wrapper').append(modal);
			}
			else if(target.is('#modifySubmit')) {
				const cols = $('#modifyModal').find('span').map(function() {
					return $(this).text();
				}).get();
				const values = $('#modifyModal').find('input').map(function() {
					return $(this).val();
				}).get();
				field = $('#modifyModal').data('field');
				id = $('#modifyModal').data('id');
				
				$.ajax({
					type:'PUT',
					url:'${pageContext.request.contextPath}/admin/manage/'+field+'/'+id,
					data:JSON.stringify({cols:cols, values:values}),
					contentType:'application/json',
					success:function(result) {
						if(result === 'SUCCESS') alert('수정되었습니다.');
						else alert('실패했습니다.');
					}, error:function(error) {
						alert('수정에 실패했습니다.');
						console.log(error.responseText);
					}
				});
			}
			
			// 삭제
			else if(target.hasClass('deleteButton')) {
				let message = '정말 삭제하시겠습니까?';
				if(field === 'artist') message += ' 아티스트의 모든 음악이 삭제됩니다.';
				else if(field === 'album') message += ' 앨범의 모든 트랙이 삭제됩니다.';
				
				if(confirm(message)) {
					$.ajax({
						type:'DELETE',
						url:'${pageContext.request.contextPath}/admin/manage/'+field+'/'+id,
						data:{},
						success:function(result) {
							if(result === "SUCCESS") {
								alert('삭제되었습니다.');
								if(field === "artist") {
									manageDiv.html('');
									detachedMain.find('.artistPreview[data-id]="'+id+'"').remove();
									$('#manageMusic-wrapper').prepend(detachedMain);
								} else if(field === "album") {
									manageDiv.html('');
									if(detachedMain !== null) {
										detachedMain.find('.albumPreview[data-album_id="'+id+'"]').remove();
										$('#manageMusic-wrapper').prepend(detachedMain);
									} else {
										detachedArtist.find('.albumPreview[data-album_id="'+id+'"]').remove();
										$('#manageMusic-wrapper').prepend(detachedArtist);
									}
								} else if(field === "music") {
									manageDiv.remove();
								}
							}
						}, error:function(error) {
							alert('삭제에 실패했습니다.');
							console.log(error.responseText);
						}
					});
				}
			} else if(target.hasClass('modal-close')) {
				target.closest('.modal-body').remove();
			}
			
		});
	</script>
</body>
</html>