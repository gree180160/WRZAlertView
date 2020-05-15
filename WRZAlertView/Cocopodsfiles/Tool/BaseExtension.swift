//
//  BaseExtension.swift
//  WRAlertViewDemo
//
//  Created by WillowRivers on 2020/5/13.
//  Copyright © 2020 com.WRTechnology. All rights reserved.
//

import UIKit

enum LayoutKind {
    case wid_Scale      //宽高比和UI一致，宽高都*UI.Wscale
    case hei_Scale     //宽高比和UI一致，宽高都*UI.Hscale , 谨慎使用，max 机型wscale < hScale ,所以screenWidth * Hscale 会大于屏幕实际宽度
    case wh_Scale   //宽高比和UI 不 一致 ，宽*wscale， 高*hscale。考虑到NavigationBar 的影响，hscale 并不绝对准确，只是屏幕的高度比，而不是可用的空间的高度比
    case no_ScaleBut5    //5series wid * wscale， hei*hscale， 其他设置 宽高比和UI一致，宽高于UI尺寸完全一致,
    case absoluteSize   //绝对尺寸，不做任何比例缩放 宽高于UI尺寸完全一致, 宽度不要用375，用UI.screenWidth
}

extension UIView {
    //    frame and size
    var minX: CGFloat {
        return self.frame.minX
    }
    var minY: CGFloat {
        return self.frame.minY
    }
    var maxX: CGFloat {
        return self.frame.minX + self.frame.size.width
    }
    var maxY: CGFloat {
        return self.frame.minY + self.frame.size.height
    }
    
    var width: CGFloat {
        return self.frame.width
    }
    var height: CGFloat {
        return self.frame.height
    }
    
    var centerX: CGFloat {
        minX + width/2
    }
    var centerY: CGFloat {
        minY + height/2
    }
    
    
    /// 初始化方法，根据屏幕尺寸自动调整大小
    /// - Parameters:
    ///   - frame: frame
    ///   - adjust: true： adjust  frame by scale ， false： （defualt vaue）should‘t adjust frame
    convenience init(frame: CGRect, adjust:LayoutKind = .absoluteSize) {
        switch adjust {
        case .wh_Scale:
             self.init(frame: CGRect(x: frame.origin.x*UI.WScale, y: frame.origin.y*UI.HScale, width: frame.width*UI.WScale, height: frame.height*UI.HScale))
        case .hei_Scale:
             self.init(frame: CGRect(x: frame.origin.x*UI.HScale, y: frame.origin.y*UI.HScale, width: frame.width*UI.HScale, height: frame.height*UI.HScale))
        case .wid_Scale:
             self.init(frame: CGRect(x: frame.origin.x*UI.WScale, y: frame.origin.y*UI.WScale, width: frame.width*UI.WScale, height: frame.height*UI.WScale))
        case .no_ScaleBut5:
            if UI.screenWidth < 374 {
                 self.init(frame: CGRect(x: frame.origin.x*UI.WScale, y: frame.origin.y*UI.HScale, width: frame.width*UI.WScale, height: frame.height*UI.HScale))
            }else {
                self.init(frame: frame)
            }
        default:
            self.init(frame: frame)
        }
    }
    
    //    border and shadow
    
    
    /// 给view顶部加边框
    /// - Parameters:
    /// -leftspace :  左边有边距
    ///   - width: 边框高度
    ///   - color: color description
    func addTopBorder(width: CGFloat, color: UIColor, leftSpace: CGFloat = 0) {
        let border = CALayer()
        border.frame = CGRect(x: leftSpace, y: 0, width: frame.width - 2*leftSpace, height: width)
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
    }
    
    
    /// 给view底部加边框
    /// - Parameters:
    ///   - width: 边框高度
    ///   - color: color description
    func addBorder(width: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
    }
    
    /** 部分圆角
     * - corners: 需要实现为圆角的角，可传入多个
     * - radii: 圆角半径
     */
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 判读point 是否落在view 内部，
    /// - Parameter point: point 是在self.superView 中的位置
    func isContainPoint(point: CGPoint) ->Bool {
        return  (point.x >= self.minX && point.x <= self.maxX) && (point.y >= self.minY && point.y <= self.maxY)
    }
    
}


public extension UIColor {
    convenience init(hexString: UInt32, alpha: CGFloat = 1.0) {
        let red     = CGFloat((hexString & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((hexString & 0x00FF00) >> 8 ) / 255.0
        let blue    = CGFloat((hexString & 0x0000FF)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    static var random: UIColor {
        let r = CGFloat(Double(arc4random() % 255) / 255.0)
        let g = CGFloat(Double(arc4random() % 255) / 255.0)
        let b = CGFloat(Double(arc4random() % 255) / 255.0)
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
}



