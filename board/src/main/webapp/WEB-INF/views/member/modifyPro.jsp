<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 Pro</title>
</head>
<body>
	<c:if test="${result == 1}">
		<script>
			alert("회원정보 수정 완료");
			window.location = '/member/mypage';
		</script>
	</c:if>
	<c:if test="${result != 1}">
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>