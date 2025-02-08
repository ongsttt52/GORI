## MySQL 문법
- 테이블 정보 확인하기 : DESC 테이블명;

- 집계함수의 별칭을 WHERE 절에서 사용할 수 없는 이유
: MYSQL은 FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
의 순서를 기반으로 실행이 되며, 이때 alias의 경우 GROUP BY 절 이후 부터 인식이 가능하기 때문에 WHERE절에서는 별칭을 사용할 수 없음
따라서 WHERE ~ GROUP BY ~ HAVING (별칭을 사용한 조건) 으로 조회하자


1. 날짜 관련

- DATE_SUB, DATE_ADD : DATE_SUB(a,b)는 두 날짜 a와 b의 차를 계산하는 함수이다. 예를 들어 DATE_SUB(NOW(), INTERVAL 7 DAY) 는 현재 날짜로부터 7일 이전의 날짜를 계산해 반환한다 (INTERVAL은 DATE_SUB, DATE_ADD에서 쓰이는 날짜 간격 변수이다, '해당 간격만큼 떨어진 날짜를 계산하라' 가 되는 것)

- DATEDIFF(날짜1, 날짜2) : 날짜1 - 날짜2의 일 수를 가져옴
- TIMESTAMPDIFF(단위, 날짜1, 날짜2) : 날짜1 - 날짜2의 초,분,시,일,주,월,분기,년 차이를 가져옴

2. 쿼리문 관련

- CASE WHEN EXISTS (SELECT 1 FROM ... WHERE 조건)  : 서브쿼리(괄호 안의 쿼리문)에서 조건을 만족하는 레코드가 있는지 확인할 수 있음



## MyBatis 동적 SQL 문법

1. <if test="..."> , <choose>, <when>, <otherwise> : 해당 조건이 참일때만 SQL문이 추가됨

2. <where> : 자동으로 WHERE 절을 추가해주며, 조건이 여러 개 있을 때 자동으로 AND/OR을 처리

3. <set> : UPDATE 문에서 동적으로 컬럼을 설정할 때 사용, SET 절 내에서 첫 번째 항목 앞에 자동으로 SET이 추가되고 마지막 항목 뒤에는 자동으로 ,가 제거

4. <foreach> : 리스트나 배열과 같은 컬렉션을 반복
(예시 : 
    SELECT * FROM users
    WHERE id IN
    <foreach item="id" collection="list" open="(" separator="," close=")">
        #{id}
    </foreach>
)

---

## insert 쿼리문 실행 시 중복 데이터 삽입을 방지하는 방법

1. UNIQUE 제약조건 추가
UNIQUE 제약조건 설정 시 여러 컬럼을 묶어서 적용하면 **모든 컬럼이 동시에 중복되어야만 제약조건이 발동**하는 UNIQUE키를 만들 수 있다
예:
```sql
ALTER TABLE music
ADD CONSTRAINT unique_music UNIQUE (title, artist, album, track_number);
```
이렇게 하면 title,artist,album,track_number가 동시에 모두 중복되어야만 insert가 거부되게 된다

2. ON DUPLICATE KEY UPDATE 제약조건 추가
MySQL에서는 ON DUPLICATE KEY UPDATE 구문을 사용하여 중복된 레코드가 있는 경우, 삽입 대신 기존 레코드를 업데이트하도록 할 수 있다
**PRIMARY 혹은 UNIQUE KEY로 설정된 컬럼에 중복된 데이터가 삽입 되었을 경우**, ON DUPLICATE KEY 아래 선언된 컬럼들이 설정된 값으로 업데이트 되게 된다
예:
```sql
INSERT INTO music (title, artist, genre, lyrics, duration, release_date, album, track_number, album_img, preview_url)
VALUES (#{title}, #{artist}, #{genre}, #{lyrics}, #{duration}, #{releaseDate}, #{album}, #{trackNumber}, #{albumImg}, #{previewUrl})
ON DUPLICATE KEY UPDATE
    genre = VALUES(genre), 
    lyrics = VALUES(lyrics),
    duration = VALUES(duration),
    release_date = VALUES(release_date),
    album_img = VALUES(album_img),
    preview_url = VALUES(preview_url);
```
이 테이블의 UNIQUE KEY가 title이라고 했을 때, title이 이미 존재하는 데이터와 중복되는 새로운 데이터를 insert 시키면 
insert 중인 데이터의 genre,lyrics,duration 등이 기존 데이터에 덮어씌워지게 된다

