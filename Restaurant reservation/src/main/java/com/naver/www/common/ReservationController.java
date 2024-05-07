package com.naver.www.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.http.HttpResponse;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.naver.www.common.dto.FoodDTO;
import com.naver.www.common.dto.ReservationDTO;
import com.naver.www.common.dto.ReviewDTO;
import com.naver.www.user.dto.UserDTO;

@Controller
public class ReservationController {

	@Autowired
	ReservationService reservationService;

	@RequestMapping("/userBasketResvervation.do")
	public String userBasketResvervation(
			@RequestParam(value = "name", defaultValue = "", required = false) List<String> name,
			@RequestParam(value = "price", defaultValue = "", required = false) List<String> price,
			@RequestParam(value = "cnt", defaultValue = "", required = false) List<String> cnt,
			@RequestParam(value = "hour", defaultValue = "", required = false) String hour,
			@RequestParam(value = "minute", defaultValue = "", required = false) String minute, ReservationDTO dto,
			HttpSession session, Model model) {
		String customer_id = ((UserDTO) session.getAttribute("user")).getCustomer_id();
		ReservationDTO vo = new ReservationDTO();
		vo.setRestaurantName(dto.getRestaurantName());
		vo.setRestaurantDescription(dto.getRestaurantDescription());
		vo.setRestaurant_id(dto.getRestaurant_id());
		vo.setCustomer_id(customer_id);
		vo.setReservation_date(dto.getReservation_date());
		vo.setReservation_time(hour + ":" + minute);
		vo.setNumber_of_guests(dto.getNumber_of_guests());
		vo.setSpecial_requests(dto.getSpecial_requests());

		HashMap<String, String> hashcnt = new HashMap<String, String>();
		for (int i = 0; i < name.size(); i++) {
			if (hashcnt.containsKey(name.get(i))) {
				String value = hashcnt.get(name.get(i));
				int newCnt = Integer.parseInt(value) + Integer.parseInt(cnt.get(i));
				hashcnt.put(name.get(i), String.valueOf(newCnt));
			} else {
				hashcnt.put(name.get(i), cnt.get(i));
			}
		}
		HashMap<String, String> hashprice = new HashMap<String, String>();
		for (int i = 0; i < name.size(); i++) {
			hashprice.put(name.get(i), price.get(i));
		}
		ArrayList<FoodDTO> list = new ArrayList<FoodDTO>();
		for (String key : hashcnt.keySet()) {
			FoodDTO foodDTO = new FoodDTO();
			int currentCnt = Integer.parseInt(hashcnt.get(key));
			int currentPrice = Integer.parseInt(hashprice.get(key));
			foodDTO.setRestaurant_id(dto.getRestaurant_id());
			foodDTO.setCustomer_id(customer_id);
			foodDTO.setName(key);
			foodDTO.setCnt(currentCnt);
			foodDTO.setPrice(currentPrice);
			list.add(foodDTO);
		}
		vo.setFoods(list);
		model.addAttribute("reservationCheck", vo);
		session.setAttribute("reservationObj", vo);
		return "./jsp/userReservationCheck.jsp";
	}

	@RequestMapping("/reservationOK.do")
	public String reservationOK(@RequestParam(value = "check", defaultValue = "true", required = false) String check,
			HttpSession session) {
		if (check.equals("cancle")) {
			session.removeAttribute("reservationObj");
		} else {
			reservationService.reservationRegister((ReservationDTO) session.getAttribute("reservationObj"));
			session.removeAttribute("reservationObj");
		}
		return "redirect:./jsp/userRestaurantList.jsp";
	}

	@RequestMapping("/restaurantReservationList.do")
	public void restaurantReservationList(
			@RequestParam(value = "restaurant_id", defaultValue = "", required = false) String restaurant_id,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		String result = reservationService.restaurantReservationList(restaurant_id);
		System.out.println(result);
		out.write(result + "");
	}

	@RequestMapping("/myreservationList.do")
	public String myreservationList(HttpSession session, Model model) {
		String customer_id = ((UserDTO) session.getAttribute("user")).getCustomer_id();
		model.addAttribute("myreservationList", reservationService.myreservationList(customer_id));
		return "./jsp/userMyReservation.jsp";
	}

	@RequestMapping("/updateStatus.do")
	public void updateStatus(
			@RequestParam(value = "reservation_id", defaultValue = "", required = false) String reservation_id,
			@RequestParam(value = "checkvalue", defaultValue = "", required = false) String check,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		int result = (int) reservationService.updateStatus(reservation_id, check);
		out.write(result);
	}

	// 由щ럭�븯湲� �닃���쓣�븣
	@RequestMapping("/myreplyOk.do")
	public String myreplyOk(ReviewDTO dto, HttpSession session) {
		String customer_id = ((UserDTO) session.getAttribute("user")).getCustomer_id();
		dto.setCustomer_id(customer_id);
		reservationService.myreplyOk(dto);
		return "/myreservationList.do";
	}

	// �궗�옣�떂�씠 由щ럭瑜� �떖�옄�쓣 �뻹
	@RequestMapping("/updatereview_comment.do")
	public void updatereview(ReviewDTO dto) {
		System.out.println(dto.getReview_id());
		System.out.println(dto.getReply_comment());
		reservationService.updatereviewComment(dto);
	}

}
