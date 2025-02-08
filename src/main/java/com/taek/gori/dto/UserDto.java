package com.taek.gori.dto;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Objects;

import org.springframework.format.annotation.DateTimeFormat;

public class UserDto {
	private Integer idx;
	private String email;
	private String pwd;
	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birth;
	private String gender;
	private Timestamp regDate;
	private String profileImg;
	private String genre;
	private String grade;
	private boolean isAgreed;
	private Timestamp deactivate;
	private Timestamp deleteDate;
	private Timestamp lastAcc;
	private int totAcc;
	
	public UserDto() {
		super();
	}
	public UserDto(String email, String pwd, String name, LocalDate birth, String gender) {
		super();
		this.email = email;
		this.pwd = pwd;
		this.name = name;
		this.birth = birth;
		this.gender = gender;
	}
	
	public Integer getIdx() {
		return idx;
	}
	public void setIdx(Integer idx) {
		this.idx = idx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public LocalDate getBirth() {
		return birth;
	}
	public void setBirth(LocalDate birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public boolean isAgreed() {
		return isAgreed;
	}
	public void setAgreed(boolean isAgreed) {
		this.isAgreed = isAgreed;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public Timestamp getDeactivate() {
		return deactivate;
	}
	public void setDeactivate(Timestamp deactivate) {
		this.deactivate = deactivate;
	}
	public Timestamp getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(Timestamp deleteDate) {
		this.deleteDate = deleteDate;
	}
	public Timestamp getLastAcc() {
		return lastAcc;
	}
	public void setLastAcc(Timestamp lastAcc) {
		this.lastAcc = lastAcc;
	}
	public int getTotAcc() {
		return totAcc;
	}
	public void setTotAcc(int totAcc) {
		this.totAcc = totAcc;
	}
	
	@Override
	public String toString() {
		return "UserDto [idx=" + idx + ", email=" + email + ", pwd=" + pwd + ", name=" + name + ", birth=" + birth
				+ ", gender=" + gender + ", regDate=" + regDate + ", profileImg=" + profileImg + ", genre=" + genre
				+ ", isAgreed=" + isAgreed + ", grade=" + grade + ", deactivate=" + deactivate + ", deleteDate="
				+ deleteDate + ", lastAcc=" + lastAcc + ", totAcc=" + totAcc + "]";
	}
	@Override
	public int hashCode() {
		return Objects.hash(email, gender, grade, idx, isAgreed, deleteDate, name, profileImg, pwd);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserDto other = (UserDto) obj;
		return Objects.equals(email, other.email) && Objects.equals(gender, other.gender)
				&& Objects.equals(grade, other.grade) && Objects.equals(idx, other.idx) && isAgreed == other.isAgreed
				&& deleteDate == other.deleteDate && Objects.equals(name, other.name)
				&& Objects.equals(profileImg, other.profileImg) && Objects.equals(pwd, other.pwd);
	}	
}
