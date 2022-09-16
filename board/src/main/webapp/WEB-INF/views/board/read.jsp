<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<%@ include file="../includes/header.jsp"%>
	<style>
	.reply_container {
		margin: 0.5rem auto;
		display: flex;
		flex-direction: column;
	}
	
	.reply_li {
		margin: 1rem 0;
		display: flex;
		flex-direction: column;
		width: 100%;
	}
	
	.replyer_reg_ctn {
		margin: 0.4rem 0;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		width: 100%;
	}
	
	.reply_div {
		font-size: 1rem;
		width: 100%;
	}
	
	.replyer_div {
		font-weight: bold;
		font-size: 0.9rem;
	}
	
	.replyReg_div {
		font-size: 0.7rem;
	}
	
	.reply_inputbox {
		display: flex;
		flex-direction: column;
		font-size: 0.7rem;
		width: 100%;
	}
	
	.rbox_div {
		margin: 0.2rem 0;
		width: 100%;
	}
	</style>
	
	<h1 class="h3 mb-2 text-gray-800">Board Read</h1>
	<br />
	
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">Board Read Page</h6>
		</div>
		<div class="card-body">
			<div class="mr-3 ml-3 mb-4">
				<div class="form-group row">
					<label>번호</label>
					<input type="text" class="form-control" name="bno" value="${board.bno}" readonly="readonly" />
				</div>
				<div class="form-group row">
					<label>제목</label>
					<input type="text" class="form-control" name="title" value="${board.title}" readonly="readonly" />
				</div>
				<div class="form-group row">
					<label>내용</label>
					<textarea class="form-control" rows="3" name="content" readonly="readonly">${board.content}</textarea>
				</div>
				<div class="form-group row">
					<label>작성자</label>
					<input type="text" class="form-control" name="writer" value="${board.writer}" readonly="readonly" />
				</div>
			</div>
			<div class="mr-1 ml-1">
				<!-- 시큐리티에서 principal 정보 pInfo 변수에 담기 -->
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pInfo" />
					<c:if test="${pInfo.username == board.writer}">
						<!-- "==" 은 eq 로 대체 가능 -->
						<button class="btn btn-warning" data-service="modify">수정</button>
					</c:if>
				</sec:authorize>
				<button class="btn btn-info" data-service="list">리스트</button>
			</div>
			<form id="btnForm" action="/board/modify" method="get">
				<input type="hidden" name="bno" value="${board.bno}" id="bno" />
				<input type="hidden" name="pageNum" value="${cri.pageNum}" />
				<input type="hidden" name="listQty" value="${cri.listQty}" />
				<input type="hidden" name="sel" value="${cri.sel}" />
				<input type="hidden" name="keyword" value="${cri.keyword}" />
			</form>
		</div>
	</div>
	<!-- 댓글 -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">댓글</h6>
		</div>
		<div class="card-body">
			<div class="mr-3 ml-3 mb-4">
				<div class="reply_container">
					<div class="reply_li">
						<div class="replyer_reg_ctn">
							<div class="replyer_div">작성자</div>
							<div class="replyReg_div">2022.08.31</div>
						</div>
						<div>
							<div class="reply_div">reply : 댓글내용.......................</div>
						</div>
					</div>
	
					<div class="reply_li">
						<div class="replyer_reg_ctn">
							<div class="replyer_div">작성자</div>
							<div class="replyReg_div">2022.08.31</div>
						</div>
						<div>
							<div class="reply_div">reply : 댓글내용.......................</div>
							<sec:authorize access="isAuthenticated()">
								<button type="button" class="btn btn-warning replyBtn" data-repno="result[i].repno" data-service="modify">수정</button>
								<button id="deleteBtn" type="button" class="btn btn-danger replyBtn" data-repno="result[i].repno" data-service="delete">삭제</button>
							</sec:authorize>
						</div>
					</div>
				</div>
				<!-- 로그인했을때만 댓글 작성 가능하게 -->
				<sec:authorize access="isAuthenticated()">
					<hr />
					<div class="reply_inputbox form-group">
						<div class="rbox_div">
							<textarea id="reply" class="form-control" rows="3" name="reply" placeholder="댓글을 남겨보세요."></textarea>
						</div>
						<div class="rbox_div">
							<input id="replyer" type="text" class="form-control" name="replyer" value='<sec:authentication property="principal.username" />' readonly="readonly" />
						</div>
						<div class="rbox_div">
							<button id="saveReplyBtn" type="button" class="btn btn-warning">등록</button>
						</div>
					</div>
				</sec:authorize>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			let bnoVal = "${board.bno}";
			showReplyList(); // 댓글 목록 가져와 뿌리기 호출
	
			// 댓글 목록 가져와 뿌려주기 함수 (페이징처리 X)
			function showReplyList() {
				console.log("show reply list 호출!!");
				// 전체 댓글 가져오기 요청
				$.ajax({
				type : "GET",
				url : "/reply/list/" + bnoVal + ".json",
				data : {
					bno : bnoVal
				},
				success : function(result) {
					console.log("요청 성공............ 기무티");
					console.log(result);
					makeList(result);
				},
				error : function(e) {
					console.log("요청 실패...........야모치");
					console.log(e);
				}
				});
			}
	
			let replyContainer = $(".reply_container"); // 댓글목록 담을 컨테이너div의 클래스
			let username = "${pInfo.username}"; // sec:authenticated로 저장한 로그인한사람 정보 js로 가져오기
	
			// 댓글목록 만들어서 화면에 부착 함수
			function makeList(result) {
				console.log("makelist length!! " + result.length);
	
				// 댓글이 없을 경우
				if (result == null || result.length == 0) {
					// 댓글목록에 아래와 같이 태그 부착하고 
					replyContainer.html("<div class='reply_li'>댓글이 없습니다.</div>");
					return; // makeList 함수 강제종료
				}
				// 부착할 html 목록 문자열로 만들기
				let str = "";
	
				for (let i = 0; i < result.length; i++) {
					str += "<div class='reply_li'><div class='replyer_reg_ctn'>";
					str += "<div class='replyer_div'>" + result[i].replyer + "</div>";
					str += "<div class='replyReg_div'>" + timeFormat(result[i].reg) + "</div></div>";
					str += "<div><div class='reply_div'>" + result[i].reply + "</div>";
	
					// 로그인된 상황에서 보여줘야하고 댓글단사람이 로그인한 아이디와 같으면 버튼 보여줘야함!
					str += "<sec:authorize access='isAuthenticated()'>";
					// 댓글작성자가 로그인한 사람과 동일하면 ~
					if (username == result[i].replyer) {
						str += "<button class='btn btn-warning replyBtn' data-repno='" + result[i].repno + "' data-service='modify' >수정</button>";
						str += "<button class='btn btn-danger replyBtn' data-repno='" + result[i].repno + "' data-service='deleteReply' data-replyer='"+result[i].replyer+"'/>삭제</button>";
					}
					str += "</sec:authorize></div></div>";
	
				}
				replyContainer.html(str); // html부착이라는데 이게 무슨 의미인지 찾아보자
			}
	
			// 시간포맷
			function timeFormat(regVal) {
				let today = new Date();
				let diff = today.getTime() - regVal;
				let dateObj = new Date(regVal);
	
				if (diff < (1000 * 60 * 60 * 24)) { // 24h 보다 작으면 
					let hh = dateObj.getHours();
					let mi = dateObj.getMinutes();
					let ss = dateObj.getSeconds();
	
					return (hh > 9 ? "" : "0") + hh + ":" + (mi > 9 ? "" : "0") + mi + ":" + (ss > 9 ? "" : "0") + ss;
				} else {
					let yy = dateObj.getFullYear();
					let mm = dateObj.getMonth() + 1;
					let dd = dateObj.getDate();
	
					return yy + "/" + (mm > 9 ? "" : "0") + mm + "/" + (dd > 9 ? "" : "0") + dd;
				}
			}
	
			// csrf 정보 meta 태그에서 가져오기
			let token = $("meta[name='_csrf']").attr("content");
			let header = $("meta[name='_csrf_header']").attr("content");
			// xhr : XMLHttpRequest : 서버와 상호작용하기 위한 객체 
	
			$("#saveReplyBtn").on("click", function(e) { // 댓글 저장버튼 이벤트 등록
				// 보낼 데이터 js객체로 만들기
				let replyVal = $("#reply").val();
				let replyerVal = $("#replyer").val();
	
				//보낼 데이터 JS 객체로 만들고 
				let reqData = {
				reply : replyVal,
				replyer : replyerVal,
				bno : bnoVal
				};
				console.log(reqData);
	
				$.ajax({
				type : "POST",
				url : "/reply/add",
				data : JSON.stringify(reqData),
				contentType : "application/json;charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result) {
					console.log("요청 성공!!");
					console.log(result);
					showReplyList();
					// 등록 후 인풋란에 내용 없애기 
					$("#reply").val("");
				},
				error : function(e) {
					console.log("요청 에러..");
					console.log(e);
				}
				}); // ajax통신 끝
			}); // saveReplyBtn click
	
			// 댓글 수정/삭제 버튼 이벤트 등록
			// 동적으로 생성된 버튼요소에는 직접적으로 이벤트 등록이 안돼서
			// html 문서가 미리 만들어져 있는 부모 태그 즉 reply_container에
			// 이벤트 우회해서 걸기!!!!
			$(".reply_container").on("click", "button.replyBtn", function() {
				let service = $(this).data("service");
	
				if (service == 'modify') {
					// 수정가능한 폼으로 html 변경 후 reply_li 내용물 입력가능하게 변경
					let reply_li = $(this).parent().parent();
					console.log(reply_li);
					// 수정폼으로 태그 변경
					// html 부착 코드 참고해서 해보면 됨!
	
				} else if (service == 'deleteReply') {
					// ajax로 삭제 요청
					let repno = $(this).data("repno");
					let replyerVal = $(this).data("replyer");
					let reqData = {
						repno : repno
					};
	
					$.ajax({
					type : "POST",
					url : "/reply/deleteReply",
					data : JSON.stringify(reqData),
					contentType : "application/json;charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success : function(result) {
						//alert("삭제했음");
						$("#deleteBtn").click(function() {
							if (!confirm("삭제할거임?")) {
								window.location.reload(true);
							} else {
								history.go(-1);
	
							}
						});
						console.log(result);
						showReplyList();
					},
					error : function(e) {
						console.log("요청 에러..");
						console.log(e);
					}
					});
				}
			})
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			let btnForm = $("#btnForm");
			$("button[data-service='modify']").on("click", function() {
				btnForm.attr("action", "/board/modify").submit();
			});
			$("button[data-service='list']").on("click", function() {
				// bno 히든 태그 삭제
				btnForm.find("#bno").remove();
				// action 속성값 list로 변경
				btnForm.attr("action", "/board/list");
				btnForm.submit();
			});
		});
	</script>
	
	<%@ include file="../includes/footer.jsp"%>
