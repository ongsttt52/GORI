## 자바스크립트 문법

1. AJAX 관련
- JSON.stringify(value, replacer, space) : 자바스크립트 객체, 배열, 값을 JSON 문자열로 변환(직렬화)하는 메서드
    > value: JSON 문자열로 변환할 자바스크립트 객체 또는 배열
    > replacer (선택): 변환할 값의 속성을 필터링하거나 변경하는 함수 또는 배열
    > space (선택): 출력되는 JSON 문자열의 들여쓰기 수준을 지정하는 값, 가독성을 높이기 위해 사용

JavaScript의 Promise와 then, catch는 비동기 작업을 보다 직관적이고 효율적으로 처리하기 위해 사용됩니다. 각각의 역할은 다음과 같습니다.

- Promise 함수
Promise는 비동기 작업을 처리하는 객체로, 주로 서버에 데이터를 요청하거나 파일을 읽는 등의 작업에 사용됩니다. Promise는 아래와 같은 세 가지 상태를 가집니다.

Pending(대기): 비동기 작업이 아직 완료되지 않은 상태.
Fulfilled(이행): 비동기 작업이 성공적으로 완료된 상태.
Rejected(거부): 비동기 작업이 실패한 상태.

- .then() 메서드
.then() 메서드는 Promise가 Fulfilled 상태로 변했을 때(즉, 성공했을 때) 호출됩니다. then 메서드에 전달된 함수는 resolve로 전달된 값을 받아와 후속 작업을 진행할 수 있습니다.


- .catch() 메서드
.catch() 메서드는 Promise가 Rejected 상태로 변했을 때(즉, 실패했을 때) 호출됩니다. catch 메서드에 전달된 함수는 reject로 전달된 오류 값을 받아와 에러 처리를 진행할 수 있습니다.



2. window 관련
- window.onload(function() {...}) : DOM이 완전히 로드되었을 때 함수를 실행시킬 수 있는 함수 
- window.location.pathname : 현재 경로를 문자열로 반환 (컨텍스트 루트 포함)
- window.location.search : 현재 URL의 쿼리스트링(파라미터)를 반환 (href는 전체경로 반환)


3. 문자열 관련
- String(str).padStart(length, padString) : str을 설정한 length만큼의 자리수로 표시되게 하며 늘린 자리를 padString으로 채움
예 : String(Math.floor((music.duration / 1000) % 60)).padStart(2, '0');
String 안의 숫자가 한자리만 표시될 때 (0,1,2,3...,9) 두자리로 늘려서 표시하고, 늘린 자리를 0으로 채움 (00,01,02,03,...,09)


4. 객체, 배열 관련
- Object.keys(object) : 주어진 객체의 속성 이름들을 일반적인 반복문과 동일한 순서로 순회되는 배열로 반환

- 배열 정렬하기
    sort() : 정렬기준을 정하는 콜백함수를 매개변수로 받아 배열을 정렬
    콜백함수의 규칙 : (a,b) 를 비교할 때 a가 b보다 작으면 음수, 같으면 0, 크면 양수를 반환해야 함
```javascript
[3, 1, 2].sort();
// [1, 2, 3]

// 주의할 점 : 정렬하기 전 내부적으로 배열의 값들을 문자열로 변환함
[100, 3, 1, 20].sort();
// [1, 100, 20, 3]

// 따라서 다음과 같이 콜백함수를 정의함
[-3, 2, 0, 1, 3, -2, -1].sort((a, b) => a - b);
// [-3, -2, -1, 0, 1,  2,  3]

const countries = [
  { no: 1, code: "KR", name: "Korea" },
  { no: 2, code: "CA", name: "Canada" },
  { no: 3, code: "US", name: "United States" },
  { no: 4, code: "GB", name: "United Kingdom" },
  { no: 5, code: "CN", name: "China" },
];

// 객체는 통째로 인자에 넣게되면 Object object 로 변환되게 되어 비교가 불가능해짐
// 따라서 문자열의 순서를 비교해주는 localeCompare() 메서드 사용
countries.sort((a, b) => a.code.localeCompare(b.code));
/**
[
  { no: 2, code: 'CA', name: 'Canada' },
  { no: 5, code: 'CN', name: 'China' },
  { no: 4, code: 'GB', name: 'United Kingdom' },
  { no: 1, code: 'KR', name: 'Korea' },
  { no: 3, code: 'US', name: 'United States' }
]
*/
```


