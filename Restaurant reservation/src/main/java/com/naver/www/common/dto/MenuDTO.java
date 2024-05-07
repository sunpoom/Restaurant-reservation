package com.naver.www.common.dto;

import java.util.ArrayList;

public class MenuDTO {
	private String[] category;
	private String[] image_url;
	private String[] name;
	private int[] price;
	private String[] description;


	public String[] getCategory() {
		return category;
	}

	public void setCategory(String[] category) {
		this.category = category;
	}

	public String[] getImage_url() {
		return image_url;
	}

	public void setImage_url(String[] image_url) {
		this.image_url = image_url;
	}

	public String[] getName() {
		return name;
	}

	public void setName(String[] name) {
		this.name = name;
	}

	public int[] getPrice() {
		return price;
	}

	public void setPrice(int[] price) {
		this.price = price;
	}

	public String[] getDescription() {
		return description;
	}

	public void setDescription(String[] description) {
		this.description = description;
	}

}
