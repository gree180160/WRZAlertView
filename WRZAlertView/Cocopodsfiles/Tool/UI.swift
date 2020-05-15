//
//  UI.swift
//
//
//  Created by wr on 2019/1/15.

import UIKit

enum DeviceType {
    case size_3_5
    case size_4_0
    case size_4_7
    case size_5_5
    case size_5_5_bigmode
    case size_5_8
    case size_5_8_bigmode
    case size_6_1
    case size_6_1_bigmode
    case size_6_5
    case size_6_5_bigmode
}

struct UI {
    
}

// MARK: - Device
extension UI {
    static var currentScreenSize: CGSize? {
        return UIScreen.main.currentMode?.size
    }
    
    static var deviceType: DeviceType {
        var type: DeviceType = .size_5_8_bigmode
        if let currentScreenSize = currentScreenSize {
            switch currentScreenSize {
            case CGSize(width: 640, height: 960):
                type = .size_3_5
            case CGSize(width: 640, height: 1136):
                type = .size_4_0
            case CGSize(width: 750, height: 1334):
                type = .size_4_7
            case CGSize(width: 1242, height: 2208):
                type = .size_5_5
            case CGSize(width: 1125, height: 2001):
                type = .size_5_5_bigmode
            case CGSize(width: 1125, height: 2436):
                type = .size_5_8
            case CGSize(width: 1125, height: 1136):
                type = .size_5_8_bigmode
            case CGSize(width: 828, height: 1792):
                type = .size_6_1
            case CGSize(width: 1125, height: 1136):
                type = .size_6_1_bigmode
            case CGSize(width: 1242, height: 2688):
                type = .size_6_5
            case CGSize(width: 1125, height: 1136):
                type = .size_6_5_bigmode
            default:
                type = .size_5_8_bigmode
            }
        }
        return type
    }
}

// MARK: - size
extension UI {
    static let leftBorder: CGFloat = 12
    static let topBorder: CGFloat = 12
    
    static let screenSize: CGSize = UIScreen.main.bounds.size
    static let screenWidth: CGFloat = screenSize.width
    static let screenHeigth: CGFloat = screenSize.height
    static let WScale: CGFloat = UIScreen.main.bounds.size.width/375
    static let HScale: CGFloat = UIScreen.main.bounds.size.height/667
    static var validScreenSize: CGSize {
        return CGSize(width: screenSize.width, height: screenSize.height - navigationBarMaxY - tabBarHeight)
    }
    // navigation bar 88, tab bar 83
//    static var navigationBarHeight: CGFloat {
//        var height: CGFloat
//        switch deviceType {
//        case .size_3_5, .size_4_0, .size_4_7, .size_5_5, .size_5_5_bigmode:
//            height = 0
//        default:
//            height = 44
//        }
//        return height
//    }
    static var navigationBarHeight: CGFloat {
        return 44.0
    }
    
    static var navigationBarMaxY: CGFloat {
        return 44 + statusBarHeight;
    }
    
    static var homeBarHeight: CGFloat {
        var height: CGFloat
        switch deviceType {
        case .size_3_5, .size_4_0, .size_4_7, .size_5_5, .size_5_5_bigmode:
            height = 0
        default:
            height = 34
        }
        return height
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    static var tabBarHeight: CGFloat { // include homeBar
        var height: CGFloat
        switch deviceType {
        case .size_3_5, .size_4_0, .size_4_7, .size_5_5, .size_5_5_bigmode:
            height = 49
        default:
            height = 82
        }
        return height
    }
    
    static var keyboardHeight: CGFloat {
        var height: CGFloat
        switch deviceType {
        case .size_3_5, .size_4_0, .size_4_7, .size_5_5, .size_5_5_bigmode:
            height = 271
        default:
            height = 340
        }
        return height
    }
}

// MARK: - tableView
extension UI {
    static let cardViewTop:CGFloat = 5.0
    static let cardViewLeft:CGFloat = 12.0
    static let tableViewCellHeight: CGFloat = 40 * HScale;
    static let tableViewEstimatedCellHeight: CGFloat = 40 * HScale;
    static let tableViewHeaderHeight: CGFloat = 10 * HScale;
    static let tableViewFooterHeight: CGFloat = UI.homeBarHeight;
    
    static let collectionViewCellHeight: CGFloat = 80 * HScale;
    static let collectionViewEstimatedCellHeight: CGFloat = 80 * HScale;
    static let collectionViewHeaderHeight: CGFloat = 20 * HScale;
    static let collectionViewFooterHeight: CGFloat = 0.0 * HScale;
    
}
