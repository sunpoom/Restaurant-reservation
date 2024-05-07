package com.naver.www.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.Sides;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.cj.xdevapi.JsonArray;
import com.naver.www.common.dto.FoodDTO;
import com.naver.www.common.dto.ResaurantReservationList;
import com.naver.www.common.dto.ReservationDTO;
import com.naver.www.common.dto.ReviewDTO;

@Repository
public class ReservationMybaties {

	@Autowired
	private SqlSessionTemplate mybaties;

	public void reservationRegister(ReservationDTO dto) {
		mybaties.insert("reservation.insertInfo", dto);
		int reservation_id = mybaties.selectOne("reservation.getReservationNum", dto);
		ArrayList<FoodDTO> foods = dto.getFoods();
		for (int i = 0; i < foods.size(); i++) {
			foods.get(i).setReservation_id(reservation_id);
		}
		mybaties.insert("reservation.insertMenu", foods);
	}

	public String restaurantReservationList(String restaurant_id) {
		List<ResaurantReservationList> list = mybaties.selectList("reservation.restaurantReservationList",
				restaurant_id);
		StringBuffer sb = new StringBuffer("");
		sb.append("{\"reservation\":[");
		boolean flag = false;
		int size = list.size();
		int reservationID = -1;
		for (int i = 0; i < size; i++) {
			ResaurantReservationList reservationdto = list.get(i);
			if (reservationID != reservationdto.getReservation_id()) {
				if (flag) {
					sb.append("]}]");
					if (i != size - 1) {
						sb.append(",");
					}
				}
				sb.append("[{\"reserNum\":[");
				sb.append("{\"reservationNum\":\"" + reservationdto.getReservation_id() + "\"},");
				sb.append("{\"user\":\"" + reservationdto.getCustomer_id() + "\"},");
				sb.append("{\"email\":\"" + reservationdto.getCustomersEmail() + "\"},");
				sb.append("{\"date\":\"" + reservationdto.getReservation_date() + "\"},");
				sb.append("{\"time\":\"" + reservationdto.getReservation_time() + "\"},");
				sb.append("{\"person\":\"" + reservationdto.getNumber_of_guests() + "\"},");
				sb.append("{\"request\":\"" + reservationdto.getSpecial_requests() + "\"},");
				sb.append("{\"status\":\"" + reservationdto.getReservation_status() + "\"}]},");
				sb.append("{\"reserFood\":[");
				sb.append("{\"foodName\":\"" + reservationdto.getName() + "\"},");
				sb.append("{\"foodcnt\":\"" + reservationdto.getCnt() + "\"}");
				reservationID = reservationdto.getReservation_id();
			} else {
				sb.append(",");
				sb.append("{\"foodName\":\"" + reservationdto.getName() + "\"},");
				sb.append("{\"foodcnt\":\"" + reservationdto.getCnt() + "\"}");
				flag = true;
			}
			if (i == size - 1) {
				sb.append("]}]");
			}
		}
		sb.append("]}");
		return sb.toString();
	}

	public List<ReservationDTO> myreservationList(String customer_id) {
		List<ResaurantReservationList> list = mybaties.selectList("reservation.customersReservationList", customer_id);
		int reservationID = -1;
		List<ReservationDTO> reservationList = new ArrayList<ReservationDTO>();
		ArrayList<FoodDTO> foods = null;

		int size = list.size();
		ReservationDTO vo = null;
		for (int i = 0; i < size; i++) {
			ResaurantReservationList dto = list.get(i);
			FoodDTO food = new FoodDTO();
			if (reservationID != dto.getReservation_id()) {
				if (vo != null) {
					vo.setFoods(foods);
					reservationList.add(vo);
				}
				vo = new ReservationDTO();
				vo.setReservation_id(dto.getReservation_id());
				vo.setRestaurant_id(dto.getRestaurant_id());
				vo.setRestaurantName(dto.getCafeName());
				vo.setRestaurantDescription(dto.getCafedescription());
				vo.setReservation_status(dto.getReservation_status());
				vo.setCustomer_id(dto.getCustomer_id());
				vo.setCustomer_email(dto.getCustomersEmail());
				vo.setCustomerphone(dto.getCustomersPhonenum());
				vo.setReservation_date(dto.getReservation_date());
				vo.setReservation_time(dto.getReservation_time());
				vo.setNumber_of_guests(dto.getNumber_of_guests());
				vo.setSpecial_requests(dto.getSpecial_requests());

				foods = new ArrayList<FoodDTO>();
				food.setName(dto.getName());
				food.setCnt(dto.getCnt());
				food.setPrice(dto.getPrice());
				reservationID = dto.getReservation_id();
				foods.add(food);
			} else {
				food.setName(dto.getName());
				food.setCnt(dto.getCnt());
				food.setPrice(dto.getPrice());
				foods.add(food);
			}
			if (i == size - 1) {
				vo.setFoods(foods);
				reservationList.add(vo);
			}
		}
		return reservationList;
	}

	public int updateStatus(String reservation_id, String check) {
		Map<String, String> params = new HashMap<>();
		params.put("check", check); // 또는 "cancelled"
		params.put("reservation_id", reservation_id);
		return (int) mybaties.update("reservation.updateStatus", params);
	}

	public void myreplyOk(ReviewDTO dto) {
		mybaties.insert("reservation.myreplyinsert", dto);
		mybaties.update("restaurant.restaurantUpdateavg", dto);
	}

	public void updatereviewComment(ReviewDTO dto) {
		mybaties.update("reservation.updatereviewComment", dto);
	}
}
