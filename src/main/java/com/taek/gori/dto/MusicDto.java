package com.taek.gori.dto;

import java.time.LocalDate;
import java.util.Objects;

public class MusicDto {
	private int idx;
    private String title;
    private String artistId;
    private String lyrics;
    private int duration;
    private String albumId;
    private String albumName;
    private String albumImg;
    private LocalDate releaseDate;
    private int trackNumber;
    private String previewUrl;
    private long playedCount;
    private long likedCount;
    private long sharedCount;
    private long feedCount;
    private long popularity;
    private boolean isLiked;
    private String artistName;
    private String profileImg;
    private Genre genre;
    private String type;
    private String durationString;
    private Integer listOrder;
    
	public MusicDto() {
		super();
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArtistId() {
		return artistId;
	}

	public void setArtistId(String artistId) {
		this.artistId = artistId;
	}

	public String getLyrics() {
		return lyrics;
	}

	public void setLyrics(String lyrics) {
		this.lyrics = lyrics;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getAlbumId() {
		return albumId;
	}

	public void setAlbumId(String albumId) {
		this.albumId = albumId;
	}

	public String getAlbumName() {
		return albumName;
	}

	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}

	public String getAlbumImg() {
		return albumImg;
	}

	public void setAlbumImg(String albumImg) {
		this.albumImg = albumImg;
	}

	public LocalDate getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(LocalDate releaseDate) {
		this.releaseDate = releaseDate;
	}

	public int getTrackNumber() {
		return trackNumber;
	}

	public void setTrackNumber(int trackNumber) {
		this.trackNumber = trackNumber;
	}

	public String getPreviewUrl() {
		return previewUrl;
	}

	public void setPreviewUrl(String previewUrl) {
		this.previewUrl = previewUrl;
	}

	public long getPlayedCount() {
		return playedCount;
	}

	public void setPlayedCount(long playedCount) {
		this.playedCount = playedCount;
	}

	public long getLikedCount() {
		return likedCount;
	}

	public void setLikedCount(long likedCount) {
		this.likedCount = likedCount;
	}

	public long getSharedCount() {
		return sharedCount;
	}

	public void setSharedCount(long sharedCount) {
		this.sharedCount = sharedCount;
	}

	public long getFeedCount() {
		return feedCount;
	}

	public void setFeedCount(long feedCount) {
		this.feedCount = feedCount;
	}

	public long getPopularity() {
		return popularity;
	}

	public void setPopularity(long popularity) {
		this.popularity = popularity;
	}

	public boolean getIsLiked() {
		return isLiked;
	}

	public void setIsLiked(boolean isLiked) {
		this.isLiked = isLiked;
	}

	public String getArtistName() {
		return artistName;
	}

	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public Genre getGenre() {
		return genre;
	}

	public void setGenre(Genre genre) {
		this.genre = genre;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDurationString() {
		return durationString;
	}

	public void setDurationString(String durationString) {
		this.durationString = durationString;
	}

	public Integer getListOrder() {
		return listOrder;
	}

	public void setListOrder(Integer listOrder) {
		this.listOrder = listOrder;
	}
	
	@Override
	public String toString() {
		return "MusicDto [idx=" + idx + ", title=" + title + ", artistId=" + artistId + ", lyrics=" + lyrics
				+ ", duration=" + duration + ", albumId=" + albumId + ", albumName=" + albumName + ", albumImg="
				+ albumImg + ", releaseDate=" + releaseDate + ", trackNumber=" + trackNumber + ", previewUrl="
				+ previewUrl + ", playedCount=" + playedCount + ", likedCount=" + likedCount + ", sharedCount="
				+ sharedCount + ", feedCount=" + feedCount + ", popularity=" + popularity + ", isLiked=" + isLiked
				+ ", artistName=" + artistName + ", profileImg=" + profileImg + ", genre=" + genre + ", type=" + type
				+ ", durationString=" + durationString + ", listOrder=" + listOrder + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(albumId, albumImg, albumName, artistId, artistName, duration, genre, idx, isLiked, lyrics,
				previewUrl, profileImg, releaseDate, title, trackNumber);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MusicDto other = (MusicDto) obj;
		return Objects.equals(albumId, other.albumId) && Objects.equals(albumImg, other.albumImg)
				&& Objects.equals(albumName, other.albumName) && Objects.equals(artistId, other.artistId)
				&& Objects.equals(artistName, other.artistName) && duration == other.duration && genre == other.genre
				&& idx == other.idx && isLiked == other.isLiked && Objects.equals(lyrics, other.lyrics)
				&& popularity == other.popularity && Objects.equals(profileImg, other.profileImg) 
				&& Objects.equals(releaseDate, other.releaseDate) && Objects.equals(title, other.title) 
				&& trackNumber == other.trackNumber;
	}
	
}