5. 날짜 관련
- 현재 날짜 구하기, 날짜 계산하기, 특정 날짜로 생성하기
    자바스크립트에서 현재 날짜는 new Date(); 로 얻을 수 있으며, 특정 날짜에 주어진 일 수를 더하거나 빼려면 setDate() 메서드를 사용한다.
```javascript
let now = new Date(); // 현재 날짜와 시각 얻음
now.setDate(now.getDate() + 5); // getDate() : 현재 일(day)을 가져옴, setDate() : now를 현재 날짜에 5일을 더한 날짜로 변경 (년,월은 자동 변경됨)
now.setMonth(now.getMonth() + 5) // now를 현재 월에 5개월을 더한 날짜로 변경
```
    특정 날짜를 얻으려면 new Date('yyyy-MM-dd') 혹은 new Date(yyyy,MM,dd -> MM은 0부터 시작하는 것에 주의) 를 사용

- isNaN(date.getTime()) : date에 어떤 값을 집어넣고 getTime()을 isNaN안에 집어넣게 되면 date가 유효한 날짜인지 검증 할 수 있다(13월, 52일 등을 걸러줌)
    >NaN :
    NaN은 "Not a Number"의 약자로, JavaScript에서 숫자가 아닌 값을 나타내는 특수한 값임. 특정 연산이나 함수 호출이 의도한 숫자 값을 반환하지 못할 때 발생
    문자열을 숫자로 변환하려하거나 (let result = Number("abc"), parseInt("abc"), parseFloat("abc")), 0을 0으로 나누는 등 수학적 오류가 있는 연산을 수행하거나,
    "날짜 형식이 아닌 문자열로 Date 객체를 생성하고 getTime() 메서드를 호출하면" NaN이 반환된다.
    NaN은 특이하게 자기 자신과의 비교에서도 false를 반환함, isNaN()은 입력값을 숫자로 변환한 후에 NaN인지 확인하는 메서드이다. 

- Date타입의 비교
    자바스크립트는 날짜형식 yyyy-MM-dd 혹은 yyyy/MM/dd 의 문자열에 대해 Date타입으로 자동변환해주는 기능을 지원함
    또한 뺄셈으로 Date타입을 비교 할 수 있음, 따라서 두 날짜를 비교하려면
    const date1 = new Date('날짜1');
    const date2 = new Date('날짜2');
    date1 - date2 = value => value가 음수이면 date1이 date2보다 이전, 양수이면 date1이 이후


- Date타입을 출력하면 yyyy,MM,dd 로 나오는 이유
    자바스크립트는 Date타입을 출력할 때 기본적으로 toString 메서드를 이용하는데 이때 쉼표로 구분된 문자열이 반환됨
    date.toISOString()을 통해 Date타입 날짜를 2021-03-25T00:00:00.000Z 형식으로 바꾸고 split('T')[0]으로 yyyy-MM-dd 형식의 날짜 문자열을 얻을 수 있음

- 자바의 sql.Date타입 변수는 자바스크립트에서 Date타입으로 저장되지 않음
    sql.Date 변수를 JSON 객체로 전송한 뒤 자바스크립트에서 출력해보면 yyyy,MM,dd 의 형식으로 출력되게 되는데, typeOf로 타입을 확인해보면 Object타입을 가짐
    Date타입이 아니므로 toISOString() 사용 불가능, 문자열이 아니므로 split() 사용 불가능 하므로 new Date(sql.Date)로 새로운 Date타입 변수를 만들어서 toISOString을 사용하자
    **주의사항** : toISOString으로 변경된 시간은 시간대가 UTC로 변경됨
    
---

## 제이쿼리 문법

