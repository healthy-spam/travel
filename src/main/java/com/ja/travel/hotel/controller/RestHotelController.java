package com.ja.travel.hotel.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.HotelReservationDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.hotel.service.HotelService;

@RestController
@RequestMapping("/hotel/*")
public class RestHotelController {
	
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping("getHotel")
	public Map<String, Object> getHotel(int hotel_id) {
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> hotel =  hotelService.searchHotel(hotel_id);
		
		map.put("hotel", hotel);
		
		return map;
	}
	
	@RequestMapping("insertReservationInfo")
	public Map<String, Object> insertReservationInfo(HttpSession session, HotelReservationDto hotelReservationDto) {
		
		Map<String, Object> map = new HashMap<>();
		
		UserDto sessionUser = (UserDto)session.getAttribute("sessionuser");
		
		hotelReservationDto.setUser_id(sessionUser.getUser_id()); 
		
		hotelService.insertReservationOfHotel(hotelReservationDto);
		
		map.put("result", "success");
		
		return map;
	}

}
