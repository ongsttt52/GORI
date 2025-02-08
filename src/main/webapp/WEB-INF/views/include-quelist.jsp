<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/resources/css/quelist.css'/>?ts=<%= System.currentTimeMillis() %>">

<section id="section-right">
	<div class="sectionWrapper">
		<div id="right-header">
			<span class="mainTitle">재생목록</span>
			<c:if test="${not empty sessionScope.user}">
				<div>
					<button type="button" class="chooseAllButton button-option" style="display:none;">전체 선택</button>
					<button type="button" class="chooseButton button-option">선택</button>
				</div>
			</c:if>
		</div>
		<div id="quelist-buttons">
		<c:if test="${not empty sessionScope.user}">
			<div id="quelist-sortDiv">
<!-- 				<label style="display:block;">
					<input type="text" id="quelist-searchInput" class=" searchInput" placeholder="검색하기" style="padding: 0 10px;">
					<button type="submit" id="quelist-searchButton" class="inputSubmit" style="width:50px; height: 30px;">검색</button>
				</label> -->
				<button type="button" class="sort-artist button-option" data-toggle="false">가수별</button>
				<button type="button" class="sort-genre button-option" data-toggle="false">장르별</button>
			</div>
			<div id="quelist-chooseDiv" style="display:none;">
				<button type="button" class="choose-delete inputSubmit" style="width:50px; height: 30px;">삭제</button>
			</div>
		</c:if>
		</div>
		<div id="right-quelist" class="scroll">
			<div id="quelist-list">
				<c:if test="${empty sessionScope.user}">
					<div class="emptyResult"><span>로그인 후 이용 부탁드립니다.</span></div>
				</c:if>
			</div>
		</div>
	</div>
</section>

<script>
	$('#right-header').on('click', function(event) {
		const target = $(event.target);
		const button = target.closest('button');
		const mList = $('#quelist-list .musicPreview');
		
		// 선택
		if(button.hasClass('chooseButton')) {
			if(!button.hasClass('button-selected')) {
				let chooseBox = $('<input type="checkbox" class="chooseBox">'); // DOM 요소로 만들기
				mList.find('.dropdownButton').replaceWith(chooseBox);
				button.parent().find('.chooseAllButton').show();
				
				button.addClass('button-selected');
			} else {
				let dropdownButton = $('<button type="button" class="dropdownButton" data-toggle="false"><i class="fa-solid fa-ellipsis"></i></button>');
				mList.find('.chooseBox').replaceWith(dropdownButton);
				button.parent().find('.chooseAllButton').hide();
				button.removeClass('button-selected');
			}
			$('#quelist-chooseDiv').toggle();
			$('#quelist-sortDiv').toggle();
			
		// 전체 선택
		} else if(button.hasClass('chooseAllButton')) {
			if(!button.hasClass('button-selected')) {
				mList.find('.chooseBox').prop('checked', true);
				button.addClass('button-selected');
			} else {
				mList.find('.chooseBox').prop('checked', false);
				button.removeClass('button-selected');
			}
		}
	});
	
	// 정렬
	let quelistTmp = null;
	$('#quelist-buttons').on('click', function(event) {
		const target = $(event.target);
		const button = target.closest('button');
		const mList = $('#quelist-list .musicPreview');
		const mArray = mList.toArray();
		
		// 가수별, 장르별, ???
		if(button.hasClass('sort-artist') || button.hasClass('sort-genre')) {
			let dataName = null; 
			if(button.hasClass('sort-artist')) {
				dataName = 'artistName';
				if($('#quelist-buttons .sort-genre').hasClass('button-selected')) 
					$('#quelist-buttons .sort-genre').removeClass('button-selected');
			}
			else if(button.hasClass('sort-genre')) {
				dataName = 'genre';
				if($('#quelist-buttons .sort-artist').hasClass('button-selected')) 
					$('#quelist-buttons .sort-artist').removeClass('button-selected');
			}
			
			if(!button.hasClass('button-selected')) {
				const sortedArray = sortArray(mArray, dataName);
				if(quelistTmp === null) quelistTmp = mList;
				$('#quelist-list').html(sortedArray);
				button.addClass('button-selected');
				currentIndex = getCurrentIndex();
				// 추가할 기능 : 정렬된 그룹마다 그룹명을 표시해주기 + 체크박스로 해당 그룹만 선택
			} else {
				$('#quelist-list').html(quelistTmp);
				quelistTmp = null;
				button.removeClass('button-selected');
				currentIndex = getCurrentIndex();
			}
		} else if(button.hasClass('choose-add')) {
			
		} else if(button.hasClass('choose-like')) {
			
		} else if(button.hasClass('choose-delete')) {
			const checkedMusics = $('#quelist-list .musicPreview input[type="checkbox"]:checked').closest('.musicPreview');
			let isFailed = false;
			$.each(checkedMusics, function(index, music){
				// 추가할 기능 : 트랜잭션 처리
				deleteMusicFromQuelist($(music).data('list-order'))
				.then(() => {
					if($(music).hasClass('quelist-playing')) playNewMusic(null);
					$(music).remove();
				})
				.catch(error =>{
					isFailed = true;
					showMessage(errorMessage);
					return false;
				});
			});
			if(!isFailed) showMessage('음악이 삭제되었습니다.');
			
		} else if(button.hasClass('')) {
			
		} else if(button.hasClass('')) {
			
		} else if(button.hasClass('')) {
			
		} else if(button.hasClass('')) {
			
		}
	});

