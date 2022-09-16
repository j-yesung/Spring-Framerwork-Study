<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="/resources/member/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<br />
	<h1 align="center">마이페이지</h1>
	<table>
		<tr>
			<td>
				<button onclick="window.location='/common/main'">메인으로</button>
			</td>
			<td>
				<button onclick="window.location='/member/delete'">회원탈퇴</button>
			</td>
			<td>
				<button onclick="window.location='/member/modify'">회원정보 수정</button>
			</td>
		</tr>
	</table>
	<br />
	<br />
	<div align="center">
		<img src="/resources/member/imgs/sky.jpg" width="800" />
	</div>
</body>
</html>