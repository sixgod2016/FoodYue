//
//  IngredientsViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/14.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class IngredientsViewController: FoodYueViewController {

	var kindId: Int = -1 {
		didSet {
			configureNetwork()
		}
	}
	
	var imgName: String = "" {
		didSet {
			headerView.imgView.kf.setImage(with: URL(string: imgName), placeholder: #imageLiteral(resourceName: "instead_l"))
		}
	}
	
	private var dataArr: [FoodShowInfoModel] = [] {
		didSet {
			mainTable.reloadData()
		}
	}
	
	private var pageNum = 1 {
		didSet {
			configureNetwork()
		}
	}
	
	private let cellName = "IngredientsTableViewCell"
	
	private lazy var headerView: IngredientsHeaderView = {
		let view = IngredientsHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250 * ratio))
		view.delegate = self
		return view
	}()
	
	private lazy var mainTable: UITableView = {
		let table = UITableView(frame: CGRect.zero, style: .plain)
		table.dataSource = self
		table.delegate = self
		table.register(IngredientsTableViewCell.self, forCellReuseIdentifier: cellName)
		table.tableHeaderView = headerView
		table.estimatedRowHeight = 100.0
		table.estimatedSectionHeaderHeight = 30 * ratio
		table.tableFooterView = UIView()
		return table
	}()
	
	override func loadView() {
		super.loadView()
		configureUI()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		addTarget()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension IngredientsViewController: UITableViewDataSource, UITableViewDelegate, IngredientsHeaderViewDelegate {
	
	//MARK: - 😀基本设置😀
	private func basicSetting() {
		
	}
	
	//MARK: - 😞addTarget😞
	private func addTarget() {
		mainTable.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
			self.pageNum += 1
		})
	}
	
	//MARK: - ☺️UI设置☺️
	private func configureUI() {
		view.addSubview(mainTable)
		mainTable.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
	}
	
	//MARK: - 😘网络请求😘
	private func configureNetwork() {
		provider.request(Service.ingredientsList("\(kindId)", "\(pageNum)")) { (result) in
			switch result {
			case .success(let response):
				let dataDict = try! response.mapJSON()
				let model = conversion(dataDict, FoodListTotalModel.self)
				if self.pageNum == 1 {
					self.dataArr = model.data.data
				} else {
					self.dataArr += model.data.data
					if model.data.data.count < 10 {
						self.mainTable.mj_footer.endRefreshingWithNoMoreData()
					}
					self.mainTable.mj_footer.endRefreshing()
				}
				
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	//MARK: - 🤪代理🤪
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArr.count
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 30 * ratio)
		view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		let label = UILabel()
		label.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 30 * ratio)
		label.textAlignment = .center
		label.text = "菜谱"
		label.font = UIFont(name: fontName, size: 16.0)
		view.addSubview(label)
		return view
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! IngredientsTableViewCell
		cell.setData(dataArr[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let next = DishesViewController()
		next.title = dataArr[indexPath.row].name
		next.dishId = dataArr[indexPath.row].id
		navigationController?.pushViewController(next, animated: true)
	}
	
	func pushNextPage(_ idx: Int) {
		let titleStr: String
		
		switch idx {
		case 0:
			titleStr = "选购要诀"
		case 1:
			titleStr = "营养成分"
		case 2:
			titleStr = "食物百科"
		default:
			titleStr = ""
			break
		}
		let next = ScienceViewController()
		next.title = titleStr
		next.kindId = kindId
		navigationController?.pushViewController(next, animated: true)
	}
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
	
}
