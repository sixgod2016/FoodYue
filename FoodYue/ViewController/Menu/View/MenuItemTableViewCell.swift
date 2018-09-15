//
//  MenuItemTableViewCell.swift
//  FoodYue
//
//  Created by 222 on 2018/9/14.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

protocol MenuItemTableViewCellDelegate {
	func cellButtonClick(_ btn: CustomButton, _ selectedSection: Int)
}

class MenuItemTableViewCell: UITableViewCell {

	var delegate: MenuItemTableViewCellDelegate?
	
	private var selectedSection = -1
	
	private let btnColors = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.7685186781, green: 0.8536061754, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.7156821507, blue: 0.6808976553, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)]
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		basicSetting()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension MenuItemTableViewCell {
	
	private func basicSetting() {
		selectionStyle = .none
	}
	
	func configure(_ data: MISectionModel, _ selectedIdx: Int) {
		let dataArr = data.data
		selectedSection = selectedIdx
		let numOfLine = 4
		let btnSpace = 5 * ratio
		let btnWidth = (screenWidth - btnSpace * CGFloat(numOfLine + 1)) / CGFloat(numOfLine)
		let btnHeight = btnWidth / 5 * 3
		subviews.forEach { (view) in
			view.removeFromSuperview()
		}
		dataArr.enumerated().forEach { (idx, model) in
			let row = Int(ceil(Double(idx + 1) / Double(numOfLine))) - 1
			let column = idx % numOfLine
			let btn  = cellBtn(model.name, Int(model.id)!, model.imgName ?? "")
			btn.frame = CGRect(x: btnSpace * CGFloat(column + 1) + CGFloat(column) * btnWidth , y: btnSpace * CGFloat(row + 1) + btnHeight * CGFloat(row), width: btnWidth, height: btnHeight)
			addSubview(btn)
		}
	}
	
	private func cellBtn(_ ttl: String, _ idx: Int, _ imgName: String) -> CustomButton {
		let btn = CustomButton(type: .custom)
		btn.imgName = imgName
		btn.tag = idx
		btn.backgroundColor = btnColors[Int(arc4random_uniform(10))]
		btn.setTitle(ttl, for: .normal)
		btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
		btn.titleLabel?.font = UIFont(name: fontName, size: 14.0)
		btn.layer.cornerRadius = 10.0 * ratio
		btn.layer.masksToBounds = true
		btn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
		return btn
	}
	
	@objc private func buttonClick(_ sender: CustomButton) {
		delegate?.cellButtonClick(sender, selectedSection)
	}
	
}

class CustomButton: UIButton {
	var imgName: String = ""
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
