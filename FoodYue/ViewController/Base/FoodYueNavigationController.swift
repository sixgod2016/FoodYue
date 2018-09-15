//
//  FoodYueNavigationController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/11.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class FoodYueNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		basicSetting()
    }

	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		if self.childViewControllers.count > 0 {
			viewController.hidesBottomBarWhenPushed = true
		}
		viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		super.pushViewController(viewController, animated: animated)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension FoodYueNavigationController {
	
	private func basicSetting() {
		navigationBar.tintColor = mainColor
		navigationBar.titleTextAttributes = [
			NSAttributedStringKey.foregroundColor: mainColor,
			NSAttributedStringKey.font: UIFont(name: fontName, size: 20.0)!
		]
	}
	
}
