//
//  Utility.swift
//
//  Created by Mac on 27/06/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SystemConfiguration
import SVProgressHUD
import ReachabilitySwift
import Alamofire

//MARK:- Check internet connectivity
func ShowProgress(){
    SVProgressHUD.show()
}

func HideProgress(){
    SVProgressHUD.dismiss()
}

//MARK:- Save, Fetch, Get Model
//==========================================

func addBoolToUserDefaults(pBool: Bool, pForKey:String){
    let defaults = UserDefaults.standard
    defaults.set(pBool, forKey: pForKey)
    defaults.synchronize()
}

func getBoolFromUserDefaults(pForKey:String)->Bool{
    var valid = Bool()
    let defaults = UserDefaults.standard
    valid = defaults.bool(forKey: pForKey)
    return valid
}

func saveStringValue(strValue : String, forKey key : String) {
    UserDefaults.standard.set(strValue, forKey: key)
    UserDefaults.standard.synchronize()
}

func getStringValue(key : String) ->String{
    return UserDefaults.standard.object(forKey: key) as? String ?? "0"
}

func saveModel(_ model: Any, forKey key: String) {
    let ud = UserDefaults.standard
    let archivedPool = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: true)
    ud.set(archivedPool, forKey: key)
}

func getModelForKey<T>(_ key: String) -> T? {
    let ud = UserDefaults.standard
    if let val = ud.value(forKey: key) as? Data,
        let obj = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(val) as? T {
        return obj
    }
    return nil
}

//func saveModel(_ model : AnyObject, forKey key : String) {
//    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: model)
//    UserDefaults.standard.set(encodedObject, forKey: key)
//    UserDefaults.standard.synchronize()
//}
//
//func getModelForKey(_ key : String) -> AnyObject? {
//    let encodedObject = UserDefaults.standard.object(forKey: key) as? Data
//    let savedModel = encodedObject != nil ? NSKeyedUnarchiver.unarchiveObject(with: encodedObject!) : nil
//    return savedModel as AnyObject?
//}

func removeModelForKey(_ key : String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserInfo(key: String)
{
    removeModelForKey(key)
    UserDefaults.standard.removeObject(forKey: "socialLoginUserInfo")
    UserDefaults.standard.synchronize()
}


//func saveRestaurantInfo(_ restaurantInfo: RestaurantProfileDataModel) {
//    saveModel(restaurantInfo, forKey: UserDefaultsKey.restaurantData)
//}
//
//func getRestaurantInfo() -> RestaurantProfileDataModel? {
//    return getModelForKey(UserDefaultsKey.restaurantData) as? RestaurantProfileDataModel
//}
//==========================================

//MARK:- TabBar
func changeTabItemImage(tabBar: UITabBarController, index: Int, newNotifications: Bool)
{
    if newNotifications {
        tabBar.tabBar.items?[index].image = UIImage(named: "bell_selected")
        tabBar.tabBar.items?[index].selectedImage = UIImage(named: "bell_selected_blue")
    } else {
        tabBar.tabBar.items?[index].image = UIImage(named: "bell")
        tabBar.tabBar.items?[index].selectedImage = UIImage(named: "bell_blue")
    }
}

//MARK:- Thumbnail generator from video url
func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
    DispatchQueue.global().async { //1
        let asset = AVAsset(url: url) //2
        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
        avAssetImageGenerator.appliesPreferredTrackTransform = true //4
        let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
        do {
            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
            let thumbImage = UIImage(cgImage: cgThumbImage) //7
            DispatchQueue.main.async { //8
                completion(thumbImage) //9
            }
        } catch {
            print(error.localizedDescription) //10
            DispatchQueue.main.async {
                completion(nil) //11
            }
        }
    }
}

//MARK:- UILabel
public class UIPaddedLabel: UILabel
{
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    public override func sizeToFit() {
        super.sizeThatFits(intrinsicContentSize)
    }
}

