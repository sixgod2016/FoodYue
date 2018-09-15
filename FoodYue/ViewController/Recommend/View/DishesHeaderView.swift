//
//  DishesHeaderView.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class DishesHeaderView: UIView {

	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = #imageLiteral(resourceName: "instead_l")
		imgView.contentMode = .scaleAspectFill
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	private lazy var descLabel: UILabel = {
		let label = UILabel()
		label.text = "默认食物描述"
		label.font = UIFont(name: fontName, size: 16.0)
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	private lazy var levelLabel: UILabel = {
		let label = UILabel()
		label.text = "难度：默认"
		label.font = UIFont(name: fontName, size: 12.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var timeLabel: UILabel = {
		let label = UILabel()
		label.text = "烹饪时间：默认"
		label.font = UIFont(name: fontName, size: 12.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var tasteLabel: UILabel = {
		let label = UILabel()
		label.text = "口味：默认"
		label.font = UIFont(name: fontName, size: 12.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var updateLabel: UILabel = {
		let label = UILabel()
		label.text = "XXXX-XX-XX"
		label.font = UIFont(name: fontName, size: 12.0)
		label.sizeToFit()
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension DishesHeaderView {
	
	private func basicSetting() {
		backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
	}
	
	func setData(_ data: FoodInfoModel) {
		imgView.kf.setImage(with: URL(string: data.imgName), placeholder: #imageLiteral(resourceName: "instead_l"))
		descLabel.text = data.desc
		levelLabel.text = "难度：\(data.level)"
		timeLabel.text = "烹饪时间：\(data.cookTime)"
		tasteLabel.text = "口味：\(data.taste)"
		updateLabel.text = data.date
	}
	
	private func configureUI() {
		addSubview(imgView)
		addSubview(descLabel)
		addSubview(levelLabel)
		addSubview(timeLabel)
		addSubview(tasteLabel)
		addSubview(updateLabel)
	}
	
	private func addConstraints() {
		imgView.snp.makeConstraints { (make) in
			make.top.left.right.equalToSuperview()
			make.height.equalTo(250 * ratio)
		}
		
		descLabel.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(10 * ratio)
			make.centerX.equalToSuperview()
		}
		
		levelLabel.snp.makeConstraints { (make) in
			make.top.equalTo(descLabel.snp.bottom).offset(10 * ratio)
			make.centerX.equalTo(screenWidth / 4)
		}
		
		timeLabel.snp.makeConstraints { (make) in
			make.top.equalTo(descLabel.snp.bottom).offset(10 * ratio)
			make.centerX.equalTo(screenWidth / 2)
		}
		
		tasteLabel.snp.makeConstraints { (make) in
			make.top.equalTo(descLabel.snp.bottom).offset(10 * ratio)
			make.centerX.equalTo(screenWidth * 3 / 4)
		}
		
		updateLabel.snp.makeConstraints { (make) in
			make.top.equalTo(tasteLabel.snp.bottom).offset(5 * ratio)
			make.right.equalTo(-5 * ratio)
			make.bottom.equalTo(-5 * ratio)
		}
	}
}
