//
//  Suit.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct SuitTotalModel: Codable {
	let data: MaterialSuitableModel
	struct MaterialSuitableModel: Codable {
		let material: SuitableListModel
	}
	struct SuitableListModel: Codable {
		let suitable: [SuitModel]
		let notSuitable: [SuitModel]
		enum CodingKeys: String, CodingKey {
			case suitable = "suitable_with"
			case notSuitable = "suitable_not_with"
		}
	}
}

struct SuitModel: Codable {
	let name: String
	let desc: String
	let imgName: String
	enum CodingKeys: String, CodingKey {
		case name = "material_name"
		case desc = "suitable_desc"
		case imgName = "image"
	}
}