기존 데이터 : '밤편지', '아이유', '발라드', ... 
삽입 데이터 : '밤편지', 'IU', 'KPOP', ...
삽입 후 기존 데이터 : '밤편지', '아이유', 'KPOP', ...

3. 동적 SQL문 활용
MyBatis의 동적 SQL문을 활용해 조건에 맞을 때만 쿼리문이 실행되도록 설정
예:
```sql
SELECT COUNT(*) FROM music 
WHERE title = #{title} 
AND artist = #{artist} 
AND album = #{album} 
AND track_number = #{trackNumber};

<if test="(select count(*) from music where title=#{title} and artist=#{artist} and album=#{album} and track_number=#{trackNumber}) == 0">
    INSERT INTO music (title, artist, genre, lyrics, duration, release_date, album, track_number, album_img, preview_url)
    VALUES (#{title}, #{artist}, #{genre}, #{lyrics}, #{duration}, #{releaseDate}, #{album}, #{trackNumber}, #{albumImg}, #{previewUrl});
</if>
```
-> select문으로 중복되는 값이 있는지 검색한 후 중복되는 데이터가 0일때만 쿼리문을 실행

4. INSERT IGNORE
기본키 또는 유니크키가 중복되는 데이터가 삽입될 경우 **아무런 오류 없이 삽입을 무시함** / 오류 원인 파악이 어렵다는 단점이 있다
예: 
```sql
INSERT IGNORE INTO music (title, artist, genre, lyrics, duration, release_date, album, track_number, album_img, preview_url)
VALUES (#{title}, #{artist}, #{genre}, #{lyrics}, #{duration}, #{releaseDate}, #{album}, #{trackNumber}, #{albumImg}, #{previewUrl});
```


## 특정 날짜가 되면 계정이 삭제되게 하기 (이벤트 스케쥴러)
- mySQL의 이벤트 스케쥴러는 특정 시간이나 주기에 따라 작업을 실행할 수 있게 해줌
    SET GLOBAL event_scheduler = ON; 로 이벤트 스케쥴러 활성화 (서버가 재시작되면 초기화됨, 설정파일에 [mysqld]event_scheduler=ON 추가 가능)

- 이벤트 생성하기
```sql
CREATE EVENT IF NOT EXISTS delete_old_accounts
ON SCHEDULE EVERY 1 DAY
DO
  DELETE FROM users
  WHERE deletion_date <= CURDATE();  -- 삭제할 기준 날짜 컬럼

```


## 트리거 생성하기
- 이벤트와 달리 트리거는 딜리미터 내에서 선언해야함 (트리거 발동시 실행되는 코드가 있기 때문에)

- BEFORE/AFTER INSERT/UPDATE/DELETE 로 트리거 발동 시점을 설정할 수 있으며, OLD/NEW 변수로 변화가 일어나기 전/일어난 후 의 행 데이터를 지정하여 사용할 수 있음
(INSERT는 OLD, DELETE는 NEW 변수가 없음)

- FOR EACH ROW : 트리거가 발동되면 조건에 부합하는 모든 행에 각각 트리거를 적용

- COALESCE(a,b,..) : 각 인자에 대해 NULL인지 검사 후 NULL이 아니면 해당 인자를, NULL이라면 오른쪽의 인자로 넘어가 다시 검사를 실행하는 메서드

```sql
DELIMITER $$
CREATE TRIGGER set_playlist_order_default
BEFORE INSERT ON playlist_music 
FOR EACH ROW
BEGIN
	DECLARE max_order INT;
    
    SET max_order = (SELECT COALESCE(MAX(list_order), 0) FROM playlist_music WHERE playlist_idx = NEW.playlist_idx);
    -- order가 예약어이기 때문에 오류가 발생하여서 컬럼명을 변경함, 변경하기 싫다면 백틱으로 order를 감싸서 사용하면 됨    
    SET NEW.list_order = max_order + 1;
    -- 트리거가 발동되면 새로 INSERT된 데이터의 list_order 컬럼값을 max_order+1로 변경한다
END $$
DELIMITER ;
```