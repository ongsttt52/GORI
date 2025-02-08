<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		let date = new Date();
		date.setDate(date.getDate() + 30);
		const locale = date.toLocaleString('ko-KR', { timeZone: 'Asia/Seoul' });
		
		if(confirm(name+'님을 강제 탈퇴시키시겠습니까?')) {
			$.ajax({
				type:'DELETE',
				url:'${pageContext.request.contextPath}/admin/user/'+id,
				data:JSON.stringify({date:locale}),
				contentType: 'application/json',
				success:function(result) {
					if(result === "SUCCESS") alert('탈퇴 처리되었습니다.');
					else alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
				}, error:function(error) {
					console.log(error.responseText);
				}
			});
		}
	</script>
</body>
</html>