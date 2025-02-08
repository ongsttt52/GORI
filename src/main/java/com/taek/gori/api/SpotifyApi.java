package com.taek.gori.api;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Base64;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Component;

import com.taek.gori.dto.ArtistDto;
import com.taek.gori.dto.Genre;
import com.taek.gori.dto.MusicDto;

@Component
public class SpotifyApi {
	private final String CLIENT_ID = "83e2439a5ec14badb68128d55e70a6ff";
	private final String CLIENT_SECRET = "b1b413eee3df4bb7a127c072fb5f83d1";
	private final String authorizationEnCoded = "Basic "
			+ Base64.getEncoder().encodeToString((CLIENT_ID + ":" + CLIENT_SECRET).getBytes());
	private String accessToken;
	private long tokenExpirationTime; // ��ū ����ð�

	// id�� ��ũ��Ű�� accessToken�� ���
	private void getAccessToken() throws Exception {
		if (accessToken == null || System.currentTimeMillis() > tokenExpirationTime) {
			HttpRequest request = HttpRequest.newBuilder() // newBuilder() �޼���� HttpRequest.Builder ��ü�� ��ȯ / �̸� ���� ��û�� URI, ���, �޼��� �� ��� ���� ����
					.uri(URI.create("https://accounts.spotify.com/api/token")) // .uri �޼���� HTTP ��û�� URI�� ���� / URI.create()�� ���ڿ��� �� URL�� URI ��ü�� ��ȯ��
					.header("Content-Type", "application/x-www-form-urlencoded") // .header �޼���� ��û�� ����� �߰� / ���⼭�� URL ���ڵ��� ���� (key=value) ���� �����ؾ� �ϹǷ� x-www-form-urlencoded ���
					.header("Authorization", authorizationEnCoded) // �� �ٸ� ��� �߰� / Authorization �Ķ���Ϳ��� Ŭ���̾�Ʈ ID�� Secret  Key�� �����ϴ� Base 64 ���ڵ��� ���ڿ��� �䱸��
					.POST(HttpRequest.BodyPublishers.ofString("grant_type=client_credentials")) // POST() �޼���� ��û �޼��带 POST�� ����, BodyPublishers Ŭ������ ofString() �޼��带 ����� ���ڿ� �����͸� ��û ������ ���Խ�Ŵ
					.build(); // ��� �ʼ� �Ű������� ������ �����Ǹ� build()�� ��û��ü�� ��ȯ��

			HttpClient client = HttpClient.newHttpClient(); // ��û�� ������ ������ �޴µ��� ����ϴ� Ŭ���̾�Ʈ, send �޼��带 ���� HttpRequest�� �����ϰ�, �׿� ���� HttpResponse�� ��ȯ��

			HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
			// send() �޼���� ������ ��û�� ������ ����, BodyHandlers.ofString()�� ������ ������ ���ڿ��� �о���̴� �ڵ鷯�� (�������� ���� ���� �����͸� ���ڿ��� ��ȯ�Ͽ� ��ȯ)
			// HttpResponse Ŭ������ ���׸� Ÿ���� ����� / ���⼭ **T**�� ���� ����(body)�� Ÿ���� ��Ÿ�� (������ ������ � Ÿ������ ��ȯ������ ����)

			JSONParser parser = new JSONParser();
			JSONObject responseBody = (JSONObject) parser.parse(response.body());
			String token = responseBody.get("access_token") + "";
			long expiresIn = (long) responseBody.get("expires_in");
			accessToken = token;
			tokenExpirationTime = System.currentTimeMillis() + expiresIn * 1000; // ����ð��� �и��ʷ� ��ȯ
			if(accessToken==null) {
				throw new Exception("SpotifyApi.getResponseByEndPoint() : accessToken �߱� ����");
			}
		}
	}

	// ��������Ʈ�� ���� ��û�� �����ϰ� JSON Simple�� ���䰴ü�� �Ľ��Ͽ� ����
	private JSONObject getResponseByEndPoint(String endPoint) throws Exception {
		getAccessToken();
		if(accessToken != null) {
			HttpRequest request = HttpRequest.newBuilder().uri(URI.create(endPoint))
					.header("Authorization", "Bearer " + accessToken).GET().build();
	
			HttpClient client = HttpClient.newHttpClient();
			HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
	
			JSONParser parser = new JSONParser();
			return (JSONObject) parser.parse(response.body());
		} else {
			throw new Exception("SpotifyApi.getResponseByEndPoint() : accessToken is null");
		}
	}

	// ��Ƽ��Ʈ�� �˻� �� itemsArray ����
	public JSONArray searchArtist(String artistName) throws Exception {
		String encodedArtistName = URLEncoder.encode(artistName, StandardCharsets.UTF_8.toString());
		String endPoint = "https://api.spotify.com/v1/search?q=remaster%2520artist:" + encodedArtistName + "&type=artist&locale=ko_KR&market=KR&limit=20";
		if(artistName.charAt(0) >= 0x0041 && artistName.charAt(0) < 0x007A)
			endPoint = "https://api.spotify.com/v1/search?q=artist:" + encodedArtistName + "&type=artist&locale=ko_KR&market=KR&limit=20";
		
		JSONObject responseObject = getResponseByEndPoint(endPoint);
		if(responseObject == null) return null;
		
		JSONObject artistsObject = (JSONObject) responseObject.get("artists");
		JSONArray itemsArray = (JSONArray)artistsObject.get("items");
		return itemsArray;
	}
	
