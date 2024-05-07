package com.naver.www.common.dto;

public class ResaurantReservationList {
	private int reservation_id;
	private int restaurant_id;
	private String cafeName;
	private String cafedescription;
	private String reservation_date;
	private String reservation_time;
	private int number_of_guests;
	private String reservation_status;
	private String special_requests;
	private String customer_id;
	private String customersName;
	private String customersEmail;
	private String customersPhonenum;
	private String name;
	private int cnt;
	private int price;
	private int MenuCnt;

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}

	public String getCafedescription() {
		return cafedescription;
	}

	public void setCafedescription(String cafedescription) {
		this.cafedescription = cafedescription;
	}

	public int getMenuCnt() {
		return MenuCnt;
	}

	public void setMenuCnt(int menuCnt) {
		MenuCnt = menuCnt;
	}

	public int getReservation_id() {
		return reservation_id;
	}

	public void setReservation_id(int reservation_id) {
		this.reservation_id = reservation_id;
	}

	public int getRestaurant_id() {
		return restaurant_id;
	}

	public void setRestaurant_id(int restaurant_id) {
		this.restaurant_id = restaurant_id;
	}

	public String getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}

	public String getReservation_date() {
		return reservation_date;
	}

	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}

	public String getReservation_time() {
		return reservation_time;
	}

	public void setReservation_time(String reservation_time) {
		this.reservation_time = reservation_time;
	}

	public int getNumber_of_guests() {
		return number_of_guests;
	}

	public void setNumber_of_guests(int number_of_guests) {
		this.number_of_guests = number_of_guests;
	}

	public String getReservation_status() {
		return reservation_status;
	}

	public void setReservation_status(String reservation_status) {
		this.reservation_status = reservation_status;
	}

	public String getSpecial_requests() {
		return special_requests;
	}

	public void setSpecial_requests(String special_requests) {
		this.special_requests = special_requests;
	}

	public String getCustomersName() {
		return customersName;
	}

	public void setCustomersName(String customersName) {
		this.customersName = customersName;
	}

	public String getCustomersEmail() {
		return customersEmail;
	}

	public void setCustomersEmail(String customersEmail) {
		this.customersEmail = customersEmail;
	}

	public String getCustomersPhonenum() {
		return customersPhonenum;
	}

	public void setCustomersPhonenum(String customersPhonenum) {
		this.customersPhonenum = customersPhonenum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

}
