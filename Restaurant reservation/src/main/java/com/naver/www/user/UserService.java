package com.naver.www.user;

import com.naver.www.user.dto.UserDTO;

public interface UserService {

	UserDTO getUser(UserDTO dto);

	void userRegister(UserDTO dto);

}
