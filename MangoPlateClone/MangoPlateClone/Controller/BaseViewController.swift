//
//  BaseViewController.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/07.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 아래 예시들처럼 상황에 맞게 활용하시면 됩니다.

        self.navigationController?.navigationBar.isTranslucent = false
        
        // Background Color
//        self.view.backgroundColor = .white
    }
    
    func customNavBarLeft(title: String) {
        let containerView = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 15))
        topLabel.numberOfLines = 1
        topLabel.textAlignment = .left
        topLabel.font = .systemFont(ofSize: 11.5)
        topLabel.textColor = .black
        topLabel.text = "지금 보고있는 지역은"
        
        let bottomLabel = UILabel(frame: CGRect(x: 0, y: topLabel.frame.height, width: 200, height: 20))
        bottomLabel.numberOfLines = 1
        bottomLabel.textAlignment = .left
        bottomLabel.font = .systemFont(ofSize: 18)
        bottomLabel.textColor = .black
        bottomLabel.text = title
        bottomLabel.sizeToFit()
        
        let downImg = UIImageView(frame: CGRect(x: bottomLabel.frame.width + 3, y: topLabel.frame.height + 7, width: 10, height: 6))
        downImg.image = UIImage(systemName: "chevron.down")
        downImg.tintColor = .black
        
        containerView.addSubview(topLabel)
        containerView.addSubview(bottomLabel)
        containerView.addSubview(downImg)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
    }
    
    func navTitleLeftAlign(title: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 60, height: view.frame.height))
        
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        
        navigationItem.titleView = label
    }
    
    func customNavBarRight() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 70))
        
        let searchButton = UIButton(frame: CGRect(x: 0, y: 8, width: 25, height: 25))
        searchButton.setImage(UIImage(named: "searchbutton"), for: .normal)
        searchButton.adjustsImageWhenHighlighted = false
        
        let separatorView = UIView(frame: CGRect(x: 35, y: 5, width: 0.8, height: 30))
        separatorView.backgroundColor = UIColor.white
        
        let mapButton = UIButton(frame: CGRect(x: 45, y: 8, width: 25, height: 25))
        mapButton.setImage(UIImage(named: "mapbutton"), for: .normal)
        mapButton.adjustsImageWhenHighlighted = false
        
        containerView.addSubview(searchButton)
        containerView.addSubview(separatorView)
        containerView.addSubview(mapButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containerView)
    }
    
    
    
}
