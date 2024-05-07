package com.naver.www.restaurant;

import java.util.List;

import com.naver.www.admin.dto.AdminDTO;
import com.naver.www.common.dto.FoodDTO;
import com.naver.www.common.dto.RestaurantANDMenuDTO;
import com.naver.www.common.dto.ReviewDTO;
import com.naver.www.restaurant.dto.RestaurantDTO;

public interface RestaurantService {

	void restaurantRegister(RestaurantDTO dto);

	List<RestaurantDTO> getRestaurantList(AdminDTO attribute);

	String getRestaurantType(RestaurantDTO dto,String sortname);

	RestaurantDTO getRestaurant(int restaurant_id);

	void adminMenuRegister(RestaurantDTO dto);

	List<RestaurantANDMenuDTO> userRestaurantAndMenu(RestaurantDTO dto);

	List<ReviewDTO> reviewList(RestaurantDTO dto);

	void restaurantmodify(RestaurantDTO dto);

	void deleteRestaurant(RestaurantDTO dto);

	String restaurantreviewList(RestaurantDTO dto);

	List<FoodDTO> getMenuList(int restaurant_id);


}
