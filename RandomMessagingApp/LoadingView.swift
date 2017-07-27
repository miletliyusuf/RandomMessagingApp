//
//  LoadingView.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 28/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import Foundation
import UIKit

class LoadingView:UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func showActivityIndicator() {
		let loadingViewTag = 1000
		let selfWindow: UIWindow = ((UIApplication.shared.delegate?.window)!)!
		let container: UIView = UIView()
		container.tag = loadingViewTag
		let loadingView: UIView = UIView()
		let customImageView: UIActivityIndicatorView = UIActivityIndicatorView()
		customImageView.startAnimating()
		
		container.frame = selfWindow.frame
		container.center = selfWindow.center
		container.backgroundColor = UIColor.black.withAlphaComponent(0.45)
		
		loadingView.frame = CGRect.init(x: 0, y: 0, width: 150, height: 150)
		loadingView.center = selfWindow.center
		loadingView.backgroundColor = UIColor.clear
		loadingView.clipsToBounds = true
		loadingView.layer.cornerRadius = 10
		
		customImageView.frame = CGRect.init(x: 0, y: 0, width: 150, height: 150)
		customImageView.center = CGPoint.init(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
		
		loadingView.addSubview(customImageView)
		container.addSubview(loadingView)
		
		if selfWindow.viewWithTag(loadingViewTag) == nil {
			selfWindow.addSubview(container)
		}
	}
	
	/*
	Hide activity indicator
	Actually remove activity indicator from its super view
	
	@param uiView - remove activity indicator from this view
	*/
	class func hideActivityIndicator() {
		let loadingViewTag = 1000
		let selfWindow: UIWindow = ((UIApplication.shared.delegate?.window)!)!
		selfWindow.viewWithTag(loadingViewTag)?.removeFromSuperview()
	}
}
