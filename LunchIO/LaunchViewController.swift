//
//  LaunchViewController.swift
//  LunchIO
//
//  Created by Sam Clark on 9/5/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	override func viewDidAppear(_ animated: Bool) {
		spinner.startAnimating()
		// Do any additional setup after loading the view.
		
		let defaults = UserDefaults.standard;
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		var initialViewController: UIViewController = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
		
		if let token = defaults.string(forKey: "loginToken") {
			User.fetchInfo(token: token){
				user, err in
				if let err = err {
					defaults.setNilValueForKey("loginToken")
					let alert = UIAlertController(title: "Error", message: "\(err.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert);
					alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: {
						action in
						alert.dismiss(animated: true, completion: nil)
						self.present(initialViewController, animated: true, completion: nil)
					}));
					self.present(alert, animated: true, completion: nil)
				}
				
				if let user = user {
					User.currentUser = user
					initialViewController = storyboard.instantiateViewController(withIdentifier: "MainVC")
					self.present(initialViewController, animated: true, completion: nil)
				}
			}
		} else {
			self.present(initialViewController, animated: true, completion: nil)
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		
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
