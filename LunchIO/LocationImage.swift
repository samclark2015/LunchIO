//
//  LocationImage.swift
//  LunchIO
//
//  Created by Sam Clark on 8/27/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class LocationImage: NSObject {
	var hShift: CGFloat
	var image: UIImage
	init?(named: String, hShift: CGFloat){
		guard let i = UIImage(named: named) else {
			return nil
		}
		self.image = i
		self.hShift = hShift
	}

}
