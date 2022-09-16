<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="/resources/member/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<br />
	<h1 align="center">메인페이지</h1>

	<sec:authorize access="isAnonymous()">
		<table>
			<tr>
				<td>
					<button type="button" onclick="window.location='/board/list'">게시판</button>
				</td>
				<td>
					<button type="button" onclick="window.location='/upload/logincss'">로그인</button>
				</td>
				<td>
					<button type="button"  onclick="window.location='/common/signup'">회원가입</button>
				</td>
			</tr>
		</table>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<table>
			<tr>
				<td>
					<button type="button" onclick="window.location='/board/list'">게시판</button>
				</td>
				<td>
					<!-- 시큐리티로 로그아웃 : /logout POST 요청, csrf 토근 필수 -->
					<form action="/logout" method="POST">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button>로그아웃</button>
					</form>
				</td>
				<td>
					<button type="button" onclick="window.location='/member/mypage'">마이페이지</button>
				</td>
			</tr>
		</table>
		<br />

		<h2 align="center">사용자 정보 출력</h2>
		<table>
			<tr>
				<td>principal</td>
				<td>
					<sec:authentication property="principal" />
				</td>
			<tr>	
				<td>MemberVO</td>
				<td>
					<sec:authentication property="principal.member" />
				</td>
			</tr>	
			<tr>
				<td>사용자 이름</td>
				<td>
					<sec:authentication property="principal.member.name" />
				</td>
			</tr>	
			<tr>
				<td>사용자 아이디</td>
				<td>
					<sec:authentication property="principal.username" />
				</td>
			</tr>	
			<tr>
				<td>권한 리스트</td>
				<td>
					<sec:authentication property="principal.member.authList" />
				</td>
			</tr>	
		</table>
	</sec:authorize>

	<br />
	<br />
	<div align="center">
		<img src="/resources/member/imgs/sky.jpg" width="800" />
	</div>
	<br />
	<br />
</body>
</html>