
function formatUser(user) {
	const formattedUser = {...user};
	const birthDate = new Date(user.birth);
	const date = birthDate.toISOString().split('T')[0];
	console.log(birthDate);
	console.log(date);

	formattedUser.birth = date;
	formattedUser.gender = user.gender === "M" ? "남성" : user.gender === "F" ? "여성" : "그 외";
	formattedUser.regDate = new Date(user.regDate).toISOString().substring(0,10) + ' ' + new Date(user.regDate).toISOString().substring(11,19);
	formattedUser.profileImg = contextPath + user.profileImg;
	formattedUser.genre = user.genre === null ? null : user.genre.split(',');
	formattedUser.isAgreed = user.isAgreed ? "동의" : "비동의";

	formattedUser.lastAcc = user.lastAcc === null ? "없음" : new Date(user.lastAcc).toLocaleString('ko-KR', { timeZone: 'Asia/Seoul'});
	if(user.deactivate !== null) formattedUser.deactivate = new Date(user.deactivate).toLocaleString('ko-KR', { timeZone: 'Asia/Seoul'});
	if(user.deleteDate !== null) formattedUser.deleteDate = new Date(user.deleteDate).toLocaleString('ko-KR', { timeZone: 'Asia/Seoul'});

	return formattedUser;
}

function formatMusic(music) {
	const formatted = {...music};
	formatted.duration = Math.floor((music.duration / 1000) / 60) + ":" + String(Math.floor((music.duration / 1000) % 60)).padStart(2, '0');
	formatted.releaseDate = new Date(music.releaseDate).toISOString().substring(0,10);
	formatted.artistName = music.artistName.split(',');
	return formatted;
}
function formatAlbum(album) {	
	const formatted = {...album};
	formatted.artistName = album.artistName.split(',');
	formatted.releaseDate = new Date(album.releaseDate).toISOString().substring(0,10);
	return formatted;
}
function formatTime(seconds) {
	const min = Math.floor(seconds / 60);
	const sec = Math.floor(seconds % 60);
	return `${min.toString().padStart(2, '0')}:${sec.toString().padStart(2, '0')}`;
}


function createPreview(field, object) {
	if(field === "artist") {
		return `
			<div class="artistPreview previewDiv text-overflow" data-id="${object.id}" data-name="${object.name}" data-genre="${object.genre}" data-profile_img="${object.profileImg}">
				<img src="${object.profileImg}" class="imgPreview">
				<span>${object.name}</span>
			</div>
		`;
	} else if(field === "album") {
		return `
			<div class="albumPreview previewDiv text-overflow" data-id="${object.albumId}" data-name="${object.albumName}" data-artist_id="${object.artistId}" data-popularity="${object.popularity}">
				<img src="${object.albumImg}" class="imgPreview">
				<span>${object.albumName}</span>
			</div>
		`;
	} else if(field === "music") {
		const artistName = object.artistName.split(',');
		return `
			<div class="musicPreview previewDiv" data-id="${object.idx}" data-title="${object.title}" data-artist_id="${object.artistId}" data-artist-name="${object.artistName}" data-album_id="${object.albumId}" data-album-img="${object.albumImg}" data-popularity="${object.popularity}" data-duration="${object.duration}" data-preview-url="${object.previewUrl}" data-release-date="${object.releaseDate}" data-genre="${object.genre}" data-list-order="${object.listOrder}">
			<img src="${object.albumImg}" class="imgPreview">
			<div class="text-overflow">
				<span>${object.title}</span>
				<span class="subText">${artistName}</span>
			</div>
			<div>
				<button type="button" class="dropdownButton" data-toggle="false"><i class="fa-solid fa-ellipsis"></i></button>
			</div>
		</div>
		`;
	}
}


function createContentDiv(field, object) {
	if(field === 'artist') {
		return `
			<div class="artistDiv contentDiv" data-id="${object.id}">
				<div>
					<img src="<c:url value='${object.profileImg}'/>">
					<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
				</div>
				<a href="<c:url value='/view/artist/${object.id}'/>" class="text-overflow-2">${object.name}</a>
			</div>
		`;
	}
	else if(field === 'album') {
		return `
			<div class="albumDiv contentDiv" data-id="${object.albumId}" data-artist-id="${object.artistId}">
				<div>
					<img src="<c:url value='${object.albumImg}'/>">
					<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
				</div>
				<a href="<c:url value='/view/album/${object.albumId}'/>" class="text-overflow-2">${object.albumName}</a>
				<span class="subText text-overflow-2">${object.artistName.split(',')[0]}</span>
			</div>
		`;
	} else if(field === 'music') {
		return `
			<div class="musicDiv contentDiv" data-id="${object.idx}" data-album-id="${object.albumId}" data-artist-id="${object.artistId}">
				<div>
					<img src="<c:url value='${object.albumImg}'/>">
					<button type="button" class="contentDiv-playButton"><i class="fa-solid fa-circle-play"></i></button>
				</div>
				<a href="<c:url value='/view/music/${object.idx}'/>" class="text-overflow-2">${object.title}</a>
				<span class="subText text-overflow-2">${object.artistName}</span>
			</div>
		`;
	} else {
		return `<h2>이런!</h2>`;
	}
}



function createArtistView(object) {
	
}

