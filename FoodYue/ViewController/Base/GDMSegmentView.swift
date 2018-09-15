//
//  GDMSegmentView.swift
//  SportsInformation
//
//  Created by 222 on 2018/8/13.
//  Copyright © 2018年 HuoGuo. All rights reserved.
//

import UIKit

protocol GDMSegmentViewDelegate {
	func GDMSegmentViewCurrentPageNum(idx: Int)
}

class GDMSegmentView: UIView {

	var number: Int!
	var selected: Int!
	var delegate: GDMSegmentViewDelegate?
	
	lazy var selectView: UIView = {
		let view = UIView(frame: CGRect(x: 15 * ratio, y: frame.size.height - 2, width: screenWidth / CGFloat(number) - 30 * ratio, height: 2))
		view.backgroundColor = mainColor
		return view
	}()
	
	lazy var bottomLine: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: frame.size.height - 0.5, width: screenWidth, height: 0.5))
		view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		return view
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		subviews.forEach { (view) in
			if view.isKind(of: UILabel.self) {
				let label = view as! UILabel
				label.center = CGPoint(x: screenWidth / CGFloat(number * 2) * CGFloat((label.tag - 981) * 2 + 1), y: frame.height / 2)
			}
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		let touch = (touches as NSSet).anyObject() as! UITouch
		let point = touch.location(in: self)
		let detla = frame.size.width / CGFloat(number)
		let touchNum = point.x / detla
		selected = Int(touchNum)
		setSelectItemAt(idx: selected, animated: true)
		delegate?.GDMSegmentViewCurrentPageNum(idx: selected)
	}

}

extension GDMSegmentView {
	
	func configureFor(titles: [String]) {
		cleanAll()
		number = titles.count
		titles.enumerated().forEach { (idx, ttl) in
			let label = standLabel()
			if idx == 0 {
				label.textColor = mainColor
			}
			label.tag = idx + 981
			label.text = ttl
			label.sizeToFit()
			label.backgroundColor = UIColor.clear
			self.addSubview(label)
		}
		addSubview(selectView)
		addSubview(bottomLine)
	}
	
	private func cleanAll() {
		subviews.forEach { view in
			if view.isKind(of: UILabel.self) {
				view.removeFromSuperview()
			}
		}
	}
	
	private func standLabel() -> UILabel {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth / CGFloat(number), height: 30))
		label.font = UIFont(name: fontName, size: 16.0)
		label.textColor = .black
		return label
	}
	
	private func setSelectItemAt(idx: Int, animated: Bool) {
		subviews.forEach { (view) in
			if view.isKind(of: UILabel.self) {
				let label = view as! UILabel
				if idx + 981 == label.tag {
					label.textColor = mainColor
				} else {
					label.textColor = .black
				}
			}
		}
		UIView.animate(withDuration: 0.2) {
			self.selectView.frame = CGRect(x: screenWidth / CGFloat(self.number) * CGFloat(idx) + 15 * ratio, y: self.frame.size.height - 2, width: screenWidth / CGFloat(self.number) - 30 * ratio, height: 2)
		}
	}
}
