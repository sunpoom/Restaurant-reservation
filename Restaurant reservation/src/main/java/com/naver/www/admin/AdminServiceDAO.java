package com.naver.www.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.www.admin.dto.AdminDTO;
import com.naver.www.restaurant.dto.RestaurantDTO;


@Service("AdminService")
public class AdminServiceDAO implements AdminService{

	@Autowired
	private AdminMybaties adminDAO;
	
	@Override
	public AdminDTO adminLogin(AdminDTO dto) {
		return adminDAO.adminLogin(dto);
	}

	@Override
	public void adminRegister(AdminDTO dto) {
		adminDAO.adminRegister(dto);
	}

}
