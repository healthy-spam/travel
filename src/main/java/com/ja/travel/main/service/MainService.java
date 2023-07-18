package com.ja.travel.main.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.GuideReportDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanningDto;
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

	public List<Map<String, Object>> getMyList(HttpSession session) {
		UserDto user = (UserDto) session.getAttribute("sessionuser");
		int user_id = 0;
		
		if (user != null) {
			user_id = user.getUser_id();
		}
		
		List<PlanningDto> myPlanningList = mainSqlMapper.getMyPlanningList(user_id);
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		
		for (PlanningDto planningDto : myPlanningList) {
			Map<String, Object> map = new HashMap<>();
			
			map.put("myPlanning", planningDto);
			
			// 종료 시간을 LocalDateTime으로 변환합니다.
			LocalDateTime endDate = LocalDateTime.parse(planningDto.getPlanning_end_date(), formatter);
			
		    // 현재 시간을 얻어옵니다.
		    LocalDateTime now = LocalDateTime.now();
		    
			if (endDate.isBefore(now)) {
				map.put("planningStatus", "모집종료");
			} else {
				map.put("planningStatus", "모집중");
			}
				
			list.add(map);
		}
		
		return list;
	}
}
