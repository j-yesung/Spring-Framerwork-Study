<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UploadForm</title>
</head>
<body>
	<h1>파일 업로드</h1>
	<form action="/upload/uploadPro" method="post" enctype="multipart/form-data">
		입력 :
		<input type="text" name="msg" /><br />
		업로드 :
		<input type="file" name="img" /><br />
		<input type="submit" name="전송" /><br />
	</form>
</body>
</html>