//MARK:- UITextfield
func addTextFieldpadding(txtFields: [UITextField], paddingLeft : CGFloat, paddingRight : CGFloat) {
    for textfield in txtFields
    {
        let paddingLeft = UIView(frame: CGRect(x: 0, y: 0, width: paddingLeft, height: textfield.frame.size.height))
        textfield.leftView = paddingLeft
        textfield.leftViewMode = .always
        
        let paddingRight = UIView(frame: CGRect(x: 0, y: 0, width: paddingRight, height: textfield.frame.size.height))
        textfield.rightView = paddingRight
        textfield.rightViewMode = .always
    }
}

//MARK:- UITextview
func TextViewPadding(textView: UITextView){
    textView.contentInset = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 0)
}

//MARK:- UIView
func roundSpecifiedCorners(_ corners:UIRectCorner, radius: CGFloat, views: [UIView]) {
    for view in views
    {
        if #available(iOS 11.0, *) {
//            view.clipsToBounds = true
            view.layer.cornerRadius = radius
            view.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
        }
    }
}

//MARK:- RandomNumber generator
class RandomNumber: NSObject {
    class func randomNumberWithLength (_ len : Int) -> NSString {
        let letters : NSString = "123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString
    }
}


//MARK:- UISwitch
func setSwitchSize(switches: [UISwitch], transformScale: CGFloat)
{
    for swtch in switches
    {
        swtch.transform = CGAffineTransform(scaleX: transformScale, y: transformScale)
    }
}

func setSwitchUserInteraction(switches: [UISwitch], onOff: Bool)
{
    for swtch in switches
    {
        swtch.isUserInteractionEnabled = onOff
    }
}

func setSwitchOnOff(switches: [UISwitch], onOff: Bool)
{
    for swtch in switches
    {
        swtch.setOn(onOff, animated: true)
        if onOff == false {
            swtch.isEnabled = false
        } else {
            swtch.isEnabled = true
        }
    }
}

func setSwitchOnOffWithoutEnable(switches: [UISwitch], onOff: Bool)
{
    for swtch in switches
    {
        swtch.setOn(onOff, animated: true)
    }
}


//MARK:- Gradient methods
func addGradientBorder(view: UIView, gradientColors: [CGColor])
{
    let gradient = CAGradientLayer()
    gradient.frame =  CGRect(origin: CGPoint.zero, size: view.bounds.size)
    gradient.colors = gradientColors
    
    let shape = CAShapeLayer()
    shape.lineWidth = 2
    shape.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath//UIBezierPath(rect: view.bounds).cgPath
    shape.strokeColor = UIColor.black.cgColor
    shape.fillColor = UIColor.clear.cgColor
    gradient.mask = shape
    
    view.layer.addSublayer(gradient)
}

func addGradientBackground(view: UIView, gradientColors: [CGColor], direction: gradientDirection) {
    
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = gradientColors
    
    if direction == .bottomTop {
        gradient.locations = [0.2, 1.0]
    } else {
        gradient.locations = [0.0 , 1.0]
    }
    
    switch direction
    {
    case .topBottom:    //left to right
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
    case .bottomTop:
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
    case .leftRight:
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    case .rightLeft:
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
    case .TopLeftToBottomRight:
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    case .TopRightToBottomLeft:
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
    case .BottomLeftToTopRight:
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
    case .BottomRightToTopLeft:
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
    }
//    gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = view.layer.bounds
    view.layer.insertSublayer(gradient, at: 0)
    
}

enum gradientDirection {//darkTolight
    case topBottom
    case bottomTop
    case leftRight
    case rightLeft
    case TopLeftToBottomRight
    case TopRightToBottomLeft
    case BottomLeftToTopRight
    case BottomRightToTopLeft
}

extension CALayer {
    
    func removeAllGradiantLayers(){
        self.sublayers?.forEach
            { layer in
                if layer.isKind(of: CAGradientLayer.self)
                {
                    layer.removeFromSuperlayer()
                }
        }
    }
}

// MARK: - Toast Methods
func showToastMsg(message : String) {
    let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    let toastLabel = UILabel(frame: CGRect(x: keyWindow!.frame.size.width/2 - 150, y: (keyWindow?.frame.size.height)!-120, width:300,  height : 50))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = NSTextAlignment.center;
    //appDelegate.window!.addSubview(toastLabel)
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(toastLabel)
    toastLabel.text = message
    toastLabel.numberOfLines = 0
    toastLabel.alpha = 1.0
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 5.0)
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    UIView.animate(withDuration: 6, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    })
}

