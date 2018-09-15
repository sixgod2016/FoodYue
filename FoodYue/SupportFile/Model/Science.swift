//
//  Science.swift
//  FoodYue
//
//  Created by 222 on 2018/9/15.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct ScienceTotalModel: Codable {
	let data: ScienceModel
}

struct ScienceModel: Codable {
	let pick: String
	let pickImgName: String
	let effect: String
	let effectImgName: String
	let applied: String
	let appliedImgName: String
	enum CodingKeys: String, CodingKey {
		case pick
		case pickImgName = "pick_image"
		case effect
		case effectImgName = "effect_image"
		case applied
		case appliedImgName = "applied_image"
	}
}
