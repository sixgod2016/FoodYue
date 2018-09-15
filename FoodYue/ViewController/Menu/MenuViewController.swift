//
//  MenuViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/11.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class MenuViewController: FoodYueViewController {

	private lazy var segmentView: GDMSegmentView = {
		let segment = GDMSegmentView(frame: CGRect(x: 0, y: naviHeight, width: screenWidth, height: 40 * ratio))
		segment.delegate = self
		return segment
	}()
	
	private var selectedIndex = 0
	
	private lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView(frame: CGRect(x: 0, y: 40 * ratio + naviHeight, width: screenWidth, height: screenHeight - 40 * ratio - naviHeight - tabHeight))
		scroll.contentSize = CGSize(width: screenWidth * 2, height: screenHeight - 40 * ratio - naviHeight - tabHeight)
		scroll.bounces = false
		scroll.isPagingEnabled = true
		scroll.showsVerticalScrollIndicator = false
		scroll.showsHorizontalScrollIndicator = false
		scroll.isScrollEnabled = false
		return scroll
	}()
	
	override func loadView() {
		super.loadView()
		configureUI()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
}

extension MenuViewController: GDMSegmentViewDelegate {
	
	//MARK: - 😀基本设置😀
	private func basicSetting() {
		
	}
	
	//MARK: - 😞addTarget😞
	private func addTarget() {
		
	}
	
	//MARK: - ☺️UI设置☺️
	private func configureUI() {
		configureSegment()
		configureScroll()
	}
	
	//MARK: 设置segmentView
	private func configureSegment() {
		segmentView.configureFor(titles: ["菜谱", "食材"])
		view.addSubview(segmentView)
	}
	
	private func configureScroll() {
		view.addSubview(scrollView)
		
		for idx in 0 ..< 2 {
			let item = MenuItemViewController()
			item.idx = idx
			addChildViewController(item)
			scrollView.addSubview(item.view)
			item.view.frame = CGRect(x: CGFloat(idx) * screenWidth, y: 0, width: screenWidth, height: screenHeight - 40 * ratio - naviHeight - tabHeight)
		}
	}
	
	//MARK: - 😘网络请求😘
	private func configureNetwork() {
		
	}
	
	//MARK: - 🤪代理🤪
	func GDMSegmentViewCurrentPageNum(idx: Int) {
		selectedIndex = idx
		scrollView.contentOffset = CGPoint(x: CGFloat(idx) * screenWidth, y: 0)
	}
	
	//MARK: - 😫点击😫
	
	//MARK: - 🤯其他🤯
	
}
