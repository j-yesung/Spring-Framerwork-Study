package com.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.member.domain.MemberVO;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("mypage")
	public void mypage() {
		log.info("************* mypage *************");
	}

	@GetMapping("modify")
	public void modify(Authentication auth, Model model) {
		log.info("************* modify *************");
		CustomUser user = (CustomUser) auth.getPrincipal();
		log.info("************* user : " + user);
		
		MemberVO member = service.getMember(user.getUsername()); // == principal.username
		model.addAttribute("member", member);
	}
	
	@PostMapping("modify")
	public String modifyPro(MemberVO member, Authentication auth, Model model) {
		log.info("************* modify Pro *************");
		log.info("************* modify customUser : " + ((CustomUser) auth.getPrincipal()).getUsername());
		member.setId(((CustomUser)auth.getPrincipal()).getUsername());   // auth에서 username == id꺼내 vo 채우기
		int result = service.modifyMember(member);
		log.info("************* modify Pro result : " + result);
		model.addAttribute("result", result);
		
		return "member/modifyPro";
	}
	
	// 회원탈퇴(삭제)
	@GetMapping("delete")
	public void delete() {
		
	}
	
	@PostMapping("delete")
	public String deletePro(MemberVO member, @AuthenticationPrincipal CustomUser customuser, Model model) {
		member.setId(customuser.getUsername());
		int result = service.deleteMember(member);
		model.addAttribute("result", result);
		
		return "member/deletePro";
	}
}
