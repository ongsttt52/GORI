<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/resources/css/toolBar.css'/>?ts=<%= System.currentTimeMillis() %>">

<div id="toolBar">
	<div id="toolBar-left">
		<div></div>
		<button type="button"><i class="fa-regular fa-heart"></i><i class="fa-solid fa-heart"></i></button>
		<button type="button"><i class="fa-solid fa-plus"></i></button>
	</div>
	<div id="toolBar-center">
		<div id="toolBar-center-top">
			<button type="button" id="toolBar-shuffle" data-toggle="false"><i class="fa-solid fa-shuffle"></i></button>
			<button type="button" id="toolBar-prev"><i class="fa-solid fa-backward-step"></i></button>
			<button type="button" id="toolBar-playButton" style="font-size: 35px; color:white;"><i class="fa-solid fa-circle-play"></i></button>
			<button type="button" id="toolBar-next"><i class="fa-solid fa-forward-step"></i></button>
			<button type="button" id="toolBar-repeat" data-repeat="no"><i class="fa-solid fa-repeat"></i></button>
		</div>
		<div id="toolBar-center-bottom">
			<span id="durationCurrent">00:00</span>
			<div id="durationBar-wrapper">
				<div id="durationBar"><button type="button" id="durationButton"></button></div>
			</div>
			<span id="durationEnd"></span>
		</div>
		<div id="toolBar-audioBox" style="display:none;">
			<audio controls preload="auto" id="toolBar-audio" src=""></audio>
		</div>
	</div>
	<div id="toolBar-right">
		<button type="button" id="toolBar-lyrics"><i class="fa-solid fa-file-lines"></i></button>
		<button type="button" id="toolBar-feed"><i class="fa-solid fa-comments"></i></button>
		<button type="button">버튼</button>
		<div>
			<button type="button" id="toolBar-volume" data-toggle="false">
				<i class="fa-solid fa-volume-high"></i>
			</button>
			<div id="volumeBar-wrapper">
				<div id="toolBar-volumeBar"><button type="button" id="toolBar-volumeButton"></button></div>
			</div>
		</div>
		<button type="button"><i class="fa-solid fa-up-right-and-down-left-from-center"></i><i class="fa-solid fa-down-left-and-up-right-to-center"></i></button>
		<button type="button">버튼</button>
	</div>
</div>

