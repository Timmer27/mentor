<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹소켓 테스트 페이지</title>
<script type="text/javascript">

</script>
</head>
<body>
    <input id="inputMsgBox" style="width: 250px;" type="text" onkeypress="inputMsgBox_onkeypress()">
    <input id="sendButton" value="Send" type="button" onclick="sendButton_onclick()">
    <input id="disconnectButton" value="Disconnect" type="button" onclick="disconnectButton_onclick()">
    <br/>
    <textarea id="chatBoxArea" style="width: 100%;" rows="10" cols="50" readonly="readonly"></textarea>
    <script src="/js/socketTest.js"></script>
</body>
</html>