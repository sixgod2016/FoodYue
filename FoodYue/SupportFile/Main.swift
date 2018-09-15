
//
//  Main.swift
//  FoodYue
//
//  Created by 222 on 2018/9/11.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

//MARK: - 尺寸
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

let ratio = screenWidth / 375

let naviHeight: CGFloat = screenHeight == 812.0 ? 44 + 44 : 20 + 44
let tabHeight: CGFloat = screenHeight == 812.0 ? 34 + 49 : 49

//MARK: RecommendTableViewCell
let cellNormalHeight = 150 * ratio
let cellFullyHeight = 200 * ratio

//MARK: - 颜色
let mainColor = UIColor(red: 253/255.0, green: 178/255.0, blue: 6/255.0, alpha: 1.0)
//MARK: - 字体
let fontName = "PingFangTC-Thin"

//MARK: - 转换
//将字典转为Data,然后转为Model
func conversion<T>(_ dataDict: Any, _ type: T.Type) -> T where T : Decodable {
	let data = try? JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
	let decoder = JSONDecoder()
	let model = try! decoder.decode(type, from: data!)
	return model
}

//获取当前ViewController
func getCurrentViewController() -> UIViewController {
	var result: UIViewController
	var window = UIApplication.shared.keyWindow
	if window?.windowLevel != UIWindowLevelNormal {
		let windows = UIApplication.shared.windows
		for temp in windows {
			if temp.windowLevel == UIWindowLevelNormal {
				window = temp
				break
			}
		}
	}
	let frontView = window?.subviews.first
	let next = frontView?.next
	if (next?.isKind(of: UIViewController.self))! {
		if (next?.isKind(of: UITabBarController.self))! {
			result = (next as! UITabBarController).selectedViewController!
			if result.isKind(of: UINavigationController.self) {
				result = (result as! UINavigationController).visibleViewController!
			}
		} else if (next?.isKind(of: UINavigationController.self))! {
			result = (next as! UINavigationController).visibleViewController!
		} else {
			result = next as! UIViewController
		}
	} else {
		result = (window?.rootViewController)!
	}
	return result
}
