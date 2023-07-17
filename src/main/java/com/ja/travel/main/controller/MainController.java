package com.ja.travel.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.travel.dto.MessageDto;
import com.ja.travel.dto.UserCouponDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.main.service.MainService;
import com.ja.travel.plan.service.PlanService;

@Controller
public class MainController {
	
	@Autowired
	private PlanService planService;
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping("/main")
	public String mainPage() {
		
		return "main/mainPage";
	}
	
	@RequestMapping("/myPage")
	public String myPage(Model model, HttpSession session) {
		
		return "main/myPage";
	}
	
	@RequestMapping("/main/readRestrictPage")
	public String readRestrictPage(Model model, int id) {
		
		
		
		return "main/readRestrictPage";
	}
	
	@RequestMapping("/allCouponPage")
	public String allCouponPage(HttpSession session, Model model) {
		
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();
		
		
	    List<UserCouponDto> userCouponList = mainService.getUserCoupon(userId);
	    
		
		return "main/allCouponPage";
	}
	
	@RequestMapping("/registerCoupon")
	public String registerCoupon(HttpSession session ,int id) {
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();
		mainService.getCoupon(id, userId);
		
		return "redirect:../travel/allCouponPage";
	}
	
	@RequestMapping("/messageGot")
	public String messageGot(HttpSession session, Model model) {
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();
		List<Map<String, Object>> list = mainService.getMessageGotById(userId);
		
		model.addAttribute("list", list);
		
		return "main/messageGot";
	}
	
	@RequestMapping("/messageWrote")
	public String messageWrote(HttpSession session, Model model) {

		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();
		List<MessageDto> messageList = mainService.getMessageWroteById(userId);
		model.addAttribute("messageList", messageList);
		
		return "main/messageWrote";
	}
	
	@RequestMapping("/writeMessage")
	public String writeMessage() {
		
		return "main/writeMessage";
	}
	
	@RequestMapping("/sendMessageProcess")
	public String sendMessageProcess(HttpSession session, MessageDto params) {
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		params.setUser_id(sessionuser.getUser_id());
		String result = mainService.sendMassage(params);
				
		return result;
	}
	
	@RequestMapping("/readMessageGot")
	public String readMessageGot(Model model, int id) {
		
		MessageDto messageDto = mainService.getMessageGotByMessageId(id);
		
		model.addAttribute("messageDto", messageDto);
		
		return "main/readMessageGot";
	}

	@RequestMapping("/readMessageWrote")
	public String readMessageWrote(Model model, int id) {
		
		MessageDto messageDto = mainService.getMessageWroteByMessageId(id);
		
		model.addAttribute("messageDto", messageDto);
		
		return "main/readMessageWrote";
	}	
	
	@RequestMapping("/package")
	public String packagePage() {
		
		return "main/package";
	}
}
