package com.taek.gori.dto;

public enum Genre {
    POP("팝"),
    ROCK("록"),
    HIPHOP("힙합"),
    BALLAD("발라드"),
    RNB("R&B"),
    JAZZ("재즈"),
    EDM("EDM"),
    DISCO("디스코"),
    FUNK("펑크"),
    COUNTRY("컨트리"),
    FOLK("포크"),
    KPOP("KPOP"),
    INDIE("인디");
	
	// 필드
	private final String kr;
	
	// 생성자
	Genre(String kr) {
		this.kr = kr;
	}
	
	// Getter
	public String getKr() {
		return kr;
	}
}