1. 이벤트 관련
- target: 사용자가 클릭한 실제 DOM 요소.
currentElement ($(this)): 이벤트 핸들러가 바인딩된 요소(클릭된 요소의 부모).
currentTarget: 이벤트 리스너가 바인딩된 부모 요소.
```javascript
$('#manageMusic-content').on('click', '.manageArtist', function(event) {
			const target = $(event.target); // .manageArtist 내부에 있는 실제 클릭된 요소 (자식이 없다면 .manageArtist)
			const this = $(this) // 클릭 이벤트가 바인딩된 .manageArtist (내부 요소를 클릭해도 .manageArtist를 가리킴)
			const currentTarget = $(event.currentTarget); // 이벤트 리스너가 바인딩된 부모요소 (#manageMusic-content를 가리킴)
        // 여기서, 이벤트 핸들러는 이벤트 발생시 실행되는 함수를 말하며 이벤트 리스너는 $('#manageMusic-content')를 감시하고 핸들러를 호출하는 .on('click'...)를 말함
		});
```

- 여러 요소에 동시에 같은 이벤트 걸기 : $('#email, #name').blur(function(event) {...}); -> 구분자의 따옴표 안에서 쉼표로 구분하기

- 요소와 요소의 자식들에 같은 이벤트 걸기 : .artistDiv와 이것의 자식요소에 한꺼번에 이벤트를 걸려고 할 때 아래와 같은 방법을 사용할 수 있다
```javascript
$('상위요소 혹은 .artistDiv').on('click', function() {
    const artistDiv = $(event.target).closest('.artistDiv'); // artistDiv 자신 혹은 자식요소일 경우 변수에 값이 저장됨
    if(artistDiv.length) {...} // 변수에 값이 저장되어 있을 경우 true
})
```

2. 요소 관련
- $(2개 이상의 요소).get(0) / $(2개 이상의 요소).eq(0)
: JQuery 객체에 get(index) 또는 eq(index)로 해당 인덱스에 해당하는 값을 불러올 수 있다 / 둘의 차이점은 get은 DOM요소를, eq는 JQuery 객체를 반환한다는 것

- detach() : DOM 요소를 제거하면서도 해당 요소에 연결된 데이터와 이벤트 핸들러를 유지한 채로 제거할 수 있음
- remove() : 이벤트와 데이터를 모두 제거

```javascript
// 특정 요소를 detach하여 DOM에서 제거
 let btn = $("#myButton").detach(); 
 
 // 특정 컨테이너에 다시 추가
$("#container").append(btn);
 ```
- html('') vs empty() : html은 요소의 내용을 빈문자열로 설정, 이벤트핸들러는 남아있음 / empty는 모든 자식요소와 이벤트 핸들러를 제거, 더 빠르고 효율적

3. 객체 관련
- **object.each**(function(index, element){...}) : 객체의 값을 순회하는 반복문을 만든다 / 매개변수를 하나만 설정할 시 index로 취급되며 함수 안에서 $(this)로 해당 반복의 단일 요소를 지정 할 수 있다
> 주의할 점 : object.each는 JQuery 객체에만 사용할 수 있으며 자바스크립트 객체 또는 배열에는 $.each(object, function(){...}) 을 사용해야 한다

> each문 안에서 객체에 $(this).data(); 로 타겟의 **데이터속성들이 모두 합쳐진 객체**를 만들어 낼 수 있다
> 예 : 
```javascript
let artistObject = null;
$.each(target, function() {
    artistObject = $(this).data();
});

{ // 결과
    id: "object.id",
    name: "object.name",
    genre: "object.genre",
    img: "object.profileImg"
}
```

- object.length : 객체가 값을 가지고 있는지 확인할 수 있다 (length가 0이면 값이 없는 것) / 조건문에 활용 가능


4. 예외 관련
- AJAX에서의 error 콜백함수는 3가지 매개변수를 제공한다 / error:function(jqXHR, textStatus, errorThrown)
> 1. jqXHR : jqXHR 타입의 변수이며, 브라우저 XMLHttpRequest Object의 집합임
```javascript
error : function( jqXHR, textStatus, errorThrown ) {

alert( jqXHR.status ); // 500 | Http 오류번호를 출력 (400에러, 500에러 등)

alert( jqXHR.statusText ); // "Internal Server Error" | 오류 내용의 텍스트

alert( jqXHR.responseText ); // 서버에서 반환한 문자열에 접근 -> 이것을 사용해 예외처리 가능

alert( jqXHR.readyState ); // 4 | ajax의 readyState를 출력

}
```
> 2. textStatus : 'error' 문자열을 출력
> 3. errorThrown : jqXHR.statusText를 출력