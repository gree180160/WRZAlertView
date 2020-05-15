//
//  Global.swift
//
//
//  Created by wr on 2018/9/26.

import UIKit

// MARK: - weak
struct Global {
    static var dateFormatter = DateFormatter()
    static var calendar = Calendar(identifier: .gregorian)
    
    static func weekdayOfDate(_ date: Date) -> String {
        let day = calendar.component(.weekday, from: date)
        var weekday = ""
        if day == 1 {
            weekday = "周日"
        } else if day == 2 {
            weekday = "周一"
        } else if day == 3 {
            weekday = "周二"
        } else if day == 4 {
            weekday = "周三"
        } else if day == 5 {
            weekday = "周四"
        } else if day == 6 {
            weekday = "周五"
        } else if day == 7 {
            weekday = "周六"
        }
        return weekday
    }
    
    static func weekdayOfDateString(_ dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        return weekdayOfDate(date)
    }
}

//about view,lay
extension Global {
    static let SMCardRadius = 6*UI.WScale   //卡片圆角
    static let SMCardBkgColor = UIColor.white  //卡片背景色
    static let SMThemeColor = UIColor(hexString: "#CA3C3C")
    static let SMViewBkgColor = UIColor(hexString: "#F5F5F6")   //页面背景色
    static let SMTitleFontColor = UIColor(hexString: "#4A4A4A")    //新闻标题字体色
    static let SMSubTitleColor = UIColor(hexString: "#838383")  //副标题字体色
    static let viewAnimalDuration = 0.25              // UIView 动画持续时间
    static let viewToastDuration = 1.5
    static let SMLineSpace:CGFloat = 2.0
    static var bottomBtnSpace:CGFloat {   //页面底部的“下一步”，“确认”等按钮距离页面底部的距离
        max(13, UI.homeBarHeight)
    }
    #if DEBUG
    static let downTimeLaunchAD: Int = 1
    static let downTimeRegistraction: Int = 1
    #else
    static let downTimeLaunchAD: Int = 3
    static let downTimeRegistraction: Int = 10
    #endif
}

//about marason info content
extension Global {
    static let SMEmptyIndicator: String = "--"
}

// about third SDK id
extension Global {
    static let buglyID = "2fa8349cab"
    static let buglyKey = "0eac876b-6378-4458-ae72-f0f3db65c54e"
}
