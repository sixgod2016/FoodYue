//
//  UIImage.swift
//  FoodYue
//
//  Created by 222 on 2018/9/13.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

extension UIImage {
	//这里我对UIImage做了个扩展
	func cornerImage(size: CGSize) -> UIImage? {
		UIGraphicsBeginImageContext(size)
		guard let gc = UIGraphicsGetCurrentContext() else {  return nil }
		let radius = size.width / 2
		gc.concatenate(gc.ctm)
		gc.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: 1.5 *  3.14, endAngle:  1.5 * -3.14, clockwise: true)
		gc.closePath()
		gc.clip()
		gc.draw(self.cgImage!, in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
}

extension UIImage {
	func fixOrientation() -> UIImage? {
		print("-----> \(#function)")
		if self.imageOrientation == .up {
			return self
		}
		
		var transform = CGAffineTransform.identity
		
		switch self.imageOrientation {
		case .down, .downMirrored:
			transform = transform.translatedBy(x: self.size.width, y: self.size.height)
			transform = transform.rotated(by: CGFloat(M_PI))
		case .left, .leftMirrored:
			transform = transform.translatedBy(x: self.size.width, y: 0)
			transform = transform.rotated(by: CGFloat(M_PI_2))
		case .right, .rightMirrored:
			transform = transform.translatedBy(x: 0, y: self.size.height)
			transform = transform.rotated(by: -CGFloat(M_PI_2))
		default:
			print("1 is normal")
		}
		
		switch self.imageOrientation {
		case .upMirrored, .downMirrored:
			transform = transform.translatedBy(x: self.size.width, y: 0)
			transform = transform.scaledBy(x: -1, y: 1)
		case .leftMirrored, .rightMirrored:
			transform = transform.translatedBy(x: self.size.height, y: 0)
			transform = transform.scaledBy(x: -1, y: 1)
		default:
			print("2 is normal")
		}
		
		guard let cgImage = self.cgImage else { return nil }
		
		guard let ctx = CGContext.init(data: nil, width: Int(self.size.width), height: Int(self.size.height),
									   bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
									   space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue) else { return nil }
		
		ctx.concatenate(transform)
		switch self.imageOrientation {
		case .left, .leftMirrored, .right, .rightMirrored:
			ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
		default:
			ctx.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: self.size))
		}
		
		guard let cgImg = ctx.makeImage() else { return nil }
		let img = UIImage(cgImage: cgImg)
		return img
	}
}
