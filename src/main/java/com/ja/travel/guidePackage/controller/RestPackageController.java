package com.ja.travel.guidePackage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.GuidePlanningApplicationDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.guidePackage.service.PackageService;

@RestController
@RequestMapping("/guidePackage/*")
public class RestPackageController {

	@Autowired
	private PackageService packageService;

	@RequestMapping("updateGuideApplicationaStatusByUser")
	public Map<String, Object> updateGuideApplicationaStatusByUser(
			GuidePlanningApplicationDto guidePlanningApplicationDto, String value) {

		Map<String, Object> map = packageService.updateGuideApplicationaStatusByUser(guidePlanningApplicationDto,
				value);

		return map;
	}

	@RequestMapping("getPackageApplicationList")
	public Map<String, Object> getPackageApplicationList(HttpSession session, int pageNum, String searchType,
			String searchWord) {

		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> list = packageService.getGuidePlanningList(pageNum, searchType, searchWord, session);
		int totalCount = packageService.getGuidePlanningCount(searchWord);

		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		if (sessionUser != null) {
			map.put("sessionUser", sessionUser);
		}

		map.put("totalCount", totalCount);
		map.put("list", list);

		return map;
	}

	@RequestMapping("guideApplicationDetailInfo")
	public Map<String, Object> guideApplicationDetailInfo(int guide_planning_id, Model model) {

		Map<String, Object> map = packageService.getPlaceByDayForPlan(guide_planning_id);

		model.addAttribute("map", map);
		model.addAttribute("guide_planning_id", guide_planning_id);

		return map;
	}

}
