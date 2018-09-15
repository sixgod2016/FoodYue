//
//  MenuItemViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/14.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON

class MenuItemViewController: FoodYueViewController {

	var idx: Int = -1 {
		didSet {
			configureNetwork()
		}
	}
	
	var dataArr: [MISectionModel] = [] {
		didSet {
			mainTable.reloadData()
		}
	}
	
	private let cellName = "MenuItemTableViewCell"
	
	private lazy var mainTable: UITableView = {
		let table = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 40 * ratio - naviHeight - tabHeight), style: .grouped)
		table.dataSource = self
		table.delegate = self
		table.estimatedRowHeight = 100.0
		table.estimatedSectionHeaderHeight = 50 * ratio
		table.estimatedSectionFooterHeight = 0.01
		table.register(MenuItemTableViewCell.self, forCellReuseIdentifier: cellName)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
}

extension MenuItemViewController: UITableViewDelegate, UITableViewDataSource, MenuItemTableViewCellDelegate {
	
	//MARK: - 😀基本设置😀
	private func basicSetting() {
		view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	}
	
	//MARK: - 😞addTarget😞
	private func addTarget() {
		
	}
	
	//MARK: - ☺️UI设置☺️
	private func configureUI() {
		view.addSubview(mainTable)
	}
	
	//MARK: - 😘网络请求😘
	private func configureNetwork() {
		provider.request(idx == 0 ? Service.menu : Service.ingredients) { (result) in
			switch result {
			case .success(let response):
				let dataDict = try! response.mapJSON()
				let model = conversion(dataDict, MITotalModel.self)
				self.dataArr = model.data.data
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	//MARK: - 🤪代理🤪
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let numOfLine = 4
		let btnSpace = 5 * ratio
		let btnWidth = (screenWidth - btnSpace * CGFloat(numOfLine + 1)) / CGFloat(numOfLine)
		let btnHeight = btnWidth / 5 * 3
		let number = dataArr[indexPath.section].data.count
		let row = Int(ceil(Double(number) / Double(numOfLine)))
		return btnSpace * CGFloat(row + 1) + btnHeight * CGFloat(row)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return dataArr.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50 * ratio))
		headerView.subviews.forEach { (view) in
			view.removeFromSuperview()
		}
		let headerLabel = UILabel()
		headerLabel.text = "默认header"
		headerLabel.font = UIFont(name: fontName, size: 16.0)
		headerLabel.text = dataArr[section].name
		headerLabel.sizeToFit()
		headerLabel.center = headerView.center
		headerView.addSubview(headerLabel)
		return headerView
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! MenuItemTableViewCell
		cell.delegate = self
		cell.configure(dataArr[indexPath.section], idx)
		return cell
	}
	
	func cellButtonClick(_ btn: CustomButton, _ selectedSection: Int) {
		if selectedSection == 0 {
			let next = MenuListViewController()
			next.kindId = btn.tag
			next.title = btn.titleLabel?.text
			navigationController?.pushViewController(next, animated: true)
		} else {
			let next = IngredientsViewController()
			next.kindId = btn.tag
			next.title = btn.titleLabel?.text
			next.imgName = btn.imgName
			navigationController?.pushViewController(next, animated: true)
		}
		
	}
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
	
}
