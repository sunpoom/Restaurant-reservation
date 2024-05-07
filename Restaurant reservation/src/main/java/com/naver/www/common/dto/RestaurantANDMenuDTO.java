package com.naver.www.common.dto;

public class RestaurantANDMenuDTO {
	private int restaurant_id;
	private String restaurantName;
	private String restaurantAddress;
	private String restaurantPhone;
	private String restaurantAvg;
	private String restaurantDescription;
	private String restaurantImage_URL;
	private String foodCategory;
	private String foodName;
	private int foodPrice;
	private String foodDescription;

	public int getRestaurant_id() {
		return restaurant_id;
	}

	public void setRestaurant_id(int restaurant_id) {
		this.restaurant_id = restaurant_id;
	}

	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}

	public String getRestaurantAddress() {
		return restaurantAddress;
	}

	public void setRestaurantAddress(String restaurantAddress) {
		this.restaurantAddress = restaurantAddress;
	}

	public String getRestaurantPhone() {
		return restaurantPhone;
	}

	public void setRestaurantPhone(String restaurantPhone) {
		this.restaurantPhone = restaurantPhone;
	}

	public String getRestaurantAvg() {
		return restaurantAvg;
	}

	public void setRestaurantAvg(String restaurantAvg) {
		this.restaurantAvg = restaurantAvg;
	}

	public String getRestaurantDescription() {
		return restaurantDescription;
	}

	public void setRestaurantDescription(String restaurantDescription) {
		this.restaurantDescription = restaurantDescription;
	}

	public String getRestaurantImage_URL() {
		return restaurantImage_URL;
	}

	public void setRestaurantImage_URL(String restaurantImage_URL) {
		this.restaurantImage_URL = restaurantImage_URL;
	}

	public String getFoodCategory() {
		return foodCategory;
	}

	public void setFoodCategory(String foodCategory) {
		this.foodCategory = foodCategory;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public int getFoodPrice() {
		return foodPrice;
	}

	public void setFoodPrice(int foodPrice) {
		this.foodPrice = foodPrice;
	}

	public String getFoodDescription() {
		return foodDescription;
	}

	public void setFoodDescription(String foodDescription) {
		this.foodDescription = foodDescription;
	}

}
