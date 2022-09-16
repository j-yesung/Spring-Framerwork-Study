<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link href="/resources/member/style.css" rel="stylesheet" type="text/css" />
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<br />
	<h1 align="center">회원탈퇴</h1>
	<form id="form1" action="/member/delete" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<table>
			<tr>
				<td>
					탈퇴를 원하시면 비밀번호를 입력하세요 <br />
					<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="탈퇴" id="delete" />
					<input type="button" value="취소" onclick="window.location='/member/mypage'" />
				</td>
			</tr>
		</table>
	</form>

	<script>
		$(document).ready(function() {
			$("#delete").click(function() {
				if (!confirm("정말 탈퇴할거니?")) {
					window.location.reload(true); // 현재 페이지 새로고침
				} else {
					document.form1.action = "/member/delete";
					document.form1.submit();
				}
			});
		});
	</script>
</body>
</html>