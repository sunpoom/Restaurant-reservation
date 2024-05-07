package com.naver.www.restaurant;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.naver.www.admin.dto.AdminDTO;
import com.naver.www.common.dto.FoodDTO;
import com.naver.www.restaurant.dto.RestaurantDTO;

@Controller
public class RestaurantController {

	@Autowired
	RestaurantService restaurantService;

	// �궗�옣�떂�씠 �젅�뒪�넗�옉 �벑濡앺븯湲�
	@RequestMapping("/restaurantRegister.do")
	public String restaurantRegister(RestaurantDTO dto, HttpSession session) throws IOException {
		String amdin_id = ((AdminDTO) session.getAttribute("admin")).getAdmin_id();
		dto.setAdmin_id(amdin_id);
		MultipartFile uploadFile = dto.getRestaurantImg();
		if (!uploadFile.isEmpty()) {
			String fileName = amdin_id + "" + dto.getName() + "" + dto.getEmail();
			String filePath = "C:/javaStudy/spring/LastProject/src/main/webapp/img/" + fileName;
			uploadFile.transferTo(new File(filePath));
			dto.setImage_url(fileName);
		}
		restaurantService.restaurantRegister(dto);
		return "redirect:/adminRestaurantList.do";
	}

	// �궗�옣�떂�뱾�씠 �벑濡앺븳 �젅�뒪�넗�옉 1媛� 諛섑솚
	@RequestMapping("/adminRestaurant.do")
	public String adminRestaurant(RestaurantDTO dto, Model model) {
		model.addAttribute("restaurant", restaurantService.getRestaurant(dto.getRestaurant_id()));
		return "./jsp/adminRestaurant.jsp";
	}

	// �궗�옣�떂�뱾�씠 �벑濡앺븳 �젅�뒪�넗�옉 �닔�젙�븯湲�
	@RequestMapping("/restaurantmodify.do")
	public String restaurantmodify(RestaurantDTO dto, HttpSession session) throws IOException {
		MultipartFile uploadFile = dto.getRestaurantImg();
		if (!uploadFile.isEmpty()) {
			String fileName = uploadFile.getOriginalFilename();
			String filePath = "C:/javaStudy/spring/LastProject/src/main/webapp/img/" + fileName;
			uploadFile.transferTo(new File(filePath));
			dto.setImage_url(fileName);
		}
		restaurantService.restaurantmodify(dto);
		return "./adminRestaurantList.do";
	}

	// �궗�옣�떂�뱾�씠 �벑濡앺븳 �젅�뒪�넗�옉 1媛� �궘�젣
	@RequestMapping("/deleteRestaurant.do")
	public String deleteRestaurant(RestaurantDTO dto) {
		restaurantService.deleteRestaurant(dto);
		return "./adminRestaurantList.do";
	}

	// �궗�옣�떂�뱾�씠 �벑濡앺븳 �젅�뒪�넗�옉 由ъ뒪�듃 諛섑솚
	@RequestMapping("/adminRestaurantList.do")
	public String getRestaurantList(Model model, HttpSession session) {
		model.addAttribute("getRestaurantList",
				restaurantService.getRestaurantList((AdminDTO) session.getAttribute("admin")));
		return "./jsp/adminRestaurantList.jsp";
	}

	// 怨좉컼�뱾�씠 �썝�븯�뒗 �젅�뒪�넗�옉 由ъ뒪�듃 諛섑솚
	@RequestMapping(value = "/getRestaurantTypeList.do")
	public void getRestaurantType(@RequestParam(value = "foods", defaultValue = "", required = false) String food,
			@RequestParam(value = "sortname", defaultValue = "", required = false) String sortname, Model model,
			RestaurantDTO dto, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		dto.setCuisine_type(food);
		System.out.println(restaurantService.getRestaurantType(dto,sortname));
		out.write(restaurantService.getRestaurantType(dto,sortname) + "");
	}

	// 怨좉컼�씠 �썝�븯�뒗 �젅�뒪�넗�옉 諛섑솚
	@RequestMapping("/getRestaurant.do")
	public void getRestaurant(
			@RequestParam(value = "restaurant_id", defaultValue = "", required = false) int restaurant_id,
			Model model) {
		model.addAttribute("restaurant", restaurantService.getRestaurant(restaurant_id));
	}

	//�궗�옣�떂�뱾�씠 硫붾돱�벑濡앸쾭�듉 �닃���쓣 �븣 <<<湲곗〈�뜲�씠�꽣 媛��졇�삤湲�
	@RequestMapping("/adminMenu.do")
	public String getMenuList(@RequestParam(value="restaurant_id",defaultValue = "",required = false)int restaurant_id,Model model) {
		List<FoodDTO> menuList=restaurantService.getMenuList(restaurant_id);
		model.addAttribute("menuList", menuList);
		return "./jsp/adminMenu.jsp";
	}
	
	//�궗�옣�떂�씠 硫붾돱 �닔�젙�뻽�쓣 �븣
	
	// �궗�옣�떂�뱾�씠 硫붾돱�벑濡앹셿猷뚰뻽�쓣�븣  << 湲곗〈�뜲�씠�꽣 �뾾�쓣 �븣
	@RequestMapping(value =  "/adminMenuRegister.do")
	public String adminMenuRegister(RestaurantDTO dto) {
		System.out.println("asdfasdf");
		restaurantService.adminMenuRegister(dto);
		return "/adminRestaurantList.do";
	}

	// 怨좉컼�씠 留ㅼ옣�솗�씤 �닃���쓣 �븣 �젅�뒪�넗�옉 諛섑솚(由щ럭�뜲�씠�꽣�룄 �룷�븿�빐�빞�븿)
	@RequestMapping("/userRestaurant.do")
	public String userRestaurantAndMenu(RestaurantDTO dto, Model model) {
		model.addAttribute("list", restaurantService.userRestaurantAndMenu(dto));
		model.addAttribute("reviewlist", restaurantService.reviewList(dto));
		return "./jsp/userRestaurant.jsp";
	}

	// �궗�옣�떂�뱾�씠 留ㅼ옣 由щ럭踰꾪듉 �닃���쓣�븣
	@RequestMapping("/restaurantreviewList.do")
	public void restaurantreviewList(RestaurantDTO dto, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String reviewList = restaurantService.restaurantreviewList(dto);
		System.out.println(reviewList);
		out.print(reviewList);
	}

	// 怨좉컼�씠 �삁�빟踰꾪듉 �닃���쓬
	@RequestMapping("/userReservation.do")
	public String userResvervation(RestaurantDTO dto, Model model) {
		model.addAttribute("list", restaurantService.userRestaurantAndMenu(dto));
		return "./jsp/userReservation.jsp";
	}
}
