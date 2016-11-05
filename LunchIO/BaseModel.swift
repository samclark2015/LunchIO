//
//  BaseModel.swift
//  LunchIO
//
//  Created by Sam Clark on 9/5/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
	static private let baseURL = "192.168.33.10:8080"
	
	static func endpoint(_ s: String)->String {
		return "http://\(BaseModel.baseURL)/\(s)"
	}
}
