//
//  ScienceViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/15.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScienceViewController: FoodYueViewController {

	var kindId: Int = -1 {
		didSet {
			configureNetwork()
		}
	}
	
	private lazy var scroll: UIScrollView = {
		let scroll = UIScrollView()
		return scroll
	}()
	
	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = #imageLiteral(resourceName: "instead_l")
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = 5.0 * ratio
		imgView.layer.masksToBounds = true
		return imgView
	}()
	
	private lazy var label: UILabel = {
		let label = UILabel()
		label.text = "默认内容"
		label.font = UIFont(name: fontName, size: 14.0)
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	override func loadView() {
		super.loadView()
		configureUI()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		basicSeting()
		configureNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ScienceViewController {
	
	private func basicSeting() {
		
	}
	
	private func setData(_ imgName: String, _ content: String) {
		imgView.kf.setImage(with: URL(string: imgName), placeholder: #imageLiteral(resourceName: "instead_l"))
		label.text = content
	}
	
	private func configureUI() {
		view.addSubview(scroll)
		scroll.addSubview(imgView)
		scroll.addSubview(label)
		
		scroll.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		imgView.snp.makeConstraints { (make) in
			make.top.left.equalTo(5 * ratio)
			make.width.equalTo(screenWidth - 10 * ratio)
			make.height.equalTo(200 * ratio)
		}
		
		label.snp.makeConstraints { (make) in
			make.top.equalTo(imgView.snp.bottom).offset(5 * ratio)
			make.left.equalTo(5 * ratio)
			make.width.equalTo(screenWidth - 10 * ratio)
			make.bottom.equalTo(-5 * ratio)
		}
	}
	
	private func configureNetwork() {
		provider.request(Service.science("\(kindId)")) { (result) in
			switch result {
			case .success(let response):
				let dataDict = try! response.mapJSON()
				let model = conversion(dataDict, ScienceTotalModel.self)
				switch self.title {
				case "选购要诀":
					self.setData(model.data.pickImgName, model.data.pick)
				case "营养成分":
					self.setData(model.data.effectImgName, model.data.effect)
				case "食物百科":
					self.setData(model.data.appliedImgName, model.data.applied)
				default: break
 				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
