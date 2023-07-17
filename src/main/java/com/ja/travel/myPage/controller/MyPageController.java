package com.ja.travel.myPage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyPageController {

	@RequestMapping("/myPage")
	public String myPage(Model model, HttpSession session) {

		return "my/myPage";
	}

}