//MARK:- UIColor
func hexStringToUIColor(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//MARK:- Date functions
func getDayNameBy(stringDate: String) -> String
{
    let df = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "EEEE"
    return df.string(from: date);
}

func getDayFromString(stringDate: String) -> String
{
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm:ss" //2021-01-02 06:14:18
    let date = df.date(from: stringDate)!
    df.dateFormat = "EEE, MMM, dd, yyyy"
    return df.string(from: date);
}

// MARK: - Data Conversion funcs from array/dict to json or vice versa
func ModelToDic(Model:AnyObject) -> NSDictionary{
    
    let theDict = NSMutableDictionary()
    let mirrored_object = Mirror(reflecting: Model)
    for (_, attr) in mirrored_object.children.enumerated() {
        if let name = attr.label {
            theDict.setValue( Model.value(forKey:name) , forKey: name)
        }
    }
    
    return theDict
}

func json(from object:Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options:.prettyPrinted) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}


func DictToJson(Dict:[String:Any]) -> String? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: Dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        if let jsonString =  NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? {
            return jsonString
        }
    }catch let error as NSError {
        print(error)
    }
    return nil
}

func JsonToDict(Json:String) -> [String:Any]? {
    if let data = Json.data(using: String.Encoding.utf8) {
        do{
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
        }catch let error as NSError {
            print(error)
        }
    }
    return nil
}

func JsonToArrOfDict(Json:String) -> [[String:Any]]? {
    if let data = Json.data(using: String.Encoding.utf8) {
        do{
            return try JSONSerialization.jsonObject(with: data, options: []) as? [[String:AnyObject]]
        }catch let error as NSError {
            print(error)
        }
    }
    return nil
}
public class CentersecondAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let oldAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        let attributes = oldAttributes.map { $0.copy() as! UICollectionViewLayoutAttributes }
        
        // We will do centering alignment only on the Cell layout attributes
        let cellAttributes = attributes.filter({ (layout: UICollectionViewLayoutAttributes) -> Bool in
            return layout.representedElementCategory == .cell
        })
        
        let attributesForRows: [[UICollectionViewLayoutAttributes]] = groupLayoutAttributesByRow(cellAttributes)
        
        for attributesInRow in attributesForRows {
            let sortedItem = attributesInRow.sorted(by: { $0.frame.minX < $1.frame.minX })
            
            // Layout this row layout attributes with spacing equals to layout's `minimumInteritemSpacing`.
            sortedItem.first?.frame.origin.x = 0.0
            let (neighborsElements) = zip(sortedItem.dropLast(), sortedItem.dropFirst())
            for neighborsElement in neighborsElements {
                neighborsElement.1.frame.origin.x = neighborsElement.0.frame.maxX + self.minimumInteritemSpacing
            }
            
            let (minX, maxX) = attributesInRow.reduce((CGFloat.greatestFiniteMagnitude, CGFloat.leastNormalMagnitude), { (value, attributes) -> (CGFloat, CGFloat) in
                return (min(value.0, attributes.frame.minX), max(value.1, attributes.frame.maxX))
            })
            
            let cellViewPortWidth = maxX - minX
            // Calculate the offset of this row, and apply it to this row's layout attributes to make them center aligned
            let offset = floor((self.collectionViewContentSize.width - cellViewPortWidth) / 2)
            attributesInRow.forEach({
                $0.frame.origin.x += offset
            })
        }
        
        return attributes
    }
}

/// A simple data structure to represent the row of UICollectionViewCell layout attributes.
/// Consist of top Y position and the height of this row
private struct RowAttributes {
    var y: CGFloat
    var height: CGFloat
    
    func contains(_ rect: CGRect) -> Bool {
        return rect.maxY > self.y && rect.minY < (self.y + self.height)
    }
    func attributeByUnionRect(_ rect: CGRect) -> RowAttributes {
        let y = min(self.y, rect.minY)
        let height = max(self.height + self.y, rect.maxY) - y
        return RowAttributes(y: y, height: height)
    }
}

