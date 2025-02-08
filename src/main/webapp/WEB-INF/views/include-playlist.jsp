<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/resources/css/playlist.css'/>?ts=<%= System.currentTimeMillis() %>">

<section id="section-left" >
	<div class="sectionWrapper">
		<div id="left-header">
			<h2 class="mainTitle">내 라이브러리</h2>
			<c:if test="${not empty sessionScope.user}">
				<button type="button" id="createPlaylist-button" style="font-size: 30px;"><i class="icon fa-solid fa-plus"></i></button>
			</c:if>
		</div>
		<div id="left-buttons">
			<!-- <button type="button" class="button-option">플레이리스트</button>
			<button type="button" class="button-option">아티스트</button>
			<button type="button"><i class="icon fa-solid fa-magnifying-glass"></i></button>
			<button type="button"><i class="icon fa-solid fa-arrow-down-wide-short"></i></button> -->
		</div>
		<div id="left-container">
			<div id="playlist-container" class="scroll">
				<c:if test="${empty sessionScope.user}">
					<div class="emptyResult"><span style="left: calc(50% - 80px);">로그인 후 이용 부탁드립니다.</span></div>
				</c:if>
			</div>
		</div>
	</div>
</section>

<script src="<c:url value='/resources/js/functions-playlist.js'/>?ts=<%= System.currentTimeMillis() %>"></script>
<script>
	
	$(document).on('click', function(event) {
		const target = $(event.target);
		
		if(target.closest('#addToPlaylist-wrapper .playlistPreview').length) {
			const musicIdx = target.closest('#addToPlaylist-wrapper').data('musicIdx');
			const playlist = target.closest('.playlistPreview').data();
			
			addMusicToPlaylist(playlist.idx, musicIdx)
			.then(result => {
				target.closest('.modal-body').remove();
				refreshUsersPlaylist();
			})
			.catch((error) => {
				console.log(error);
				showMessage(errorMessage);
			});
		}
	});
	
	function deleteMusicFromPlaylist(playlistIdx, listOrder) {
		return new Promise((resolve,reject) => {
			$.ajax({
				type:'DELETE',
				url:contextPath+'/playlist/'+playlistIdx+'/listOrder/'+listOrder,
				data:{},
				success: function(result) {
					resolve(result);
				}, error: function (error) {
					reject(error);
				}
			});
		});
	}
	
	$(document).ready(function() {
		if(currentUserIdx !== null && currentUserIdx !== undefined) {
			refreshUsersPlaylist();
		}
	});
	
	// 유저의 플레이리스트 불러오기
	function getUsersPlaylist() {
		return new Promise((resolve, reject) => {
			$.ajax({
				type:'GET',
				url:'${pageContext.request.contextPath}/user/'+ currentUserIdx + '/playlist',
				data:{},
				success: function(result) {
					return resolve(result);
				}, error: function(error) {
					return reject(error);
				}
			});
		});
	}
	
	function refreshUsersPlaylist() {
		const container = $('#playlist-container');
		container.html('');
		
		getUsersPlaylist()
		.then((playlists) => { // resolve와 함께 반환된 result를 playlists에 저장
			$.each(playlists, function(index, playlist) {
				let preview = createPlaylistPreview(playlist);
				container.append(preview);
			});
		})
		.catch(error => {
			console.log(error);
			container.append(`<div><span>이런!<span></div>`);
			showMessage('플레이리스트를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.');
		});
	}
	
	// 플레이리스트에 추가 - 모달
	function createPlaylistModal(musicIdx) {
		let div = `<div id="addToPlaylist-wrapper" data-music-idx="${'${musicIdx}'}">
			<h2>플레이리스트 선택하기</h2>
			<div class="scroll" style="width:250px; height:350px;">`;
		getUsersPlaylist()
		.then(playlists => {
			$.each(playlists, function(index, playlist) {
				if(playlist.type === 'likelist') return; 
				div += createPlaylistPreview(playlist);
			});
			div += `</div></div>`;
			//target.closest('.musicView').append(createModal(div));
			$('body').append(createModal(div));
		})
		.catch(error => {
			console.log(error);
			div += `이런!</div></div>`;
		});
	}
	
	// 플레이리스트에 추가 - 모달 - 클릭
	function addMusicToPlaylist(playlistIdx, musicIdx) {
		return new Promise((resolve, reject) => {
			checkMusicInPlaylist(playlistIdx, musicIdx)
			.then(result => {
				if(result === "DUPLICATED") {
					if(confirm('이미 존재하는 곡입니다. 그래도 추가하시겠습니까?')) {
						insertMusicInPlaylist(playlistIdx, musicIdx);
					}
				} else if("SUCCESS") {
					insertMusicInPlaylist(playlistIdx, musicIdx);
				} else {
					throw new Error();
				}
				return resolve(result);
			})
			.catch(error => {
				return reject(error);
			});
		});
	}
	
	// 중복된 곡인지 확인
	function checkMusicInPlaylist(playlistIdx, musicIdx) {
		return new Promise((resolve, reject) => {
			$.ajax({
				type:'GET',
				url:'${pageContext.request.contextPath}/playlist/'+ playlistIdx + '/music/' + musicIdx,
				data:{},
				success: function(result) {
					return resolve(result);
				}, error: function(error) {
					return reject(error);
				}
			});
		});
	}
	
	// 플레이리스트에 음악 저장
	function insertMusicInPlaylist(playlistIdx, musicIdx) {
		$.ajax({
			type:'POST',
			url:'${pageContext.request.contextPath}/playlist/'+playlistIdx+'/music/'+musicIdx,
			data:{},
			success: function(result) {
				let message = '플레이리스트에 곡이 추가되었습니다.';
				showMessage(message);
			}, error: function(error) {
				console.log(error);
				showMessage(errorMessage);
			}
		});
	}
	
	
	$('#left-header').on('click', function(event) {
		const target = $(event.target);
		const button = target.closest('button');
		
		// 플레이리스트 생성 (모달)
		if(button.is('#createPlaylist-button')) {
			let div = `
				<div id="createPlaylist-div">
					<h2>플레이리스트 만들기</h2>
					<div>
						<label>
							<input type="file" class="inputImage" name="uploadFile" accept="image/*" style="display:none;"/>
							<img src="" class="inputImage-preview">
						</label>
						<label>제목 : 
							<input type="text" class="inputText" name="name" placeholder="플레이리스트 이름" maxlength="100">
						</label>
					</div>
					<br>
					<label>설명 : 
						<textarea name="description" rows="5" placeholder="(선택사항)" maxlength="255"></textarea>
					</label>
					<br>
					<button id="createPlaylist-submit" class="inputSubmit">만들기</button>
				</div>`;
			$('#left-header').append(createModal(div));
			
		// 플레이리스트 생성 - submit
		} else if(button.is('#createPlaylist-submit')) {
			const div = $('#createPlaylist-div');
			const name = div.find('[name="name"]').val();
			const description = div.find('[name="description"]').val();
			
			let formData = new FormData();
			let inputFile = button.parent().find('.inputImage').get(0); // get(0) : files를 얻기 위해 JQuery 객체를 DOM요소로 변환
			console.log(button.parent().find('.inputImage'));

			// formData.append('uploadFile', inputFile.files[0]);
			
			// 파일 추가 (다중 파일도 가능)
			Array.from(inputFile.files).forEach(file => { // files : FileList 객체 (파일 입력 필드에서 선택된 파일들을 배열처럼 다룸)
			    formData.append('uploadFile', file); // 'uploadFiles'는 컨트롤러에서 받을 필드 이름
			});

			// 다른 데이터 추가
			formData.append('userIdx', currentUserIdx);
			formData.append('name', name);
			formData.append('description', description);
			
			$.ajax({
				type:'POST',
				url:'${pageContext.request.contextPath}/playlist',
				data:formData,
				processData: false, // 데이터를 문자열로 변환하지 않도록 설정
			    contentType: false, // 브라우저가 적절한 Content-Type을 설정하도록 허용
				success: function(result) {
					refreshUsersPlaylist();
					target.closest('.modal-body').remove();
					showMessage('플레이리스트가 생성되었습니다.');
				}, error: function(error) {
					console.log(error);
				}
			});
		}
	});
	
	$('#playlist-container').on('click', function(event) {
		const target = $(event.target);
		const playlist = target.closest('.playlistPreview');
		
		if(playlist.length) {
			const playlistIdx = playlist.data('idx');
			window.location.href= contextPath + '/playlist/' + playlistIdx;
		}
	});
</script>