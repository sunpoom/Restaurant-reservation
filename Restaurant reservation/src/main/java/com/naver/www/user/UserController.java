package com.naver.www.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.naver.www.user.dto.UserDTO;

@Controller
public class UserController {

	@Autowired
	UserService userService;

	@RequestMapping("/userLogin.do")
	public ModelAndView userLogin(ModelAndView mav, UserDTO dto, HttpSession session) {
		UserDTO vo = userService.getUser(dto);
		
		if (vo != null) {
			session.setAttribute("user", vo);
			mav.setViewName("redirect:./jsp/userRestaurantList.jsp");
		} else {
			mav.setViewName("redirect:./jsp/userLogin.jsp");
		}
		return mav;
	}

	@RequestMapping("/userRegister")
	public ModelAndView userRegister(ModelAndView mav, UserDTO dto) {
		userService.userRegister(dto);
		mav.setViewName("redirect:./jsp/userLogin.jsp");
		return mav;
	}
	
	@RequestMapping("/userLogout.do")
	public String userLogout(HttpSession session) {
		session.invalidate();
		return "redirect:./index.jsp";
	}
}
