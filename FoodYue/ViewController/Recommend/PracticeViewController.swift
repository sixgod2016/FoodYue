//
//  PracticeViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON

class PracticeViewController: FoodYueViewController {

	var dishId: String = "" {
		didSet {
			configureNetwork()
		}
	}
	
	private var dataArr: [PracticeStepModel] = [] {
		didSet {
			mainTable.reloadData()
		}
	}
	
	private let cellName = "PracticeTableViewCell"
	
	private lazy var mainTable: UITableView = {
		let table = UITableView(frame: .zero, style: .plain)
		table.dataSource = self
		table.delegate = self
		table.register(PracticeTableViewCell.self, forCellReuseIdentifier: cellName)
		table.estimatedRowHeight = 200.0
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension PracticeViewController: UITableViewDataSource, UITableViewDelegate {
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
		provider.request(Service.practice(dishId)) { (result) in
			switch result {
			case .success(let respone):
				let dataDict = try! respone.mapJSON()
				let model = conversion(dataDict, PracticeTotalModel.self)
				self.dataArr = model.data.step
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	//MARK: - 🤪代理🤪
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArr.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! PracticeTableViewCell
		cell.setData(dataArr[indexPath.row])
		return cell
	}
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
}
