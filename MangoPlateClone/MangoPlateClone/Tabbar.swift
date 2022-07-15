//
//  Tabbar.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/11.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon


class Tabbar: BaseViewController , UIViewControllerTransitioningDelegate{

    @IBOutlet weak var animationBar: UIView!
    
    @IBOutlet weak var containerMainView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabBarStackView: UIStackView!
    @IBOutlet weak var searchRestuarantImage: UIButton!
    @IBOutlet weak var searchRestuarantLabel: UIButton!
    

    @IBOutlet weak var mangoPickImage: UIButton!
    
    @IBOutlet weak var mangoPickLabel: UIButton!
    
    @IBOutlet weak var plusImage: UIButton!
    @IBOutlet weak var myProfileImage: UIButton!
    @IBOutlet weak var myProfileLabel: UIButton!

    var tabBarItemImage : [UIButton] = [UIButton]()
    var tabBarItemLabel : [UIButton] = [UIButton]()
    let transition =  CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItemImage = [self.searchRestuarantImage , self.mangoPickImage , self.myProfileImage]
        self.tabBarItemLabel = [self.searchRestuarantLabel , self.mangoPickLabel , self.myProfileLabel]
        changeToMainViewController(containerView: contentView)
        selectedTabBarButton(selectedTabBarImage: self.searchRestuarantImage, selectedTabBarLabel: self.searchRestuarantLabel)
        self.plusImage.layer.cornerRadius = self.plusImage.frame.width/2
    }
    
    @IBAction func searchRestrauntButtonTapped(_ sender: Any) {changeToMainViewController(containerView: contentView)
        slideViewAnimation(moveX: 0)
        selectedTabBarButton(selectedTabBarImage: self.searchRestuarantImage, selectedTabBarLabel: self.searchRestuarantLabel)
        
        
    }
    
    
    @IBAction func pickButtonTapped(_ sender: Any) {
        changeToMangoPickView(containerView: contentView)
        slideViewAnimation(moveX: self.view.frame.width/5)
        selectedTabBarButton(selectedTabBarImage: self.mangoPickImage, selectedTabBarLabel: self.mangoPickLabel)
        
    }
    
    
    @IBAction func userProfileButtonTapped(_ sender: Any) {
        slideViewAnimation(moveX: self.view.frame.width/5*4)
        selectedTabBarButton(selectedTabBarImage: self.myProfileImage, selectedTabBarLabel: self.myProfileLabel)
    }
    

    
    
    // MARK:커스텀 탭바 버튼들의 isSelect 바꾸는 함수
    func selectedTabBarButton(selectedTabBarImage : UIButton, selectedTabBarLabel : UIButton){
        tabBarItemImage = tabBarItemImage.map { button in
            button.isSelected = false
            return button
        }
        tabBarItemLabel = tabBarItemLabel.map { button in
            button.isSelected = false
            return button
        }
        selectedTabBarImage.isSelected = true
        selectedTabBarLabel.isSelected = true
    }
    

    
    func slideViewAnimation(moveX: CGFloat){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5,initialSpringVelocity: 0.7, options: .allowUserInteraction,
                       animations: {
                        self.animationBar.transform = CGAffineTransform(translationX: moveX, y: 0)
                       }, completion: {_ in
                       })
    }
}


extension Tabbar{
// MARK: - animation style
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! NewPostViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        secondVC.xButtonMidY = plusImage.frame.midY
        secondVC.screenHeight = self.contentView.bounds.size.height
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x: self.contentView.bounds.size.width/2, y: self.contentView.bounds.size.height - plusImage.frame.midY)
        //print(self.contentView.bounds.size.height)
        transition.circleColor = plusImage.backgroundColor!
        
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: self.contentView.bounds.size.width/2, y: self.contentView.bounds.size.height - plusImage.frame.midY)
        transition.circleColor = plusImage.backgroundColor!
        
        return transition
    }
}


extension Tabbar{

    func changeToMainViewController(containerView: UIView){
        guard let SearchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as? MainViewController else {
            return
        }
        for view in containerView.subviews{
            view.removeFromSuperview()
        }
        SearchVC.willMove(toParent: self)
        containerView.frame = SearchVC.view.bounds
        containerView.addSubview(SearchVC.view)
        self.addChild(SearchVC)
        SearchVC.didMove(toParent: self)
    }
    
    func changeToMangoPickView(containerView: UIView){
        guard let mangoPickVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MangoPickViewController") as? MangoPickViewController else {
            return
        }
        
        for view in containerView.subviews{
            view.removeFromSuperview()
        }
        mangoPickVC.willMove(toParent: self)
        containerView.addSubview(mangoPickVC.view)
        self.addChild(mangoPickVC)
        mangoPickVC.didMove(toParent: self)
    }
    
    func changeToNewPostView(containerView: UIView){
        guard let plusVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewPostViewController") as? NewPostViewController else {
            return
        }
        for view in containerView.subviews{
            view.removeFromSuperview()
        }
        plusVC.willMove(toParent: self)
        containerView.addSubview(plusVC.view)
        self.addChild(plusVC)
        plusVC.didMove(toParent: self)
    }
    
    

        
}
