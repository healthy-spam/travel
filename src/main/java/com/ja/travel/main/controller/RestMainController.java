package com.ja.travel.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ja.travel.dto.CouponDto;
import com.ja.travel.dto.MemberRestrictDto;
import com.ja.travel.dto.MessageDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.main.service.MainService;

@RestController
public class RestMainController {
	
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping("/getMyId")
	public Map<String, Object> getMyId(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		
		if(sessionuser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인되어있지않습니다.");
		}else {
			map.put("result", "success");
			map.put("userId", sessionuser.getUser_id());
		}
		return map;
	}
	
	
	@RequestMapping("/getCouponList")
	public Map<String, Object> getCouponList() {
		
		Map<String, Object> map = new HashMap<>();
		List<CouponDto> couponList = mainService.getCouponList();
		map.put("couponList", couponList);
		map.put("result", "success");
		
		
		return map;
	}
	
	//쿠폰받기버튼 눌러서 쿠폰받기
	@RequestMapping("/getCoupon")
	public Map<String, Object> getCoupon(HttpSession session, @RequestParam("couponId") Integer couponId) {
		
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionUser.getUser_id();
		System.out.println(userId);
		mainService.insertUserCoupon2(couponId, userId);
		
		map.put("result", "success");
		
		
		return map;
	}
	
	@RequestMapping("/hasCoupon")
	public Map<String, Object> hasCoupon(HttpSession session, @RequestParam("couponId") Integer couponId) {
		
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionUser.getUser_id();
		
		map.put("hasCoupon", mainService.hasCoupon(userId, couponId));
		map.put("isExpired", mainService.isExpired(couponId));
		map.put("isExhausted", mainService.isExhausted(couponId));
		return map;
	}
	
	@RequestMapping("/reloadMessageGet")
	public Map<String, Object> reloadMessageGet(HttpSession session){
		Map<String, Object> map = new HashMap<>();
		
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionUser.getUser_id();
		
		List<Map<String, Object>> messageGetList = mainService.getMessageGotById(userId);
		
		map.put("result", "success");
		map.put("messageGetList", messageGetList);
		return map;
	}
	
	@RequestMapping("/reloadMessageSend")
	public Map<String, Object> reloadMessageSend(HttpSession session){
		Map<String, Object> map = new HashMap<>();
		
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionUser.getUser_id();
		
		List<MessageDto> messageSendList = mainService.getMessageSendById(userId);
		
		map.put("result", "success");
		map.put("messageSendList", messageSendList);
		return map;
	}
}
