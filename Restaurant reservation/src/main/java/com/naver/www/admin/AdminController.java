package com.naver.www.admin;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.naver.www.admin.dto.AdminDTO;

@Controller
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@RequestMapping("/adminLogin.do")
	public String adminLogin(AdminDTO dto, HttpSession session) {
		AdminDTO vo = adminService.adminLogin(dto);
		if (vo != null) {
			session.setAttribute("admin", vo);
			return "redirect:adminRestaurantList.do";
		} else {
			return "redirect:./jsp/adminLogin.jsp";
		}
	}

	@RequestMapping("/adminRegister.do")
	public String adminRegister(AdminDTO dto) {
		adminService.adminRegister(dto);
		return "redirect:./jsp/adminLogin.jsp";
	}

	@RequestMapping("/adminLogout.do")
	public String amdinLogout(HttpSession session) {
		session.invalidate();
		return "redirect:./index.jsp";
	}

}
