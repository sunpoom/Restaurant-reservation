package com.naver.www.restaurant;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.www.admin.dto.AdminDTO;
import com.naver.www.common.dto.FoodDTO;
import com.naver.www.common.dto.RestaurantANDMenuDTO;
import com.naver.www.common.dto.ReviewDTO;
import com.naver.www.restaurant.dto.RestaurantDTO;

@Service("RestaurantService")
public class RestaurantServiceDAO implements RestaurantService {

	@Autowired
	RestaurantMybaties RestaurantDAO;

	@Override
	public void restaurantRegister(RestaurantDTO dto) {
		RestaurantDAO.restaurantRegister(dto);
	}

	@Override
	public List<RestaurantDTO> getRestaurantList(AdminDTO dto) {
		return RestaurantDAO.getRestaurantList(dto);
	}

	@Override
	public String getRestaurantType(RestaurantDTO dto,String sortname) {
		return RestaurantDAO.getRestaurantType(dto,sortname);
	}

	@Override
	public RestaurantDTO getRestaurant(int restaurant_id) {
		return RestaurantDAO.getRestaurant(restaurant_id);
	}

	@Override
	public void adminMenuRegister(RestaurantDTO dto) {
		RestaurantDAO.adminMenuRegister(dto);
	}

	@Override
	public List<RestaurantANDMenuDTO> userRestaurantAndMenu(RestaurantDTO dto) {
		return RestaurantDAO.userRestaurant(dto);
	}

	@Override
	public List<ReviewDTO> reviewList(RestaurantDTO dto) {
		return RestaurantDAO.reviewList(dto);
	}

	@Override
	public void restaurantmodify(RestaurantDTO dto) {
		RestaurantDAO.restaurantmodify(dto);
	}

	@Override
	public void deleteRestaurant(RestaurantDTO dto) {
		RestaurantDAO.adminRestaurantList(dto);
	}

	@Override
	public String restaurantreviewList(RestaurantDTO dto) {
		return RestaurantDAO.restaurantreviewList(dto);
	}

	@Override
	public List<FoodDTO> getMenuList(int restaurant_id) {
		return RestaurantDAO.getMenuList(restaurant_id);
	}
}
