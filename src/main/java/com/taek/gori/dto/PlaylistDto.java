package com.taek.gori.dto;

import java.sql.Timestamp;
import java.util.List;

public class PlaylistDto {
	private int idx;
	private int userIdx;
	private String type;
	private String name;
	private String description;
	private Timestamp createdAt;
	private long playedCount;
	private long likedCount;
	private long sharedCount;
	private List<MusicDto> musicList;
	private String playlistImage;
	private String userName;
	
	public PlaylistDto() {super();}

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
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

	public List<MusicDto> getMusicList() {
		return musicList;
	}

	public void setMusicList(List<MusicDto> musicList) {
		this.musicList = musicList;
	}

	public String getPlaylistImage() {
		return playlistImage;
	}

	public void setPlaylistImage(String playlistImage) {
		this.playlistImage = playlistImage;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "PlaylistDto [idx=" + idx + ", userIdx=" + userIdx + ", type=" + type + ", name=" + name
				+ ", description=" + description + ", createdAt=" + createdAt + ", playedCount=" + playedCount
				+ ", likedCount=" + likedCount + ", sharedCount=" + sharedCount + ", musicList=" + musicList
				+ ", playlistImage=" + playlistImage + ", userName=" + userName + "]";
	}
}
