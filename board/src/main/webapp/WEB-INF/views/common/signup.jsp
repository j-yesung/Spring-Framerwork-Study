<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="/resources/member/style.css" rel="stylesheet" type="text/css" />
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<br />
	<h1 align="center">회원가입</h1>
	<form action="/common/signup" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<table>
			<tr>
				<td>권한 *</td>
				<td>
					<input type="radio" name="au" value="member" checked="checked" /> 일반회원
					<input type="radio" name="au" value="admin" /> 관리자
				</td>
			</tr>
			<tr>
				<td>아이디 *</td>
				<td><input type="text" name="id" id="id" /></td>
			</tr>
			<tr>
				<td>아이디 사용가능 여부</td>
				<td><input type="text" id="checkResult" disabled /></td>
			</tr>
			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인 *</td>
				<td><input type="password" name="pwch" /></td>
			</tr>
			<tr>
				<td>이름 *</td>
				<td><input type="text" name="name" /></td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
					<input type="radio" name="gender" value="male" checked />남
					<input type="radio" name="gender" value="female" />여
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="회원가입" />
					<input type="reset" value="재작성" />
					<input type="button" value="취소" onclick="window.location='/common/main'" />
				</td>
			</tr>
		</table>
	</form>

	<script>
		/*
			$(document).ready(function() {
				// id 입력란에 값을 입력했을 때
				$("#id").change(function() {
					// id 입력란에 사용자가 입력한 값이 필요
					let idVal = $("#id").val();
					console.log(idVal);
					// 꺼낸 입력값을 서버에 보내서 DB에 동일한 id가 있는지 확인
					$.ajax({
						type : "post",
						url : "/member/idAvail",
						data : {
							id : idVal
						},
						success : function(result) {
							console.log("success");
							console.log(result);
							// 결과를 아이디 사용가능 여부 input 태그의 value 값으로 띄워 주기
							$("#checkResult").val(result);
						},
						error : function(e) {
							console.log(e);
						}
					});
				});
			});
		 */
	</script>
</body>
</html>