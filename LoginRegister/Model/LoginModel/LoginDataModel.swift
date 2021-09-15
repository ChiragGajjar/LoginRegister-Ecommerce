//
//  LoginDataModel.swift
//  Shopper
//
//  Created by Theappfathers on 01/01/21.
//  Copyright © 2021 Theappfathers. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginDataModel:Mappable{
    
    var status                  : Bool?
    var message                 : String?
    var data                    : LoginDetailsDataModel?
    var code                    : Int?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status                  <- map["status"]
        message                 <- map["message"]
        data                    <- map["data"]
        code                    <- map["code"]
    }
}
class LoginDetailsDataModel:NSObject, Mappable, NSCoding{
    
    var um_id                       : String?
    var um_mall_id                  : String?
    var um_name                     : String?
    var um_email                    : String?
    var um_mobile                   : String?
    var um_password                 : String?
    var um_image_name               : String?
    var um_type                     : String?
    var um_status                   : String?
    var um_updated                  : String?
    var um_created                  : String?

    required init?(map: Map) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.um_id = aDecoder.decodeObject(forKey: "um_id") as? String
        self.um_mall_id = aDecoder.decodeObject(forKey: "um_mall_id") as? String
        self.um_name = aDecoder.decodeObject(forKey: "um_name") as? String
        self.um_email = aDecoder.decodeObject(forKey: "um_email") as? String
        self.um_mobile = aDecoder.decodeObject(forKey: "um_mobile") as? String
        self.um_password = aDecoder.decodeObject(forKey: "um_password") as? String
        self.um_image_name = aDecoder.decodeObject(forKey: "um_image_name") as? String
        self.um_type = aDecoder.decodeObject(forKey: "um_type") as? String
        self.um_status = aDecoder.decodeObject(forKey: "um_status") as? String
        self.um_updated = aDecoder.decodeObject(forKey: "um_updated") as? String
        self.um_created = aDecoder.decodeObject(forKey: "um_created") as? String
    }

    func encode(with aCoder: NSCoder){
        aCoder.encode(um_id, forKey: "um_id")
        aCoder.encode(um_mall_id, forKey: "um_mall_id")
        aCoder.encode(um_name, forKey: "um_name")
        aCoder.encode(um_email, forKey: "um_email")
        aCoder.encode(um_mobile, forKey: "um_mobile")
        aCoder.encode(um_password, forKey: "um_password")
        aCoder.encode(um_image_name, forKey: "um_image_name")
        aCoder.encode(um_type, forKey: "um_type")
        aCoder.encode(um_status, forKey: "um_status")
        aCoder.encode(um_updated, forKey: "um_updated")
        aCoder.encode(um_created, forKey: "um_created")
    }

    func mapping(map: Map) {
        um_id                   <- map["um_id"]
        um_mall_id              <- map["um_mall_id"]
        um_name                 <- map["um_name"]
        um_email                <- map["um_email"]
        um_mobile               <- map["um_mobile"]
        um_password             <- map["um_password"]
        um_image_name           <- map["um_image_name"]
        um_type                 <- map["um_type"]
        um_status               <- map["um_status"]
        um_updated              <- map["um_updated"]
        um_created              <- map["um_created"]
    }
}