/// Calculate the row attributes for row of the given layout attributes by walking through the array of layout attributes
private func rowAttributesOfAttributesSameRowAs(_ layoutAttributes: UICollectionViewLayoutAttributes, byAttributes attributes: [UICollectionViewLayoutAttributes]) -> RowAttributes {
    let seedRowAttributes = RowAttributes(y: layoutAttributes.frame.minY, height: layoutAttributes.frame.height)
    return  attributes.reduce(seedRowAttributes, { (attribute, layoutAttributes) -> RowAttributes in
        if attribute.contains(layoutAttributes.frame) {
            return attribute.attributeByUnionRect(layoutAttributes.frame)
        } else {
            return attribute
        }
    })
}

/// Grouping the layout attributes by their row
private func groupLayoutAttributesByRow(_ layoutAttributes: [UICollectionViewLayoutAttributes]) -> [[UICollectionViewLayoutAttributes]] {
    var groupedLayoutAttributes = [[UICollectionViewLayoutAttributes]]()
    var remainingLayoutAttributes = layoutAttributes
    while let attributes = remainingLayoutAttributes.first {
        let attributes = rowAttributesOfAttributesSameRowAs(attributes, byAttributes: remainingLayoutAttributes)
        let classifiedRects = remainingLayoutAttributes.filter{ attributes.contains($0.frame) }
        groupedLayoutAttributes.append(classifiedRects)
        
        remainingLayoutAttributes = remainingLayoutAttributes.filter{ !attributes.contains($0.frame) }
    }
    
    return groupedLayoutAttributes
}

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        // Copy each item to prevent "UICollectionViewFlowLayout has cached frame mismatch" warning
        guard let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        
        // Constants
        let leftPadding: CGFloat = 8
        let interItemSpacing = minimumInteritemSpacing
        
        // Tracking values
        var leftMargin: CGFloat = leftPadding // Modified to determine origin.x for each item
        var maxY: CGFloat = -1.0 // Modified to determine origin.y for each item
        var rowSizes: [[CGFloat]] = [] // Tracks the starting and ending x-values for the first and last item in the row
        var currentRow: Int = 0 // Tracks the current row
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute represents its own item
            if layoutAttribute.frame.origin.y >= maxY {
                
                // This layoutAttribute represents the left-most item in the row
                leftMargin = leftPadding
                
                // Register its origin.x in rowSizes for use later
                if rowSizes.count == 0 {
                    // Add to first row
                    rowSizes = [[leftMargin, 0]]
                } else {
                    // Append a new row
                    rowSizes.append([leftMargin, 0])
                    currentRow += 1
                }
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
            
            // Add right-most x value for last item in the row
            rowSizes[currentRow][1] = leftMargin - interItemSpacing
        }
        
        // At this point, all cells are left aligned
        // Reset tracking values and add extra left padding to center align entire row
        leftMargin = leftPadding
        maxY = -1.0
        currentRow = 0
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute is its own item
            if layoutAttribute.frame.origin.y >= maxY {
                
                // This layoutAttribute represents the left-most item in the row
                leftMargin = leftPadding
                
                // Need to bump it up by an appended margin
                let rowWidth = rowSizes[currentRow][1] - rowSizes[currentRow][0] // last.x - first.x
                let appendedMargin = (collectionView!.frame.width - leftPadding  - rowWidth - leftPadding) / 2
                leftMargin += appendedMargin
                
                currentRow += 1
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}


func ShowAlert(alertTitle:String, alertMessage:String){
    
    let alert = UIAlertView()
    alert.title = alertTitle
    alert.message = alertMessage
    alert.addButton(withTitle: Language.OK.Localized())
    alert.show()
}

class GLOBAL : NSObject {
    
    //sharedInstance
    static let sharedInstance = GLOBAL()
    
    
    //MARK: - Internet Reachability
    var reachability: Reachability?
    var isInternetReachable : Bool? = false
    
