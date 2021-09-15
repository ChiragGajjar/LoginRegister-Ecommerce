//
//  Extentions.swift
//  SeasonLife
//
//  Created by Theappfathers on 27/11/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

class ImageRounded:UIImageView
{
    override func awakeFromNib()
    {
        self.backgroundColor = UIColor.init(hexString: "CAE9F6")
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.alpha = 0.5
    }
}


class Rounded:UIButton
{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.init(hexString: "34A5D9")
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

class ApplyedButtonRounded:UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.init(hexString: "32CD32")
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}


class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.gray
    
    override func layoutSubviews() {
        cornerRadius = layer.frame.height / 2
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
}
class CardSquareView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.gray
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
}
extension UIViewController {
    
    func AskConfirmation (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: Language.OK.Localized(), style: .default, handler: { action in
            completion(true)
        }))
        //
        //        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        //            completion(false)
        //        }))
    }
    
    func AskConfirmationWithCancel (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: Language.OK.Localized(), style: .default, handler: { action in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: Language.Cancel.Localized(), style: .cancel, handler: { action in
            completion(false)
        }))
    }
    
    func ConfirmationAlert (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: Language.OK.Localized(), style: .default, handler: { action in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: Language.Cancel.Localized(), style: .cancel, handler: { action in
            completion(false)
        }))
    }
}


@IBDesignable extension UIButton {
    
    @IBInspectable var bordWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var bordColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


@IBDesignable extension UIView {
    
    @IBInspectable var ViewWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var ViewRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var ViewColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var leftBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = UIColor(cgColor: layer.borderColor!)
            line.tag = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    
    @IBInspectable var topBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = ViewColor
            line.tag = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        }
    }
    
    @IBInspectable var rightBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = ViewColor
            line.tag = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var bottomBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = ViewColor
            line.tag = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        }
    }
}

extension Date {
    // Returns the number of years
    func yearsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    // Returns the number of months
    func monthsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    // Returns the number of weeks
    func weeksCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    // Returns the number of days
    func daysCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    // Returns the number of hours
    func hoursCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    // Returns the number of minutes
    func minutesCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    // Returns the number of seconds
    func secondsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    // Returns time ago by checking if the time differences between two dates are in year or months or weeks or days or hours or minutes or seconds
    func timeAgo(from date: Date) -> String {
        if yearsCount(from: date)   > 0 { return "\(yearsCount(from: date)) years ago"   }
        if monthsCount(from: date)  > 0 { return "\(monthsCount(from: date)) months ago"  }
        if weeksCount(from: date)   > 0 { return "\(weeksCount(from: date)) weeks ago"   }
        if daysCount(from: date)    > 0 { return "\(daysCount(from: date)) days ago"    }
        if hoursCount(from: date)   > 0 { return "\(hoursCount(from: date)) hours ago"   }
        if minutesCount(from: date) > 0 { return "\(minutesCount(from: date)) minutes ago" }
        if secondsCount(from: date) > 0 { return "\(secondsCount(from: date)) seconds ago" }
        return ""
    }
}
extension UINavigationController {
    
    func backToViewController(viewController: Swift.AnyClass) {
        
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
extension UINavigationController {
    func popToController<T: UIViewController>(_ type: T.Type, animated: Bool) {
        if let vc = viewControllers.first(where: { $0 is T }) {
            popToViewController(vc, animated: animated)
        }
    }
    func popToControllerOrToRootControllerIfNotInTheStack<T: UIViewController>(_ type: T.Type, animated: Bool) {
        if let vc = viewControllers.first(where: { $0 is T }) {
            popToViewController(vc, animated: animated)
        } else {
            popToRootViewController(animated: animated)
        }
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

@IBDesignable
extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}
extension UIView {
  func addDashedBorder() {
    let color = UIColor.red.cgColor

    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6,3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

    self.layer.addSublayer(shapeLayer)
    }
}
class CustomDashedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}

@IBDesignable
class RoundedEnds: UIView {

    override func layoutSubviews() { setup() } // "layoutSubviews" is best

    func setup() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 30, height: 30))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

@IBDesignable
class RoundedTopEnds: UIView {

    override func layoutSubviews() { setup() } // "layoutSubviews" is best

    func setup() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 30, height: 30))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
class GradientView: UIView {
    override func layoutSubviews() { setup() } // "layoutSubviews" is best
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    func setup() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
    }
}

