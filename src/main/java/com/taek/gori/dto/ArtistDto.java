package com.taek.gori.dto;

import java.sql.Date;
import java.util.Objects;

public class ArtistDto {
	private int idx;
	private String id;
	private String name;
	private	Genre genre;
	private String profileImg;
	private long monthlyListener;
	private long popularity;
	private int followCount;
	private boolean isFollowed;
	private Date avgDate;
	
	public ArtistDto() {
		super();
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Genre getGenre() {
		return genre;
	}

	public void setGenre(Genre genre) {
		this.genre = genre;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public long getMonthlyListener() {
		return monthlyListener;
	}

	public void setMonthlyListener(long monthlyListener) {
		this.monthlyListener = monthlyListener;
	}

	public long getPopularity() {
		return popularity;
	}

	public void setPopularity(long popularity) {
		this.popularity = popularity;
	}
	

	public boolean getIsFollowed() {
		return isFollowed;
	}

	public void setIsFollowed(boolean isFollowed) {
		this.isFollowed = isFollowed;
	}
	
	public Date getAvgDate() {
		return avgDate;
	}

	public void setAvgDate(Date avgDate) {
		this.avgDate = avgDate;
	}
	
	public int getFollowCount() {
		return followCount;
	}

	public void setFollowCount(int followCount) {
		this.followCount = followCount;
	}

	@Override
	public String toString() {
		return "ArtistDto [idx=" + idx + ", id=" + id + ", name=" + name + ", genre=" + genre + ", profileImg="
				+ profileImg + ", monthlyListener=" + monthlyListener + ", popularity=" + popularity + ", isFollowed="
				+ isFollowed + ", avgDate=" + avgDate + "]";
	}
	@Override
	public int hashCode() {
		return Objects.hash(genre, id, idx, name, profileImg);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ArtistDto other = (ArtistDto) obj;
		return genre == other.genre && Objects.equals(id, other.id) && idx == other.idx
				&& Objects.equals(name, other.name) && Objects.equals(profileImg, other.profileImg);
	}
}