<script src="<c:url value='/resources/js/functions-toolBar.js'/>?ts=<%= System.currentTimeMillis() %>"></script>
<script>
	const audio = $('#toolBar-audio')[0];
	const playButton = $('#toolBar-playButton');
	let isPlaying = false;
	
	
	// 재생버튼 클릭
	function togglePlayButton() {
		if(isPlaying) {
			isPlaying = false;
			playButton.html('<i class="fa-solid fa-circle-play"></i>');
			audio.pause();			
		}
		else {
			isPlaying = true;
			playButton.html('<i class="fa-solid fa-circle-pause"></i>');
			audio.play();			
		} 
	}
	$('#toolBar-playButton').on('click', function(event) {
		togglePlayButton();
	});
	
	
	// 새로운 음악 재생
	// $(#quelist-list .musicPreview) 의 index를 매개변수로 받음
	function setNewMusic(index) {
		const mList = $('#quelist-list .musicPreview');
		$(mList).removeClass('quelist-playing');
		
		if(index === null) {
			$('#toolBar-left>div:first-of-type').html('');
			audio.src = '';
			if(isPlaying) togglePlayBtton();
		} else {
			$(mList[index]).addClass('quelist-playing');
			const music = $(mList[index]).data();
			try {
				let preview = createPreview('music', music);
				$('#toolBar-left>div:first-of-type').html(preview);
				$('#toolBar-left .musicPreview').data('id', music.id);
			} catch(e) {
				mList[index].click();
			}
			currentIndex = index;
			audio.src = music.previewUrl;
		}
	}
	
	function playNewMusic(index) {
		setNewMusic(index);
		if(isPlaying) audio.play();
		else togglePlayButton();
		const musicIdx = $('#toolBar-left .musicPreview').data('id');
		$.ajax({
			type:'POST',
			url:contextPath+'/user/'+currentUserIdx+'/music/'+musicIdx+'/played',
			data:{},
			success: function(result) {
				
			}, error: function(error) {
				
			}
		});
	}
	
	function playNextMusic() {
		const mList = $('#quelist-list').find('.musicPreview');
		const isShuffling = $('#toolBar-shuffle').data('toggle');
		if(isShuffling) {
			const randomIndex = Math.floor(Math.random() * mList.length);
			playNewMusic(randomIndex);
	        // 셔플 목록을 만들어 모든 음악이 한번씩만 재생되게 하기
	        // 브라우저의 localStorage를 사용해 셔플 목록이 유지되도록 하기
		} else {
			if(currentIndex === mList.length - 1) playNewMusic(0);
			else playNewMusic(currentIndex + 1);
		}
	}
	function playPrevMusic() {
		const mList = $('#quelist-list').find('.musicPreview');
		const isShuffling = $('#toolBar-shuffle').data('toggle');
		if(isShuffling) {
			const randomIndex = Math.floor(Math.random() * mList.length);
	        playNewMusic(randomIndex);
		} else {
			if(currentIndex === 0) playNewMusic(mList.length - 1);
			else playNewMusic(currentIndex - 1);
		}
	}
	
	// 재생 끝
	audio.addEventListener('ended', function(event) {
		const isShuffling = $('#toolBar-shuffle').data('toggle');
		const isRepeating = $('#toolBar-repeat').data('repeat');
		const mList = $('#quelist-list').find('.musicPreview');
		
		if(isRepeating === 'one') {
			playNewMusic(currentIndex);
		} else if(isRepeating === 'yes' && isShuffling === 'false' && currentIndex === mList.length-1) {
			playNewMusic(0);
		} else if(isRepeating === 'no' && isShuffling === 'false' && currentIndex === mList.length-1) {
			playNewMusic(null);
		} else {
			playNextMusic();
		}
	});

	// 재생바 진행
	const durationCurrent = document.querySelector('#durationCurrent');
	const durationWrapper = document.querySelector('#durationBar-wrapper');
	const durationBar = document.querySelector('#durationBar');
	const durationButton = document.querySelector('#durationButton');
	
	audio.addEventListener('loadedmetadata', function(event) {
		durationCurrent.textContent = '00:00';
		durationBar.style.width = '0%';
		document.querySelector('#durationEnd').textContent = formatTime(Math.ceil(audio.duration));
	});
	
	audio.addEventListener('timeupdate', function(event) {
		const currentTime = formatTime(Math.floor(audio.currentTime));
		durationCurrent.textContent = currentTime;
		durationBar.style.width = ((audio.currentTime / audio.duration) * 100) + '%';
	});
	
	// 재생바 hover
	durationWrapper.addEventListener('mouseover', function(event) {
		durationButton.style.display = 'block';
		durationBar.style.backgroundColor = 'var(--point-color)';
	});
	durationWrapper.addEventListener('mouseout', function(event) {
		durationButton.style.display = 'none';
		durationBar.style.backgroundColor = 'white';
	});
	
	// 재생바 드래그
	let isDragging = false;
	
	function updateDuration(event) {
		if(event.type === 'mousedown') isDragging = true;
		else if(event.type === 'mouseup') isDragging = false;
		
		if(!isDragging) return;
		else {
			durationButton.style.display = 'block';
			durationBar.style.backgroundColor = 'var(--point-color)';
		}
		
		let percent;
		if(event.currentTarget === document) {
			const wrapperRect = durationWrapper.getBoundingClientRect();
			const offset = event.clientX - wrapperRect.left; // 클릭한 위치의 화면 좌측 끝에서부터의 x좌표 거리 - wrapper의 왼쪽 끝이 문서의 왼쪽 끝에서 떨어져있는 거리
			
			// 마우스 위치가 재생바 안쪽일 때, 재생바 왼쪽 바깥일 때, 오른쪽 바깥일 때
			if(offset >= 0 && offset <= wrapperRect.width) percent = (offset / wrapperRect.width) * 100;
			else if(offset < 0) percent = 0;
			else percent = 100;
			
		} else if(event.currentTarget === durationWrapper) {
			percent = (event.offsetX / event.currentTarget.offsetWidth) * 100;
		}
		durationBar.style.width = percent + '%';
		audio.currentTime = audio.duration * (percent / 100);
	}
	
	durationWrapper.addEventListener('mousedown', updateDuration);
	document.addEventListener('mousemove', updateDuration);
	document.addEventListener('mouseup', updateDuration);
	

	
	// 재생 관련 버튼 (중앙)
	$('#toolBar-center-top').on('click', function(event) {
		const target = $(event.target);
		const button = target.closest('button');
		
		if(button.is('#toolBar-shuffle')) {
			if(!button.data('toggle')) {
				button.css('color', 'white');
				button.data('toggle', true);
			} else {
				button.css('color', 'var(--text-color-weak)');
				button.data('toggle', false);
			}
		} else if(button.is('#toolBar-prev')) {
			console.log('prev');
			playPrevMusic();
			
		} else if(button.is('#toolBar-next')) {
			playNextMusic();
			
		} else if(button.is('#toolBar-repeat')) {
			switch (button.data('repeat')) {
		    case 'no':
		        button.css('color', 'white');
		        button.data('repeat', 'yes');
		        break;
		    case 'yes':
		        button.html('<i class="fa-solid fa-1"></i>');
		        button.data('repeat', 'one');
		        break;
		    case 'one':
		        button.html('<i class="fa-solid fa-repeat"></i>');
		        button.css('color', 'var(--text-color-weak)');
		        button.data('repeat', 'no');
		        break;
			}
		}
	});
	
	// 재생 관련 버튼 (우측)
	let volumeTmp = null;
	$('#toolBar-right').on('click', function(event) {
		const target = $(event.target);
		const button = target.closest('button');
		if(button.is('#toolBar-lyrics')) {
			
		} else if(button.is('#toolBar-feed')) {
			
		} else if(button.is('#toolBar-volume')) {
			if(audio.muted) {
				const volume = audio.volume;
				if(volume === 0) button.html('<i class="fa-solid fa-volume-xmark"></i>')
				else if(volume <= 0.5) button.html('<i class="fa-solid fa-volume-low"></i>')
				else button.html('<i class="fa-solid fa-volume-high"></i>');
				audio.muted = false;
			} else {
				button.html('<i class="fa-solid fa-volume-xmark"></i>');
				audio.muted = true;
			}
		}	
	});
	
	// 볼륨 아이콘
	audio.addEventListener('volumechange', function(event) {
		const volume = audio.volume;
		const button = $('#toolBar-volume');
		if(audio.muted) return;
		if(volume <= 0.5 && volume > 0) button.html('<i class="fa-solid fa-volume-low"></i>');
		else if(volume === 0) button.html('<i class="fa-solid fa-volume-off"></i>');
		else if(volume > 0.5) button.html('<i class="fa-solid fa-volume-high"></i>');
	});
	
	// 볼륨바
	$('#volumeBar-wrapper').on('mouseover', function(event) {
		$(this).find('#toolBar-volumeButton').show();
		$(this).find('#toolBar-volumeBar').css('background-color', 'var(--point-color)');
	});
	$('#volumeBar-wrapper').on('mouseout', function(event) {
		$(this).find('#toolBar-volumeButton').hide();
		$(this).find('#toolBar-volumeBar').css('background-color', 'white');
	});
	
	// 볼륨바 드래그
	let isVolumeDragging = false;
	const volumeWrapper = document.querySelector('#volumeBar-wrapper');
	const volumeButton = document.querySelector('#toolBar-volumeButton');
	const volumeBar = document.querySelector('#toolBar-volumeBar');
	
	function updateVolume(event) {
		if(event.type === 'mousedown') isVolumeDragging = true;
		else if(event.type === 'mouseup') isVolumeDragging = false;
		
		if(!isVolumeDragging) return;
		else {
			volumeButton.style.display = 'block';
			volumeBar.style.backgroundColor = 'var(--point-color)';
		}
		
		let percent;
		if(event.currentTarget === document) {
			const wrapperRect = volumeWrapper.getBoundingClientRect();
			const offset = event.clientX - wrapperRect.left; // 클릭한 위치의 화면 좌측 끝에서부터의 x좌표 거리 - wrapper의 왼쪽 끝이 문서의 왼쪽 끝에서 떨어져있는 거리
			
			// 마우스 위치가 재생바 안쪽일 때, 재생바 왼쪽 바깥일 때, 오른쪽 바깥일 때
			if(offset >= 0 && offset <= wrapperRect.width) percent = (offset / wrapperRect.width) * 100;
			else if(offset < 0) percent = 0;
			else percent = 100;
			
		} else if(event.currentTarget === volumeWrapper) {
			percent = (event.offsetX / event.currentTarget.offsetWidth) * 100;
		}
		volumeBar.style.width = percent + '%';
		audio.volume = (percent / 100.0);
	}
	volumeWrapper.addEventListener('mousedown', updateVolume);
	document.addEventListener('mousemove', updateVolume);
	document.addEventListener('mouseup', updateVolume);
	
	
	
</script>