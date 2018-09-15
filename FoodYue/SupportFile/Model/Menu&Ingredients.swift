//
//  Menu&ingredients.swift
//  FoodYue
//
//  Created by 222 on 2018/9/14.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct MITotalModel: Codable {
	let data: MIListModel
	struct MIListModel: Codable {
		let data: [MISectionModel]
	}
}

struct MISectionModel: Codable {
	let id: String
	let name: String
	let imgName: String
	let data: [MICellModel]
	enum CodingKeys: String, CodingKey {
		case id
		case name = "text"
		case imgName = "image"
		case data
	}
}

struct MICellModel: Codable {
	let id: String
	let name: String
	let imgName: String?
	enum CodingKeys: String, CodingKey {
		case id
		case name = "text"
		case imgName = "image"
	}
}
