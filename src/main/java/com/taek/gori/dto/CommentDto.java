package com.taek.gori.dto;

import java.sql.Timestamp;

public class CommentDto {
	private int idx;
    private int feedIdx;
    private int userIdx;
    private String content;
    private Timestamp createdAt;
    private String diffString;
    private boolean isDeleted;
    private String userName;
    private String userImg;
    
	public CommentDto() {
		super();
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getFeedIdx() {
		return feedIdx;
	}

	public void setFeedIdx(int feedIdx) {
		this.feedIdx = feedIdx;
	}

	public int getUserIdx() {
		return userIdx;
	}

	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
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

	public String getDiffString() {
		return diffString;
	}

	public void setDiffString(String diffString) {
		this.diffString = diffString;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
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

	@Override
	public String toString() {
		return "CommentDto [idx=" + idx + ", feedIdx=" + feedIdx + ", userIdx=" + userIdx + ", content=" + content
				+ ", createdAt=" + createdAt + ", diffString=" + diffString + ", isDeleted=" + isDeleted + ", userName="
				+ userName + ", userImg=" + userImg + "]";
	}
}
