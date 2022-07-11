//
//  CustomButton.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/07.
//

import UIKit

class MyCustomButton: UIButton {
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    private let myIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var viewModel: MyCustomButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: MyCustomButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubviews()
        configure(with: viewModel)
    }
    
    private func addSubviews() {
        guard !myTitleLabel.isDescendant(of: self) else {
            return
        }
        
        addSubview(myTitleLabel)
        addSubview(myIconView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: MyCustomButtonViewModel){
        myTitleLabel.text = viewModel.title
        myTitleLabel.textColor = UIColor(cgColor: viewModel.borderColor)
        myIconView.image = UIImage(named: viewModel.imageName)?.withRenderingMode(.alwaysTemplate)
        
        addSubviews()
        
        layer.cornerRadius = 16
        layer.borderWidth = viewModel.borderWidth
        layer.borderColor = viewModel.borderColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myIconView.frame = CGRect(x: 11, y: 7, width: 17, height: 17)
        myTitleLabel.frame = CGRect(x: 34, y: 8, width: 40, height: 30)
        //myTitleLabel.center.y = self.frame.height / 2
        myTitleLabel.sizeToFit()
        self.frame.size = CGSize(width: 43 + myTitleLabel.frame.width , height: 32)
    }
}

struct MyCustomButtonViewModel {
    let imageName: String
    let title: String
    let borderWidth: CGFloat
    let borderColor: CGColor
}
