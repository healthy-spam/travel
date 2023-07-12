package com.ja.travel.hotel.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.HotelCategoryDto;
import com.ja.travel.dto.HotelDto;
import com.ja.travel.dto.HotelFacilityDto;
import com.ja.travel.dto.HotelImageDetailsDto;
import com.ja.travel.dto.HotelReservationDto;
import com.ja.travel.dto.HotelReviewDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.hotel.mapper.HotelSqlMapper;
import com.ja.travel.planPlace.mapper.PlanPlaceSqlMapper;

@Service
public class HotelService {

	@Autowired
	private HotelSqlMapper hotelSqlMapper;

	@Autowired
	private PlanPlaceSqlMapper planPlaceSqlMapper;

//	숙소 정보 삽입
	public void insertHotel(HotelDto hotelDto, HttpSession session, MultipartFile mainImage) {

		if (mainImage != null) {

			String rootFolder = "C:/uploadFiles/mainImage/";

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

			String today = sdf.format(new Date());

			File targetFolder = new File(rootFolder + today);

			if (!targetFolder.exists()) {
				targetFolder.mkdirs();
			}

			String fileName = UUID.randomUUID().toString();

			fileName += "_" + System.currentTimeMillis();

			String originalFileName = mainImage.getOriginalFilename();

			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

			String saveFileName = today + "/" + fileName + ext;

			try {

				mainImage.transferTo(new File(rootFolder + saveFileName));

			} catch (Exception e) {

				e.printStackTrace();
			}

			UserDto userDto = (UserDto) session.getAttribute("sessionuser");

			if (userDto != null) {

				int user_id = userDto.getUser_id();

				hotelDto.setUser_id(user_id);
				hotelDto.setHotel_main_image(saveFileName);

				hotelSqlMapper.insertHotelByUser(hotelDto);
			}

		}

	}

	public void insertHotelDetailImages(MultipartFile[] detailImages) {

		if (detailImages != null) {

			for (MultipartFile multipartFile : detailImages) {

				if (multipartFile.isEmpty()) {
					continue;
				}

				String rootFolder = "C:/uploadFiles/";

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

				String today = sdf.format(new Date());

				File targetFolder = new File(rootFolder + today);

				if (!targetFolder.exists()) {
					targetFolder.mkdirs();
				}

				String fileName = UUID.randomUUID().toString();

				fileName += "_" + System.currentTimeMillis();

				String originalFileName = multipartFile.getOriginalFilename();

				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

				String saveFileName = today + "/" + fileName + ext;

				try {

					multipartFile.transferTo(new File(rootFolder + saveFileName));

				} catch (Exception e) {

					e.printStackTrace();

				}

				int hotel_id = hotelSqlMapper.selectMaxHotelId();

				HotelImageDetailsDto hotelImageDetailsDto = new HotelImageDetailsDto();

				hotelImageDetailsDto.setHotel_id(hotel_id);

				hotelImageDetailsDto.setHotel_image_details_link(saveFileName);

				hotelSqlMapper.insertHotelDetailImageByUser(hotelImageDetailsDto);

			}
		}
	}

//	숙소 카테고리 리스트 출력
	public List<Map<String, Object>> selectAllHotelCategoryList() {

		List<Map<String, Object>> hotelCategorylist = new ArrayList<>();

		List<HotelCategoryDto> hotelCategoryDtoList = hotelSqlMapper.selectAllHotelCategoryList();

		for (HotelCategoryDto hotelCategoryDto : hotelCategoryDtoList) {

			Map<String, Object> map = new HashMap<>();

			map.put("hotelCategoryDto", hotelCategoryDto);

			hotelCategorylist.add(map);

		}

		return hotelCategorylist;
	}

//	모든 숙소 리스트 출력
	/*
	 * public List<Map<String, Object>> selectAllHotelList() {
	 * 
	 * List<Map<String, Object>> hotelList = new ArrayList<>();
	 * 
	 * List<HotelDto> hotelDtoList = hotelSqlMapper.selectAllHotelList();
	 * 
	 * for (HotelDto hotelDto : hotelDtoList) {
	 * 
	 * Map<String, Object> map = new HashMap<>();
	 * 
	 * int user_id = hotelDto.getUser_id();
	 * 
	 * int hotel_id = hotelDto.getHotel_id();
	 * 
	 * int hotel_category_id = hotelDto.getHotel_category_id();
	 * 
	 * Integer hotelReviewPointCount =
	 * hotelSqlMapper.searchCountReviewPoint(hotel_id); Integer hotelReviewCount =
	 * hotelSqlMapper.searchCountReview(hotel_id); UserDto userDto =
	 * planPlaceSqlMapper.selectUserById(user_id); HotelCategoryDto hotelCategoryDto
	 * = hotelSqlMapper.selectHotelCategoryById(hotel_category_id);
	 * 
	 * map.put("userDto", userDto); map.put("hotelDto", hotelDto);
	 * map.put("hotelReviewPointCount", hotelReviewPointCount);
	 * map.put("hotelReviewCount", hotelReviewCount); map.put("hotelCategoryDto",
	 * hotelCategoryDto);
	 * 
	 * hotelList.add(map); }
	 * 
	 * return hotelList;
	 * 
	 * }
	 */
//	PK로 숙소 정보 출력
	public Map<String, Object> searchHotel(int hotel_id) {
		
		Map<String, Object> map =  new HashMap<>();
		
		HotelDto hotelDto = hotelSqlMapper.selectHotelByHotelId(hotel_id);
		
		int user_id = hotelDto.getUser_id();
		
		UserDto userDto = planPlaceSqlMapper.selectUserById(user_id);
		
		map.put("hotelDto", hotelDto);
		map.put("userDto", userDto);
		
		return map;
	}
	
//	PK로 숙소 상세 이미지 출력
	public List<Map<String, Object>> searchHotelImageDetails(int hotel_id) {
		
		List<Map<String, Object>> hotelImageDetailsList =  new ArrayList<>();
		
		List<HotelImageDetailsDto> hotelImageDetailsDtoList= hotelSqlMapper.selectAllHotelImageDetailsByHotelId(hotel_id);
		
		for (HotelImageDetailsDto hotelImageDetailsDto : hotelImageDetailsDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("hotelImageDetailsDto", hotelImageDetailsDto);
			
			hotelImageDetailsList.add(map);
			
		}
		
		return hotelImageDetailsList;
	}

