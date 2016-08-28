//
//  Extensions.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc static let rgbRange: CGFloat = 255

    /// 17B3DD
    static func skyBlueColor() -> UIColor {
        return UIColor(red: CGFloat(23) / rgbRange,
                       green: CGFloat(179) / rgbRange,
                       blue: CGFloat(221) / rgbRange,
                       alpha: 1)
    }

    /// FF4A5D
    static func pastelRedColor() -> UIColor {
        return UIColor(red: CGFloat(255) / rgbRange,
                       green: CGFloat(74) / rgbRange,
                       blue: CGFloat(53) / rgbRange,
                       alpha: 1)
    }

    /// FEBF34
    static func pastelYellowColor() -> UIColor {
        return UIColor(red: CGFloat(254) / rgbRange,
                       green: CGFloat(191) / rgbRange,
                       blue: CGFloat(52) / rgbRange,
                       alpha: 1)
    }

    /// 1BBC9B
    static func pastelTealColor() -> UIColor {
        return UIColor(red: CGFloat(27) / rgbRange,
                       green: CGFloat(188) / rgbRange,
                       blue: CGFloat(155) / rgbRange,
                       alpha: 1)
    }

    /// 764EBE
    static func pastelPurpleColor() -> UIColor {
        return UIColor(red: CGFloat(118) / rgbRange,
                       green: CGFloat(78) / rgbRange,
                       blue: CGFloat(190) / rgbRange,
                       alpha: 1)
    }

    /// 363B5B
    static func navyBlueColor() -> UIColor {
        return UIColor(red: CGFloat(54) / rgbRange,
                       green: CGFloat(59) / rgbRange,
                       blue: CGFloat(191) / rgbRange,
                       alpha: 1)
    }

    /// 333333
    static func deepGrayColor() -> UIColor {
        return UIColor(red: CGFloat(51) / rgbRange,
                       green: CGFloat(51) / rgbRange,
                       blue: CGFloat(51) / rgbRange,
                       alpha: 1)
    }
    static func wordColor() -> UIColor {
        return deepGrayColor()
    }

    /// B3B3B3
    static func mediumGrayColor() -> UIColor {
        return UIColor(red: CGFloat(179) / rgbRange,
                       green: CGFloat(179) / rgbRange,
                       blue: CGFloat(179) / rgbRange,
                       alpha: 1)
    }

    /// CCCCCC
    static func faintGrayColor() -> UIColor {
        return UIColor(red: CGFloat(204) / rgbRange,
                       green: CGFloat(204) / rgbRange,
                       blue: CGFloat(204) / rgbRange,
                       alpha: 1)
    }
}