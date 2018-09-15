//
//  MaterialTableViewCell.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class MaterialTableViewCell: UITableViewCell {

	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "默认食材"
		label.font = UIFont(name: fontName, size: 16.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var weightLabel: UILabel = {
		let label = UILabel()
		label.text = "默认重量"
		label.font = UIFont(name: fontName, size: 16.0)
		label.sizeToFit()
		return label
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		basicSetting()
		configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension MaterialTableViewCell {
	
	private func basicSetting() {
		selectionStyle = .none
	}
	
	func setData(_ data: MaterialModel) {
		nameLabel.text = data.name
		weightLabel.text = data.weight
	}
	
	private func configureUI() {
		addSubview(nameLabel)
		addSubview(weightLabel)
		makeConstraints()
	}
	
	private func makeConstraints() {
		nameLabel.snp.makeConstraints { (make) in
			make.top.left.equalTo(5 * ratio)
			make.bottom.equalTo(-5 * ratio)
		}
		
		weightLabel.snp.makeConstraints { (make) in
			make.top.equalTo(5 * ratio)
			make.right.bottom.equalTo(-5 * ratio)
		}
	}
	
}
