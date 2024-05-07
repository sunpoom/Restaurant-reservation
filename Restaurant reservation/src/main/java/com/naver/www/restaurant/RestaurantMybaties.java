package com.naver.www.restaurant;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.www.admin.dto.AdminDTO;
import com.naver.www.common.dto.FoodDTO;
import com.naver.www.common.dto.MenuDTO;
import com.naver.www.common.dto.RestaurantANDMenuDTO;
import com.naver.www.common.dto.ReviewDTO;
import com.naver.www.restaurant.dto.RestaurantDTO;

@Repository
public class RestaurantMybaties {

	@Autowired
	private SqlSessionTemplate mybaties;

	public void restaurantRegister(RestaurantDTO dto) {
		String address = dto.getPostcode() + "/" + dto.getRoadAddress() + "/" + dto.getJibunAddress() + "/"
				+ dto.getDetailAddress() + "/" + dto.getExtraAddress();
		dto.setAddress(address);
		mybaties.insert("restaurant.register", dto);
	}

	public List<RestaurantDTO> getRestaurantList(AdminDTO dto) {
		return mybaties.selectList("restaurant.getRestaurantList", dto);
	}

	public String getRestaurantType(RestaurantDTO dto,String sortname) {
		String cuisine_type = dto.getCuisine_type();
		Map<String,String> map =new HashMap<String, String>();
		map.put("cuisine_type", cuisine_type);
		map.put("sortname", sortname);
		List<RestaurantDTO> list = mybaties.selectList("restaurant.getRestaurantType", map);
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		int size = list.size();
		for (int i = 0; i < size; i++) {
			RestaurantDTO vo = list.get(i);
			result.append("[{\"value\":\"" + vo.getImage_url() + "\"},");
			result.append("{\"value\":\"" + vo.getName() + "\"},");
			result.append("{\"value\":\"" + vo.getAddress() + "\"},");
			result.append("{\"value\":\"" + vo.getPhone_number() + "\"},");
			String[] stringtoken = vo.getDescription().split("\n");
			String description = "";
			for (String str : stringtoken) {
				description += (str.trim() + "\\n");
			}
			result.append("{\"value\":\"" + description + "\"},");
			result.append("{\"value\":\"" + vo.getAverage_rating() + "\"},");
			result.append("{\"value\":\"" + vo.getRestaurant_id() + "\"}]");
			if (i != size - 1) {
				result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}

	public RestaurantDTO getRestaurant(int restaurant_id) {
		return (RestaurantDTO) mybaties.selectOne("restaurant.getRestaurant", restaurant_id);
	}

	public void adminMenuRegister(RestaurantDTO dto) {
		for (MenuDTO vo : dto.getType()) {
			for (String category : vo.getCategory()) {
				for (int i = 0; i < vo.getName().length; i++) {
					if (!vo.getName()[i].equalsIgnoreCase("NULL")) {
						FoodDTO foodvo = new FoodDTO();
						foodvo.setRestaurant_id(dto.getRestaurant_id());
						foodvo.setCategory(category);
						foodvo.setName(vo.getName()[i]);
						foodvo.setPrice(vo.getPrice()[i]);
						foodvo.setDescription(vo.getDescription()[i]);
						mybaties.insert("restaurant.menuRegister", foodvo);
					}
				}
			}
		}
	}

	public List<RestaurantANDMenuDTO> userRestaurant(RestaurantDTO dto) {
		return mybaties.selectList("restaurant.menuRestaurant", dto);
	}

	public List<ReviewDTO> reviewList(RestaurantDTO dto) {
		return mybaties.selectList("restaurant.viewList", dto);
	}

	public void restaurantmodify(RestaurantDTO dto) {
		String address = dto.getPostcode() + "/" + dto.getRoadAddress() + "/" + dto.getJibunAddress() + "/"
				+ dto.getDetailAddress() + "/" + dto.getExtraAddress();
		System.out.println(dto.getName());
		System.out.println(address);
		System.out.println(dto.getPhone_number());
		System.out.println(dto.getEmail());
		System.out.println(dto.getCuisine_type());
		System.out.println(dto.getDescription());
		System.out.println(dto.getImage_url());
		System.out.println(dto.getRestaurant_id());
		dto.setAddress(address);
		mybaties.update("restaurant.restaurantmodify", dto);
	}

	public void adminRestaurantList(RestaurantDTO dto) {
		mybaties.delete("restaurant.deleterestaurant", dto);
	}

	public String restaurantreviewList(RestaurantDTO dto) {
		List<ReviewDTO> list = mybaties.selectList("restaurant.viewList", dto);
		StringBuffer result=new StringBuffer("");
		result.append("{\"result\":[");
		int size = list.size();
		for (int i = 0; i < size; i++) {
			ReviewDTO vo = list.get(i);
			result.append("[{\"value\":\"" + vo.getReview_id() + "\"},");
			result.append("{\"value\":\"" + vo.getRestaurant_id() + "\"},");
			result.append("{\"value\":\"" + vo.getCustomer_id() + "\"},");
			result.append("{\"value\":\"" + vo.getScore() + "\"},");
			result.append("{\"value\":\"" + vo.getComment() + "\"},");
			
			result.append("{\"value\":\"" + vo.getReview_date() + "\"},");
			result.append("{\"value\":\"" + vo.getReply_comment() + "\"}]");
			if (i != size - 1) {
				result.append(",");
			}
		}
		result.append("]}");
		return result.toString();
	}

	public List<FoodDTO> getMenuList(int restaurant_id) {
		List<FoodDTO> menuList=mybaties.selectList("restaurant.foodList",restaurant_id);
		return menuList;
	}
}
