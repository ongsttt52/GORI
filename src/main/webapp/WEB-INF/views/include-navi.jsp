<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/resources/css/nav.css'/>?ts=<%= System.currentTimeMillis() %>">

<header>
	<a href="<c:url value='/'/>" style="width:50px; height: 50px; display:flex; align-items:center;"><img src="<c:url value='/resources/image/icon/logo.png'/>"></a>
	<a href="<c:url value='/'/>">홈</a>
	<a href="<c:url value='/feed'/>">피드 보러가기</a>
</header>
<nav>
	<form id="nav-searchForm" method="post" action="<c:url value='/search'/>">	
		<input type="text" id="nav-searchInput" class="searchInput" name="search" placeholder=" 어떤 콘텐츠를 감상하고 싶으세요?">
		<button id="nav-searchButton"><i class="fa-solid fa-magnifying-glass" style="color: #fff480;"></i></button>	
	</form>
</nav>
<div id="header-right">
	<c:choose>
		<c:when test="${empty sessionScope.user}">
			<div id="header-login">
				<a href="<c:url value='/login'/>" id="loginButton"><button type="button" class="inputSubmit">로그인하기</button></a>
				<a href="<c:url value='/regist'/>" id="registButton">가입하기</a>
			</div>
		</c:when>
		<c:otherwise>
			<div id="header-profile" data-user-idx="${sessionScope.user.idx}" data-user-name="${sessionScope.user.name}" data-user-img="${sessionScope.user.profileImg}">
				<img src="${pageContext.request.contextPath}${sessionScope.user.profileImg}" class="imgPreview">
				<c:choose>
					<c:when test="${sessionScope.user.grade eq 'admin'}">
						<a href="<c:url value='/admin/music'/>"><i class="fa-solid fa-star" style="color: #fff480;"></i> ${sessionScope.user.name}</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/profile/user/${sessionScope.user.name} }'/>">${sessionScope.user.name}</a>
					</c:otherwise>
				</c:choose>
				<div>
					<a href="<c:url value='/logout'/>" style="float:right">로그아웃하기</a>
					<button type="button" style="float:right">버튼2</button>
					<button type="button" style="float:right">버튼1</button>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<script>
	const currentUserIdx = $('#header-profile').data('user-idx');
	
	$('#nav-searchForm').on('submit', function(event) {
		event.preventDefault();
		const form = $(event.currentTarget);
		const value = $('#nav-searchInput').val().trim();
		if(value === '' || value === undefined || value === null) {
			showMessage('검색어를 입력해주세요.');
			return;
		}
		
		window.location.href='${pageContext.request.contextPath}/search/all/'+value;
	});
	
</script>