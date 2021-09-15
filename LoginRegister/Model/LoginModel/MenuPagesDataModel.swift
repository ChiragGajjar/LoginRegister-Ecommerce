//
//  MenuPagesDataModel.swift
//  Shopper
//
//  Created by Theappfathers on 06/01/21.
//  Copyright © 2021 Theappfathers. All rights reserved.
//

import Foundation
import ObjectMapper

//About Us
class MenuPagesAboutModel:Mappable{
    
    var status                  : Bool?
    var message                 : String?
    var data                    : AboutUsModel?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status                  <- map["status"]
        message                 <- map["message"]
        data                    <- map["data"]
    }
}
class AboutUsModel:Mappable{
    
    var about_us_page           : String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        about_us_page           <- map["about_us_page"]
    }
}

//Term_condition
class MenuPagesTermsConditionModel:Mappable{
    
    var status                  : Bool?
    var message                 : String?
    var data                    : TermsConditionModel?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status                  <- map["status"]
        message                 <- map["message"]
        data                    <- map["data"]
    }
}
class TermsConditionModel:Mappable{
    
    var term_condition_page           : String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        term_condition_page           <- map["term_condition_page"]
    }
}

//Contact Us
class MenuPagesContactUsModel:Mappable{
    
    var status                  : Bool?
    var message                 : String?
    var data                    : ContactUsModel?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status                  <- map["status"]
        message                 <- map["message"]
        data                    <- map["data"]
    }
}
class ContactUsModel:Mappable{
    
    var contact_us_page           : String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        contact_us_page           <- map["contact_us_page"]
    }
}
