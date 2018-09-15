//
//  MenuListViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/14.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class MenuListViewController: FoodYueViewController {

	var kindId: Int = -1 {
		didSet {
			configureNetwork()
		}
	}
	
	private var pageNum: Int = 1 {
		didSet {
			configureNetwork()
		}
	}
	
	private var dataList: [TopCellModel] = [] {
		didSet {
			mainTable.reloadData()
		}
	}
	
	private let cellName = "RecommendTableViewCell"
	
	private lazy var mainTable: UITableView = {
		let table = UITableView(frame: CGRect.zero, style: .plain)
		table.dataSource = self
		table.delegate = self
		table.register(RecommendTableViewCell.self, forCellReuseIdentifier: cellName)
		table.estimatedRowHeight = 200
		table.showsVerticalScrollIndicator = false
		table.separatorStyle = .none
		return table
	}()
	
	private var selectedIndex: Int = -1
	
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

extension MenuListViewController: UITableViewDataSource, UITableViewDelegate, RecommendTableViewCellDelegate {
	
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
		addConstraints()
	}
	
	private func addConstraints() {
		mainTable.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
	}
	
	//MARK: - 😘网络请求😘
	private func configureNetwork() {
		provider.request(Service.menuList("\(kindId)", "\(pageNum)")) { (result) in
			switch result {
			case .success(let response):
				let dataDict = try! response.mapJSON()
				let model = conversion(dataDict, TopListModel.self)
				if let temp = model.data.data {
					if self.pageNum == 1 {
						self.dataList = temp
						self.addTarget()
					} else {
						self.dataList += temp
						if temp.count < 10 {
							self.mainTable.mj_footer.endRefreshingWithNoMoreData()
						}
						self.mainTable.mj_footer.endRefreshing()
					}
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	//MARK: - 🤪代理🤪
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataList.count
	}
	
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! RecommendTableViewCell
		cell.delegate = self
		cell.setData(dataList[indexPath.row], selectedIndex == indexPath.row)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let oldIndexPath = IndexPath(row: selectedIndex == -1 ? 0 : selectedIndex, section: indexPath.section)
		selectedIndex = indexPath.row
		tableView.reloadRows(at: [oldIndexPath, indexPath], with: .none)
	}
	
	func pushNextPage(_ id: String, _ title: String) {
		let next = DishesViewController()
		next.dishId = id
		next.title = title
		navigationController?.pushViewController(next, animated: true)
	}
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
}
