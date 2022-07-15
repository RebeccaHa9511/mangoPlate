//
//  MangoPickViewController.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/05.
//

import UIKit

class MangoPickViewController: UIViewController {
    
    
    @IBOutlet weak var eatDealButton: UIButton!
    @IBOutlet weak var storyButton: UIButton!
    @IBOutlet weak var topListButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var animationBar: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeView()
    }
    
    @IBAction func topTabBarbuttonTab(_ sender: UIButton) {
        sender.isSelected = true
        if sender.tag == 0 {
            storyButton.isSelected = false
            topListButton.isSelected = false
            slideViewAnimation(moveX: 0)
        } else if sender.tag == 1{
            eatDealButton.isSelected = false
            topListButton.isSelected = false
            slideViewAnimation(moveX: self.view.frame.width/3)
        }
        else{
            eatDealButton.isSelected = false
            storyButton.isSelected = false
            slideViewAnimation(moveX: self.view.frame.width/3*2)
        }
        
    }
    
    func slideViewAnimation(moveX: CGFloat){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5,initialSpringVelocity: 1, options: .allowUserInteraction,
                       animations: {
                        self.animationBar.transform = CGAffineTransform(translationX: moveX, y: 0)
                       }, completion: {_ in
                       })
    }
    
    func changeView(){
        guard let EATDealVC = self.storyboard?.instantiateViewController(identifier: "EatDealVC") as? EatDealVC else {
            return
        }
        for view in containerView.subviews{
            view.removeFromSuperview()
        }
        EATDealVC.willMove(toParent: self)
        containerView.frame = EATDealVC.view.bounds
        containerView.addSubview(EATDealVC.view)
        self.addChild(EATDealVC)
        EATDealVC.didMove(toParent: self)
    }
}
