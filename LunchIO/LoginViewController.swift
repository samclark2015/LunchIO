//
//  LoginViewController.swift
//  LunchIO
//
//  Created by Sam Clark on 9/1/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBAction func loginAction(_ sender: AnyObject) {
		if let email = emailField.text, let password = passwordField.text {
			User.login(email: email, password: password){
				user, err in
				if let err = err {
					print(err)
					return
				}
				
				guard let user = user else{
					return
				}
				
				User.currentUser = user
				print("^",User.currentUser?.name ?? "No User")
				UserDefaults.standard.set(user.jwt, forKey: "loginToken")
				
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
				self.present(vc, animated: true)
				
			}
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
