//
//  Colors.swift
//  LunchIO
//
//  Created by Sam Clark on 8/27/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class GradientView: UIView {
	
	override init(frame: CGRect){
		super.init(frame: frame)
		self.drawGradient()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.drawGradient()
	}
	
	fileprivate func drawGradient() {
		let colorTop = UIColor(colorLiteralRed: 153.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.0).cgColor
		let colorBottom = UIColor(colorLiteralRed: 153.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.9).cgColor
		
		let gl: CAGradientLayer
		
		gl = CAGradientLayer()
		gl.colors = [ colorTop, colorBottom]
		gl.locations = [ 0.0, 0.12]
		
		self.backgroundColor = UIColor.clear
		let backgroundLayer = gl
		backgroundLayer.frame = self.frame
		self.layer.insertSublayer(backgroundLayer, at: 0)
	}
	

}

class SolidView: UIView {
	
	override init(frame: CGRect){
		super.init(frame: frame)
		self.drawGradient()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.drawGradient()
	}
	
	fileprivate func drawGradient() {
		let colorTop = UIColor(colorLiteralRed: 153.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.9).cgColor
		
		let gl: CAGradientLayer
		
		gl = CAGradientLayer()
		gl.colors = [ colorTop, colorTop]
		gl.locations = [ 0.0, 1.0]
		
		self.backgroundColor = UIColor.clear
		let backgroundLayer = gl
		backgroundLayer.frame = self.frame
		self.layer.insertSublayer(backgroundLayer, at: 0)
	}
	
	
}
