package com.ja.travel.hotel.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.HotelDto;
import com.ja.travel.dto.HotelReservationDto;
import com.ja.travel.dto.HotelReviewDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.hotel.service.HotelService;

@RequestMapping("/hotel/*")
@Controller
public class HotelController {
	
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping("hotelPage")
	public String hotelPage(Model model) {
		
		List<Map<String, Object>> hotelList = hotelService.selectAllHotelList();
		
		List<Map<String, Object>> hotelCategoryList =  hotelService.selectAllHotelCategoryList();
		
		model.addAttribute("hotelList", hotelList);
		model.addAttribute("hotelCategoryList", hotelCategoryList);
	
		return "hotel/hotelPage";
	}
	
	@RequestMapping("hotelRegisterPage")
	public String hotelRegisterPage(Model model) {
		
		List<Map<String, Object>> hotelCategoryList =  hotelService.selectAllHotelCategoryList();
	
		model.addAttribute("hotelCategoryList", hotelCategoryList);
		
		return "hotel/hotelRegisterPage";
	}
	
	@RequestMapping("hotelRegisterProcess")
	public String hotelRegisterProcess(HotelDto hotelDto, HttpSession session, MultipartFile mainImage, MultipartFile[] detailImages) {
		
		System.out.println(hotelDto + "숙소등록과정");
		
		hotelService.insertHotel(hotelDto, session, mainImage);
		
		hotelService.insertHotelDetailImages(detailImages);
		
		return "redirect:./hotelPage";
	}
	
	@RequestMapping("hotelDetailPage")
	public String hotelDetailPage(int hotel_id, Model model) {
		
		Map<String, Object> hotelMap = hotelService.searchHotel(hotel_id);
		
		List<Map<String, Object>> hotelImageDetailsDtoList = hotelService.searchHotelImageDetails(hotel_id);
		
		List<Map<String, Object>> hotelReviewDtoList = hotelService.serachHotelReview(hotel_id);
		
		Integer hotelAvgReviewPoint = hotelService.searchCountReviewPoint(hotel_id);
		
		Integer hotelReviewPoint = hotelService.searchCountReview(hotel_id);
		
		model.addAttribute("hotelMap", hotelMap);
		model.addAttribute("hotelImageDetailsDtoList", hotelImageDetailsDtoList);
		model.addAttribute("hotelReviewDtoList", hotelReviewDtoList);
		model.addAttribute("hotelAvgReviewPoint", hotelAvgReviewPoint);
		model.addAttribute("hotelReviewPoint", hotelReviewPoint);
		
		return "hotel/hotelDetailPage";
	}
	
	@RequestMapping("reserveProcess")
	public String reserveProcess(HttpSession session, HotelReservationDto hotelReservationDto) {
		
		UserDto userDto = (UserDto)session.getAttribute("sessionuser");
		
		if (userDto != null) {
			
			int user_id = userDto.getUser_id();
	
			hotelReservationDto.setUser_id(user_id);
			
			hotelService.insertReservationOfHotel(hotelReservationDto);
			
		}
		
		return "redirect:./hotelPage";
	}
	
	@RequestMapping("insertHotelReviewPage")
	public String insertHotelReviewPage(Model model, int hotel_reservation_id) {
		
		model.addAttribute("hotel_reservation_id",hotel_reservation_id);
		
		return "hotel/insertHotelReviewPage";
	}
	
	@RequestMapping("insertReviewProcess")
	public String insertReviewProcess(HotelReviewDto hotelReviewDto) {
		
		hotelService.insertReviewByUser(hotelReviewDto);
		
		return "redirect:../myPage";
	}
	
	
}
