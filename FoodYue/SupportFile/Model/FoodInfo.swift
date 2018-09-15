//
//  FoodInfo.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct FoodInfoTotalModel: Codable {
	let data: FoodInfoModel
}

struct FoodListTotalModel: Codable {
	let data: FoodListModel
	struct FoodListModel: Codable {
		let data: [FoodShowInfoModel]
	}
}

struct FoodInfoModel: Codable {
	let imgName: String
	let name: String
	let desc: String
	let level: String
	let cookTime: String
	let taste: String
	let date: String
	enum CodingKeys: String, CodingKey {
		case imgName = "image"
		case name = "dishes_name"
		case desc = "dishes_title"
		case level = "hard_level"
		case cookTime = "cooking_time"
		case taste
		case date = "last_update"
	}
}

struct FoodShowInfoModel: Codable {
	let id: String
	let imgName: String
	let name: String
	let desc: String
	let level: String
	let cookTime: String
	let taste: String?
	enum CodingKeys: String, CodingKey {
		case id = "dishes_id"
		case imgName = "image"
		case name = "title"
		case desc = "content"
		case level = "hard_level"
		case cookTime = "cookie"
		case taste
	}
}