	// id�� ��Ƽ��Ʈ �˻� �� responseObject ����
	public JSONObject searchArtistById(String artistId) throws Exception {
		String endPoint = "https://api.spotify.com/v1/artists/"+artistId+"?locale=ko_KR";
		
		JSONObject responseObject = getResponseByEndPoint(endPoint);
		if(responseObject == null) return null;
		
		return responseObject;
	}
	
	// ��Ƽ��Ʈ�� ��� �ٹ��� ��� itemsArray ����
	@SuppressWarnings("unchecked") //
	public JSONArray searchAlbumsByArtist(String artistId) throws Exception {
		String endPoint = "https://api.spotify.com/v1/artists/"+artistId+"/albums?locale=ko_KR&limit=50";
		JSONArray returnArray = new JSONArray();
		
		JSONObject responseArtist = searchArtistById(artistId);
		JSONObject responseAlbum = getResponseByEndPoint(endPoint);
		if(responseArtist == null || responseAlbum == null) return null;
		else {
			String artistName = responseArtist.get("name")+"";
			JSONArray itemsAlbum = (JSONArray)responseAlbum.get("items");
			for(int i=0; i<itemsAlbum.size(); i++) {
				JSONObject albumObject = (JSONObject)itemsAlbum.get(i);
				JSONObject artist = (JSONObject)(((JSONArray)(albumObject.get("artists"))).get(0));
				if(artistName.equals(artist.get("name")+"")) {
					returnArray.add(albumObject);
				}
			}
			return returnArray;
		}
	}
	
	// id�� �ٹ� �˻� �� responseObject ����
	public JSONObject searchAlbumById(String albumId) throws Exception {
		String endPoint = "https://api.spotify.com/v1/albums/"+albumId+"?locale=ko_KR";
		
		JSONObject responseObject = getResponseByEndPoint(endPoint);
		if(responseObject == null) return null;
		
		return responseObject;
	}
	
	public JSONObject searchObjectById(String field, String id) throws Exception {
		String endPoint = "https://api.spotify.com/v1/"+field+"s/"+id+"?locale=ko_KR";
		
		JSONObject responseObject = getResponseByEndPoint(endPoint);
		if(responseObject == null) return null;
		
		return responseObject;
	}
	
	// �ٹ��� ��� Ʈ�� �˻� �� itemsArray ����
	public JSONArray searchTracksByAlbum(String albumId) throws Exception {
		String endPoint = "https://api.spotify.com/v1/albums/"+albumId+"/tracks?locale=ko_KR&limit=50";
		
		JSONObject responseObject = getResponseByEndPoint(endPoint);
		if(responseObject == null) return null;
		else {
			JSONArray itemsArray = (JSONArray)responseObject.get("items");
			return itemsArray;
		}
		
	}
	
	public MusicDto createMusicDto(JSONObject albumObject, JSONObject track) {
		MusicDto music = new MusicDto();
		JSONObject albumArtist = (JSONObject)((JSONArray)albumObject.get("artists")).get(0);
		
		try {
			String releaseDate = albumObject.get("release_date")+"";
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate date = LocalDate.parse(releaseDate, dtf);
			music.setReleaseDate(date);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("SpotifyApi.createMusicDto() : �߸��� ��¥ ������ �Էµ�");
		}
		
		// ����Ƽ���� �������� duration�� track�� Integer�� ��ȯ�ȴٰ� ���������� 
		// JSON �Ľ� ���̺귯�� (��: org.json �Ǵ� Jackson)�� ū ���ڸ� ó���� �� Long���� �ڵ� ��ȯ��Ű�� ������ �־� int�� ��ȯ��Ű�� �ϸ� ClassCastException�� �߻��ϰ� �ȴ�
		music.setTitle(track.get("name")+"");
		music.setArtistId(albumArtist.get("id")+"");
		music.setDuration(((Long)track.get("duration_ms")).intValue());
		music.setAlbumId(albumObject.get("id")+"");
		music.setAlbumName(albumObject.get("name")+"");
		music.setTrackNumber(((Long)track.get("track_number")).intValue());
		JSONArray images = (JSONArray)albumObject.get("images");
		JSONObject image = (JSONObject)images.get(1);
		if(image!=null) music.setAlbumImg(image.get("url")+"");
		else music.setAlbumImg("/resources/image/album/default_album.png");
		music.setPreviewUrl(track.get("preview_url")+""); // nullable
		
		System.out.println("SpotifyApi.createMusicDto : returned " + music);
		return music;
	}
	
	public ArtistDto createArtistDto(JSONObject artistObject, Genre genre) {
		ArtistDto artist = new ArtistDto();
		artist.setId(artistObject.get("id")+"");
		artist.setName(artistObject.get("name")+"");
		artist.setGenre(genre);
		JSONArray images = (JSONArray)artistObject.get("images");
		JSONObject image = (JSONObject)images.get(1);
		if(image!=null) artist.setProfileImg(image.get("url")+"");
		else artist.setProfileImg("/resources/image/artist/default_artist.png");
		
		System.out.println("SpotifyApi.createArtistDto() : returned " + artist);
		return artist;
	}
	
	public static void main(String[] args) {
		SpotifyApi api = new SpotifyApi();
		// requestTest();
		try {
			JSONArray artistItems = api.searchArtist("������");
			System.out.println(artistItems);
			JSONObject artist = (JSONObject)(artistItems.get(0));
			JSONArray albumItems = api.searchAlbumsByArtist(artist.get("id")+"");
			for(int i=0; i<albumItems.size(); i++) {
				JSONObject album = (JSONObject)albumItems.get(i);
				System.out.println(album.get("name"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
