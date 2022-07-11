//
//  IndicatorView.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/07.
//

import UIKit

open class IndicatorView {
    static let shared = IndicatorView()
        
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    open func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.containerView.frame = window.frame
        self.containerView.center = window.center
        self.containerView.backgroundColor = .clear
        
        self.containerView.addSubview(self.activityIndicator)
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    
    open func showIndicator() {
        self.containerView.backgroundColor = UIColor.white
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .large
        self.activityIndicator.color = UIColor.orange
        self.activityIndicator.center = self.containerView.center
        
        self.activityIndicator.startAnimating()
    }
    
    open func dismiss() {
        self.activityIndicator.stopAnimating()
        self.containerView.removeFromSuperview()
    }
}
