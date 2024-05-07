package com.naver.www.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.www.admin.dto.AdminDTO;
import com.naver.www.restaurant.dto.RestaurantDTO;

@Repository
public class AdminMybaties {
	
	@Autowired
	private SqlSessionTemplate mybaties;

	public AdminDTO adminLogin(AdminDTO dto) {
		return (AdminDTO)mybaties.selectOne("admin.getAdmin", dto);
	}

	public void adminRegister(AdminDTO dto) {
		mybaties.insert("admin.register", dto);
	}
}
