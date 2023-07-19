package com.ja.travel.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.UserDto;
import com.ja.travel.login.service.LoginService;

@RestController
public class RestMainController {
	
	@Autowired
	private LoginService loginService;
	
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
	
	@RequestMapping("/insertImage")
	public void insertImage(MultipartFile file, HttpSession session) {
		UserDto user = (UserDto) session.getAttribute("sessionuser");
		loginService.updateProfile(user, file);
	}
}
