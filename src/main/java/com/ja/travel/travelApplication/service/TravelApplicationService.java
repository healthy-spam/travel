package com.ja.travel.travelApplication.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.travel.dto.PlanDayDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.PlanningComment;
import com.ja.travel.dto.PlanningCommentLove;
import com.ja.travel.dto.PlanningDto;
import com.ja.travel.dto.TravelApplicationRequestDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.login.mapper.LoginSqlMapper;
import com.ja.travel.plan.mapper.PlanSqlMapper;
import com.ja.travel.planPlace.mapper.PlanPlaceSqlMapper;
import com.ja.travel.travelApplication.mapper.TravelApplicationSqlMapper;

@Service
public class TravelApplicationService {

	@Autowired
	private TravelApplicationSqlMapper travelApplicationSqlMapper;

	@Autowired
	private PlanSqlMapper planSqlMapper;

	@Autowired
	private LoginSqlMapper loginSqlMapper;

	@Autowired
	private PlanPlaceSqlMapper planPlaceSqlMapper;
	
	public void planningApplicationParty(HttpSession session, PlanningApplicationDto planningApplicationDto) {
		planningApplicationDto.setUser_id(getSessionUserInfo(session).getUser_id());
		PlanningApplicationDto applicationStatus = travelApplicationSqlMapper
				.getApplicationStatus(planningApplicationDto);

		if (applicationStatus == null) {
			travelApplicationSqlMapper.insertPlanningApplicationParty(planningApplicationDto);
		}
	}

	private UserDto getSessionUserInfo(HttpSession session) {
		UserDto userInfo = (UserDto) session.getAttribute("sessionuser");
		return userInfo;
	}

	public Map<String, Object> updateApplicationaStatusByUser(PlanningApplicationDto planningApplicationDto,
			String value) {
		if (value.equals("수락")) {
			travelApplicationSqlMapper.acceptApplicationaStatusByUser(planningApplicationDto);
		} else {
			travelApplicationSqlMapper.refusalApplicationaStatusByUser(planningApplicationDto);
		}

		PlanningApplicationDto planningStatus = travelApplicationSqlMapper.getApplicationStatus(planningApplicationDto);
		PlanningDto planning = travelApplicationSqlMapper.getPlanningByPlanningId(planningStatus.getPlanning_id());
		List<PlanningApplicationDto> count = travelApplicationSqlMapper
				.getPlanningAcceptCountByPlanningId(planning.getPlanning_id());

		Map<String, Object> map = new HashMap<>();
		map.put("planningStatus", planningStatus);
		map.put("planning", planning);
		map.put("planningAcceptCount", count);

		return map;
	}

	public List<Map<String, Object>> getPlanningList(TravelApplicationRequestDto travelApplicationRequestDto) {
		List<PlanningDto> planningList = travelApplicationSqlMapper.getPlanningList(travelApplicationRequestDto);

		List<Map<String, Object>> list = new ArrayList<>();

		for (PlanningDto planning : planningList) {
			Map<String, Object> map = new HashMap<>();

			UserDto userOfPlanning = loginSqlMapper.selectById(planning.getUser_id());
			PlanDto plan = planSqlMapper.selectById(planning.getPlan_id());
			List<PlanDayDto> planDayList = travelApplicationSqlMapper.getPlanDayByPlanId(plan.getPlan_id());

			List<Map<String, Object>> list2 = new ArrayList<>();
			
			for (PlanDayDto planDay : planDayList) {
				List<PlanPlaceDto> placeList = travelApplicationSqlMapper.getPlaceByPlanId(planDay);
				Map<String, Object> map2 = new HashMap<>();
	        	
	        	map2.put("placeList", placeList);
	        	
	        	list2.add(map2);
			}
			
			map.put("list2", list2);
			map.put("user", userOfPlanning);
			map.put("plan", plan);
			map.put("planning", planning);
			map.put("planDay", planDayList.size());

			list.add(map);
		}

		return list;
	}

	public int getPlanningCount(String searchWord) {
		return travelApplicationSqlMapper.getPlanningCount(searchWord);
	}

	public PlanningDto getPlanningByPlanIdAndUserId(int plan_id) {
		PlanningDto planningDto = travelApplicationSqlMapper.getPlanAndPlanningInfoByPlanId(plan_id);
		
		return planningDto;
	}
	
