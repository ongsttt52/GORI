function createManageDiv(field, object) {
	if(field === "artist") {
        // data 속성값을 받음
		return `
			<div id="manageArtist" class="manageDiv" data-id="${object.id}" data-name="${object.name}" data-genre="${object.genre}" data-profile_img="${object.profile_img}">
                <button type="button" id="manageArtist-back" style="float:left">뒤로가기</button>
				<div id="manageArtist-top">
					<img src="${object.profile_img}" class="imgPreview">
					<div>
						<span>아티스트</span>
						<h1>${object.name}</h1>	
						<div>
							<button type="button" class="modifyButton button-option">수정</button>
							<button type="button" class="deleteButton button-option">삭제</button>
						</div>
					</div>
				</div>
				<div id="manageArtist-bottom" class="scroll"></div>
			</div>
		`;
	} else if(field === "album") {
        object = formatAlbum(object);
        // DTO 필드값을 받음
		
		return `
			<div id="manageAlbum" class="manageDiv" data-id="${object.albumId}" data-album_name="${object.albumName}" data-album_img="${object.albumImg}" data-release_date="${object.releaseDate}">
                <button type="button" id="manageAlbum-back" style="float:left">뒤로가기</button>
				<div id="manageAlbum-top">
					<img src="${object.albumImg}">
					<div>
						<span>앨범</span>
						<h1>${object.albumName}</h1>
						<div>
							<img src="${object.profileImg}" style="width:20px; height:20px; border-radius:50%;">
							<span>${object.artistName[0]}</span>
							<span>•</span>
							<span>${object.releaseDate}</span>
							<span>•</span>
							<button type="button" class="modifyButton button-option">수정</button>
							<button type="button" class="deleteButton button-option">삭제</button>
						</div>
					</div>
				</div>
				<div id="manageAlbum-bottom" class="scroll"></div>
			</div>
		`;
	} else if(field ==="music") {
        object = formatMusic(object);
        // DTO 필드값 받음
		let preview = '재생 가능';
		if(object.previewUrl === 'undefined' || object.previewUrl === 'null') preview = '재생 불가능';

		let div = `
		<div class="manageMusic manageDiv" data-id="${object.idx}" data-title="${object.title}" data-track_number="${object.trackNumber}" data-preview_url="${object.previewUrl}">
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
		div += `
				</div>
			</div>
			<span>${preview}</span>
			<div>
				<button type="button" class="lyricsButton button-option">가사 추가(모달)</button>
				<button type="button" class="modifyButton button-option">수정</button>
				<button type="button" class="deleteButton button-option">삭제</button>
			</div>
		</div>`;
		return div;
	}
}

function createManageUser(object) {
    let div = `<table id="manageUser-table">
    <tr id="manageUser-columns"><th><span data-field="idx">번호</span></th><th><span data-field="email">이메일</span></th><th><span data-field="name">이름</span></th><th><span data-field="birth">생일</span></th><th><span data-field="reg_date">가입일</span></th></tr>
    `;
    for(let i=0; i<object.length; i++) {
        user = formatUser(object[i]);
        div += `
        <tr class="manageUser" data-id="${user.idx}" data-email="${user.email}" data-name="${user.name}" data-birth="${user.birth}" data-reg_date="${user.regDate}">
            <td><span>${user.idx}</span></td>
            <td><span>${user.email}</span></td>
            <td><span>${user.name}</span></td>
            <td><span>${user.birth}</span></td>
            <td><span>${user.regDate}</span></td>
        </tr>
        `;
    }
    div += `</div>`;
    return div;
}

function createSeeMore(object) {
    user = formatUser(object);
    console.log(user);
    let div =  `
        <div id="seeMoreModal" class="modal-body">
            <div id="user-seeMore" class="modal-content" data-id="${user.idx}">
                <div id="seeMore-wrapper">
                    <div id="seeMore-profile">
                        <img src="${user.profileImg}" class="imgPreview" style="width:100px; height:100px;">
                        <span>이메일 : ${user.email}</span>
                        <input type="password" class="inputText" readonly placeholder="비밀번호는 확인할 수 없습니다." style="width: 250px; height: 30px;">
                        <button type="button" class="inputSubmit" id="resetPassword">비밀번호 초기화</button>
                        <span id="seeMore-name">이름 : ${user.name}</span>
                        <span>생년월일 : ${user.birth}</span>
                        <span>성별 : ${user.gender}</span>
                    </div>
                    <div id="seeMore-info">
                        <span>가입일 : ${user.regDate}</span>
                        <span>마지막 접속 : ${user.lastAcc}</span>
                        <span>총 접속 횟수 : ${user.totAcc}</span>
                        <span>마케팅 동의 : ${user.isAgreed}</span>
                    </div>
                </div>`;
    if(user.deactivate === null) {
        div += `<div>
            <button type="button" id="deactivate">활동정지</button>
                <select id="deactivate-day" class="selectBox">
                    <option value="1">1</option>
                    <option value="3">3</option>
                    <option value="7">7</option>
                    <option value="30">30</option>
                </select>
                <span>|</span>`;
    } else {
        div += `<div><span>${user.deactivate}까지 정지됨 | </span><button type="button" id="cancle-deactivate">정지 해제</button><span>|</span>`;
    }
    
    if(user.deleteDate === null) div += `<button type="button" id="cancellation">강제 탈퇴</button><span>|</span>`;
    else div += `<button type="button" id="cancellation">탈퇴 대기중 (${user.deleteDate})</button><span>|</span>`;

    div += `
                <button type="button" class="modal-close">닫기</button>
            </div>
        </div>
    </div>
    `;
    return div;
}

function createModifyDiv(field,id,manageDiv) {
    let modifyObject = null;
    $.each(manageDiv, function() {
        modifyObject = $(this).data();
    });

    let modal = `
        <div id="modifyModal" class="modal-body" data-field="${field}" data-id=${id}>
            <div class="modal-content"><h2>수정하기</h2>
    `;
    Object.keys(modifyObject).forEach(function(key, index) {
        if(key === 'id') return;
        modal += `<label><span>${key}</span> : <input type="text" class="inputText" value="${modifyObject[key]}" placeholder="수정할 내용을 입력하세요."></label>`;
    });
    modal += `
        <div>
            <button type="button" id="modifySubmit" class="inputSubmit">수정</button>
            <button type="button" class="modal-close">닫기</button>
        </div>
    </div></div>`;

    return modal;
}