//
//  UIButton.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/12.
//

import UIKit

// MARK: UIButton 내에 Indicator 표시
extension UIButton {
    func showIndicator() {
        let indicator = UIActivityIndicatorView()
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
        self.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func dismissIndicator() {
        for view in self.subviews {
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
    //로그인할때 버튼 Radius
    func cornerRadiusLogin(){
        self.layer.cornerRadius = 20
    }
    
    
    func cornerCircleRadius(){
        self.layer.cornerRadius = self.bounds.width / 2
    }
}