    func setupReachability(_ hostName: String?) {
        
        GLOBAL.sharedInstance.reachability = hostName == nil ? Reachability() : Reachability(hostname: hostName!)
        
        if reachability?.isReachable == true
        {
            GLOBAL.sharedInstance.isInternetReachable = true
        }
        
        NotificationCenter.default.addObserver(GLOBAL.sharedInstance, selector: #selector(reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: nil)
    }
    
    func startNotifier() {
        
        setupReachability("google.com")
        
        print("--- start notifier")
        do {
            try GLOBAL.sharedInstance.reachability?.startNotifier()
        } catch {
            print("Unable to create Reachability")
            return
        }
    }
    
    func stopNotifier() {
        print("--- stop notifier")
        GLOBAL.sharedInstance.reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        GLOBAL.sharedInstance.reachability = nil
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            GLOBAL.sharedInstance.isInternetReachable = true
        } else {
            GLOBAL.sharedInstance.isInternetReachable = false
        }
    }
}
func getFromNSUserDefaults(pForKey: String)-> String{
    var pReturnObject:String
    let defaults = UserDefaults.standard
    pReturnObject = defaults.object(forKey: pForKey) as? String ?? ""
    return pReturnObject;
}

func removeSpaceFromUrl(_ strImage:String) -> URL{
    let strImgUrl = strImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let fileUrl = URL(fileURLWithPath: strImgUrl ?? "")
    
    return fileUrl
}


extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }
    func setEmptyMessage(_ img:UIImage) {

        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        image.contentMode = .scaleAspectFit
        image.image = img

        let mainView = UIView()
        mainView.addSubview(image)

        self.backgroundView = mainView
    }

    func restore() {
        self.backgroundView = nil
    }
}
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func setEmptyMessage(_ img:UIImage) {

        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        image.contentMode = .scaleAspectFit
        image.image = img

        let mainView = UIView()
        mainView.addSubview(image)

        self.backgroundView = mainView
    }

    func restore() {
        self.backgroundView = nil
    }
    func scrollToBottom() {
        let rows = self.numberOfRows(inSection: 0)
        
        if rows > 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: rows - 1, section: 0)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }

}
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
@IBDesignable
class DashedLineView : UILabel {
    @IBInspectable var perDashLength: CGFloat = 2.0
    @IBInspectable var spaceBetweenDash: CGFloat = 2.0
    @IBInspectable var dashColor: UIColor = UIColor.lightGray


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let  path = UIBezierPath()
        if height > width {
            let  p0 = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            path.addLine(to: p1)
            path.lineWidth = width

        } else {
            let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            path.addLine(to: p1)
            path.lineWidth = height
        }

        let  dashes: [ CGFloat ] = [ perDashLength, spaceBetweenDash ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }

    private var width : CGFloat {
        return self.bounds.width
    }

    private var height : CGFloat {
        return self.bounds.height
    }
}

class LocalizationSystem: NSObject {
    var bundle: Bundle!
    
    class var sharedInstance: LocalizationSystem {
        struct Singleton {
            static let instance: LocalizationSystem = LocalizationSystem()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        bundle = Bundle.main
    }
    
    func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }
    
    //MARK:- setLanguage
    // Sets the desired language of the ones you have.
    // If this function is not called it will use the default OS language.
    // If the language does not exists y returns the default OS language.
    func setLanguage(languageCode:String) {
        var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        appleLanguages.remove(at: 0)
        appleLanguages.insert(languageCode, at: 0)
        UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize() //needs restrat
        
        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
            bundle = Bundle.init(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
    }
    
    //MARK:- resetLocalization
    //Resets the localization system, so it uses the OS default language.
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    //MARK:- getLanguage
    // Just gets the current setted up language.
    func getLanguage() -> String {
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let prefferedLanguage = appleLanguages[0]
        if prefferedLanguage.contains("-") {
            let array = prefferedLanguage.components(separatedBy: "-")
            return array[0]
        }
        return prefferedLanguage
    }
    

}
extension String {
    
    func Localized() -> String{
        
        return LocalizationSystem.sharedInstance.localizedStringForKey(key: self, comment: "")
        
    }
}
func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
}
