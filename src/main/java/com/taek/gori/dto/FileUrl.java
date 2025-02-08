package com.taek.gori.dto;

public enum FileUrl {
	DEFAULT_ALBUM("/gori/resources/image/album/default_album.png");
	
	private final String url;
	
	FileUrl(String url) {
		this.url = url;
	}
	
	public String getUrl() {
		return url;
	}
}
