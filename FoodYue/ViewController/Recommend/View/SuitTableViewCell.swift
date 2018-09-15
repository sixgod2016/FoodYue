//
//  SuitTableViewCell.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class SuitTableViewCell: UITableViewCell {
	
	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = #imageLiteral(resourceName: "instead_n")
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = 3.0
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "默认食物"
		label.font = UIFont(name: fontName, size: 18.0)
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	private lazy var funcLabel: UILabel = {
		let label = UILabel()
		label.text = "默认功效"
		label.font = UIFont(name: fontName, size: 14.0)
		label.numberOfLines = 0
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

extension SuitTableViewCell {
	private func basicSetting() {
		selectionStyle = .none
	}
	
	func setData(_ data: SuitModel) {
		imgView.kf.setImage(with: URL(string: data.imgName), placeholder: #imageLiteral(resourceName: "instead_n"))
		nameLabel.text = data.name
		funcLabel.text = data.desc
	}
	
	private func configureUI() {
		addSubview(imgView)
		addSubview(nameLabel)
		addSubview(funcLabel)
		makeConstraints()
	}
	
	private func makeConstraints() {
		imgView.snp.makeConstraints { (make) in
			make.top.left.equalTo(5 * ratio)
			make.width.height.equalTo(screenWidth / 3)
			make.bottom.equalTo(-5 * ratio)
		}
		nameLabel.snp.makeConstraints { (make) in
			make.top.equalTo(20 * ratio)
			make.left.equalTo(imgView.snp.right).offset(10 * ratio)
		}
		funcLabel.snp.makeConstraints { (make) in
			make.top.equalTo(nameLabel.snp.bottom).offset(30 * ratio)
			make.left.equalTo(imgView.snp.right).offset(10 * ratio)
			make.right.equalTo(-10 * ratio)
		}
	}
}
