//
//  CommonModel.swift
//  Shopper
//
//  Created by Theappfathers on 06/01/21.
//  Copyright © 2021 Theappfathers. All rights reserved.
//

import Foundation
import ObjectMapper

class CommonModel:Mappable{
    
    var status                  : Bool?
    var message                 : String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status                  <- map["status"]
        message                 <- map["message"]
    }
}
