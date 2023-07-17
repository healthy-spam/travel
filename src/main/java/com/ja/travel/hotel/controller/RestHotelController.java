package com.ja.travel.hotel.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.HotelDto;
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
	
	@RequestMapping("inserthotelInfo1")
	public Map<String, Object> inserthotelInfo1(HttpSession session, String spanText) {
		
		Map<String, Object> map = new HashMap<>();
		
		HotelDto hotelDto = new HotelDto();
		
		System.out.println(spanText);
		
		hotelDto.setHotel_category(spanText);
		
		System.out.println(hotelDto);
		
		session.setAttribute("hotelDto", hotelDto);
		
		map.put("result", "success");
		
		return map;
	}
	
	@RequestMapping("inserthotelInfo2")
	public Map<String, Object> inserthotelInfo2(HttpSession session, HotelDto hotelDto) {
		
		Map<String, Object> map = new HashMap<>();
		
		HotelDto hotelDto1 =  (HotelDto)session.getAttribute("hotelDto");
		
		hotelDto.setHotel_category(hotelDto1.getHotel_category());
		
		System.out.println(hotelDto);
		
		session.setAttribute("hotelDto", hotelDto);
		
		map.put("result", "success");
		
		return map;
	}
	
	@RequestMapping("inserthotelInfo3")
	public Map<String, Object> inserthotelInfo3(HttpSession session, HotelDto hotelDto) {
		
		Map<String, Object> map = new HashMap<>();
		
		HotelDto hotelDto1 =  (HotelDto)session.getAttribute("hotelDto");
		
		hotelDto.setHotel_category(hotelDto1.getHotel_category());
		
		System.out.println(hotelDto);
		
		session.setAttribute("hotelDto", hotelDto);
		
		map.put("result", "success");
		
		return map;
	}

}
