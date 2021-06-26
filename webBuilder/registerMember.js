// 회원가입 마스터카드 list Display
function dispList(selectList) { 
	var obj1 = document.getElementById("masterDisplay1"); // 가르드 마스터
	var obj2 = document.getElementById("masterDisplay2"); // 이노스트 마스터
	var obj3 = document.getElementById("masterDisplay3"); // 홈버 마스터

	if(selectList == "가르드" ){ 	      // 가르드 마스터 list
		obj1.style.display = "block"; 
		obj2.style.display = "none"; 
		obj3.style.display = "none"; 
	}
	else if(selectList == "이노스트" ) {   // 이노스트 마스터 list
		obj1.style.display = "none"; 
		obj2.style.display = "block"; 
		obj3.style.display = "none"; 
	}
	else if(selectList == "홈버" ) {       // 홈버 마스터 list
		obj1.style.display = "none"; 
		obj2.style.display = "none"; 
		obj3.style.display = "block"; 
	}
} 

// 회원가입 최종 예외 처리
function doSubmit(){
	form = document.registerForm;
	
	if(!form.userid.value){
		alert('아이디를 입력하지 않았습니다.');
		form.userid.focus();
		return;
	}
	if(!form.userid_check.value){
		alert('아이디 중복체크를 하지 않았습니다.');
		MM_openBrWindow('./userid_check.jsp','userid_check','width=300,height=200');
		return;
	}
	if(!CheckID()){
		return;
	}
	if(!CheckPassword()){
		return;
	}
	if(!form.password.value){
		alert('비밀번호를 입력하지 않았습니다.');
		form.password.focus();
		return;
	}
	if(form.password.value != form.password2.value){
		alert('비밀번호가 일치하지 않았습니다.');
		form.password.value = "";
		form.password2.value = "";
		form.password.focus();
		return;
	}
	if(form.userid.value == form.password.value){
		alert("아이디와 비밀번호를 서로 다르게 입력하세요!");
		form.password.value = "";
		form.password2.value = "";
		form.password.focus();
		return;
	}
	if(!form.email.value){
		alert('Email을 입력하지 않았습니다.');
		form.email.focus();
		return;
	}
	if(form.email.value.indexOf("@") < 0){
		alert('Email 주소 형식이 틀립니다.');
		form.email.focus();
		return;
	}
	if(form.email.value.indexOf(".") < 0){
		alert('Email 도메인 주소가 틀립니다.');
		form.email.focus();
		return;
	}
	form.submit();
}

// 아이디 체크
function CheckID() {
    var userid = document.getElementById("userid").value;

    var lenByte = 0;
    for (var i = 0; i < userid.length; i++) {
        var c = userid.charCodeAt(i);
        if (c < 0xac00 || 0xd7a3 < c) lenByte++;
        else lenByte += 2;
    }
    if (lenByte < 5 || lenByte > 10) {
        alert("아이디는 5~10자의 영문,숫자만 가능합니다.");
        return false;
    }
    var len = userid.length;
    for (i = 0; i < len; i++) {
        var checkid = userid.charAt(i);
        if ((checkid >= 'a' && checkid <='z') || (checkid >= 'A' && checkid <= 'Z') || (checkid >= '0' && checkid <= '9')) {
        	;
        }
        else {
            alert("아이디는 5~10자의 영문,숫자만 가능합니다.");
            return false;
        }
    }
    return true;
}
// 패스워드 체크
function CheckPassword() {
    var password = form.password.value;

    var lenByte = 0;
    for (var i = 0; i < password.length; i++) {
        var c = password.charCodeAt(i);
        if (c < 0xac00 || 0xd7a3 < c) lenByte++;
        else lenByte += 2;
    }
    if (lenByte < 4 || lenByte > 10) {
        alert("패스워드는 4~10자 이어야 가능합니다.");
        return false;
    }
    return true;
}

// 아이디 체크 팝업창
function MM_openBrWindow(theURL, winName, features){
	var userid = document.getElementById("userid").value;
	if(winName == "userid_check"){
		if(!CheckID()){              // 아디체크 
			return;
		}
		theURL = theURL+"?userid="+userid;
	}
	window.open(theURL, winName, features);
}

function checkEnd(){
	var form = document.id_check;
	
	if(!CheckID()){
		return;
	}

	opener.registerForm.userid.value = id_check.userid.value;
	opener.registerForm.userid_check.value = form.existCheck.value;
	
	opener.registerForm.userid.readOnly=true;
	self.close();
}

function doCheck(){
	var form = document.id_check;
	
	if(!CheckID()){
		return;
	}
	form.submit();
}

// 메인으로 버튼 클릭시
function goMainPage() {
	location.href="./index.jsp";
}
