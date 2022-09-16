package com.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.Criteria;
import com.board.domain.ReplyVO;
import com.board.service.ReplyService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/reply/*")
@Log4j
public class ReplyController {

	@Autowired
	private ReplyService service;

	// 댓글 추가 요청 매핑
	@PostMapping(value = "add", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> add(@RequestBody ReplyVO vo) {
		log.info("**************** vo : " + vo);
		int result = service.add(vo);

		return result == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("fail...", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 댓글 목록 요청 매핑
	@GetMapping(value = "list/{bno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno) {
		log.info("**************** bno : " + bno);
		List<ReplyVO> list = service.getList(bno);

		return new ResponseEntity<List<ReplyVO>>(list, HttpStatus.OK);
	}

	// 댓글 삭제 요청 매핑
	//@PreAuthorize("principal.username == #vo.replyer") // id 와 작성자가 동일한지 확인
	@PostMapping(value = "deleteReply", consumes = "application/json")
	public String deleteReply(@RequestBody ReplyVO vo, Criteria cri, RedirectAttributes rttr) {
		if (service.deleteReply(vo.getRepno())) {
			log.info("********** 댓글 삭제 요청!!**********");
			rttr.addFlashAttribute("result", "success");
		}
		// 제자리로 돌아가려고 쿼리 스트링 시전
		return "redirect:/board/read" + cri.getListLink();
	}

}
