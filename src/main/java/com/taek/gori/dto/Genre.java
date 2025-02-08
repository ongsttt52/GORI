package com.taek.gori.dto;

public enum Genre {
    POP("��"),
    ROCK("��"),
    HIPHOP("����"),
    BALLAD("�߶��"),
    RNB("R&B"),
    JAZZ("����"),
    EDM("EDM"),
    DISCO("����"),
    FUNK("��ũ"),
    COUNTRY("��Ʈ��"),
    FOLK("��ũ"),
    KPOP("KPOP"),
    INDIE("�ε�");
	
	// �ʵ�
	private final String kr;
	
	// ������
	Genre(String kr) {
		this.kr = kr;
	}
	
	// Getter
	public String getKr() {
		return kr;
	}
}
