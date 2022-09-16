<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<%@ include file="../includes/header.jsp"%>
	
	<h1 class="h3 mb-2 text-gray-800">Board Write</h1>
	<br />	
	
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">Board Write Page</h6>
		</div>
		<div class="card-body">
			<form action="/board/write" method="post">
				<div class="mr-3 ml-3 mb-4">
					<div class="form-group row">
						<label>제목</label>
						<input type="text" class="form-control" name="title" />
					</div>
					<div class="form-group row">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content"></textarea>
					</div>
					<div class="form-group row">
						<label>작성자</label>
						<input type="text" class="form-control" name="writer" />
					</div>
				</div>
				<div class="mr-1 ml-1">
					<button type="submit" class="btn btn-success">등록</button>
					<button type="reset" class="btn btn-secondary">재작성</button>
					<button type="button" class="btn btn-info" onclick="location.href='/board/list'">리스트</button>
				</div>
			</form>
		</div>
	</div>
	
	<%@ include file="../includes/footer.jsp"%>

