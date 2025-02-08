function createPlaylistPreview(object) {
    let div = `
        <div class="playlistPreview" data-idx="${object.idx}" data-user-idx="${object.userIdx}" data-name="${object.name}" data-description="${object.description}">
            <div>
                <img src="${object.playlistImage}" class="imgPreview">
            </div>
            <div>
                <span class="text-overflow">${object.name}</span>
                <span class="subText">플레이리스트</span>
            </div>
        </div>
    `; 
    return div;
}