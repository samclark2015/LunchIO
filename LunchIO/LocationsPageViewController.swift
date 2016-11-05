//
//  LocationsPageViewController.swift
//  LunchIO
//
//  Created by Sam Clark on 8/26/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class LocationsPageViewController: UIPageViewController, UIPageViewControllerDataSource {
	var locations: [Location]?
	
	fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
		var r = [UIViewController]()
		guard let locations = self.locations else {
			print("^ location error: \(self.locations)")
			return []
		}
		for location in locations {
			let vc = self.newLocationViewController(location)
			r.append(vc)
		}
		return r
	}()
	
	fileprivate func newLocationViewController(_ location: Location) -> UIViewController {
		return LocationPageViewController(location: location)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
			return nil
		}
		
		let previousIndex = viewControllerIndex + 1
		
		guard previousIndex >= 0 else {
			return nil
		}
		
		guard orderedViewControllers.count > previousIndex else {
			return nil
		}
		
		return orderedViewControllers[previousIndex]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
			return nil
		}
		
		let nextIndex = viewControllerIndex - 1
		
		guard nextIndex >= 0 else {
			return nil
		}
		
		guard orderedViewControllers.count > nextIndex else {
			return nil
		}
		
		return orderedViewControllers[nextIndex]
	}
	
	/*func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return orderedViewControllers.count
	}
	
	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
				print("^ err")
				return 0
		}
		
		return firstViewControllerIndex
	}*/

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		dataSource = self
		
		self.view.backgroundColor = UIColor.red
		
		Location.all{
			locations, err in
			if let err = err {
				print(err.localizedDescription)
				return
			}
			if let locations = locations {
				self.locations = locations
				self.refresh()
			}
			
		}
		
		
    }
	
	func refresh(){
		self.reloadInputViews()
		if let firstViewController = orderedViewControllers.first {
			setViewControllers([firstViewController], direction: .reverse, animated: true, completion: nil)
		}
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

}
