//
//  DishesViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON

class DishesViewController: FoodYueViewController {

	var dishId: String = "" {
		didSet {
			configureNetwork()
		}
	}
	
	private var headData: FoodInfoModel? {
		didSet {
			if let model = headData {
				headerView.setData(model)
			}
		}
	}
	
	private let headerView: DishesHeaderView = {
		let view = DishesHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 350 * ratio))
		return view
	}()
	
	private let titles: [String] = ["做法", "食材", "相关知识", "相宜相克"]
	
	private lazy var controllers: [FoodYueViewController] = {
		let one = PracticeViewController()
		one.dishId = dishId
		let two = MaterialViewController()
		two.dishId = dishId
		let three = CorrelationViewController()
		three.dishId = dishId
		let four = SuitViewController()
		four.dishId = dishId
		return [
			one,
			two,
			three,
			four
		]
	}()
	
	private let layout: LTLayout = {
		let layout = LTLayout()
		layout.isAverage = true
		return layout
	}()
	
	private lazy var manager: LTSimpleManager = {
		let y: CGFloat = naviHeight
		let h: CGFloat = screenHeight - tabHeight + 49
		let frame = CGRect(x: 0, y: y, width: screenWidth, height: h)
		let manager = LTSimpleManager(frame: frame, viewControllers: controllers, titles: titles, currentViewController: self, layout: layout)
		manager.delegate = self
		return manager
	}()
	
	override func loadView() {
		super.loadView()
		configureUI()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		basicSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
}

extension DishesViewController: LTSimpleScrollViewDelegate {
	
	//MARK: - 😀基本设置😀
	private func basicSetting() {
		
	}
	
	//MARK: - 😞addTarget😞
	private func addTarget() {
		
	}
	
	//MARK: - ☺️UI设置☺️
	private func configureUI() {
		view.addSubview(manager)
		configureManager()
	}
	
	private func configureManager() {
		manager.configHeaderView { () -> UIView? in
			return self.headerView
		}
		
		manager.didSelectIndexHandle { (idx) in
			
		}
	}
	
	//MARK: - 😘网络请求😘
	private func configureNetwork() {
		provider.request(Service.dishesView(dishId)) { (result) in
			switch result {
			case .success(let response):
				let dataDict = try! response.mapJSON()
				let model = conversion(dataDict, FoodInfoTotalModel.self)
				self.headData = model.data
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	//MARK: - 🤪代理🤪
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
	
}
