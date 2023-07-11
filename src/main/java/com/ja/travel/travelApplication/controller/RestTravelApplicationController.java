package com.ja.travel.travelApplication.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.PlanningComment;
import com.ja.travel.dto.TravelApplicationRequestDto;
import com.ja.travel.travelApplication.service.TravelApplicationService;

@RequestMapping("/plan/*")
@RestController
public class RestTravelApplicationController {

	@Autowired
	private TravelApplicationService travelApplicationService;

//	@RequestMapping("updateApplicationaStatusByUser")
//	public Map<String, Object> updateApplicationaStatusByUser(PlanningApplicationDto planningApplicationDto,
//			String value) {
//		Map<String, Object> map = travelApplicationService.updateApplicationaStatusByUser(planningApplicationDto,
//				value);
//
//		return map;
//	}

	@RequestMapping("getTravelApplicationList")
	public Map<String, Object> getTravelApplicationList(TravelApplicationRequestDto travelApplicationRequestDto) {
		Map<String, Object> map = new HashMap<>();
		
		List<Map<String, Object>> list = travelApplicationService.getPlanningList(travelApplicationRequestDto);
		int totalCount = travelApplicationService.getPlanningCount(travelApplicationRequestDto.getSearchWord());
		
		map.put("totalCount", totalCount);
		map.put("list", list);

		return map;
	}

	@RequestMapping("planByDate")
	public Map<String, Object> planByDate(int planning_id) {
		Map<String, Object> map = travelApplicationService.getPlaceByDayForPlan(planning_id);

		return map;
	}

	@RequestMapping("getAddresList")
	public Map<String, Object> getAddresList(int plan_id) {
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> list = travelApplicationService.getPlanDayList(plan_id);

		map.put("list", list);

		return map;
	}
	
	@RequestMapping("createComment")
	public Map<String, Object> createComment(@ModelAttribute PlanningComment planningComment, HttpSession session) {
		travelApplicationService.createComment(planningComment, session);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("ok", "ok");
		
		return map;
	}
	
	@RequestMapping("getCommentList")
	public Map<String, Object> getCommentList(int planning_id, HttpSession session) {
		List<Map<String, Object>> list = travelApplicationService.getCommentList(planning_id, session);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		return map;
	}
	
	@RequestMapping("addLike")
	public Map<String, Object> addLike(int comment_id, HttpSession session) {
		travelApplicationService.addLike(comment_id, session);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("ok", "ok");
		
		return map;
	}
}
