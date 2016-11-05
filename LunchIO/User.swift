//
//  User.swift
//  LunchIO
//
//  Created by Sam Clark on 8/27/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class User: Mappable {
	static var currentUser: User?
	
	var name: String?
	var email: String?
	var jwt: String?
	var bio: String?
	var following: [String]?
	var privacy: Bool = false
	var _id: String?
	
	/// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
	public required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		name <- map["name"]
		email <- map["email"]
		privacy <- map["private"]
		bio <- map["bio"]
		following <- map["following"]
		_id <- map["_id"]
	}
	
	static func login(email: String, password: String, callback: @escaping (_ l: User?, _ err: Error? )->Void) {
		Alamofire.request(BaseModel.endpoint("users"), method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
			.responseJSON { r in
				if let err = r.result.error {
					callback(nil, err)
					return
				}
				if let json = r.result.value {
					if let user = Mapper<User>().map(JSONObject: json) {
						User.currentUser = user
						callback(user, nil)
					} else {
						callback(nil, NSError(domain: "App", code: 0, userInfo: ["message": "Could not parse JSON"]))
					}
					
				}
		}
	}

	static func fetchInfo(token: String, callback: @escaping (_ l: User?, _ err: Error? )->Void){
		Alamofire.request("google.com", method: .post).response { r in
			
		}
		Alamofire.request(BaseModel.endpoint("users/verify"), method: .post, parameters: ["token": token], encoding: JSONEncoding.default).responseJSON { r in
				if let err = r.result.error {
					print(r.response ?? "No Response")
					callback(nil, err)
					return
				}
				if let json = r.result.value {
					if let user = Mapper<User>().map(JSONObject: json) {
						user.jwt = token
						User.currentUser = user
						callback(user, nil)
					} else {
						callback(nil, NSError(domain: "App", code: 0, userInfo: ["message": "Could not parse JSON"]))
					}
					
				}
		}
	}
}
