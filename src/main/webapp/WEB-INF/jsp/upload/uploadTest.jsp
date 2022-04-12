<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<!-- enctry의 의미는 텍스트와 파일같은 여러 종류의 파일 존재 -->
<!-- submiu을 통해서 파일을 전송함   -->
<form action="upload" method="post" enctype="multipart/form-data">
작성자 <input type="text" name="author" value="smith"><br>
FILE <input type="file" name="files" multiple="multiple"><br>
FILE <input type="file" name="files" multiple="multiple"><br>
<button type="submit">업로드</button>
</form>

</body>
</html>