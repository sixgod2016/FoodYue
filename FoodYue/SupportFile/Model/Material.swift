//
//  Material.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct MaterialTotalModel: Codable {
	let data: SpiceAndMaterialModel
	struct SpiceAndMaterialModel: Codable {
		let spices: [SpiceModel]
		let material: [MaterialModel]
	}
}

struct SpiceModel: Codable {
	let imgName: String
	let title: String
	enum CodingKeys: String, CodingKey {
		case imgName = "image"
		case title
	}
}

struct MaterialModel: Codable {
	let name: String
	let weight: String
	enum CodingKeys: String, CodingKey {
		case name = "material_name"
		case weight = "material_weight"
	}
}
