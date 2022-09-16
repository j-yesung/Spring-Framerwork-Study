package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;
import com.board.domain.PageDTO;
import com.board.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {

	@Autowired
	private BoardService service;

	@GetMapping("list")
	public void list(Model model, Criteria cri) {
		model.addAttribute("list", service.getListWithPaging(cri)); // model로 list.jsp에 게시글 목록 뿌려주기
		int total = service.getTotal(cri); // 게시글 개수 가져오기
		log.info(">>>>>>>>>>>>>>>>>> total : " + total);
		model.addAttribute("pager", new PageDTO(cri, total));
	}

	@GetMapping("read")
	public void read(Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		model.addAttribute("board", service.get(bno));
	}

	@GetMapping("modify")
	@PreAuthorize("isAuthenticated()")
	public void modifyForm(Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		model.addAttribute("board", service.get(bno));
	}

	@PostMapping("modify")
	@PreAuthorize("principal.username == #board.writer") // 작성자와 로그인한 사람이 같은지 확인
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}

	@PostMapping("delete")
	@PreAuthorize("principal.username == #writer") // 작성자와 로그인한 사람이 같은지 확인
	public String delete(Long bno, String writer, Criteria cri, RedirectAttributes rttr) {
		if (service.delete(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}

	// 글쓰기 폼 요청
	@GetMapping("write")
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능하게
	public void write() {

	}

	// 글쓰기 Pro
	@PostMapping("write")
	public String writeBoard(BoardVO board, RedirectAttributes rttr) {
		service.register(board);
		/*
		 * RedirectAttributes : Model 처럼 스프링 MVC가 자동으로 전달해주는 객체 addFlashAttribute(key, value)
		 * : url 뒤에 데이터가 붙지 않고, 일회성 데이터로 페이지를 새로고침하면 데이터 날라감 값 1개만 전달 가능. 2개 이상은 데이터가 소멸하므로 Map 이용해 한 번에 보내야함
		 * addAttrubute(key, value) 위와 같은 메서드를 이용하여 리다이렉트되는 jsp 페이지에 데이터를 전달할 수 있다.
		 */
		rttr.addFlashAttribute("result", board.getBno());
		// 등록 처리후, 글 고유번호 속성으로 추가해서 전달 (modal 실행 / list에서 사용)

		return "redirect:/board/list";
	}
}
