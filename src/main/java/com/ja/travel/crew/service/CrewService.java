package com.ja.travel.crew.service;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.crew.mapper.CrewMapper;
import com.ja.travel.dto.CrewBoardAttachedDto;
import com.ja.travel.dto.CrewBoardCommentDto;
import com.ja.travel.dto.CrewBoardDto;
import com.ja.travel.dto.CrewDto;
import com.ja.travel.dto.CrewMemberDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserNotificationDto;

import oracle.security.o3logon.a;
@Service
public class CrewService {

	@Autowired
	private CrewMapper crewMapper;

	public String crewmain(HttpSession session, Model model) {

		List<CrewDto> arrlist = crewMapper.getAllCrewListOrderByPopularity();
		List<Map<String, Object>> crewList = new ArrayList<>();
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		
		//전체crewList 가져오기
		for(CrewDto crew: arrlist) {
			int master_id = crew.getMaster_id();
			String mastername = crewMapper.getUserNameById(master_id);
			Map<String, Object> map = new HashMap<>();
			map.put("mastername", mastername);
			map.put("crew", crew);
			crewList.add(map);
		}
		
		try { //크루 멤버일경우
			CrewMemberDto crewMemberDto = crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()); //자신의 크루 멤버 정보 가져오기
			CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crewMemberDto.getCrew_domain()); //가입한 크루 정보 가져오기
			model.addAttribute("crewDto", crewDto);
			model.addAttribute("myGrade", crewMapper.getGradeNameByGradeId(crewMemberDto.getCrew_member_grade_default_id()));
			model.addAttribute("crewamount", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crewDto.getCrew_domain()).size()));
			model.addAttribute("master", crewMapper.getUserNameById(crewDto.getMaster_id()));
			model.addAttribute("myPoint", crewMapper.getMyPointByCrewMemberId(crewMemberDto.getCrew_member_id())== null ? 0 : crewMapper.getMyPointByCrewMemberId(crewMemberDto.getCrew_member_id()));
			model.addAttribute("crewThumbnail", crewDto.getCrew_thumbnail());
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		model.addAttribute("crewList", crewList);
	
		return "crew/findcrew";
	}
	
	
	public void createcrew(Map<String, String> requestBody, HttpSession session) {
		CrewDto crewDto = new CrewDto();
		crewDto.setCrew_name(requestBody.get("crew_name"));
		crewDto.setCrew_domain(requestBody.get("crew_domain"));
		if(crewDto.getCrew_domain()=="") {
			crewDto.setCrew_domain(crewMapper.getcrewdomain().toString());
		}
		crewDto.setCrew_desc((String) requestBody.get("crew_desc"));
		
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		crewDto.setMaster_id(userDto.getUser_id());
		
		//crewMemberDto에 크루마스터 정보 넣기
		CrewMemberDto crewMemberDto = new CrewMemberDto();
		crewMemberDto.setCrew_domain(crewDto.getCrew_domain());
		crewMemberDto.setCrew_join_request_intro("");
		crewMemberDto.setCrew_member_grade_default_id(1);
		crewMemberDto.setUser_id(userDto.getUser_id());
		crewMemberDto.setCrew_join_status("member");
		crewMapper.createcrew(crewDto);
		crewMapper.addcrewmember(crewMemberDto);
		}



	
	//크루 홈 불러오기!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!
	public String crewhome(String crew_domain, HttpSession session, Model model) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		if(userDto==null) {
			return "redirect:/crew/findcrew";
		}
