// 브라우저 종료시 이벤트 ( 세션종료 )
function Exit() 
{  
    if (self.screenTop > 9000) 
    {  
    	if(opener)
    	{
    		alert("자식창 닫힘"); 
    	}
        // 브라우저가 닫힐때 일어나는 이벤트
    	else
    	{
    		alert("부모창 닫힘");    
    		location.replace("logout.jsp");
    	}
    }
    else 
    {  
    	/* /if(document.readyState == "complete") 
  		{  
            // 새로고침할때 일어나는 이벤트            
        }
  		else if(document.readyState == "loading") 
  		{
            // 다른 사이트로 이동할때 일어나는 이벤트  
        } */
    }
}   


// 댓글 작성 체크
function replyCheck(){
	if(document.comment.context.value.length == 0){
		alert("댓글을 입력해주세요");
		document.comment.context.focus();
	}
	else if(document.comment.passwd.value.length == 0){
		alert("비밀번호를 입력해주세요");
		document.comment.passwd.focus();
	}
	else{
		comment.submit();
	}
}
// 게시글 작성 체크
function check(){
	if(document.boardForm.title.value.length == 0){
		alert("제목을 입력해주세요");
		document.boardForm.title.focus();
	}
	else if(document.boardForm.name.value.length == 0){
		alert("이름을 입력해주세요");
		document.boardForm.name.focus();
	}
	else if(document.boardForm.passwd.value.length == 0){
		alert("비밀번호를 입력해주세요");
		document.boardForm.passwd.focus();
	}
	else{
		document.boardForm.content.value =trim(document.boardForm.content.value); 
		boardForm.submit();
	}
}
function trim(value){
	value = value.replace(/^\s+/, "");		//좌측 공백 제거
	value = value.replace(/^\s+$/g, "");	//우측 공백 제거
	value = value.replace(/\n/g, "<br>");	//행바꿈
	
	return value;
}
	
/*document.write("appName : " + navigator.appName + "<br>");
document.write("appVersion : " + navigator.appVersion + "<br>");
document.write("userAgent : " + navigator.userAgent + "<br>");
document.write("platform : " + navigator.platform + "<br>");
if(navigator.userAgent.indexOf("MSIE 8.0") > 0 ){
	 document.write("IE8");
}
else if(navigator.userAgent.indexOf("MSIE 7.0") > 0 ){
	 document.write("IE7");
}
else if(navigator.userAgent.indexOf("MSIE 6.0") > 0 ){
	 document.write("IE6");
}
else if(navigator.userAgent.indexOf("Firefox") > 0 ){
	 document.write("Firefox");
}
else if(navigator.userAgent.indexOf("Safari") > 0 ){
	 document.write("Safari");
}
else if(navigator.userAgent.indexOf("Chrome") > 0 ){
	 document.write("Chrome");
}*/

function GameStart() {
	//게입접속중인지 체크
	var userid = document.getElementById("session_id").value;

    if( userid == "" || userid == "null"){
    	alert("로그인을 하셔야 합니다.");
        return;
    }
    if( userid != "null"){
    	if(navigator.userAgent.indexOf("MSIE 10.0") < 0 
    	 && navigator.userAgent.indexOf("MSIE 6.0") > 0){
    		alert("Internet Explorer 9.0이하는 지원하지 않습니다.");
    	}
    	else{
    		// 객체생성후 데이터 할당 
    		var modalvalue = new Object(); 
    		modalvalue.key1 = userid; 
    		  
    		var gamepop = window.open("http://127.0.0.1:3000/index/"+userid, "webTCG", "width=1024, height=768, resizable=no, scrollbars=no");
    		gamepop.focus();
    	}
    }

    /*$.ajax({
        type: "GET",
        url: "/GameJoinChk.aspx?userid=" + userid,
        dataType: "html",
        success: function(msg) {
            var retVal = msg;
            if (retVal == "False") {
                var lbl_busy = $("#lbl_busy");

                if (lbl_busy.html() == null) {
                    lbl_busy = $("#ctl00_lbl_busy");  //마스터페이지
                }
                if (lbl_busy.html() == "2") {
                    alert("현재선택된 채널은 포화상태입니다.\n다른채널을 이용해주세요.");
                    return;
                }
                var GameServer = $('#GameServer').val();    //선택된 채널
                var gamepop = window.open("/GameStart.aspx?GameServer=" + GameServer, "SwordGirls", "width=780, height=560, resizable=yes, scrollbars=no");
                gamepop.focus();
            } else {
                if(confirm("현재 게임에 접속중입니다.\n실행하시겠습니까?")){
                    var lbl_busy = $("#lbl_busy");

                    if (lbl_busy.html() == null) {
                        lbl_busy = $("#ctl00_lbl_busy");  //마스터페이지
                    }
                    if (lbl_busy.html() == "2") {
                        alert("현재선택된 채널은 포화상태입니다.\n다른채널을 이용해주세요.");
                        return;
                    }
                    var GameServer = $('#GameServer').val();    //선택된 채널
                    var gamepop = window.open("/GameStart.aspx?GameServer=" + GameServer, "SwordGirls", "width=780, height=560, resizable=yes, scrollbars=no");
                    gamepop.focus();
                }
            }
        }
    });*/

    return;
}