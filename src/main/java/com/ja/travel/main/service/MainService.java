package com.ja.travel.main.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.travel.admin.mapper.AdminSqlMapper;
import com.ja.travel.dto.CouponDto;
import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.GuideReportDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.MessageDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.UserCouponDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.main.mapper.MainSqlMapper;

@Service
public class MainService {
	@Autowired
	private MainSqlMapper mainSqlMapper;


	public Map<String, List<PlanDto>> getPlanList(UserDto userDto) {

		int userId = userDto.getUser_id();
		List<PlanDto> planList = mainSqlMapper.getPlanList(userId);
		GuideDto guideDto = mainSqlMapper.getGuideDtoByUserId(userId);

		if (guideDto == null) {
			return Collections.emptyMap();
		}

		int guideId = guideDto.getGuide_id();
		List<GuideRestrictDto> guideRestrictList = mainSqlMapper.getGuideRestrictDtoByGuideId(guideId);
		List<PlanDto> restrictedPlanList = new ArrayList<>();
		List<PlanDto> unrestrictedPlanList = new ArrayList<>();

		for (GuideRestrictDto guideRestrictDto : guideRestrictList) {

			int guideReportId = guideRestrictDto.getGuide_report_id();
			GuideReportDto guideReportDto = mainSqlMapper.getGuideReportDtoByGuideReportId(guideReportId);
			int guidePlanningId = guideReportDto.getGuide_planning_id();
			GuidePlanningDto guidePlanningDto = mainSqlMapper.getGuidePlanningDtoByGuidePlanningId(guidePlanningId);
			int planId = guidePlanningDto.getPlan_id();
			PlanDto planDto = mainSqlMapper.getPlanDtoByPlanId(planId);
			System.out.println(planDto.getPlan_id());
			restrictedPlanList.add(planDto);

		}

		for (PlanDto planDto : planList) {
			if (restrictedPlanList != null) {
				boolean isRestricted = false;
				for (PlanDto restrictedPlanDto : restrictedPlanList) {
					if (restrictedPlanDto.getPlan_id() == planDto.getPlan_id()) {
						isRestricted = true;
						break;
					}
				}
				if (!isRestricted) {
					unrestrictedPlanList.add(planDto);
				}
			} else {
				unrestrictedPlanList.add(planDto);
				System.out.println(planDto.getPlan_id());
			}
		}

		Map<String, List<PlanDto>> planLists = new HashMap<>();
		planLists.put("restrictedPlanList", restrictedPlanList);
		planLists.put("unrestrictedPlanList", unrestrictedPlanList);

		return planLists;
	}

	public void getCoupon(int id, int userId) {

		mainSqlMapper.decreaseCoupon(id);
		UserCouponDto userCouponDto = new UserCouponDto();
		int user_coupon_id = mainSqlMapper.createUserCouponPk();
		userCouponDto.setUser_coupon_id(user_coupon_id);
		userCouponDto.setCoupon_id(id);
		userCouponDto.setUser_id(userId);
		mainSqlMapper.insertUserCoupon(userCouponDto);

	}

	public List<UserCouponDto> getUserCoupon(int userId) {

		List<UserCouponDto> userCouponList = mainSqlMapper.getUserCouponByUserId(userId);

		return userCouponList;
	}

	public String sendMassage(MessageDto params) {
		String result = "";
		String user_nickname = params.getUser_nickname();
		UserDto userDto = mainSqlMapper.getUserByUserNickName(user_nickname);
		if (userDto == null) {
			result = "main/writeMessageFail";
		} else {
			int messageId = mainSqlMapper.createMessagePk();
			params.setMessage_id(messageId);
			mainSqlMapper.insertMessage(params);
			result = "redirect:./messageWrote";
		}
		return result;

	}

	public List<Map<String, Object>> getMessageGotById(int userId) {
		UserDto userDto = mainSqlMapper.getUserDtoByUserId(userId);
		String user_nickname = userDto.getUser_nickname();
		List<MessageDto> messageList = mainSqlMapper.selectAllMessageGotByNickName(user_nickname);
		List<Map<String, Object>> list = new ArrayList<>();

		for (MessageDto messageDto : messageList) {
			Map<String, Object> map = new HashMap<>();

			userId = messageDto.getUser_id();
			userDto = mainSqlMapper.getUserDtoByUserId(userId);

			map.put("messageDto", messageDto);
			map.put("userDto", userDto);

			list.add(map);
		}
		return list;

	}

	public MessageDto getMessageGotByMessageId(int id) {

		mainSqlMapper.updateReadDate(id);
		MessageDto messageDto = mainSqlMapper.getMessageDtoByMessageId(id);

		return messageDto;
	}

	public List<MessageDto> getMessageWroteById(int userId) {

		List<MessageDto> messageList = mainSqlMapper.selectAllMessageWroteByUserId(userId);

		return messageList;
	}

	public MessageDto getMessageWroteByMessageId(int id) {

		MessageDto messageDto = mainSqlMapper.getMessageDtoByMessageId(id);

		return messageDto;

	}

	public List<CouponDto> getCouponList() {
		List<CouponDto> couponList = mainSqlMapper.getCouponList();

		return couponList;

	}

	// 쿠폰등록버튼 누르면 유저쿠폰테이블에 insert
	public void insertUserCoupon2(int couponId, int userId) {

		int userCouponId = mainSqlMapper.createUserCouponPk();
		mainSqlMapper.decreaseCoupon(couponId);
		UserCouponDto userCouponDto = new UserCouponDto();
		userCouponDto.setUser_coupon_id(userCouponId);
		userCouponDto.setCoupon_id(couponId);
		userCouponDto.setUser_id(userId);
		mainSqlMapper.insertUserCoupon2(userCouponDto);

	}

	public boolean hasCoupon(int userId, int couponId) {

		UserCouponDto userCouponDto = new UserCouponDto();
		userCouponDto.setCoupon_id(couponId);
		userCouponDto.setUser_id(userId);

		return mainSqlMapper.countCoupon(userCouponDto) > 0;

	}

	public boolean isExpired(int couponId) {
		// TODO Auto-generated method stub

		return mainSqlMapper.checkExpired(couponId) > 0;
	}

	public boolean isExhausted(int couponId) {
		// TODO Auto-generated method stub
		return mainSqlMapper.checkExhausted(couponId) > 0;
	}

}
