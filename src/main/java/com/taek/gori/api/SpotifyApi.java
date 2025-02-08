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
	private long tokenExpirationTime; // 토큰 만료시간

	// id와 시크릿키로 accessToken을 얻기
	private void getAccessToken() throws Exception {
		if (accessToken == null || System.currentTimeMillis() > tokenExpirationTime) {
			HttpRequest request = HttpRequest.newBuilder() // newBuilder() 메서드는 HttpRequest.Builder 객체를 반환 / 이를 통해 요청의 URI, 헤더, 메서드 등 요소 설정 가능
					.uri(URI.create("https://accounts.spotify.com/api/token")) // .uri 메서드는 HTTP 요청의 URI를 설정 / URI.create()는 문자열로 된 URL을 URI 객체로 변환함
					.header("Content-Type", "application/x-www-form-urlencoded") // .header 메서드로 요청에 헤더를 추가 / 여기서는 URL 인코딩된 형식 (key=value) 으로 전송해야 하므로 x-www-form-urlencoded 사용
					.header("Authorization", authorizationEnCoded) // 또 다른 헤더 추가 / Authorization 파라미터에는 클라이언트 ID와 Secret  Key를 포함하는 Base 64 인코딩된 문자열이 요구됨
					.POST(HttpRequest.BodyPublishers.ofString("grant_type=client_credentials")) // POST() 메서드로 요청 메서드를 POST로 설정, BodyPublishers 클래스의 ofString() 메서드를 사용해 문자열 데이터를 요청 본문에 포함시킴
					.build(); // 모든 필수 매개변수가 빌더에 설정되면 build()가 요청객체를 반환함

			HttpClient client = HttpClient.newHttpClient(); // 요청을 보내고 응답을 받는데에 사용하는 클라이언트, send 메서드를 통해 HttpRequest를 전송하고, 그에 따른 HttpResponse를 반환함

			HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
			// send() 메서드로 지정한 요청을 서버에 전송, BodyHandlers.ofString()은 응답의 본문을 문자열로 읽어들이는 핸들러임 (서버에서 받은 응답 데이터를 문자열로 변환하여 반환)
			// HttpResponse 클래스는 제네릭 타입을 사용함 / 여기서 **T**는 응답 본문(body)의 타입을 나타냄 (응답의 본문을 어떤 타입으로 반환할지를 결정)

			JSONParser parser = new JSONParser();
			JSONObject responseBody = (JSONObject) parser.parse(response.body());
			String token = responseBody.get("access_token") + "";
			long expiresIn = (long) responseBody.get("expires_in");
			accessToken = token;
			tokenExpirationTime = System.currentTimeMillis() + expiresIn * 1000; // 만료시간을 밀리초로 변환
			if(accessToken==null) {
				throw new Exception("SpotifyApi.getResponseByEndPoint() : accessToken 발급 실패");
			}
		}
	}

	// 엔드포인트에 대한 요청을 생성하고 JSON Simple로 응답객체를 파싱하여 리턴
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

	// 아티스트를 검색 후 itemsArray 리턴
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
	
	// id로 아티스트 검색 후 responseObject 리턴
	public JSONObject searchArtistById(String artistId) throws Exception {
		String endPoint = "https://api.spotify.com/v1/artists/"+artistId+"?locale=ko_KR";
		
		JSONObject responseObject = getResponseByEndPoint(endPoint);
		if(responseObject == null) return null;
		
		return responseObject;
	}
	
	// 아티스트의 모든 앨범이 담긴 itemsArray 리턴
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
	
	// id로 앨범 검색 후 responseObject 리턴
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
	
	// 앨범의 모든 트랙 검색 후 itemsArray 리턴
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
			System.out.println("SpotifyApi.createMusicDto() : 잘못된 날짜 형식이 입력됨");
		}
		
		// 스포티파이 문서에는 duration과 track이 Integer로 반환된다고 나와있지만 
		// JSON 파싱 라이브러리 (예: org.json 또는 Jackson)가 큰 숫자를 처리할 때 Long으로 자동 변환시키는 현상이 있어 int로 변환시키려 하면 ClassCastException이 발생하게 된다
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
			JSONArray artistItems = api.searchArtist("아이유");
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