// MusicDTO 받음
function createAlbmView(object) {
	return `
		<div id="albumView" class="view">
			<div id="albumView-top" data-id="${object.albumId}">
				<img src="${object.albumImg}">
				<div>
					<span>앨범</span>
					<span>${object.albumName}</span>
					<div>
						<img src="${object.profileImg}">
						<a href="${contextPath}/artist/${object.artistId}">${object.artistName[0]}</a>
						<span>•</span>
						<span>${object.releaseDate}</span>
						<span>•</span>
						<span>${object.genre}</span>
					</div>
				</div>
			</div>
			<div id="albumView-bottom"></div>
		</div>
	`;
	}

function createMusicView(object) {
	object = formatMusic(object);
		
	let div = `
	<div class="musicView" data-id="${object.idx}">
		<span>${object.trackNumber}</span>
		<div>
			<span>${object.title}</span>
			<div class="subText">
	`;
	
	$.each(object.artistName, function(index,artist) {
		let span = `<span class="artistName">${artist}</span>, `;
		if(index === object.artistName.length-1) span = `<span class="artistName subText">${artist}</span>`;
		div += span;
	});

	let preview;
	if(object.previewUrl === 'undefined' || object.previewUrl === 'null') preview = `<span>미리듣기 없음</span>`;
	else preview = `<button type="button" class="playButton">재생</button>`
	div += `
			</div>
		</div>
		${preview}
	</div>`;
	
	return div;
}

function createPageDiv(ph) {
    // 현재 페이지가 10 이하면 1, 20이하면 11, 30이하면 21, ...
    // beginPage = 현재 페이지 - 현재페이지%10 + 1
    // endPage = 현재 페이지 - 현재페이지%10 + 10    
	let div = `<div class="pageDiv">`;
	if(ph.showPrev) div += `<button type="button" class="showPrev pageButton" data-page="${ph.beginPage - 1}">&lang;</button>`;

	for(let i=ph.beginPage; i<=ph.endPage; i++) {
		div += `<button type="button" class="pageButton" data-page="${i}">${i}</button>`;
	}
	if(ph.showNext) div += `<button type="button" class="showNext pageButton" data-page="${ph.endPage + 1}">&rang;</button>`;
	div += `</div>`;

    return div;
}


function createModal(element) {
	return`
		<div class="modal-body">
			<div class="modal-content">
				<div style="width: 100%;">
					<button type="button" class="modal-closeButton">닫기</button>
				</div>
				${element}
			</div>
		</div>
	`;
}

function createFeedModal(music) {
	let div = `<div id="writeFeed-modal"><h2>피드 작성하기</h2>`;
				
	div += createPreview('music', music);
	div += `<form method="post" action="${contextPath}/feed" onsubmit="return formCheckFeed(this)">
				<input type="hidden" name="userIdx" value="${currentUserIdx}">
				<input type="hidden" name="musicIdx" value="${music.idx}">
				<label>내용:<br>
					<textarea id="writeFeed-content" name="content" rows="10" maxlength="255" placeholder="내용을 입력하세요."></textarea>
				</label>
				<input type="submit" class="inputSubmit" value="작성하기">
			</form>
		</div>`;
	return div;
}
function formCheckFeed(form) {
	if(form.content.value.length === 0) {
		showMessage('내용을 입력해주세요.');
		return false;
	}
	return true;
}


// 요소를 5초동안 나타났다가 사라지게 함
function fadeInOut(JQueryElement) {
	JQueryElement.fadeIn(300, function() {
		setTimeout(function() {
			JQueryElement.fadeOut(1000);
		}, 5000);
	});
}

function showMessage(message) {
	const messageDiv = $('body').find('.messageDiv');
	messageDiv.remove();

	let div = `
		<div class="messageDiv">
			<span>${message}</span>
		</div>`;
	$('body').append(div);

	const newDiv = $('body').find('.messageDiv');
	newDiv.fadeIn(300, function() {
		setTimeout(function() {
			newDiv.fadeOut(1000, function() {
				newDiv.remove();
			});
		}, 3000);
	});
}


function userLikeMusic(musicIdx) {
	return new Promise((resolve, reject) => {
		$.ajax({
			type:'PUT',
			url:contextPath+'/user/'+currentUserIdx+'/music/'+musicIdx+'/like',
			data:{},
			success: function(result) {
				resolve(result);
			}, error: function(error) {
				reject(error);
			}
		});
	});
}

function userNotLikeMusic(musicIdx) {
	return new Promise((resolve, reject) => {
		$.ajax({
			type:'DELETE',
			url:contextPath+'/user/'+currentUserIdx+'/music/'+musicIdx+'/like',
			data:{},
			success: function(result) {
				resolve(result);
			}, error: function(error) {
				reject(error);
			}
		});
	});
}

function playMusicsInContent(type, albumId) {
	$.ajax({
		type:'POST',
		url:contextPath+'/quelist',
		data:{type:type, id:albumId},
		success: function(result) {
			const quelist = $('#quelist-list .musicPreview');
			let length = quelist.length;
			$.each(result.mList, function(index,music) {
				let preview = $(createPreview('music', music));
				if(length > 0) preview.attr('data-list-order', quelist.last().data('list-order') + 1);
				else preview.attr('data-list-order', '1');
				$('#quelist-list').append(preview);
			});
			playNewMusic(length);
		}, error: function(error) {
			console.log(error);
			showMessage(errorMessage);
		}
	});
}


