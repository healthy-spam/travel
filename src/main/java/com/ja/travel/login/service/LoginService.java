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
			int user_id = loginSqlMapper.getUserDtoByIdandPw(userDto.getUser_email(), userDto.getUser_pw()).getUser_id();
		   
		   if (profileImage != null) {

				String rootFolder = "C:/uploadFiles/profileImage/";

				File targetFolder = new File(rootFolder);

				if (!targetFolder.exists()) {
					targetFolder.mkdirs();
				}

				String fileName = Integer.toString(user_id);

				String originalFileName = profileImage.getOriginalFilename();

				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

				String saveFileName = fileName + ext;

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
