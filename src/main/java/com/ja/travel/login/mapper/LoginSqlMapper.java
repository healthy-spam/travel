package com.ja.travel.login.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ja.travel.dto.MemberRestrictDto;
import com.ja.travel.dto.UserDto;


@Mapper
public interface LoginSqlMapper {
	public void register(UserDto userDto);

	public UserDto getUserDtoByIdandPw(@Param("user_email") String user_email, @Param("user_pw") String user_pw);
	
	public UserDto selectById(int user_id);
	
	public MemberRestrictDto getRestrictedUser(int user_id); 
}
