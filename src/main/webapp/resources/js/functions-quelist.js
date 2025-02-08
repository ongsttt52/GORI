function createPreviewPlaying(object) {
    const artistName = object.artistName.split(',');
    return `
        <div class="musicPreview previewDiv text-overflow quelist-playing" data-id="${object.idx}" data-title="${object.title}" data-artist_id="${object.artistId}" data-artist-name="${object.artistName}" data-album_id="${object.albumId}" data-album-img="${object.albumImg}" data-popularity="${object.popularity}" data-duration="${object.duration}" data-preview-url="${object.previewUrl}">
        <img src="${object.albumImg}" class="imgPreview">
        <div>
            <span>${object.title}</span>
            <span class="subText">${artistName}</span>
        </div>
    </div>
    `;
}