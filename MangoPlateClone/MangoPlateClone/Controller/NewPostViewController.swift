//
//  NewPostViewController.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/07.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var menuStackView: UIStackView!
    var xButtonMidY: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.layer.cornerRadius = dismissButton.frame.width/2

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareSetAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showSetAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showDismissAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showDismissAnimation()
    }
    
    private func prepareSetAnimation(){
        dismissButton.transform = CGAffineTransform(translationX: 0, y: 0).rotated(by: -46)
        dismissButton.alpha = 1
        menuStackView.transform = CGAffineTransform(translationX: 0, y: 60)
        menuStackView.alpha = 0
    }
    
    private func showSetAnimation(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction,
                       animations: {
                        //변하기 전의 모습으로는 identity로 접근이 가능함.
                        self.dismissButton.transform = CGAffineTransform.identity
                        self.dismissButton.alpha = 1
                       }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .allowUserInteraction,
                       animations: {
                        
                        self.menuStackView.transform = CGAffineTransform.identity
                        self.menuStackView.alpha = 1
                       }, completion: nil)
    }
    
    private func prepareDismissAnimation(){
        dismissButton.transform = CGAffineTransform.identity
        dismissButton.alpha = 1
    }
    
    private func showDismissAnimation(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6,initialSpringVelocity: 2, options: .allowUserInteraction,
                       animations: {
                        
                        self.dismissButton.transform = CGAffineTransform(translationX: 0, y: 0).rotated(by: -45)
                       }, completion: nil)
    }
    
    @IBAction func dismissVCTab(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
