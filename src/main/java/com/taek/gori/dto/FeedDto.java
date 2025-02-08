package com.taek.gori.dto;

import java.sql.Timestamp;

public class FeedDto {
	private int idx;
    private int userIdx;
    private int musicIdx;
    private String content;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isDeleted;
    private long playedCount;
    private long likedCount;
    private long sharedCount;
    private String diffString;
    private String userName;
    private String userImg;
    private String musicName;
    private String musicImg;
    private String artistName;
    private String previewUrl;
    
	public FeedDto() {
		super();
	}
	public FeedDto(int userIdx, int musicIdx, String content) {
		super();
		this.userIdx = userIdx;
		this.musicIdx = musicIdx;
		this.content = content;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getMusicIdx() {
		return musicIdx;
	}
	public void setMusicIdx(int musicIdx) {
		this.musicIdx = musicIdx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public boolean isDeleted() {
		return isDeleted;
	}
	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
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
	public String getDiffString() {
		return diffString;
	}
	public void setDiffString(String diffString) {
		this.diffString = diffString;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	public String getMusicName() {
		return musicName;
	}
	public void setMusicName(String musicName) {
		this.musicName = musicName;
	}
	public String getMusicImg() {
		return musicImg;
	}
	public void setMusicImg(String musicImg) {
		this.musicImg = musicImg;
	}
	public String getArtistName() {
		return artistName;
	}
	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}
	public String getPreviewUrl() {
		return previewUrl;
	}
	public void setPreviewUrl(String previewUrl) {
		this.previewUrl = previewUrl;
	}
	@Override
	public String toString() {
		return "FeedDto [idx=" + idx + ", userIdx=" + userIdx + ", musicIdx=" + musicIdx + ", content=" + content
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", isDeleted=" + isDeleted
				+ ", playedCount=" + playedCount + ", likedCount=" + likedCount + ", sharedCount=" + sharedCount
				+ ", diffString=" + diffString + ", userName=" + userName + ", userImg=" + userImg + ", musicName="
				+ musicName + ", musicImg=" + musicImg + ", artistName=" + artistName + ", previewUrl=" + previewUrl
				+ "]";
	}
}
