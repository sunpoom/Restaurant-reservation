package com.naver.www.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.www.common.dto.ReservationDTO;
import com.naver.www.common.dto.ReviewDTO;

@Service("ReservationService")
public class ReservationServiceDAO implements ReservationService {

	@Autowired
	ReservationMybaties reservationDAO;

	@Override
	public void reservationRegister(ReservationDTO dto) {
		reservationDAO.reservationRegister(dto);
	}

	@Override
	public String restaurantReservationList(String restaurant_id) {
		return reservationDAO.restaurantReservationList(restaurant_id);
	}

	@Override
	public List<ReservationDTO> myreservationList(String customer_id) {
		return reservationDAO.myreservationList(customer_id);
	}

	@Override
	public int updateStatus(String reservation_id,String check) {
		return reservationDAO.updateStatus(reservation_id,check);
	}

	@Override
	public void myreplyOk(ReviewDTO dto) {
		reservationDAO.myreplyOk(dto);
	}

	@Override
	public void updatereviewComment(ReviewDTO dto) {
		reservationDAO.updatereviewComment(dto);
	}

}
