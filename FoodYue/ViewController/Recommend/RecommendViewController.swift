//
//  RecommendViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/11.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class RecommendViewController: FoodYueViewController {

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
		configureNetwork()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension RecommendViewController: UITableViewDataSource, UITableViewDelegate, RecommendTableViewCellDelegate {
	
	//MARK: - 😀基本设置😀
	private func basicSetting() {
		
	}
	
	//MARK: - 😞addTarget😞
	private func addTarget() {
		
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
		provider.request(Service.topList) { (result) in
			switch result {
			case .success(let response):
				let dataDict = try! response.mapJSON()
				let model = conversion(dataDict, TopListModel.self)
				if let temp = model.data.data {
					self.dataList = temp
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
