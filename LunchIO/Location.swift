//
//  Location.swift
//  LunchIO
//
//  Created by Sam Clark on 8/26/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import ObjectMapper
import CoreLocation

class Location: NSObject, MKAnnotation, Mappable {
	var name: String?
	var nearby: String?
	var desc: String?
	var _id: String?
	private var imageString: String?
	private var imageShift: CGFloat?
	var image: LocationImage? {
		if let i = self.imageString, let s = self.imageShift {
			return LocationImage(named: i, hShift: s)
		}
		return nil
	}
	private var coords: [Float]?
	var distance: Double?
	var coordinate: CLLocationCoordinate2D {
		if let c = self.coords {
			return CLLocationCoordinate2D(latitude: CLLocationDegrees(c[0]), longitude: CLLocationDegrees(c[1]))
		}
		return CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
	}
	var title: String? {
		return self.name
	}
	
	init(name: String, desc: String, imageString: String, imageShift: CGFloat, coords: [Float]) {
		self.name = name
		self.desc = desc
		self.imageString = imageString
		self.imageShift = imageShift
		self.coords = coords
	}
	
	static func all(callback: @escaping (_ location: [Location]?, _ err: Error?)->Void) {
		var headers = [String:String]()
		if let token = User.currentUser?.jwt {
			headers["Authorization"] = "Bearer \(token)"
		}
		Alamofire.request(BaseModel.endpoint("locations"), method: .get, headers: headers)
			.responseJSON { r in
				if let err = r.result.error {
					callback(nil, err)
					return
				}
				
				if let JSON = r.result.value {
					if let locations = Mapper<Location>().mapArray(JSONObject: JSON) {
						callback(locations, nil)
						
					} else {
						callback(nil, NSError(domain: "App", code: 0, userInfo: ["message": "Could not parse JSON"]))
					}
					
				}
		}
		
	}
	
	func checkin(_ u: User){
		print("\(u.name) checked into \(self.name)")
	}
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		name    <- map["name"]
		desc    <- map["desc"]
		imageString <- map["imageString"]
		imageShift <- map["imageShift"]
		coords <- map["coords"]
		nearby <- map["nearby"]
		_id <- map["_id"]
	}
	
	/*static let locations = [
		Location(name: "Roth Food Court", desc: "Roth Quad\nAlthough famous for its burgers & milkshakes, this dining hall has cuisine ranging from frozen yogurt and Starbucks, to Latin specialties, and a rotation of like-home dishes.", imageString: "roth", imageShift: 0.1, coords: (40.910688, -73.123777)),
		Location(name: "West Side Dining", desc: "Kelly Quad", imageString: "west", imageShift: -0.3, coords: (40.913058, -73.129958)),
		/*Location(name: "Student Activities Center", desc: "SAC", imageString: "", imageShift: 0.0),
		Location(name: "East Side Dining", desc: "Toll Drive Plaza", imageString: "", imageShift: 0.0),
		Location(name: "Student Union", desc: "", imageString: "", imageShift: 0.0),*/
	]*/
	
}