	public List<Map<String, Object>> getPlanDayList(int plan_id) {
		List<PlanDayDto> planDayList = travelApplicationSqlMapper.getPlanDayByPlanId(plan_id);
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		for (PlanDayDto planDay : planDayList) {
			List<PlanPlaceDto> placeList = travelApplicationSqlMapper.getPlaceByPlanId(planDay);
			
			for (PlanPlaceDto placeDto : placeList) {
				int totalLoveByPlace = planPlaceSqlMapper.countPlanPlaceDetailPageLove(placeDto.getPlan_place_id());
				Map<String, Object> map = new HashMap<>();
				
				map.put("count", totalLoveByPlace);
				map.put("placeDto", placeDto);
				
				list.add(map);
			}
		}
		
		return list;
	}

	public void completePlanning(PlanningDto planningDto, HttpSession session) {
		planningDto.setUser_id(getSessionUserInfo(session).getUser_id());
		planningDto.setPlanning_id(travelApplicationSqlMapper.createPlanningPK());
		
		System.out.println(planningDto);
		travelApplicationSqlMapper.insertPlanningData(planningDto);
		travelApplicationSqlMapper.insertMyInfoWhenRecruting(planningDto);
		travelApplicationSqlMapper.updateToRecruiting(planningDto);
	}

	public Map<String, Object> getPlaceByDayForPlan(int planning_id) {
		PlanDto plan = travelApplicationSqlMapper.getPlanByPlanningId(planning_id);
		UserDto user = travelApplicationSqlMapper.getUserByPlanningId(planning_id);
		List<PlanDayDto> planDayList = travelApplicationSqlMapper.getPlanDayByPlanId(plan.getPlan_id());
		PlanningDto planningDto = travelApplicationSqlMapper.getPlanningByPlanningId(planning_id);
		int planDayListSize = planDayList.size();

		List<Map<String, Object>> list = new ArrayList<>();

		for (PlanDayDto planDay : planDayList) {
			List<PlanPlaceDto> placeList = travelApplicationSqlMapper.getPlaceByPlanId(planDay);
			Map<String, Object> map = new HashMap<String, Object>();

			map.put("planDay", planDay);
			map.put("placeList", placeList);

			list.add(map);
		}

		Map<String, Object> resultMap = new HashMap<>();

		resultMap.put("user", user);
		resultMap.put("planDayListSize", planDayListSize);
		resultMap.put("planningDto", planningDto);
		resultMap.put("list", list);
		resultMap.put("plan", plan);
		
		return resultMap;
	}

	public List<Map<String, Object>> getCommentList() {
		List<PlanningComment> planningCommentList = travelApplicationSqlMapper.getCommentList();
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		for (PlanningComment planningComment : planningCommentList) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			UserDto user = travelApplicationSqlMapper.getUserByPlanningId(planningComment.getPlanning_id());
			int totalLike = travelApplicationSqlMapper.getTotalLike(planningComment.getPlanning_comment_id());
			
			if (totalLike == 0) {
				map.put("totalLike", 0);
			}
			
			map.put("planningComment", planningComment);
			map.put("user", user);
			map.put("totalLike", totalLike);
			
			list.add(map);
		}
		
		return list;
	}
	
	public void createComment(PlanningComment planningComment, HttpSession session) {
		UserDto user = getSessionUserInfo(session);
		planningComment.setUser_id(user.getUser_id());
		
		travelApplicationSqlMapper.createComment(planningComment);
		
	}

	public void addLike(int comment_id, HttpSession session) {
		PlanningCommentLove planningCommentLove = getLoveDto(comment_id, session);
		
		if (planningCommentLove != null) {
			travelApplicationSqlMapper.deleteLike(planningCommentLove);
		} else {
			travelApplicationSqlMapper.addLike(planningCommentLove);
		}
	}
	
	public PlanningCommentLove getLoveDto(int comment_id, HttpSession session) {
		UserDto userDto = getSessionUserInfo(session);
		
		PlanningCommentLove planningCommentLove = new PlanningCommentLove();
		planningCommentLove.setPlanning_comment_id(comment_id);
		planningCommentLove.setUser_id(userDto.getUser_id());
		
		planningCommentLove = travelApplicationSqlMapper.getLikeByCommentIdAndUserId(planningCommentLove);
		
		return planningCommentLove;
	}
}