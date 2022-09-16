package com.board.service;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class TestServiceImpl implements TestSerive {

	// 핵심 기능
	@Override
	public void helloAop(Integer a, Integer b) {
		log.info("******************** hello AOP Service method ********************");
		
	}
	
	
	
}
