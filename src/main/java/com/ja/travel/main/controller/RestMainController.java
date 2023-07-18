package com.ja.travel.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ja.travel.dto.UserDto;

@RestController
public class RestMainController {
	
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
	
	
	
	
}
