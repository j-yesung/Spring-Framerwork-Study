<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 Pro</title>
<link href="/resources/member/style.css" rel="stylesheet" type="text/css" />
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form action="/logout" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

	<c:if test="${result == 1}">
		<script>
			$(document).ready(function() {
				let formObj = $("form");
				alert("정상적으로 탈퇴되었습니다.");
				formObj.submit(); // 로그아웃 폼태그 서브밋 실행하여 요청
			});
		</script>
	</c:if>
	<c:if test="${result != 1}">
		<script>
			alert("비밀번호를 잘못 입력하셨습니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>