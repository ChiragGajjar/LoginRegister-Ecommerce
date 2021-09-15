//
//  SettingDataModel.swift
//  Shopper
//
//  Created by Theappfathers on 15/01/21.
//  Copyright © 2021 Theappfathers. All rights reserved.
//

import Foundation
import ObjectMapper

//About Us
class ProductDataModel:Mappable{
    
    var status                  : Bool?
    var message                 : String?
    var data                    : [ProductDataListModel]?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status                  <- map["status"]
        message                 <- map["message"]
        data                    <- map["data"]
    }
}
class ProductDataListModel:Mappable{
    
    var id               : Int?
    var title              : String?
    var price            : Int?
    var description              : String?
    var category              : String?
    var image              : String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id               <- map["id"]
        title              <- map["title"]
        price            <- map["price"]
        description            <- map["description"]
        category            <- map["category"]
        image            <- map["image"]
    }
}
