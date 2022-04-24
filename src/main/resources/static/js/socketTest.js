var g_webSocket = null;

//onload로 실행 시 아래 메서드 바로 실행
window.onload = function() {
    //host = "152.70.92.222";   /* 배포시에 호스트 주소로 변경 */
    
    //호스트 변수 정하고
   	host = "localhost";
    //전역변수 socket을 해당 주소로 변경
    g_webSocket = new WebSocket("ws://"+host+":90/websocket");

    /* 웹소켓 접속 성공시 실행 */
    g_webSocket.onopen = function() {
        addLineToChatBox("Server is connected.");
    };
    
    /* 웹소켓 서버로부터 메시지 수신시 실행 */
    g_webSocket.onmessage = function(message) {
        addLineToChatBox(message.data);
    };

    /* 웹소켓 이용자가 연결을 해제하는 경우 실행 */
    g_webSocket.onclose = function() {
        addLineToChatBox("Server is disconnected.");
    };

    /* 웹소켓 에러 발생시 실행 */
    g_webSocket.onerror = function() {
        addLineToChatBox("Error!");
    };
}

/* 채팅 메시지를 화면에 표시 */
function addLineToChatBox(_line) {
    if (_line == null) {
        _line = "";
    }
    
    var chatBoxArea = document.getElementById("chatBoxArea");
    chatBoxArea.value += _line + "\n";
    chatBoxArea.scrollTop = chatBoxArea.scrollHeight;    
}

/* Send 버튼 클릭하면 서버로 메시지 전송 */
function sendButton_onclick() {
    var inputMsgBox = document.getElementById("inputMsgBox");
    if (inputMsgBox == null || inputMsgBox.value == null || inputMsgBox.value.length == 0) {
        return false;
    }
    
    var chatBoxArea = document.getElementById("chatBoxArea");
    
    if (g_webSocket == null || g_webSocket.readyState == 3) {
        chatBoxArea.value += "Server is disconnected.\n";
        return false;
    }
    
    // 서버로 메시지 전송
    g_webSocket.send(inputMsgBox.value);
    //접속하자마자 g_websocket (호스트의 서버소켓주소) 전역변수를 통해 메세지 전송
    //전송하고 inputbox의 value를 초기화
    inputMsgBox.value = "";
    inputMsgBox.focus();
    
    return true;
}

/* Disconnect 버튼 클릭하는 경우 호출 */
function disconnectButton_onclick() {
    if (g_webSocket != null) {
        g_webSocket.close();    
    }
}

/* inputMsgBox 키 입력하는 경우 호출 */
function inputMsgBox_onkeypress() {
    if (event == null) {
        return false;
    }
    
    // 엔터키 누를 경우 서버로 메시지 전송
    var keyCode = event.keyCode || event.which;
    // 크로스 브라우저 이벤트 호환목적 ||
    if (keyCode == 13) {
        sendButton_onclick();
    }
}