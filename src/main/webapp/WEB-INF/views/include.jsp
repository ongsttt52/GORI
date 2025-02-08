<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.net.URLDecoder" %>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Swiper.js -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/f87116b39f.js" crossorigin="anonymous"></script>
<!-- 스타일 -->
<link rel="stylesheet" href="<c:url value='/resources/css/global.css'/>?ts=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<c:url value='/resources/css/classes.css'/>?ts=<%= System.currentTimeMillis() %>">
<!-- 스크립트 -->
<script src="<c:url value='/resources/js/functions.js'/>?ts=<%= System.currentTimeMillis() %>"></script>

<script>
	const path = window.location.pathname;
	const contextPath = "/" + path.split("/")[1]; // [0]은 빈 문자열
	const errorMessage = '서버에 오류가 발생했습니다. 잠시 후 시도해주세요.';
	
	// 기본 우클릭 동작을 막음
	document.addEventListener('contextmenu', function (event) {
	    event.preventDefault();  
	});
	
	// 뒤로가기 시 강제 새로고침
	window.addEventListener("pageshow", (event) => {
	    if (event.persisted) {
	        window.location.reload();
	    }
	});
	
	$(document).ready(function() {
		
		// 로그인이 안 되어있을 시 캡처링을 통해 이벤트 전파 막기
		document.addEventListener('click', function(event) {
			const target = event.target;
		    const button = target.closest('button');
		    let toggle = false;
			
		    if(button.classList.contains('playButton') || button.classList.contains('likeButton') || button.classList.contains('followButton') || button.classList.contains('contentDiv-playButton'))
		    	toggle = true;
		    if(toggle && ${empty sessionScope.user}) {
		        event.stopPropagation();
		        showMessage('로그인 후 이용해주세요.');
		        return;
		    }
		}, true);
		
		$(document).on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			
			// 드롭다운 메뉴 끄기
			if(button.hasClass('dropdownButton')) return;
			$('.dropdown-div').hide();
			// 모달창 끄기
			if(button.hasClass('modal-closeButton')) {
				target.closest('.modal-body').remove();
			
			// 이미지 업로드 클릭
			} else if(target.hasClass('inputImage-preview')) {
		        target.parent().find('.inputImage').click();
			}
		});
		
		// 이미지 업로드
		$(document).on('change', '.inputImage', function(event) {
			const target = $(event.target);
	    	const inputFile = $(this);
	    	const preview = $(event.target).parent().find('.inputImage-preview');
	    	
	    	 // 배열형태로 값을 가져오기 때문에, dom element에 접근위해서는 인덱스 활용
	        if(inputFile[0].files[0].length !== 0){
	        	let reader = new FileReader();
	        	reader.onload = function(e){
	       			console.log(e.target.result);
	        		preview.attr('src', e.target.result);
	        	};
	        	reader.readAsDataURL(inputFile[0].files[0]);
	        }else{
	        	preview.src = '';
	        }
	    });
		
		$('.contentDiv').on({ // 이벤트를 객체형태로 적용하기
			mouseover: function(event) {
				$(this).find('.contentDiv-playButton').fadeIn(200);
				if($(event.target).hasClass('contentDiv-playButton')) $(this).css('transform', 'scale(1.1)');
			},
			mouseleave: function(event) {
				$(this).find('.contentDiv-playButton').fadeOut(200);
				if($(event.target).hasClass('contentDiv-playButton')) $(this).css('transform', 'scale(1)');
			}
		});
		
		$('.contentDiv-playButton').on('click', function(event) {
			const target = $(event.target);
			const id = target.closest('.contentDiv').data('id');
			let type = null;
			if(target.closest('.albumDiv').length) type = 'album';
			else if(target.closest('.musicDiv').length || target.closest('.contentDiv').is('#topResult-content')) type= 'music'; 
			else if(target.closest('.playlistDiv').length) type= 'playlist';
			
			$.ajax({
				type:'GET',
				url:contextPath+'/play/'+type+'/'+id,
				data:{},
				success: function(result) {
					let length = $('#quelist-list .musicPreview').length;
					if(length == null || length == undefined) length = 0;
					$.each(result, function(index, music) {
						addMusicToQuelist(music)
						.then(() => {
							if(index === result.length-1) playNewMusic(length);
						})
						.catch(error => {
							
						});
					});
				}, error: function(error) {
					showMessage('서버에 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
				}
			});
		});
		
		$('.musicView').on('click', function(event) {
			const target = $(event.target);
			const button = target.closest('button');
			const music = target.closest('.musicView').data();
			
			// 재생
			if(button.hasClass('playButton')) {
				addMusicToQuelist(music, currentUserIdx)
		        .then(() => {
		            // 성공적으로 추가되었을 때만 클릭 동작 실행
		            const mList = $('#quelist-list .musicPreview');
		            playNewMusic(mList.length - 1);
		        })
		        .catch(error => {
		            console.log(error);
		            showMessage(errorMessage);
		        });
				
			// 좋아요
			} else if(button.hasClass('likeButton')) {
				if(!button.data('is-liked')) {
					userLikeMusic(music.idx)
					.then(result => {
						button.html('<i class="fa-solid fa-heart" style="color: #fff480;"></i>');
						button.data('is-liked', true);
						showMessage('좋아요 표시한 곡에 추가되었습니다.');
					})
					.catch(error => {
						console.log(error);
						showMessage(errorMessage);
					});
				} else {
					userNotLikeMusic(music.idx)
					.then(result => {
						button.html('<i class="fa-regular fa-square-plus"></i>');
						button.data('is-liked', false);
						showMessage('좋아요 표시한 곡에서 삭제되었습니다.');
					})
					.catch(error => {
						console.log(error);
						showMessage(errorMessage);
					});
				}
			} else if(button.hasClass('dropdownButton')) {
				button.parent().find('.dropdown-div').show();
			
			// 재생목록에 추가
			} else if(button.hasClass('addToQuelist')) {
				addMusicToQuelist(music, currentUserIdx)
				.then(() => {
					
				})
				.catch(error => {
					console.log(error);
					showMessage(errorMessage);
				});
			// 플레이리스트에 추가
			} else if(button.hasClass('addToPlaylist')) {
				createPlaylistModal(music.idx);
				
			// 피드 작성하기
			} else if(button.hasClass('writeFeed')) {
				const div = createFeedModal(music);
				target.closest('.musicView').append(createModal(div));
			}
		});
	});
	
	// data 속성으로 배열 정렬
	function sortArray(array, dataName) {
		const sortedArray = array.sort(function(a,b) {
			const textA = $(a).data(dataName);
			const textB = $(b).data(dataName);
			
			if(textA < textB) return -1;
			else if(textA > textB) return 1;
			else return 0;
		});
		return sortedArray;
	}
</script>
