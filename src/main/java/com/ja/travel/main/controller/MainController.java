package com.ja.travel.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.travel.main.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping("/main")
	public String mainPage() {
		
		return "main/mainPage";
	}
	
	@RequestMapping("/myPage")
	public String myPage(Model model, HttpSession session) {
		
		List<Map<String, Object>> list = mainService.getMyList(session);
		
		model.addAttribute("list", list);
		
		return "main/myPage";
	}
	
	@RequestMapping("/main/readRestrictPage")
	public String readRestrictPage(Model model, int id) {
		
		return "main/readRestrictPage";
	}
	

	@RequestMapping("/package")
	public String packagePage() {
		
		return "main/package";
	}
}
