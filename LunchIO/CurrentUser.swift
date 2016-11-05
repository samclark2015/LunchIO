//
//  CurrentUser.swift
//  LunchIO
//
//  Created by Sam Clark on 11/5/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit
import UIKit
import ObjectMapper
import Alamofire

class CurrentUser: User {
	static var user: CurrentUser?
	
	var token: String?
	
	public required init?(map: Map) {
		super.init(map: map)
		
		if(map["token"] == nil){
			return nil
		}
		
	}
	
	override func mapping(map: Map) {
		
		name <- map["user.name"]
		email <- map["user.email"]
		privacy <- map["user.private"]
		bio <- map["user.bio"]
		following <- map["user.following"]
		_id <- map["user._id"]
		token <- map["token"]
	}
}
