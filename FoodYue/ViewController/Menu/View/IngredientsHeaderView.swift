//
//  IngredientsHeaderView.swift
//  FoodYue
//
//  Created by 222 on 2018/9/14.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

protocol IngredientsHeaderViewDelegate {
	func pushNextPage(_ idx: Int)
}

class IngredientsHeaderView: UIView {

	var delegate: IngredientsHeaderViewDelegate?
	
	lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = #imageLiteral(resourceName: "instead_l")
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = 5.0
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	private lazy var oneBtn: UIButton = {
		let btn = UIButton(type: .custom)
		btn.tag = 1000
		btn.setImage(#imageLiteral(resourceName: "jiqiao"), for: .normal)
		return btn
	}()
	
	private lazy var twoBtn: UIButton = {
		let btn = UIButton(type: .custom)
		btn.tag = 1001
		btn.setImage(#imageLiteral(resourceName: "chengfen"), for: .normal)
		return btn
	}()
	
	private lazy var threeBtn: UIButton = {
		let btn = UIButton(type: .custom)
		btn.tag = 1002
		btn.setImage(#imageLiteral(resourceName: "baike"), for: .normal)
		return btn
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
		addTarget()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension IngredientsHeaderView {
	
	private func addTarget() {
		oneBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
		twoBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
		threeBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
	}
	
	private func configureUI() {
		addSubview(imgView)
		addSubview(oneBtn)
		addSubview(twoBtn)
		addSubview(threeBtn)
		makeConstraints()
	}
	
	private func makeConstraints() {
		imgView.snp.makeConstraints { (make) in
			make.top.left.equalTo(10 * ratio)
			make.right.equalTo(-10 * ratio)
			make.height.equalTo(200 * ratio)
		}
		
		oneBtn.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(10 * ratio)
			make.centerX.equalTo(screenWidth / 4)
			make.size.equalTo(CGSize(width: 30 * ratio, height: 30 * ratio))
			make.bottom.equalTo(-10 * ratio)
		}
		
		twoBtn.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(10 * ratio)
			make.centerX.equalTo(screenWidth / 2)
			make.size.equalTo(CGSize(width: 30 * ratio, height: 30 * ratio))
			make.bottom.equalTo(-10 * ratio)
		}
		
		threeBtn.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(10 * ratio)
			make.centerX.equalTo(screenWidth / 4 * 3)
			make.size.equalTo(CGSize(width: 30 * ratio, height: 30 * ratio))
			make.bottom.equalTo(-10 * ratio)
		}
	}
	
	@objc private func buttonClick(_ sender: UIButton) {
		switch sender.tag {
		case 1000:
			delegate?.pushNextPage(0)
		case 1001:
			delegate?.pushNextPage(1)
		case 1002:
			delegate?.pushNextPage(2)
		default:
			break
		}
	}
}