</script>

<script src="<c:url value='/resources/js/functions-quelist.js'/>?ts=<%= System.currentTimeMillis() %>"></script>
<script>
	let currentIndex = 0;
	
	function getCurrentIndex() {
		const mList = $('#quelist-list .musicPreview');
		let newIndex = null;
		$.each(mList, function(index, music) {
			if($(music).hasClass('quelist-playing')) {
				newIndex = index;
			}
		});
		return newIndex;
	}
	
	// 유저의 재생목록 가져오기
	function getUsersQuelist(userIdx) {
		return new Promise((resolve, reject) => {
			$.ajax({
				type:'GET',
				url:'${pageContext.request.contextPath}/quelist',
				data:{userIdx:userIdx},
				success: function(result) {
	 				$.each(result.musicList, function(index, music) {
						let preview = createPreview('music', music);
						$('#quelist-list').append(preview);
					});
	 				resolve();
				}, error: function(error) {
					reject(error);
				}
			});
		});
	}
	
	if(currentUserIdx !== null && currentUserIdx !== undefined) {
		getUsersQuelist(currentUserIdx)
		.then(() => {
			
		})
		.catch(error => {
			console.log(error);
			showMessage(errorMessage);
		});
	}
	
	// 재생목록에 추가
	function addMusicToQuelist(music) { // idx, title, artistName, albumName, albumImg, previewUrl 필요 
		return new Promise((resolve, reject) => {
	        $.ajax({
	            type: 'POST',
	            url: '${pageContext.request.contextPath}/quelist/music/'+music.idx,
	            data: {userIdx:currentUserIdx},
	            success: function(event) {
	                let preview = createPreview('music', music);
	                $('#quelist-list').append(preview);
	                
	                const mList = $('#quelist-list .musicPreview');
	                let prevOrder;
	                if(mList.length > 1) prevOrder = $(mList[mList.length - 2]).data('list-order');
	                else prevOrder = 0;
					$(mList[mList.length - 1]).attr('data-list-order', prevOrder + 1);
					
	                resolve();  // 비동기 작업이 완료되면 resolve 호출
	                
	            }, error: function(error) {
	                reject(error);  // 실패 시 reject 호출
	            }
	        });
	    });
	}
	
	// 재생목록 한개 삭제
	function deleteMusicFromQuelist(listOrder) {
		return new Promise((resolve,reject) => {
			$.ajax({
				type:'DELETE',
				url:contextPath+'/user/'+currentUserIdx+'/quelist/'+listOrder,
				data:{},
				success: function(result) {
					resolve(result);
				}, error: function (error) {
					reject(error);
				}
			});
		});
	}
	
	
	
	let dropdown = `<div class="dropdown-div" style="display:block; padding:10px;">`;
	if(${empty sessionScope.user}) {
		dropdown += `<span>로그인 후</span><br><span>이용 가능합니다.</span></div>`;
	} else {
		dropdown += `
			<button type="button" class="removeAtQuelist">재생목록에서 삭제</button>
			<button type="button" class="addToPlaylist">플레이리스트에 추가</button>
			<button type="button" class="writeFeed">피드 작성하기</button>
		</div>`;
	}
	
	// 드롭다운
	$('#quelist-list').on('click', function(event) {
		const target = $(event.target);
		const button = target.closest('button');
		const musicPreview = target.closest('.musicPreview');
		const music = musicPreview.data();
		const mList = $(this).find('.musicPreview');
		
		if(button.hasClass('dropdownButton')) {
			$('#quelist-list').find('.dropdown-div').remove();
			if(button.data('toggle')) {
				button.parent().find('.dropdown-div').remove();
				button.data('toggle', false);
			} 
			else {
				button.parent().append(dropdown);
				button.data('toggle', true);
				
				const index = musicPreview.index();
				if(index > 6 && index >= mList.length - 2) {
					mList.find('.dropdown-div').css('top', '-130px');	
				}
				
			}
		
		// 재생목록에서 제거
		} else if(button.hasClass('removeAtQuelist')) {
			deleteMusicFromQuelist(music.listOrder)
			.then(() => {
				musicPreview.remove();
				const mList = $('#quelist-list .musicPreview');
				if(mList.length === 0) playNewMusic(null);
				if(musicPreview.hasClass('quelist-playing')) {
					let index = null;
					if(currentIndex === mList.length) index = mList.length - 1;
					else index = currentIndex;
					
					if(isPlaying) playNewMusic(index);	
					else setNewMusic(index);
				} else {
					currentIndex = getCurrentIndex();	
				} 
				showMessage('음악이 삭제되었습니다.');
			})
			.catch(error => {
				console.log(error);
				showMessage(errorMessage);
			});
		} else if(button.hasClass('addToPlaylist')) {
			createPlaylistModal(music.id);
			
		} else if(button.hasClass('writeFeed')) {
			let div = `<div id="writeFeed-modal"><h2>피드 작성하기</h2>`;
			
			div += createPreview('music', music);
			div += `<form method="post" action="${pageContext.request.contextPath}/feed" onsubmit="return formCheckFeed(this)">
						<input type="hidden" name="userIdx" value="${'${currentUserIdx}'}">
						<input type="hidden" name="musicIdx" value="${'${music.id}'}">
						<label>내용:<br>
							<textarea id="writeFeed-content" name="content" rows="10" maxlength="255" placeholder="내용을 입력하세요."></textarea>
						</label>
						<input type="submit" class="inputSubmit" value="작성하기">
					</form>
				</div>`;
			$('body').append(createModal(div));
		
		// 재생목록 음악 클릭
		} else if(musicPreview.length) {
			if(musicPreview.find('.dropdownButton').length) {
				const index = musicPreview.index();
				playNewMusic(index);
				// 추가할 기능 : 클릭된 곳으로 스크롤되게 하기
			// 음악 선택중일 경우
			} else {
				let choose = musicPreview.find('.chooseBox');
				if(!choose.attr('checked')) choose.attr('checked', true);
				else choose.attr('checked', false);
			}
		}
	});
	
	function formCheckFeed(form) {
		if(form.content.value.length === 0) {
			showMessage('내용을 입력해주세요.');
			return false;
		}
		return true;
	}
	
	
	
</script>