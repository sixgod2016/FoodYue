//
//  FoodYueTabBarController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/11.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class FoodYueTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		basicSetting()
		setupViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension FoodYueTabBarController: UITabBarControllerDelegate {
	
	private func basicSetting() {
		delegate = self
		tabBar.isTranslucent = false
		tabBar.tintColor = mainColor
		tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		selectedIndex = 0
	}
	
	private func setupViewControllers() {
		let recommend = RecommendViewController()
		setTabBar(recommend, "推荐", "reco")
		let menu = MenuViewController()
		setTabBar(menu, "菜单", "menu")
	}
	
	private func setTabBar(_ viewController: FoodYueViewController, _ title: String, _ imgName: String) {
		viewController.title = title
		let imageName = "\(imgName)_n"
		let selectImageName = "\(imgName)_s"
		viewController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
		viewController.tabBarItem.selectedImage = UIImage(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
		let navi = FoodYueNavigationController(rootViewController: viewController)
		addChildViewController(navi)
	}
}
