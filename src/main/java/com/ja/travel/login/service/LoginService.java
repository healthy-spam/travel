package com.ja.travel.login.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.admin.mapper.AdminSqlMapper;
import com.ja.travel.dto.MemberRestrictDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserReportDto;
import com.ja.travel.login.mapper.LoginSqlMapper;

@Service
public class LoginService {

	@Autowired
	private LoginSqlMapper loginSqlMapper;
	
	@Autowired
	private AdminSqlMapper adminSqlMapper;

	public void register(UserDto userDto, MultipartFile profileImage) {
		loginSqlMapper.register(userDto);
		updateProfile(userDto, profileImage);
	}

	public void updateProfile(UserDto userDto, MultipartFile profileImage) {
		int user_id = loginSqlMapper.getUserDtoByIdandPw(userDto.getUser_email(), userDto.getUser_pw()).getUser_id();

		if (profileImage != null) {
			String rootFolder = "C:/uploadFiles/profileImage/";

			// 날짜별 폴더 생성 로직.
			// 날짜를 문자로 바꿔주는 api
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String today = sdf.format(new Date());

			// 파일 속성을 컨트롤
			File targetFolder = new File(rootFolder + today); // C:/uploadFolder/2023/05/23

			if (!targetFolder.exists()) {// 저런 파일이 존재함?
				targetFolder.mkdirs(); // 폴더들 생성
			}

			// 저장 파일명 만들기. 핵심은 파일명 충돌 방지 = 랜덤 + 시간
			String fileName = UUID.randomUUID().toString();// 랜덤명 저장
			fileName += "_" + System.currentTimeMillis();

			// 확장자 추출
			String originalFileName = profileImage.getOriginalFilename();// 사용자 컴퓨터에 있는 파일명

			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

			String saveFileName = today + "/" + fileName + ext;

			try {
				profileImage.transferTo(new File(rootFolder + saveFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}

			userDto.setUser_image(saveFileName);
			loginSqlMapper.updateProfilePicByUserId(saveFileName, user_id);
		}
	}
	
	public String login(String user_email, String user_pw, HttpSession session, Model model) {
		UserDto userDto = loginSqlMapper.getUserDtoByIdandPw(user_email, user_pw);

		String result = null;
		if (userDto == null) {
			result = "login/login";
		} else {
			int user_id = userDto.getUser_id();
			MemberRestrictDto memberRestrictDto = loginSqlMapper.getRestrictedUser(user_id);
			if (memberRestrictDto == null) {

				session.setAttribute("sessionuser", userDto);
				result = "redirect:/main";
			} else {
				System.out.println(memberRestrictDto.getUser_report_id());
				int id = memberRestrictDto.getUser_report_id();

				UserReportDto userReportDto = adminSqlMapper.getUserReportDtoByUserReportId(id);

				session.setAttribute("memberRestrictDto", memberRestrictDto);
				session.setAttribute("userReportDto", userReportDto);

				result = "redirect:/userLoginFail";

			}
		}
		return result;
	}

	public String logout(HttpSession session, HttpServletRequest request) {
		session.invalidate();

		String referer = request.getHeader("Referer");
		if (referer != null) {
			System.out.println(referer);
			return "redirect:" + referer;
		}

		return "redirect:/main";
	}

}
