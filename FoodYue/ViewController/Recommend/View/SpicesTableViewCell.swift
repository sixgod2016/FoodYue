//
//  SpicesTableViewCell.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class SpicesTableViewCell: UITableViewCell {
	
	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.contentMode = .scaleAspectFill
		imgView.image = #imageLiteral(resourceName: "instead_l")
		imgView.layer.cornerRadius = 3.0
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "默认调料"
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

extension SpicesTableViewCell {
	private func basicSetting() {
		selectionStyle = .none
	}
	
	func setData(_ data: SpiceModel) {
		imgView.kf.setImage(with: URL(string: data.imgName), placeholder: #imageLiteral(resourceName: "instead_l"))
		nameLabel.text = data.title
	}
	
	private func configureUI() {
		addSubview(imgView)
		addSubview(nameLabel)
		makeConstraints()
	}
	
	private func makeConstraints() {
		imgView.snp.makeConstraints { (make) in
			make.top.left.equalTo(5 * ratio)
			make.right.equalTo(-5 * ratio)
			make.height.equalTo(200 * ratio)
		}
		
		nameLabel.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(10 * ratio)
			make.centerX.equalToSuperview()
			make.bottom.equalTo(-5 * ratio)
		}
	}
}
