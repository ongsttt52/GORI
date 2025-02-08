function getComments(feedIdx) {
    $.ajax({
        type:'GET',
        url:contextPath+'/feed/'+feedIdx+'/comments',
        success:function(result) {
            $('#commentContainer').empty(); // 이전 결과 비우기
            if(result.list.length == 0) { // 검색결과 없음
                let commentDiv = '<p>댓글이 없습니다...</p>';
                $('#commentContainer').append(commentDiv);
            }
            else { // 검색결과 있음
                result.list.forEach(function(comment) {
                    const commentDiv = createCommentDiv(comment);
                    $('#commentContainer').prepend(commentDiv);
                });
            }
        }, error: function(error) {
            console.log(error.responseText);
        }
    });
}

function createReportDiv(userIdx, contentIdx, content) {
    let div = `
        <div id="report-wrapper">
            <div>
                <h2>유저 신고하기</h2>
                ${createUserPreivew(userIdx)}
            </div>
            <div>
                <h4>콘텐츠 내용</h4>
                <div>${content}</div>
            </div>
            <form>
                <label>욕설 및 비방<input type="radio" value="0"></label>
                <label>불쾌함을 야기함<input type="radio" value="1"></label>
                <label>스팸 및 광고<input type="radio" value="2"></label>
                <label>성적인 콘텐츠<input type="radio" value="3"></label>
                <label>허위 및 불법 정보 유포<input type="radio" value="4"></label>
                <label>기타<input type="radio" value="5"></label>
                <textarea name="content" cols="50" rows="10" placeholder="정확한 사유를 입력해주세요. 적절한 조치를 위해 관리자게에 전달됩니다.">
                <input type="submit" class="inputSubmit" value="신고하기">
            </form>
        </div>
    `;
}