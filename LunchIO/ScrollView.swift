//
//  ScrollView.swift
//  LunchIO
//
//  Created by Sam Clark on 8/27/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class ScrollView: UIScrollView {

	var location: Location
	
	fileprivate(set) lazy var orderedViews: [UIView] = {
		return [LocationMasterViewController(location: self.location).view, LocationDetailViewController(location: self.location).view]
	}()
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
	init(location: Location, frame: CGRect){
		self.location = location
		super.init(frame: frame)
		//super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: [:])
		
		if let i = location.image {
			let background = UIImageView(image: i.image)
			background.frame = self.frame
			background.contentMode = .scaleAspectFill
			background.layer.contentsRect = CGRect(x: i.hShift, y: 0.0, width: 1.0, height: 1.0)
			self.insertSubview(background, at: 0)
			
			//self.view.backgroundColor = UIColor(patternImage: i.image)
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
