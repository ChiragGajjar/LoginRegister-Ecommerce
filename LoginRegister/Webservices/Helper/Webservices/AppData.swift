//
//  AppDate.swift
//  

import UIKit
import SVProgressHUD
import SDWebImage
import ObjectMapper

//var appUser : LoginDataModel?

final class AppData: NSObject
{
    static let shared = AppData()
    

    var isLoadMultipleType = false
    
    class func ApplyShdow(_ view:UIView){
        view.clipsToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2.0
        view.layer.shadowColor = UIColor(red: 59.0/255.0, green: 59.0/255.0, blue: 59.0/255.0, alpha: 1).cgColor
        view.layer.masksToBounds = false
    }
    
    class func ShowProgress(){
        SVProgressHUD.show()
    }
    
    class func HideProgress(){
        SVProgressHUD.dismiss()
    }
    func getFormattedDate(strDate: String) -> String{

        var fullNameArr = strDate.components(separatedBy:" ")
        let currDate = fullNameArr[0]
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let date: Date? = dateFormatterGet.date(from: currDate)
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd,yyyy"
        
        
        return "\(dateFormatterPrint.string(from: date!))"
    }
    static func getCurrentDateFormatted() -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        return dateFormatterGet.string(from: Date())
    }
    

    //==========================================
    //MARK: - Helper Methods
    //==========================================
    
    func saveModel(_ model : AnyObject, forKey key : String) {
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: model)
        UserDefaults.standard.set(encodedObject, forKey: key)
        UserDefaults.standard.synchronize()
    }
//    static func saveModel(_ model: Any, forKey key: String) {
//        let ud = UserDefaults.standard
//        let archivedPool = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: true)
//        ud.set(archivedPool, forKey: key)
//    }
    

    func getModelForKey(_ key : String) -> AnyObject? {
        let encodedObject = UserDefaults.standard.object(forKey: key) as? Data
        let savedModel = encodedObject != nil ? NSKeyedUnarchiver.unarchiveObject(with: encodedObject!) : nil
        return savedModel as AnyObject?
    }
    
    func removeModelForKey(_ key : String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
     //   appUser = nil
    }
}


struct UserDefaultsKey {
    static let user             = "UserKey"
    static let languages        = "Langauges"

    //Request
    static let DEVICE_UDID      = "DEVICE_UDID"
    static let GCM_KEY          = "GCM_KEY"
    static let FCM_KEY          = "FCM_KEY"

    static let restaurantData   = "resData"
}


