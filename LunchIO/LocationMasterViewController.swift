//
//  LocationViewController.swift
//  LunchIO
//
//  Created by Sam Clark on 8/26/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class LocationMasterViewController: UIViewController {
	var location: Location

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var gradientView: UIView!
	@IBAction func checkin(_ sender: AnyObject) {
		if let user = CurrentUser.user {
			location.checkin(user)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.nameLabel.text = location.name
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	init(location: Location){
		self.location = location
		super.init(nibName: "LocationMasterViewController", bundle: Bundle.main)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
