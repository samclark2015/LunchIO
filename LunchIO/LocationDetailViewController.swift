//
//  LocationDetailViewController.swift
//  LunchIO
//
//  Created by Sam Clark on 8/27/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailViewController: UIViewController {
	var location: Location

	@IBOutlet weak var nearbyField: UILabel!
	@IBOutlet weak var descField: UILabel!
	@IBOutlet weak var distanceField: UILabel!
	@IBOutlet weak var distanceSpinner: UIActivityIndicatorView!
	@IBAction func mapsButton(_ sender: AnyObject?){
		let regionSpan = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
		let options = [
			MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
			MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
		]
		let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = "\(self.location.name)"
		mapItem.openInMaps(launchOptions: options)
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		nearbyField.text = location.nearby
		descField.text = location.desc

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidAppear(_ animated: Bool) {
		if location.distance == nil {
			let dirReq = MKDirectionsRequest()
			dirReq.source = MKMapItem.forCurrentLocation()
			dirReq.destination = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
			dirReq.transportType = .walking
			
			let dir = MKDirections(request: dirReq)
			
			self.distanceSpinner.startAnimating()
			
			dir.calculateETA(completionHandler: {
				res, err in
				self.distanceSpinner.stopAnimating()
				if let dist = res?.distance {
					self.location.distance = dist/1609.344
					self.distanceField.text = "\(Double(round(10*self.location.distance!)/10)) miles"
					self.distanceField.isHidden = false
				}
				if let err = err {
					print("^", err)
					//UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
				}
			})
		} else {
			self.distanceField.text = "\(Double(round(10*location.distance!)/10)) miles"
			self.distanceField.isHidden = false
		}
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		//self.tabBarController?.
		self.tabBarController?.tabBar.isHidden = false
	}
	
	init(location: Location){
		self.location = location
		super.init(nibName: "LocationDetailViewController", bundle: Bundle.main)
		
		let background = SolidView(frame: self.view.frame)
		background.frame = self.view.frame
		background.contentMode = .scaleAspectFill
		self.view.insertSubview(background, at: 0)
		
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
