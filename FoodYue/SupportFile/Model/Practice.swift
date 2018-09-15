//
//  Practice.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct PracticeTotalModel: Codable  {
	let data: PracticeStepsModel
	struct PracticeStepsModel: Codable {
		let step: [PracticeStepModel]
	}
}


struct PracticeStepModel: Codable {
	let stepOrder: String
	let imgName: String
	let desc: String
	enum CodingKeys: String, CodingKey {
		case stepOrder = "dishes_step_order"
		case imgName = "dishes_step_image"
		case desc = "dishes_step_desc"
	}
}