	public void insertReservationOfHotel(HotelReservationDto hotelReservationDto) {
		
		hotelSqlMapper.insertHotelReservationByUser(hotelReservationDto);
		
	}
	
	public List<Map<String, Object>> selectHotelReservationListByUser(int user_id) {
		
		List<Map<String, Object>> hotelList =  new ArrayList<>();
		
		List<HotelReservationDto> hotelReservationDtoList =  hotelSqlMapper.selectHotelReservationByUser(user_id);
		
		for (HotelReservationDto hotelReservationDto : hotelReservationDtoList) {
			
			Map<String, Object> map =  new HashMap<>();
			
			int hotel_id = hotelReservationDto.getHotel_id();
			int hotel_reservation_id = hotelReservationDto.getHotel_reservation_id();
			
			HotelReviewDto hotelReviewDto = hotelSqlMapper.selectReviewByHotelReservationId(hotel_reservation_id);
			HotelDto hotelDto = hotelSqlMapper.selectHotelByHotelId(hotel_id);
			
			map.put("hotelReviewDto", hotelReviewDto);
			map.put("hotelDto", hotelDto);
			map.put("hotelReservationDto", hotelReservationDto);
			
			hotelList.add(map);
	
		}
		
		return hotelList;
	}

	public void insertReviewByUser(HotelReviewDto hotelReviewDto) {
		
		hotelSqlMapper.insertReviewByUser(hotelReviewDto);
		
	}

	public List<Map<String, Object>> serachHotelReview(int hotel_id) {
		
		List<Map<String, Object>> reviewList = new ArrayList<>();
		
		List<HotelReservationDto> hotelReservationDtoList = hotelSqlMapper.selectHotelReservationByHotelId(hotel_id);
		
		for (HotelReservationDto hotelReservationDto : hotelReservationDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int hotel_reservation_id = hotelReservationDto.getHotel_reservation_id();
			
			int user_id = hotelReservationDto.getUser_id();
			
			UserDto userDto = planPlaceSqlMapper.selectAllUserById(user_id);
			
			map.put("userDto", userDto);
			
			List<HotelReviewDto> hotelReivewDtoList =  hotelSqlMapper.selectHotelReviewByHotelReservationId(hotel_reservation_id);
			
			for (HotelReviewDto hotelReviewDto : hotelReivewDtoList) {
				
				map.put("hotelReviewDto", hotelReviewDto);
				
				reviewList.add(map);
			}
		}
		
		return reviewList;
		
	} 
	
	public Integer searchCountReviewPoint(int hotel_id) {
		
		Integer hotelAvgReviewPoint = hotelSqlMapper.searchCountReviewPoint(hotel_id);
		
		return hotelAvgReviewPoint;
	}
	
	public Integer searchCountReview(int hotel_id) {
		
		Integer hotelReviewPoint = hotelSqlMapper.searchCountReview(hotel_id);
		
		return hotelReviewPoint;
	}
	
//	HotelFacility 데이터 삽입
	public void insertHotelFacility(HotelFacilityDto hotelFacilityDto, MultipartFile facilityImage) {
		
		if (facilityImage != null) {

				String rootFolder = "C:/uploadFiles/";

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

				String today = sdf.format(new Date());

				File targetFolder = new File(rootFolder + today);

				if (!targetFolder.exists()) {
					targetFolder.mkdirs();
				}

				String fileName = UUID.randomUUID().toString();

				fileName += "_" + System.currentTimeMillis();

				String originalFileName = facilityImage.getOriginalFilename();

				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

				String saveFileName = today + "/" + fileName + ext;

				try {

					facilityImage.transferTo(new File(rootFolder + saveFileName));

				} catch (Exception e) {

					e.printStackTrace();

				}

				hotelFacilityDto.setHotel_facility_image(saveFileName);
				
				System.out.println(saveFileName + "사진 업로드 완료");

				hotelSqlMapper.insertHotelFacility(hotelFacilityDto);
				
				System.out.println("hotelFacilityDto insert success");

			}
			
		}
		
	}
	
	
