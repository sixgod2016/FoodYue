//
//  CorrelationViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON

class CorrelationViewController: FoodYueViewController {
	
	var dishId: String = "" {
		didSet {
			configureNetwork()
		}
	}
	
	private var data: CorrelationModel? {
		didSet {
			setData()
		}
	}
	
	private lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView()
		
		return scroll
	}()
	
	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = #imageLiteral(resourceName: "instead_l")
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = 3.0
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	private lazy var knowledgeTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "相关知识"
		label.font = UIFont(name: fontName, size: 18.0)
		label.textColor = #colorLiteral(red: 1, green: 0.3347277045, blue: 0, alpha: 1)
		label.sizeToFit()
		return label
	}()
	
	private lazy var knowledgeContentLabel: UILabel = {
		let label = UILabel()
		label.text = "默认知识"
		label.numberOfLines = 0
		label.font = UIFont(name: fontName, size: 14.0)
		label.sizeToFit()
		return label
	}()
	
	private lazy var guideTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "制作指导"
		label.font = UIFont(name: fontName, size: 18.0)
		label.textColor = #colorLiteral(red: 1, green: 0.3347277045, blue: 0, alpha: 1)
		label.sizeToFit()
		return label
	}()
	
	private lazy var guideContentLabel: UILabel = {
		let label = UILabel()
		label.text = "默认指导"
		label.numberOfLines = 0
		label.font = UIFont(name: fontName, size: 14.0)
		label.sizeToFit()
		return label
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

extension CorrelationViewController {
	
	//MARK: - 😀基本设置😀
	private func basicSetting() {
		
	}
	
	//MARK: - 😞addTarget😞
	private func addTarget() {
		
	}
	
	//MARK: - ☺️UI设置☺️
	private func configureUI() {
		view.addSubview(scrollView)
		scrollView.addSubview(imgView)
		scrollView.addSubview(knowledgeTitleLabel)
		scrollView.addSubview(knowledgeContentLabel)
		scrollView.addSubview(guideTitleLabel)
		scrollView.addSubview(guideContentLabel)
		makeConstraints()
	}
	
	private func makeConstraints() {
		scrollView.snp.makeConstraints { (make) in
			make.top.equalTo(44.0 * ratio)
			make.left.right.equalToSuperview()
			make.bottom.equalTo(-naviHeight)
		}
		
		imgView.snp.makeConstraints { (make) in
			make.top.left.equalTo(5 * ratio)
			make.width.equalTo(screenWidth - 10 * ratio)
			make.height.equalTo(200 * ratio)
		}
		
		knowledgeTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(10 * ratio)
			make.left.equalTo(5 * ratio)
		}
		
		knowledgeContentLabel.snp.makeConstraints { (make) in
			make.top.equalTo(knowledgeTitleLabel.snp.bottom).offset(5 * ratio)
			make.left.equalTo(5 * ratio)
			make.width.equalTo(screenWidth - 10 * ratio)
		}
		
		guideTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(knowledgeContentLabel.snp.bottom).offset(10 * ratio)
			make.left.equalTo(5 * ratio)
		}
		
		guideContentLabel.snp.makeConstraints { (make) in
			make.top.equalTo(guideTitleLabel.snp.bottom).offset(5 * ratio)
			make.left.equalTo(5 * ratio)
			make.width.equalTo(screenWidth - 10 * ratio)
			make.bottom.equalTo(-5 * ratio)
		}
	}
	
	//MARK: - 😘网络请求😘
	private func configureNetwork() {
		provider.request(Service.correlation(dishId)) { (result) in
			switch result {
			case .success(let response):
				let dataDict = try! response.mapJSON()
				let model = conversion(dataDict, CorrelationTotalModel.self)
				self.data = model.data
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	//MARK: - 🤪代理🤪
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
	private func setData() {
		if let dataModel = data {
			imgView.kf.setImage(with: URL(string: dataModel.imgName), placeholder: #imageLiteral(resourceName: "instead_l"))
			knowledgeContentLabel.text = dataModel.knowledge
			guideContentLabel.text = dataModel.guide
		}
	}
	
}
