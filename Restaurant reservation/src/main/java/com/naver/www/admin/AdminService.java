package com.naver.www.admin;

import java.util.List;

import com.naver.www.admin.dto.AdminDTO;
import com.naver.www.restaurant.dto.RestaurantDTO;

public interface AdminService {

	AdminDTO adminLogin(AdminDTO dto);

	void adminRegister(AdminDTO dto);


}
