//
//  LocationsPageViewController.swift
//  LunchIO
//
//  Created by Sam Clark on 8/26/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class LocationPageViewController: UIViewController, UIScrollViewDelegate {
	let location: Location
	var scrollView: UIScrollView
	let master: UIViewController
	let detail: UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		
		/*if let firstViewController = orderedViewControllers.first {
			setViewControllers([firstViewController], direction: .reverse, animated: true, completion: nil)
		}*/
		scrollView = UIScrollView(frame: self.view.frame)
		master.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
		detail.view.frame = CGRect(x: 0, y: master.view.frame.height, width: self.view.bounds.width, height: self.view.bounds.height/2)
		
		scrollView.contentSize = CGSize(width: master.view.frame.width, height: master.view.frame.height + detail.view.frame.height)
		scrollView.addSubview(master.view)
		scrollView.addSubview(detail.view)
		scrollView.delegate = self
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.isPagingEnabled = false
		self.view.addSubview(scrollView)
		
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
	init(location: Location){
		self.location = location
		self.master = LocationMasterViewController(location: self.location)
		self.detail = LocationDetailViewController(location: self.location)
		scrollView = UIScrollView()
		super.init(nibName: nil, bundle: nil)
		
		self.view.clipsToBounds = true
		
		if let i = location.image {
			let background = UIImageView(image: i.image)
			background.frame = self.view.frame
			background.clipsToBounds = true
			background.contentMode = .scaleAspectFill
			background.layer.contentsRect = CGRect(x: i.hShift, y: 0.0, width: 1.0, height: 1.0)
			self.view.insertSubview(background, at: 0)
			
			//self.view.backgroundColor = UIColor(patternImage: i.image)
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let maxPos = scrollView.contentSize.height-self.view.bounds.height
		let ratio = targetContentOffset.pointee.y/maxPos
		var pt = CGPoint(x: 0, y: 0)
		if ratio >= 0.5 {
			pt = CGPoint(x: 0, y: maxPos)
		}
		
		UIView.animate(withDuration: 0.25, animations: {
			scrollView.setContentOffset(pt, animated: false)
			targetContentOffset.pointee = pt
			})
	}
	
}

