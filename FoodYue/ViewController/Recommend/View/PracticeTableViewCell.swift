//
//  PracticeTableViewCell.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class PracticeTableViewCell: UITableViewCell {

	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.contentMode = .scaleAspectFill
		imgView.image = #imageLiteral(resourceName: "instead_l")
		imgView.layer.cornerRadius = 3.0
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	private lazy var descLabel: UILabel = {
		let label = UILabel()
		label.text = "默认描述XXX"
		label.font = UIFont(name: fontName, size: 16.0)
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		basicSetting()
		configureUI()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension PracticeTableViewCell  {
	
	private func basicSetting() {
		selectionStyle = .none
	}
	
	func setData(_ data: PracticeStepModel) {
		imgView.kf.setImage(with: URL(string: data.imgName), placeholder: #imageLiteral(resourceName: "instead_l"))
		descLabel.text = "\(data.stepOrder). \(data.desc)"
	}
	
	private func configureUI() {
		addSubview(imgView)
		addSubview(descLabel)
		makeConstraints()
	}
	
	private func makeConstraints() {
		imgView.snp.makeConstraints { (make) in
			make.top.left.equalTo(5 * ratio)
			make.right.equalTo(-5 * ratio)
			make.height.equalTo(180 * ratio)
		}
		
		descLabel.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(5 * ratio)
			make.left.equalTo(20 * ratio)
			make.right.bottom.equalTo(-5 * ratio)
		}
	}
}
