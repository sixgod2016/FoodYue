//
//  RecommendTableViewCell.swift
//  FoodYue
//
//  Created by 222 on 2018/9/12.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import Kingfisher

protocol RecommendTableViewCellDelegate {
	func pushNextPage(_ id: String, _ title: String)
}

class RecommendTableViewCell: UITableViewCell {

	var delegate: RecommendTableViewCellDelegate?
	
	private var title: String = ""
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14.0)
		label.sizeToFit()
		return label
	}()
	
	lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = #imageLiteral(resourceName: "instead_l")
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = 5.0
		imgView.layer.masksToBounds = true
		
		return imgView
	}()
	
	lazy var contentLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: fontName, size: 12.0)
		label.numberOfLines = 0
		label.sizeToFit()
		label.isHidden = true
		return label
	}()
	
	lazy var nextBtn: UIButton = {
		let btn = UIButton(type: .custom)
		btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		btn.setImage(#imageLiteral(resourceName: "nextPage").cornerImage(size: CGSize(width: 25, height: 25)), for: .normal)
		btn.imageView?.contentMode = .center
		btn.layer.cornerRadius = 15 * ratio
		btn.layer.shadowRadius = 3
		btn.layer.shadowOpacity = 0.4
		btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
		btn.layer.shadowOffset = CGSize(width: 0, height: 4)
		return btn
	}()
	
	var select: Bool = false {
		didSet {
			self.contentLabel.isHidden = !self.select
			reAddConstraints(select)
		}
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		basicSetting()
		configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension RecommendTableViewCell {
	
	private func basicSetting() {
		selectionStyle = .none
		addTarget()
	}
	
	func addTarget() {
		nextBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
	}
	
	func setData(_ data: TopCellModel, _ selected: Bool) {
		imgView.kf.setImage(with: URL(string: data.imageName), placeholder: #imageLiteral(resourceName: "instead_l"))
		titleLabel.attributedText = setupTitleLabel(data.title, data.description)
		title = data.title
		contentLabel.text = data.content
		nextBtn.tag = Int(data.id)!
		select = selected
	}
	
	private func setupTitleLabel(_ ttl: String, _ desc: String) -> NSMutableAttributedString {
		let titleText = NSMutableAttributedString(string: "\(ttl)  \(desc)")
		titleText.addAttribute(.font, value: UIFont(name: fontName, size: 16.0)!, range: NSMakeRange(0, ttl.count))
		titleText.addAttribute(.font, value: UIFont(name: fontName, size: 12.0)!, range: NSMakeRange(ttl.count + 2, desc.count))
		return titleText
	}
	
	private func configureUI() {
		addSubview(imgView)
		addSubview(titleLabel)
		addSubview(contentLabel)
		addSubview(nextBtn)
		addConstraints()
	}
	
	private func addConstraints() {
		imgView.snp.makeConstraints { (make) in
			make.top.equalTo(5 * ratio)
			make.left.equalTo(5 * ratio)
			make.right.equalTo(-5 * ratio)
			make.height.equalTo(200 * ratio)
		}
		
		nextBtn.snp.makeConstraints { (make) in
			make.right.bottom.equalTo(imgView).offset(-10 * ratio)
			make.size.equalTo(CGSize(width: 30 * ratio, height: 30 * ratio))
		}
		
		titleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(5 * ratio)
			make.centerX.equalToSuperview()
			make.bottom.equalTo(-5 * ratio)
		}
	}
	
	private func reAddConstraints(_ selected: Bool) {
		titleLabel.snp.remakeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(5 * ratio)
			make.centerX.equalToSuperview()
			if !selected {
				make.bottom.equalTo(-5 * ratio)
			}
		}
		
		if selected {
			contentLabel.snp.remakeConstraints { (make) in
				make.top.equalTo(titleLabel.snp.bottom).offset(5 * ratio)
				make.left.equalTo(5 * ratio)
				make.right.equalTo(-5 * ratio)
				make.bottom.equalTo(-5 * ratio)
			}
		} else {
			contentLabel.snp.removeConstraints()
		}
	}
	
	@objc private func buttonClick(sender: UIButton) {
		delegate?.pushNextPage("\(sender.tag)", title)
	}
	
}
