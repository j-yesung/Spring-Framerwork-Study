package com.board.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TestSeriveTests {

	@Autowired
	private TestSerive service;

	@Test
	/*
	public void testClass() {
		log.info(service);
		log.info(service.getClass().getName());

	}*/
	
	public void testAbc() {
		log.info("=================== test abc ===================");
		service.helloAop(10, 20);
		
	}
}
