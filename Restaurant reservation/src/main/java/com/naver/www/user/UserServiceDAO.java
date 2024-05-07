package com.naver.www.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.www.user.dto.UserDTO;

@Service("UserService")
public class UserServiceDAO implements UserService {

	@Autowired
	UserMybaties userDAO;
	
	@Override
	public UserDTO getUser(UserDTO dto) {
		return userDAO.getUser(dto);
	}

	@Override
	public void userRegister(UserDTO dto) {
		userDAO.userRegister(dto);
	}
}
