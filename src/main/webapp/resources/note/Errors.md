## 발생한 오류

**DB 연결하기**

    - IllegalStateException : 대상 객체의 상태가 호출된 메서드를 수행하기에 적절하지 않을 때 발생시킬 수 있는 예외이다. Test_test 클래스 실행했더니 발생, 즉 com.mysql.jdbc.Driver 클래스가 로드되지 못했다는 뜻
    자바 버전, 스프링 버전, 스프링 JDBC 버전을 JUnit 4에 맞게 설정하고 파일 생성시에 JUnit4로 설정, import된 클래스가 4에 맞는 클래스인지 확인 후 다시 실행했더니 해결됨

    - java.sql.SQLException: The server time zone value '���ѹα� ǥ�ؽ�' is unrecognized or represents more than one time zone. 
    : MySQL 서버의 시간대 설정과 JDBC 드라이버가 인식하지 못하는 서버 시간대 값때문에 발생한 오류 (시간대가 한글깨짐 상태이기 때문에)
    JDBC URL에 serverTimezone 속성을 명시적으로 추가하여 사용할 시간대를 설정해 해결 ...&amp;characterEncoding=utf8&amp;serverTimezone=Asia/Seoul"

    - NullPointerException : 메서드 내부에서 발생했거나 DataSource가 제대로 주입되지 않은 경우 발생
    DataSource 빈을 root-context에 설정해두었다면 프로퍼티를 다시 확인하고 @ContextConfiguration의 경로가 정확히 root-context를 가리키는지 확인
    DataSource에 이상이 없다면 JUnit의 버전을 확인할 것 (파일을 4버전으로 생성해놓고 jupiter 클래스를 사용하거나 pom에서 4버전으로 설정해놓고 파일을 5버전으로 생성하면 이 오류가 발생하는 것 같음)


**MyBatis 관련**
    - org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.exceptions.PersistenceException: 
    ###Error querying database.  Cause: java.lang.IllegalArgumentException: Mapped Statements collection does not contain value for gori.user.selectUser
    : 해당 이름(value for gori.user.selectUser)으로 매핑된 쿼리문이 없다는 뜻, namespace 혹은 쿼리문의 id를 잘 못 지정 했을 때 발생함

**Test 클래스**
    - Failures
    AssertionError : Assert.assertTrue() 메서드 내의 조건이 false여서 실패 처리되었음을 알리는 오류 -> 메서드 내 오타가 있어 수정하니 정상화

    - Errors
    NullPointerException : update 메서드의 리턴값을 session.selectOne으로 했더니 NullPointerException 발생 / 검색이 아닌 update가 실행되었으니 검색값이 null이라서 발생한듯
    Failed to load ApplicationContext ... Caused by BeanCreationException ... 'sqlSessionFactory' ... NestedIOException: Failed to parse ... 'UserMapper.xml'
    : MyBatis가 mybatis-config.xml에서 매퍼 파일을 로드하고 초기화 할 때 매퍼를 제대로 로드하지 못해 생기는 오류 / MyBatis는 설정된 모든 매퍼에 잘못된 구문, 경로, 클래스 참조가 하나라도 있다면 애플리케이션이 작동하지 않게 되므로 매퍼가 모두 잘 설정되었는지 꼼꼼히 확인할 것



**기타**
    - 400 에러 -> 쿼리파라미터가 맞게 들어왔는지 확인해보기

    - 갑자기 모든 경로에 404에러 -> 콘솔창 확인 -> 드라이버가 없음 -> pom에서 뭐 건들이거나 지웠는지 확인해보기

    - 자바스크립트에서 JSTL 문법 사용 가능? -> JSTL은 렌더링할 때 해석되는 문법이므로 렌더링 이후 처리되는 자바스크립트에서는 동작하지 않음

    - 파일 수정했는데 적용이 안될때는 F5를 눌러보자

    -**gori/null 404에러 뜰 때** : ajax로 잘못된 객체를 가져왔을 때 발생 (앨범정보를 가져왔는데 object.profileImg 이런 코드가 있으면 발생함)

    - java.lang.error: unresolved compilation problem: invalid character constant : 
        char lastChar = word.charAt(word.length()-1);
	    	if(lastChar >= '가' && lastChar <= '힣') 
    
        -> if 조건문에서 char타입 변수의 비교를 '가', '힣'과 같이 한글 문자로 시도했는데 위와 같이 문자 리터럴이 올바른 형식이 아니라는 오류가 발생했다
        '가'와 '힣'을 각각 해당되는 유니코드 값으로 변경(0xAC00, 0xD7A3)했더니 오류가 발생하지 않게 되었음
        'a'는 문제를 일으키지 않는 것으로 보아 한글 문자를 인코딩하고 난 후의 값이 문자 리터럴로 들어가서 오류를 일으킨 듯