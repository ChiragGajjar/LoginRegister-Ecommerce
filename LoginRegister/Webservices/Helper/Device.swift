//
//  Device.swift
//
//  Created by apple on 2017-12-13.
//  Copyright © 2017 Doth Solutions. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Device Structure
struct Device {
    
    // MARK: - Singletons
    static var TheCurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    static var TheCurrentDeviceVersion: Float {
        struct Singleton {
            static let version =  (UIDevice.current.systemVersion as NSString).floatValue
        }
        return Singleton.version
    }
    
    static var TheCurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.main.bounds.size.height
        }
        return Singleton.height
    }
    
    // MARK: - Device Idiom Checks
    static var PHONE_OR_PAD: String {
        if isPhone() {
            return "iPhone"
        } else if isPad() {
            return "iPad"
        }
        return "Not iPhone nor iPad"
    }
    
    static var DEBUG_OR_RELEASE: String {
        #if DEBUG
            return "Debug"
        #else
            return "Release"
        #endif
    }
    
    static var SIMULATOR_OR_DEVICE: String {
        #if targetEnvironment(simulator)
            return "Simulator"
        #else
            return "Device"
        #endif
    }
  
    static func isPhone() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .phone
    }
    
    static func isPad() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .pad
    }
    
    static func isDebug() -> Bool {
        return DEBUG_OR_RELEASE == "Debug"
    }
    
    static func isRelease() -> Bool {
        return DEBUG_OR_RELEASE == "Release"
    }
    
    static func isSimulator() -> Bool {
        return SIMULATOR_OR_DEVICE == "Simulator"
    }
    
    static func isDevice() -> Bool {
        return SIMULATOR_OR_DEVICE == "Device"
    }
    
    // MARK: - Device Version Checks
    enum Versions: Float {
        case Five = 5.0
        case Six = 6.0
        case Seven = 7.0
        case Eight = 8.0
        case Nine = 9.0
    }
    
    static func isVersion(version: Versions) -> Bool {
        return TheCurrentDeviceVersion >= version.rawValue && TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }
    
    static func isVersionOrLater(version: Versions) -> Bool {
        return TheCurrentDeviceVersion >= version.rawValue
    }
    
    static func isVersionOrEarlier(version: Versions) -> Bool {
        return TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }
    
    static var CURRENT_VERSION: String {
        return "\(TheCurrentDeviceVersion)"
    }
    
    // MARK: iOS 5 Checks
    static func IS_OS_5() -> Bool {
        return isVersion(version: .Five)
    }
    
    static func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(version: .Five)
    }
    
    static func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: .Five)
    }
    
    // MARK: iOS 6 Checks
    static func IS_OS_6() -> Bool {
        return isVersion(version: .Six)
    }
    
    static func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(version: .Six)
    }
    
    static func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: .Six)
    }
    
    // MARK: iOS 7 Checks
    static func IS_OS_7() -> Bool {
        return isVersion(version: .Seven)
    }
    
    static func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(version: .Seven)
    }
    
    static func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: .Seven)
    }
    
    // MARK: iOS 8 Checks
    static func IS_OS_8() -> Bool {
        return isVersion(version: .Eight)
    }
    
    static func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(version: .Eight)
    }
    
    static func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: .Eight)
    }
    
    // MARK: iOS 9 Checks
    static func IS_OS_9() -> Bool {
        return isVersion(version: .Nine)
    }
    
    static func IS_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(version: .Nine)
    }
    
    static func IS_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: .Nine)
    }
    
    // MARK: - Device Size Checks
    enum Heights: CGFloat {
        case Inches_3_5 = 480
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }
    
    static func isSize(height: Heights) -> Bool {
        return TheCurrentDeviceHeight == height.rawValue
    }
    
    static func isSizeOrLarger(height: Heights) -> Bool {
        return TheCurrentDeviceHeight >= height.rawValue
    }
    
    static func isSizeOrSmaller(height: Heights) -> Bool {
        return TheCurrentDeviceHeight <= height.rawValue
    }
    
    static var CURRENT_SIZE: String {
        if IS_3_5_INCHES() {
            return "3.5 Inches"
        } else if IS_4_INCHES() {
            return "4 Inches"
        } else if IS_4_7_INCHES() {
            return "4.7 Inches"
        } else if IS_5_5_INCHES() {
            return "5.5 Inches"
        }
        return "\(TheCurrentDeviceHeight) Points"
    }
    
    // MARK: Retina Check
    static func IS_RETINA() -> Bool {
        return UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale))
    }
    
    // MARK: 3.5 Inch Checks
    static func IS_3_5_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_3_5)
    }
    
    static func IS_3_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_3_5)
    }
    
    static func IS_3_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(height: .Inches_3_5)
    }
    
    // MARK: 4 Inch Checks
    static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_4)
    }
    
    static func IS_4_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_4)
    }
    
    static func IS_4_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(height: .Inches_4)
    }
    
    // MARK: 4.7 Inch Checks
    static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_4_7)
    }
    
    static func IS_4_7_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_4_7)
    }
    
    static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_4_7)
    }
    
    // MARK: 5.5 Inch Checks
    static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_5_5)
    }
    
    static func IS_5_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_5_5)
    }
    
    static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_5_5)
    }

}

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}
