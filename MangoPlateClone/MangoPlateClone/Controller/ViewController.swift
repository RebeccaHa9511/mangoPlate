//
//  ViewController.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/05.
//

import UIKit

import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon


class ViewController: UIViewController {

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var pLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
       
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
              UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                 if let error = error {
                   print(error)
                 }
                 else {
                  print("loginWithKakaoAccount() success.")
                  
                     guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
                             // 화면 전환 애니메이션 설정
                             mainVC.modalTransitionStyle = .coverVertical
                             // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                             mainVC.modalPresentationStyle = .fullScreen
                             self.present(mainVC, animated: true, completion: nil)
                  //do something
                  _ = oauthToken
   
                     self.setUserInfo()
                 }
              }
          
        
    }
    
    func setUserInfo() {
        //사용자 관리 api 호출
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
        //do something
                _ = user
                
            }
        }
    }
    
    func configureUI(){
        facebookButton.clipsToBounds = true
        facebookButton.layer.cornerRadius = 20
        facebookButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 13)
      
        
        kakaoButton.clipsToBounds = true
        kakaoButton.layer.cornerRadius = 20
        kakaoButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 13)
        
        appleButton.clipsToBounds = true
        appleButton.layer.cornerRadius = 20
        appleButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 13)
        
        emailButton.clipsToBounds = true
        emailButton.layer.cornerRadius = 20
        emailButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 13)
        
        pLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
    }
    
    
}

