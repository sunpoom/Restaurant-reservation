package com.naver.www.common;

import java.util.List;

import com.naver.www.common.dto.ReservationDTO;
import com.naver.www.common.dto.ReviewDTO;

public interface ReservationService {

	void reservationRegister(ReservationDTO dto);

	String restaurantReservationList(String restaurant_id);

	List<ReservationDTO> myreservationList(String customer_id);

	int updateStatus(String reservation_id, String check);

	void myreplyOk(ReviewDTO dto);

	void updatereviewComment(ReviewDTO dto);

}