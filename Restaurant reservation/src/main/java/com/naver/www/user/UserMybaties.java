package com.naver.www.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.www.user.dto.UserDTO;

@Repository
public class UserMybaties {

	@Autowired
	private SqlSessionTemplate mybaties;

	public UserDTO getUser(UserDTO dto) {
		return (UserDTO) mybaties.selectOne("user.getUser", dto);
	}

	public void userRegister(UserDTO dto) {
		mybaties.insert("user.userRegister", dto);
	}

}
