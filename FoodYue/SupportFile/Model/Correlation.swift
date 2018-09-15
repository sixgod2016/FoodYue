//
//  Correlation.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct CorrelationTotalModel: Codable {
	let data: CorrelationModel
}

struct CorrelationModel: Codable {
	let imgName: String
	let knowledge: String
	let guide: String
	enum CodingKeys: String, CodingKey {
		case imgName = "image"
		case knowledge = "nutrition_analysis"
		case guide = "production_direction"
	}
}
