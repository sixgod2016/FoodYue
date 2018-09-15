//
//  MaterialViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON

class MaterialViewController: FoodYueViewController {

	var dishId: String = "" {
		didSet {
			configureNetwork()
		}
	}
	
	private var spicesArr: [SpiceModel] = [] {
		didSet {
			if materialArr.count > 0 {
				mainTable.reloadData()
			}
		}
	}
	
	private var materialArr: [MaterialModel] = [] {
		didSet {
			if spicesArr.count > 0 {
				mainTable.reloadData()
			}
		}
	}
	
	private let cellName1 = "MaterialTableViewCell"
	private let cellName2 = "SpicesTableViewCell"
	
	lazy var mainTable: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.dataSource = self
		table.delegate = self
		table.register(MaterialTableViewCell.self, forCellReuseIdentifier: cellName1)
		table.register(SpicesTableViewCell.self, forCellReuseIdentifier: cellName2)
		table.estimatedRowHeight = 100.0
		table.estimatedSectionHeaderHeight = 10.0
		table.estimatedSectionFooterHeight = 10.0
		table.separatorStyle = .none
		table.tableFooterView = UIView()
		return table
	}()
	
	override func loadView() {
		super.loadView()
		configureUI()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		basicSetting()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mainTable.reloadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
}

extension MaterialViewController: UITableViewDataSource, UITableViewDelegate {
	//MARK: - 😀基本设置😀
	private func basicSetting() {
		
	}
	
	//MARK: - 😞addTarget😞
	private func addTarget() {
		
	}
	
	//MARK: - ☺️UI设置☺️
	private func configureUI() {
		view.addSubview(mainTable)
		makeConstraints()
	}
	
	private func makeConstraints() {
		mainTable.snp.makeConstraints { (make) in
			make.top.equalTo(44.0 * ratio)
			make.left.right.equalToSuperview()
			make.bottom.equalTo(-naviHeight)
		}
	}
	
	//MARK: - 😘网络请求😘
	private func configureNetwork() {
		provider.request(Service.material(dishId)) { (result) in
			switch result {
			case .success(let respone):
				let dataDict = try! respone.mapJSON()
				let model = conversion(dataDict, MaterialTotalModel.self)
				self.spicesArr = model.data.spices
				self.materialArr = model.data.material
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	//MARK: - 🤪代理🤪
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return materialArr.count
		} else {
			return spicesArr.count
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == 0 {
			return 0
		}
		return 10.0
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if section == 0 {
			return 10.0
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: cellName1, for: indexPath) as! MaterialTableViewCell
			cell.setData(materialArr[indexPath.row])
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: cellName2, for: indexPath) as! SpicesTableViewCell
			cell.setData(spicesArr[indexPath.row])
			return cell
		}
	}
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
}
