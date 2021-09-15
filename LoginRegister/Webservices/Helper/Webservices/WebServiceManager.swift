//
//  ServiceRequestResponse.swift
//  ChiragPracticalDemo
//
//  Created by Theappfathers on 10/04/21.
//

import UIKit
import Foundation
import Alamofire
import ObjectMapper

class AFWrapper: NSObject {
    
    class func servicecall(url: String, Method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {
        let headers = HTTPHeaders()
        AF.request(url, method:Method,  parameters: Parameter, encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    
                    let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                    
                    print("Response : ", jsonDictionary as Any)
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }
                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                    
                }
        }
        
    }
    
    class func servicecallContentType(url: String, method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {
        let headers = HTTPHeaders()
        AF.request(url, method:method,  parameters: Parameter, encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    
                    let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                    
                    print("Response : ", jsonDictionary as Any)
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }
                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                    
                }
        }
    }
    
    class func servicecallEncode(url: String, Method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {
        let headers = HTTPHeaders()
//        if let user = AppData.shared.getUserInfo() {
//            headers["Authorization"] = user.authToken
//        }
        AF.request(url, method:Method,  parameters: Parameter, encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                    print("Response : ", jsonDictionary as Any)
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }

                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                    
                }
        }
        
    }
    
    
    
    class func servicecallWithHeaderWithoutLoader(url: String, Method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {
        
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/x-www-form-urlencoded"

        AF.request(url, method:Method,  parameters: Parameter, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                    print("Response : ", jsonDictionary as Any)
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }

                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                }
        }
    }
    
    class func servicecallWithHeader(url: String, Method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?) -> Void) {
        print("URL: ",url)
        print("Request: ",Parameter)
        
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/x-www-form-urlencoded"

        AF.request(url, method:Method,  parameters: Parameter, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }

                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                }
        }
    }
    
    class func servicecallNoHeader(url: String, Method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {
        let headers = HTTPHeaders()

        AF.request(url, method:Method,  parameters: Parameter, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                    print("Response : ", jsonDictionary as Any)
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }

                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                }
        }
    }
    //serviceForSignResponse
    class func servicecallSignLoader(url: String, Method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {
        print("URL: ",url)

        var headers = HTTPHeaders()
        headers["Content-type"] = "application/x-www-form-urlencoded"

        AF.request(url, method:Method,  parameters: Parameter, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                    print("Response : ", jsonDictionary as Any)
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }
                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                }
        }
    }
    
    class func servicecallNoHeaderWithoutLoader(url: String, Method: HTTPMethod, Parameter: Parameters, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {
        print("URL: ",url)
        print("Request: ",Parameter)
        let headers = HTTPHeaders()

        AF.request(url, method:Method,  parameters: Parameter, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue) as String?
                    let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                    print("Response : ", jsonDictionary as Any)
                    if datastring != nil {
                        ServiceCallBack(datastring, true)
                    }else {
                        ServiceCallBack(nil, false)
                    }
                case .failure(let error):
                    print(error)
                    ServiceCallBack(nil, false)
                }
        }
    }
    
    // Single Image Upload
    class func servicecallImageUpload(imageBankData: Data? = nil ,imageProfile: Data? = nil ,imageData: [UIImage] = [] , url: String, Method: HTTPMethod, Parameter: [String:String]? = nil , forBankDetail : Bool = false, ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {

        
        var headers = HTTPHeaders()
        headers["Content-type"] = "application/x-www-form-urlencoded"

        
        let uploadRequest = AF.upload(multipartFormData: { (multipartFormData) in
            
            if imageBankData != nil {
                multipartFormData.append(imageBankData! as Data, withName: "bankProof", fileName: "bankProof_uploaded_file.jpeg", mimeType: "image/jpeg")
            }
            if imageData.count != 0 {
                var intImg = 0
                for img in imageData{
                    multipartFormData.append(img.jpegData(compressionQuality: 1)!, withName: "images", fileName: "images_uploaded_file\(intImg).jpeg", mimeType: "image/jpeg")
                    intImg = intImg + 1
                }
            }
           
            if imageProfile != nil {
                multipartFormData.append(imageProfile! as Data, withName: "profileImage", fileName: "profileImage_uploaded_file.jpeg", mimeType: "image/jpeg")
            }

            
            for (key, value) in Parameter! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
            }

        }, to: url, method: Method, headers: headers)
        
        // Alamofire 5 - Response
        uploadRequest.response { (defaultDataResponse) in
            
            guard defaultDataResponse.error == nil else {
                ServiceCallBack(nil, false)
                return
            }
            
            switch defaultDataResponse.result {
                
            case .success( _):
                
                let datastring = NSString(data:defaultDataResponse.data!, encoding:String.Encoding.utf8.rawValue) as String?
                let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                print("Response : ", jsonDictionary as Any)
                if datastring != nil {
                    ServiceCallBack(datastring, true)
                }else {
                    ServiceCallBack(nil, false)
                }
                
            case .failure(let afError):
                print(afError)
                ServiceCallBack(nil, false)
            }
        }
    }
    
    class func serviceImageUploading(imgsResturant: [UIImage] = [],imgsProfile: UIImage?, url: String, Method: HTTPMethod, Parameter: [String:String]? = nil ,ServiceCallBack: @escaping (_ result: String?, _ IsSuccess: Bool?)-> Void) {

        
        var headers = HTTPHeaders()
        headers["Content-type"] = "application/x-www-form-urlencoded"
        
        // Alamofire 5 - Request
        let uploadRequest = AF.upload(multipartFormData: { (multipartFormData) in
            
            if imgsResturant.count != 0 {
                var intImg = 0
                for img in imgsResturant{
                    if let imgData = (img.jpegData(compressionQuality: 1)){
                        multipartFormData.append(imgData, withName: "images", fileName: "Images_uploaded_file\(intImg).jpeg", mimeType: "image/jpeg")
                    }
                    intImg = intImg + 1
                }
            }
            if imgsProfile != UIImage() {
                let intImg = 0
                if let imgData = (imgsProfile?.jpegData(compressionQuality: 1)){
                    multipartFormData.append(imgData, withName: "profileImage", fileName: "Images_uploaded_file\(intImg).jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in Parameter! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
            }
            
        }, to: url, method: Method, headers: headers)
        
        // Alamofire 5 - Response
        uploadRequest.response { (defaultDataResponse) in
            
            guard defaultDataResponse.error == nil else {
                ServiceCallBack(nil, false)
                return
            }
            
            switch defaultDataResponse.result {
                
            case .success( _):
                
                let datastring = NSString(data:defaultDataResponse.data!, encoding:String.Encoding.utf8.rawValue) as String?
                let jsonDictionary =  JSONData().convertToDictionary(text: datastring!)! as NSDictionary
                print("Response : ", jsonDictionary as Any)
                if datastring != nil {
                    ServiceCallBack(datastring, true)
                }else {
                    ServiceCallBack(nil, false)
                }
                
            case .failure(let afError):
                print(afError)
                ServiceCallBack(nil, false)
            }
        }
    }
    
    
    // multiple Image Upload
    class JSONData {
        func convertToDictionary(text: String) -> [String: Any]? {
            if let data = text.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }
    }
    class func convertToDictionary(text: String) -> NSDictionary? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    class ServiceResponseMessage: Mappable, CustomStringConvertible {
        
        lazy var http_status_code :  Int? = 0
        lazy var status: String? = ""
        
        init?() {
            
        }
        required init?(map: Map) {}
        
        var description: String {
            get {
                return Mapper().toJSONString(self, prettyPrint: false)!
            }
        }
        // Mappable
        func mapping(map: Map) {
            http_status_code          <- map["http_status_code"]
            status                    <- map["status"]
        }
    }
}
