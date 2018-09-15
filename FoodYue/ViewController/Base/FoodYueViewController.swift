//
//  FoodYueViewController.swift
//  FoodYue
//
//  Created by 222 on 2018/9/11.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit
import SwiftyJSON
import Reachability

class FoodYueViewController: UIViewController {
	
	let reachability = Reachability()!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		basicSetting()
		try! reachability.startNotifier()
		receiveNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	deinit {
		reachability.stopNotifier()
		NotificationCenter.default.removeObserver(self)
	}
	
}

extension FoodYueViewController {
	
	private func basicSetting() {
		view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
	}
	
	@objc func receiveNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: .reachabilityChanged, object: nil)
	}
	
	@objc func reachabilityChanged(notification: Notification) {
		switch reachability.connection {
		case .wifi, .cellular:
			NotificationCenter.default.post(name: NSNotification.Name.init("personalServiceNotication"), object: nil)
		case .none:
			self.noticeOnlyText("无网络 请检查网络设置")
		}
	}
}
