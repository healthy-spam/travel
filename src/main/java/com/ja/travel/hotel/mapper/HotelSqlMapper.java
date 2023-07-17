package com.ja.travel.hotel.mapper;

import java.util.List;

import com.ja.travel.dto.HotelCategoryDto;
import com.ja.travel.dto.HotelDto;
import com.ja.travel.dto.HotelFacilityDto;
import com.ja.travel.dto.HotelImageDetailsDto;
import com.ja.travel.dto.HotelReservationDto;
import com.ja.travel.dto.HotelReviewDto;

public interface HotelSqlMapper {
	
//	숙소 PK 최댓값 호출
	public int selectMaxHotelId();
	
//	숙소 상세 이미지 삽입
	public void insertHotelDetailImageByUser(HotelImageDetailsDto hotelImageDetailsDto);

//	숙소 정보 삽입
	public void insertHotelByUser(HotelDto hotelDto);

//	숙소 카테고리 리스트 출력
	public List<HotelCategoryDto> selectAllHotelCategoryList();

//	숙소 리스트 출력
	public List<HotelDto> selectAllHotelList();

//	숙소 PK로 숙소 상세 이미지 출력 
	public List<HotelImageDetailsDto> selectAllHotelImageDetailsByHotelId(int hotel_id);
	
//	숙소 PK로 숙소 정보 출력
	public HotelDto selectHotelByHotelId(int hotel_id);

//	숙소 예약정보 삽입
	public void insertHotelReservationByUser(HotelReservationDto hotelReservationDto);
	
//	유저 PK로 숙소 정보 출력
	public List<HotelDto> selectHotelByUser(int user_id);
	
//	유저 PK로 숙소 예약 정보 출력
	public List<HotelReservationDto> selectHotelReservationByUser(int user_id);

//	숙소 리뷰 삽입
	public void insertReviewByUser(HotelReviewDto hotelReviewDto);

//	숙소 PK로 숙소 예약 리스트 출력
	public List<HotelReservationDto> selectHotelReservationByHotelId(int hotel_id);

//	숙소 예약 PK로 숙소 리뷰 리스트 출력
	public List<HotelReviewDto> selectHotelReviewByHotelReservationId(int hotel_reservation_id);
	
//	숙소 PK로 리뷰 평균 점수 호출
	public Integer searchCountReviewPoint(int hotel_id);
	
//	숙소 PK로 리뷰 갯수 호출
	public Integer searchCountReview(int hotel_id);

	public HotelReviewDto selectReviewByHotelReservationId(int hotel_reservation_id);
	
	public HotelCategoryDto selectHotelCategoryById(int hotel_category_id);
	
	public void insertHotelFacility(HotelFacilityDto hotelFacilityDto);
}
