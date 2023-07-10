package com.ja.travel.myPage.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ja.travel.dto.UserDto;
import com.ja.travel.hotel.service.HotelService;


@Controller
public class MyPageController {
	
	@Autowired
	private HotelService hotelService;
	
	/*
	 * @RequestMapping("/myPage") public String myPage(Model model, HttpSession
	 * session) {
	 * 
	 * UserDto userDto = (UserDto)session.getAttribute("sessionuser");
	 * 
	 * if (userDto != null) {
	 * 
	 * int user_id = userDto.getUser_id();
	 * 
	 * List<Map<String, Object>> hotelDtoList =
	 * hotelService.selectHotelReservationListByUser(user_id);
	 * 
	 * model.addAttribute("hotelDtoList", hotelDtoList);
	 * 
	 * 
	 * }
	 * 
	 * return "myMy/myPage"; }
	 */
}
