//
//  TopList.swift
//  FoodYue
//
//  Created by 222 on 2018/9/12.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation

struct TopListModel: Codable {
	let data: TopListDataListModel
	struct TopListDataListModel: Codable {
		let data: [TopCellModel]?
	}
}

struct TopCellModel: Codable {
	let id: String
	let title: String
	let description: String
	let imageName: String
	let content: String
	enum CodingKeys: String, CodingKey {
		case id = "dishes_id"
		case title
		case description
		case imageName = "image"
		case content
	}
}
