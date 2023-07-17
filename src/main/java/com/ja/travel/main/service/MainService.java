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

	

}
