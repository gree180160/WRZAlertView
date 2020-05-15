//
//  BaseAlertView.swift
//  SHMarasonT01
//
//  Created by WillowRivers on 2020/1/3.
//  Copyright © 2020 WillowRivers. All rights reserved.
//

import UIKit
import SnapKit

public enum AlertViewStyle {
    case allSCreen
    case allView
}

public enum HiddenStyle {
    case center  //在页面中间缩放
    case top    //从顶部消失
    case bottom  //从底部消失
    case fade  //交叉淡化过渡 这个效果是我猜的
}

public protocol AlertViewProtocol {
    func contentViewFrame()-> CGRect
    func configureSubViews()
    func makeShow(superV: UIView, newHiddenStyle: HiddenStyle)
    func makeHidden()
}

public protocol AlertViewItemTouchDelegate: NSObject {
    func touchedItem(itemTag: Int, useInput:String?)
}

open class BaseAlertView: UIView , AlertViewProtocol, UIGestureRecognizerDelegate {
    let contentView = UIView()
    weak var itemTouchDelegate: AlertViewItemTouchDelegate!
    var closeButton: UIButton!
    var hiddenStyle: HiddenStyle = .center
    public convenience init(style: AlertViewStyle) {
        self.init(frame: CGRect(x: 0, y: 0, width: UI.screenWidth, height: UI.screenHeigth))
        backgroundColor = UIColor(hexString: "#000000", alpha: 0.7)
        contentView.tag = 2002161231
        contentView.frame = contentViewFrame()
        self.addSubview(contentView)
        configureSubViews()
        configureCloseButton()
    }
    
    open func contentViewFrame() -> CGRect {
        return CGRect.zero
    }
    
    open func configureSubViews() {
        
    }
    
    /// add hidden this view element
    open func configureCloseButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesAction(ges:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        closeButton = UIButton()
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.bottom).offset(18*UI.HScale)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.height.equalTo(28*UI.WScale)
        }
        closeButton.setImage(UIImage(named: "alertView_close_button"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction(sender:)), for: .touchUpInside)
    }
    
    @objc func closeButtonAction(sender: UIButton) {
        makeHidden()
    }
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = gestureRecognizer.location(in: self)
        if contentView.isContainPoint(point: point) {
            return false
        }
        return true
    }
    
    @objc func tapGesAction(ges: UIGestureRecognizer) {
        makeHidden()
    }
    
    public func makeShow(superV: UIView, newHiddenStyle: HiddenStyle = .center) {
        superV.addSubview(self)
        self.hiddenStyle = newHiddenStyle
        switch newHiddenStyle {
        case .top:
            contentView.frame = CGRect(x: 0, y: -contentView.height, width: contentView.width, height: contentView.height)
        case .bottom:
            contentView.frame = CGRect(x: 0, y: self.height, width: contentView.width, height: contentView.height)
        case .fade:
            let transition = CATransition.init()
            transition.timingFunction = CAMediaTimingFunction(name: .default)
            transition.duration = Global.viewAnimalDuration
            transition.type = CATransitionType(rawValue: "fade") // 指定动画类型
            //transition.subtype = CATransitionSubtype(rawValue: "fromTop") // 指定过渡方向
            // 设置开始和结束的进度，范围都是0.0-1.0
            transition.startProgress = 0.1
            transition.endProgress = 1.0
            contentView.layer.add(transition, forKey: "top")
            contentView.alpha = 1.0
        case .center:
            break
        }
        UIView.animate(withDuration: Global.viewAnimalDuration, animations: { [weak self] in
            guard let strongSelf = self else {return}
            switch strongSelf.hiddenStyle {
            case .top:
                strongSelf.contentView.frame = CGRect(x: 0, y: 0, width: strongSelf.contentView.width, height: strongSelf.contentView.height)
            case .center:
                strongSelf.contentView.transform = (self?.contentView.transform)!.scaledBy(x: 0.5, y: 0.5)
                strongSelf.contentView.transform = (self?.contentView.transform)!.scaledBy(x: 2, y: 2)
                strongSelf.contentView.transform = CGAffineTransform.identity
            case .bottom:
                strongSelf.contentView.frame = CGRect(x: 0, y: strongSelf.height - strongSelf.contentView.height, width: strongSelf.contentView.width, height: strongSelf.contentView.height)
            case .fade:
                break
            }
            
        }) {[weak self] (finished) in
            guard let strongSelf = self else {return}
            guard strongSelf.closeButton != nil else {
                return
            }
            guard !strongSelf.closeButton.isDescendant(of: strongSelf.contentView) else {
                return  //contentView contain closeButton
            }
            strongSelf.closeButton.isHidden = false  //contentView doesn't contain closeButton
            strongSelf.contentView.layer.removeAnimation(forKey: "top")
        }
    }
    
    public func makeHidden() {
        if closeButton != nil && (!closeButton.isDescendant(of: contentView)) {
            self.closeButton.isHidden = true
        }
        
        UIView.animate(withDuration: Global.viewAnimalDuration, animations: { [weak self] in
            guard let strongSelf = self else {return}
            switch strongSelf.hiddenStyle {
            case .top:
                strongSelf.contentView.frame = CGRect(x: 0, y: -strongSelf.contentView.height, width: strongSelf.contentView.width, height: strongSelf.contentView.height)
            case .center:
                strongSelf.contentView.transform = (self?.contentView.transform)!.scaledBy(x: 0.5, y: 0.5)
                strongSelf.contentView.transform.translatedBy(x: 0.1, y: 0.1)
            case .bottom:
                strongSelf.contentView.frame = CGRect(x: 0, y: strongSelf.height, width: strongSelf.contentView.width, height: strongSelf.contentView.height)
            case .fade:
                strongSelf.contentView.alpha = 0.1
            }
        }) { (finished) in
            self.removeFromSuperview()
            UIApplication.shared.keyWindow?.endEditing(true)
        }
    }
}
