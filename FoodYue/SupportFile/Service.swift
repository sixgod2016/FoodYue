//
//  Service.swift
//  FoodYue
//
//  Created by 222 on 2018/9/12.
//  Copyright © 2018年 222. All rights reserved.
//

import Foundation
import Moya
import Result
import Lottie

final class RequestPlugin: PluginType {
	
	lazy var loadingAnimationView: LOTAnimationView = {
		let view = LOTAnimationView(name: "loading.json")
		view.loopAnimation = true
		view.frame = CGRect(x: 0, y: 0, width:100 * ratio, height: 100 * ratio)
		return view
	}()
	
	func willSend(_ request: RequestType, target: TargetType) {
		DispatchQueue.main.async {
			let currentViewController = getCurrentViewController()
			currentViewController.view.addSubview(self.loadingAnimationView)
			self.loadingAnimationView.center = (currentViewController.view.center)
			self.loadingAnimationView.play()
		}
	}
	
	func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
			self.loadingAnimationView.stop()
			self.loadingAnimationView.removeFromSuperview()
		})
	}
}

let provider = MoyaProvider<Service>(plugins: [RequestPlugin()])

enum Service {
	case topList
	case dishesView(String)
	case practice(String)
	case material(String)
	case correlation(String)
	case suit(String)
	case menu
	case ingredients
	case menuList(String, String)
	case ingredientsList(String, String)
	case science(String)
}

extension Service: TargetType {
	var baseURL: URL {
		return URL(string: "http://api.izhangchu.com")!
	}
	
	var path: String {
		var path: String
		switch self {
		case .topList:
			path = "page=1&methodName=TopList&size=10&version=4.02"
		case .dishesView(let id):
			path = "user_id=&token=&methodName=DishesView&dishes_id=\(id)&version=1.0"
		case .practice(let id):
			path = "user_id=&token=&methodName=DishesView&dishes_id=\(id)&version=1.0"
		case .material(let id):
			path = "user_id=&token=&methodName=DishesMaterial&dishes_id=\(id)&version=1.0"
		case .correlation(let id):
			path = "user_id=&token=&methodName=DishesCommensense&dishes_id=\(id)&version=1.0"
		case .suit(let id):
			path = "user_id=&token=&methodName=DishesSuitable&dishes_id=\(id)&version=1.0"
		case .menu:
			path = "user_id=&token=&methodName=CategoryIndex&version=4.02"
		case .ingredients:
			path = "user_id=&token=&methodName=MaterialSubtype&version=4.02"
		case .menuList(let id, let page):
			path = "token=&user_id=&cat_id=\(id)&page=\(page)&type=1&methodName=CategorySearch&size=10&version=1.0"
		case .ingredientsList(let id, let page):
			path = "token=&user_id=&material_id=\(id)&methodName=MaterialDishes&page=\(page)&size=6&version=1.0"
		case .science(let id):
			path = "token=&user_id=&material_id=\(id)&methodName=MaterialView&version=1.0"
		}
		return path
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		return .requestPlain
	}
	
	var headers: [String : String]? {
		return [
			"Content-type": "application/json"
		]
	}
	
}