//		CrewDto crewDto = crewMapper.getCrewDtoByUserId(userDto.getUser_id()); //크루 정보
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		
		try {
			CrewMemberDto crewMemberDto = crewMapper.getMyCrewInfo(userDto.getUser_id()); //크루원일 경우, 크루 내 나의 정보
			String gradename = crewMapper.getGradeNameByGradeId(crewMemberDto.getCrew_member_grade_default_id()); //크루원일 경우, 크루 내 나의 등급
			model.addAttribute("crewMemberDto", crewMemberDto);
			model.addAttribute("mygrade", gradename);
			Integer mypoint = crewMapper.getMyPointByCrewMemberId(crewMemberDto.getCrew_member_id());
			if(mypoint == null) {
				model.addAttribute("mypoint", 0);
			}
			model.addAttribute("mypoint", mypoint);
			model.addAttribute("list", getBoardList(crew_domain, userDto));

		} catch (Exception e) { //크루원 아님
			System.out.println("오류뜸!!");
			List<CrewBoardDto> publicpostlist = crewMapper.getAllPublicPostByCrewDomain(crew_domain);
			List<CrewBoardDto> publicnoticelist = crewMapper.getAllPublicNoticeByCrewDomain(crew_domain);
			
			model.addAttribute("publicpostlist", publicpostlist);
			model.addAttribute("publicnoticelist", publicnoticelist);
		}
		CrewMemberDto crewappliedDto = crewMapper.getAppliedMemberInfo(userDto.getUser_id());
		model.addAttribute("applied", crewappliedDto);
		
		model.addAttribute("crewDto", crewDto);
		model.addAttribute("userDto", userDto);
		return "crew/crewhome";
	}
	
	//게시글 불러오는 함수@######################!#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	public List<Map<String, Object>> getBoardList(String crew_domain, UserDto userDto) {
		List<CrewBoardDto> allpostlist = crewMapper.getAllPostByCrewDomain(crew_domain); //게시글 전체 불러오기
		CrewMemberDto mycrewMemberDto = crewMapper.getMyCrewInfo(userDto.getUser_id()); //sessionuser의 crewMemberDto
		List<Map<String, Object>> list = new ArrayList<>();
		for(CrewBoardDto post : allpostlist) { //게시글 하나 당
			Map< String, Object> map = new HashMap<String, Object>();
			String post_writer_nickname = crewMapper.getUserDtoByCrewMemberId(post.getCrew_member_id()).getUser_nickname(); //게시글 작성자 닉네임
			List<Integer> boardlikelist = crewMapper.getBoardLikeListByCrewBoardId(post.getCrew_board_id()); //해당 게시글에 좋아요 누른 crew_member_id 리스트

			int count = 0;
			int k = mycrewMemberDto.getCrew_member_id(); //sessionuser의 crew_member_id
			if(boardlikelist.size()!=0) { //boardlikelist의 값이 null이 아닐때
				count = boardlikelist.size(); //좋아요 개수
				
				for(int L:boardlikelist) {
					if(L == k) { // 좋아요 crew_member_id list에 본인 id가 있을 시
						map.put("liked", "dd"); //c태그에서 empty값 확인용
						break;
					}
				}
			}
			map.put("crewMemberDto", mycrewMemberDto);
			map.put("boardlikecount", count);
			map.put("user_nickname", post_writer_nickname);
			map.put("c", post);
			
			Integer a = crewMapper.getAllCommentByCrewBoardId(post.getCrew_board_id()).size(); //댓글 개수

			map.put("boardcommentcount", a);
			list.add(map);
		}

		return list;
	}
	
	
	

	public String joincrew(String crew_domain, Model model, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		//이전 해당 크루에 가입신청 한 적이 있는지 보기
		List<CrewMemberDto> requestlog = crewMapper.getMyAllRequestLogByUserId(userDto.getUser_id());
		for(CrewMemberDto log : requestlog) {
			
			//이미 특정 크루원이거나 가입신청한 크루가 있을 시
			if(log.getCrew_join_status().equals("member") || log.getCrew_join_status().equals("applied")) {
				return "redirect:/crew/main";
			}
			
			//해당 크루에서 영구제명 당했을 시
			if(log.getCrew_domain().equals(crewDto.getCrew_domain()) && log.getCrew_join_status().equals("banned")) {
				return "redirect:/crew/main";
			}
			
			//해당 크루에서 탈퇴 또는 거절되고 일주일이 지나지 않았을 시
			LocalDate currentDate = LocalDate.now();
			Date savedDate = log.getCrew_member_log_date();
			LocalDate logDate = new java.sql.Date(savedDate.getTime()).toLocalDate();
			if(log.getCrew_domain().equals(crewDto.getCrew_domain()) && logDate.isAfter(currentDate.minusWeeks(1))==true) {
				if(log.getCrew_join_status().equals("out") || log.getCrew_join_status().equals("rejected")) {
					return "redirect:/crew/main";
				}
			}
		}

		model.addAttribute("crewDto", crewDto);
		model.addAttribute("UserDto", session.getAttribute("sessionuser"));
		return "crew/joincrew";
	}

	public String joinrequest(CrewMemberDto crewMemberDto) {
		crewMemberDto.setCrew_join_status("applied");
		crewMemberDto.setCrew_member_grade_default_id(4);
		crewMapper.addcrewmember(crewMemberDto);
		return "redirect:/main";
	}

	public int boardwrite(Map<String, String> aa, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		CrewBoardDto crewBoardDto = new CrewBoardDto();
		crewBoardDto.setCrew_board_title(aa.get("crew_board_title"));
		crewBoardDto.setCrew_board_content(aa.get("crew_board_content"));
		crewBoardDto.setCrew_board_notice(aa.get("crew_board_notice"));
		crewBoardDto.setCrew_board_visibility(aa.get("crew_board_visibility"));
		crewBoardDto.setCrew_domain(crewMapper.getMyCrewInfo(userDto.getUser_id()).getCrew_domain());
		crewBoardDto.setCrew_member_id(crewMapper.getMyCrewInfo(userDto.getUser_id()).getCrew_member_id());
		if(crewBoardDto.getCrew_board_notice()==null) {
			crewBoardDto.setCrew_board_notice("N");
		}
		if(crewBoardDto.getCrew_board_visibility()==null) {
			crewBoardDto.setCrew_board_visibility("crewonly");
		}
		crewMapper.boardwrite(crewBoardDto);
		System.out.println("boardid = "+crewMapper.getLastCrewBoardIdByCrewMemberId(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_id()));
		return crewMapper.getLastCrewBoardIdByCrewMemberId(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_id());
	}

	public String boarddelete(int crew_board_id) {
		String crew_domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		crewMapper.boarddelete(crew_board_id);
		return "redirect:/crew/crewhome/"+crew_domain;
	}

	public String crewsetting(String crew_domain, Model model) {
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		model.addAttribute("crewDto", crewDto);
		return "crew/crewsetting";
	}

	public String crewmembers(String crew_domain, Model model) {
		model.addAttribute("applied", getappliedlist(crewMapper.getAllCrewRequestByCrewDomain(crew_domain)));
		model.addAttribute("crewDto", crewMapper.getCrewDtoByCrewDomain(crew_domain));
		model.addAttribute("crewsize", getappliedlist(crewMapper.getAllCrewRequestByCrewDomain(crew_domain)).size());
		return "crew/crewmemberlist";
	}

	public List<Map<String, Object>> requestaccept(List<Integer> crew_member_id) {
		String crew_domain = crewMapper.getCrewDomainByCrewMemberId(crew_member_id.get(0));
		crewMapper.requestaccept(crew_member_id);
		List<CrewMemberDto> list1 = crewMapper.getAllCrewRequestByCrewDomain(crew_domain);
//		sendnotification(crewMapper.getUserDtoByCrewMemberId(crew_member_id).getUser_id(), "redirect:/travel/crew/crewhome/"+crew_domain,"["+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_name()+ "] 크루 가입이 완료되었어요. 지금 크루 홈을 방문해 새로운 소식을 확인해보세요!");
		return getappliedlist(list1);
	}
	
	//크루가입 return 메소드!@@@@@@@@~$%!!!!!!!!!!!!!!!*****************************중요!~@*(~)&#!)#&!#*^###################(((((((((((*@@@@@@@@@@@@@@@@@@@@*(!(!*)(&$!_(&\
	public List<Map<String, Object>> getappliedlist(List<CrewMemberDto> list1) {
		List<Map<String, Object>> joinrequest = new ArrayList<>();
		for(CrewMemberDto mem: list1) {
			System.out.println(mem.toString());
			UserDto userDto = crewMapper.getUserDtoByUserId(mem.getUser_id());
			userDto.setUser_address(null);
			userDto.setUser_phone(null);
			Map<String, Object> map = new HashMap<>();
			map.put("userDto", userDto);
			map.put("crewMemberDto", mem);
			joinrequest.add(map);
		}
		return joinrequest;
	}
	
	
	
	//게시글 작성!!!!!!
	/**사진 추가 ajax로 바꿔야됨!!!!!!!!!!!!!!!**/
	public void addboard(int k, MultipartFile [] crew_board_attached) {
		// 파일 저장 로직
		int i=0;
		for(MultipartFile multipartFile : crew_board_attached) {
			i++;
			if(multipartFile.isEmpty()) {
				continue;
			}
			System.out.println("파일명: " + multipartFile.getOriginalFilename());
			
			String rootFolder = "C://CrewFiles/";
			
			File targetFolder = new File(rootFolder + Integer.toString(k)); // C:/uploadFolder/crew_board_id
			
			if(!targetFolder.exists()) {
				targetFolder.mkdirs();
			}
			
			// 저장 파일명 만들기. 핵심은 파일명 충돌 방지 = 랜덤 + 시간
			String fileName = Integer.toString(i);
//			fileName += "_" + System.currentTimeMillis();
			
			// 확장자 추출
			String originalFileName = multipartFile.getOriginalFilename();
			
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			String saveFileName = "/" +  fileName + ext;
			
			try {
				multipartFile.transferTo(new File(rootFolder + "/" + Integer.toString(k)+saveFileName));
			}catch(Exception e) {
				System.out.println(e);
				e.printStackTrace();
			}
			CrewBoardAttachedDto crewBoardAttachedDto = new CrewBoardAttachedDto();
			crewBoardAttachedDto.setCrew_board_original_attached(originalFileName);
			crewBoardAttachedDto.setCrew_board_attached(saveFileName);
			crewBoardAttachedDto.setCrew_board_id(k);
			crewMapper.addCrewBoardAttached(crewBoardAttachedDto);
		}
	}
	
	//게시글 세부 페이지!!!!!!

	public Map<String, Object> getboarddetails(int crew_board_id, HttpSession session) {
		CrewBoardDto crewBoardDto = crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("crew_board_title", crewBoardDto.getCrew_board_title());
		map.put("post_writer", crewMapper.getUserDtoByCrewMemberId(crewBoardDto.getCrew_member_id()).getUser_nickname());
		map.put("regdate", crewBoardDto.getCrew_board_reg_date());
		map.put("crew_board_content", crewBoardDto.getCrew_board_content());
		map.put("crew_board_id", crewBoardDto.getCrew_board_id());
		map.put("post_writer_user_id", crewMapper.getUserDtoByCrewMemberId(crewBoardDto.getCrew_member_id()).getUser_id());
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		map.put("viewer_user_id", userDto.getUser_id());
		return map;
	}
	/** 아직 사진 추가 안함!!!!!!!!!!!!**/
	public String getboarddetails(String crew_domain, int crew_board_id, Model model) {
		CrewBoardDto creweBoardDto = crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id);
		model.addAttribute("crewBoardDto", creweBoardDto); //게시글 가져오기
		model.addAttribute(crew_domain, creweBoardDto);
		
		UserDto userDto = crewMapper.getUserDtoByCrewMemberId(creweBoardDto.getCrew_member_id()); //게시글 작성자 정보
		model.addAttribute("userDto", userDto);
		
		List<CrewBoardCommentDto> list = crewMapper.getAllCommentByCrewBoardId(crew_board_id);
		List<Map<String, Object>> arr = new ArrayList<>();
		
		try {
			for(CrewBoardCommentDto c : list) {
				UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("crewBoardCommentDto", c);
				map.put("commentWriter", commentWriter);
				arr.add(map);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		model.addAttribute("commentlist", arr);
		return "crew/boarddetails";
	}
	
	//댓글 작성!!!!!
	public List<Map<String, Object>> writecomment(Map<String, Object> crewBoardCommentDto, HttpSession session) {
		String crew_comment = crewBoardCommentDto.get("crew_comment").toString();		
		int crew_board_id =  Integer.parseInt((String) crewBoardCommentDto.get("crew_board_id"));
		int crew_member_id = crewMapper.getCrewMemberDtoByUserId(( (UserDto) session.getAttribute("sessionuser") ).getUser_id()).getCrew_member_id();
		CrewBoardCommentDto a = new CrewBoardCommentDto();
		a.setCrew_board_id(crew_board_id);
		a.setCrew_member_id(crew_member_id);
		a.setCrew_comment(crew_comment);
		crewMapper.writecomment(a);	
		return getcommentlist(crew_board_id);
	}

	
	//댓글 불러오기!!!!!!

	public List<Map<String, Object>> getcommentlist(int crew_board_id) {
		List<CrewBoardCommentDto> list = crewMapper.getAllCommentByCrewBoardId(crew_board_id);
		List<Map<String, Object>> arr = new ArrayList<>();
		
		try {
			for(CrewBoardCommentDto c : list) {
				UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("crewBoardCommentDto", c);
				map.put("commentWriter", commentWriter);
				arr.add(map);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return arr;
	}
	
	
	
	public List<Map<String, Object>> getcommentlist(int crew_board_id, HttpSession session) {
		List<CrewBoardCommentDto> list = crewMapper.getAllCommentByCrewBoardId(crew_board_id);
		List<Map<String, Object>> arr = new ArrayList<>();
		
		try {
			for(CrewBoardCommentDto c : list) {
				UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("crewBoardCommentDto", c);
				map.put("commentWriter", commentWriter);
				map.put("sessionuser", session.getAttribute("sessionuser"));
				arr.add(map);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return arr;
	}

	public List<Map<String, Object>> deletecomment(int board_comment_id, HttpSession session) {
		int crew_board_id = crewMapper.getCrewBoardDtoByBoardCommentId(board_comment_id).getCrew_board_id();
		crewMapper.deletecomment(board_comment_id);
		return getcommentlist(crew_board_id, session);
	}

	public String deleteboard(Integer crew_board_id) {
		String domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		crewMapper.boarddelete(crew_board_id);
		return "/travel/crew/crewhome/"+domain;
	}

	public List<Map<String, Object>> likeboard(int crew_board_id, int crew_member_id) {

		crewMapper.likeboard(crew_board_id, crew_member_id);
		String crew_domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		UserDto userDto = crewMapper.getUserDtoByCrewMemberId(crew_member_id);
		
		sendnotification(crewMapper.getUserDtoByCrewMemberId(crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id).getCrew_member_id()).getUser_id(), 
				"redirect:/travel/crew/crewhome/"+crew_domain+"/"+Integer.toString(crew_board_id),
				"["+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_name()+ "] "+userDto.getUser_nickname()+" 님이 본인의 게시글에 좋아요를 누르셨습니다.");
		
		return getBoardList(crew_domain, userDto);
	}

	public List<Map<String, Object>> dislikeboard(int crew_board_id, int crew_member_id) {
		crewMapper.dislikeboard(crew_board_id, crew_member_id);
		String crew_domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		UserDto userDto = crewMapper.getUserDtoByCrewMemberId(crew_member_id);
		return getBoardList(crew_domain, userDto);
	}
	
	
	//알림 보내기 메소드!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~#######################
	public void sendnotification(int user_id, String user_notification_link, String user_notification_content) {
		UserNotificationDto userNotificationDto = new UserNotificationDto();
		userNotificationDto.setUser_id(user_id);
		userNotificationDto.setUser_notification_link(user_notification_link);
		userNotificationDto.setUser_notification_content(user_notification_content);
		crewMapper.sendnotification(userNotificationDto);
	}

	public List<Map<String, Object>> getmynotification(Integer integer) {
		// TODO Auto-generated method stub
		return null;
	}

	public String crewclosecheck(String crew_domain, Model model) {
		model.addAttribute("crewDto", crewMapper.getCrewDtoByCrewDomain(crew_domain));
		try {
			Date date = crewMapper.getCrewCloseDateByCrewDomain(crew_domain);
			model.addAttribute("regdate", date);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			date = calendar.getTime();
			model.addAttribute("isclosing",  date);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return "crew/crewclosecheck";
	}

	public void crewclose(int crew_id) {
		crewMapper.crewclose(crew_id);
	}

	public void crewclosecancel(int crew_id) {
		crewMapper.crewclosecancel(crew_id);
		
	}

	public String wholeMemberManage(String crew_domain, Model model) {
		List<CrewMemberDto> getmembers = crewMapper.getCrewMemberListByCrewDomain(crew_domain);
		List<Map<String, Object>> memberlist = getAllMembers(getmembers);
		model.addAttribute("member", memberlist);
		model.addAttribute("crewsize", memberlist.size());
		model.addAttribute("crewDto", crewMapper.getCrewDtoByCrewDomain(crew_domain));
		return "crew/ManageWholeMember";
	}
	
	public List<Map<String, Object>> getAllMembers(List<CrewMemberDto> getmembers) {
		List<Map<String, Object>> memberlist = new ArrayList<Map<String,Object>>();
		for(CrewMemberDto mem: getmembers) {
			UserDto userDto = crewMapper.getUserDtoByUserId(mem.getUser_id());
			userDto.setUser_address(null);
			userDto.setUser_phone(null);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("postcount", crewMapper.getMyBoardListByCrewMemberId(mem.getCrew_member_id()).size());
			map.put("commentcount", crewMapper.getMyCommentListByCrewMemberId(mem.getCrew_member_id()).size());
			map.put("userDto", userDto);
			map.put("crewMemberDto", mem);
			memberlist.add(map);
		}
		return memberlist;
	}


	public List<Map<String, Object>> managesecede(List<Integer> memberIds) {
		crewMapper.bancrewmemberid(memberIds);
		return getAllMembers(crewMapper.getCrewMemberListByCrewDomain(crewMapper.getCrewDomainByCrewMemberId(memberIds.get(0))));
	}


	public List<Map<String, Object>> membersearch(String searchcont) {
		List<CrewMemberDto> selectedMemberList = crewMapper.getSelectedMemberBySearchcont(searchcont);
		return getAllMembers(selectedMemberList);
	}


	public List<Map<String, Object>> requestdecline(List<Integer> memberIds) {
		String crew_domain = crewMapper.getCrewDomainByCrewMemberId(memberIds.get(0));
		crewMapper.requestdecline(memberIds);
		List<CrewMemberDto> list1 = crewMapper.getAllCrewRequestByCrewDomain(crew_domain);
//		sendnotification(crewMapper.getUserDtoByCrewMemberId(crew_member_id).getUser_id(), "redirect:/travel/crew/crewhome/"+crew_domain,"["+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_name()+ "] 크루 가입이 완료되었어요. 지금 크루 홈을 방문해 새로운 소식을 확인해보세요!");
		return getappliedlist(list1);
	}


	public List<Map<String, Object>> appliedsearch(String searchcont) {
		List<CrewMemberDto> selectedMemberList = crewMapper.getSelectedappliedBySearchcont(searchcont);
		return getAllMembers(selectedMemberList);
	}


	public CrewBoardDto modifyBoard(int crew_board_id) {
		return crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id);
	}


	public void boardmodify(Map<String, Object> crewBoardDto) {
		CrewBoardDto aa = new CrewBoardDto();
		aa.setCrew_board_id((int) crewBoardDto.get("crew_board_id"));
		aa.setCrew_board_visibility((String) crewBoardDto.get("crew_board_visibility"));
		aa.setCrew_board_title((String) crewBoardDto.get("crew_board_title"));
		aa.setCrew_board_content((String) crewBoardDto.get("crew_board_content"));
		crewMapper.boardmodify(aa);
		
	}


	public Boolean checkcrewname(String crew_name) {
		Integer get = crewMapper.checkcrewname(crew_name);
		if(get==null) {
			return true;
		}
			return false;
	}


	public Boolean checkcrewdomain(String crew_domain) {
		Integer get = crewMapper.checkcrewdomain(crew_domain);
		if(get==null) {
			return true;
		}
			return false;
	}


	public void uploadcrewphoto(MultipartFile photo, HttpSession session) {

			UserDto userDto = (UserDto) session.getAttribute("sessionuser");
			String crew_domain = crewMapper.getCrewDomainByMasterId(userDto.getUser_id());
			
			System.out.println("파일명: " + photo.getOriginalFilename());
			
			String rootFolder = "C:/uploadFiles/crewFiles/crewthumbnail/";
			
			File targetFolder = new File(rootFolder); // C:/uploadFolder/crewthumbnail
			
			if(!targetFolder.exists()) {
				targetFolder.mkdirs();
			}
			
			// 저장 파일명 만들기.
			String fileName = crew_domain;

			
			// 확장자 추출
			String originalFileName = photo.getOriginalFilename();
			
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			String saveFileName = fileName + ext;
			
			try {
				photo.transferTo(new File(rootFolder + saveFileName));
			}catch(Exception e) {
				System.out.println(e);
				e.printStackTrace();
			}
			String crew_thumbnail = saveFileName;
			crewMapper.addCrewThumbnailByCrewDomain(crew_thumbnail, crew_domain);
		}
		
}
