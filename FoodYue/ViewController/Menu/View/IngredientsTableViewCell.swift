//
//  IngredientsTableViewCell.swift
//  FoodYue
//
//  Created by 222 on 2018/9/14.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = #imageLiteral(resourceName: "instead_n")
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = 5.0 * ratio
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "默认题目"
		label.font = UIFont(name: fontName, size: 16.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var descLabel: UILabel = {
		let label = UILabel()
		label.text = "默认描述"
		label.font = UIFont(name: fontName, size: 14.0)
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	private lazy var levelLabel: UILabel = {
		let label = UILabel()
		label.text = "难易度：默认"
		label.font = UIFont(name: fontName, size: 14.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var tasteLabel: UILabel = {
		let label = UILabel()
		label.text = "口味：默认"
		label.font = UIFont(name: fontName, size: 14.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var timeLabel: UILabel = {
		let label = UILabel()
		label.text = "烹饪时间：默认时间"
		label.font = UIFont(name: fontName, size: 14.0)
		label.sizeToFit()
		return label
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension IngredientsTableViewCell {
	
	func setData(_ data: FoodShowInfoModel) {
		imgView.kf.setImage(with: URL(string: data.imgName), placeholder: #imageLiteral(resourceName: "instead_n"))
		titleLabel.text = data.name
		descLabel.text = data.desc
		levelLabel.text = "难易度：\(data.level)"
		tasteLabel.text = "口味：\((data.taste?.count)! > 0 ? data.taste! : "默认口味")"
		timeLabel.text = "烹饪时间：\(data.cookTime)"
	}
	
	private func configureUI() {
		addSubview(imgView)
		addSubview(titleLabel)
		addSubview(descLabel)
		addSubview(levelLabel)
		addSubview(tasteLabel)
		addSubview(timeLabel)
		makeConstraints()
	}
	
	private func makeConstraints() {
		imgView.snp.makeConstraints { (make) in
			make.top.left.equalTo(10 * ratio)
			make.size.equalTo(CGSize(width: 100 * ratio, height: 100 * ratio))
		}
		
		titleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(10 * ratio)
			make.left.equalTo(imgView.snp.right).offset(10 * ratio)
			make.right.equalTo(-10 * ratio)
		}
		
		descLabel.snp.makeConstraints { (make) in
			make.top.equalTo(titleLabel.snp.bottom).offset(5 * ratio)
			make.left.equalTo(imgView.snp.right).offset(10 * ratio)
			make.right.equalTo(-10 * ratio)
		}
		
		levelLabel.snp.makeConstraints { (make) in
			make.top.equalTo(descLabel.snp.bottom).offset(5 * ratio)
			make.left.equalTo(imgView.snp.right).offset(10 * ratio)
		}
		
		tasteLabel.snp.makeConstraints { (make) in
			make.centerY.equalTo(levelLabel)
			make.left.equalTo(levelLabel.snp.right).offset(10 * ratio)
		}
		timeLabel.snp.makeConstraints { (make) in
			make.top.equalTo(levelLabel.snp.bottom).offset(5 * ratio)
			make.left.equalTo(imgView.snp.right).offset(10 * ratio)
			make.bottom.equalTo(-10 * ratio)
		}
	}
}
