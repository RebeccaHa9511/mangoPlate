////
////  TabbarController.swift
////  MangoPlateClone
////
////  Created by Rebecca Ha on 2022/07/07.
////
//
import UIKit
import CoreLocation

class TabbarController: UITabBarController, UITabBarControllerDelegate {
    var locationManager: CLLocationManager!

    let mainViewController = MainViewController()
    let mainTabBarItem = UITabBarItem(title: "맛집찾기", image: UIImage(named: "searchitem"), tag: 0)

    let pickViewController = MangoPickViewController()
    let pickTabBarItem = UITabBarItem(title: "망고픽", image: UIImage(named: "pickitem"), tag: 1)

    let newPostViewController = NewPostViewController()
    let newPostTabBarItem = UITabBarItem(title: "+", image: nil, tag: 2)


    let myInfoViewController = UserInfoViewController()
    let myInfoTabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "myinfoitem"), tag: 3)



    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.systemOrange
        self.tabBar.unselectedItemTintColor = UIColor.systemGray4
        self.tabBar.isTranslucent = false

        let mainNaviController = UINavigationController(rootViewController: mainViewController)
        let pickNavController = UINavigationController(rootViewController: pickViewController)
        let plusNavController = UINavigationController(rootViewController: newPostViewController)
        let myInfoNavController = UINavigationController(rootViewController: myInfoViewController)

        newPostTabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 27, bottom: 0, right: 27)

        mainTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 16, bottom: 15, right: 16)
        pickTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 15, bottom: 13, right: 15)
        myInfoTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 16, bottom: 15, right: 16)


        mainNaviController.tabBarItem = mainTabBarItem
        pickNavController.tabBarItem = pickTabBarItem
        plusNavController.tabBarItem = newPostTabBarItem
        myInfoNavController.tabBarItem = myInfoTabBarItem



         self.viewControllers = [mainNaviController, pickNavController, plusNavController, myInfoNavController]


        self.delegate = self


        setUpMiddleButton()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()

    }

    func setUpMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 20, y: 5, width: 40, height: 40))

        middleButton.setBackgroundImage(UIImage(named: "centerbutton"), for: .normal)
        //middleButton.layer.shadowColor = UIColor.black.cgColor
        //middleButton.layer.shadowOpacity = 0.1
        //middleButton.layer.shadowOffset = CGSize(width: 2, height: 2)

        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }

    @objc func menuButtonAction(sender: UIButton) {
        //self.selectedIndex = 2
        let plusNavController = UINavigationController(rootViewController: newPostViewController)
        plusNavController.modalPresentationStyle = .fullScreen
        plusNavController.modalTransitionStyle = .crossDissolve
        plusNavController.navigationController?.setNavigationBarHidden(true, animated: false)
        present(plusNavController, animated: true, completion: nil)
    }

    func toPick() {
        self.selectedIndex = 1
    }

}

extension TabbarController: CLLocationManagerDelegate {
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            self.locationManager.startUpdatingLocation()
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부됨")
            getLocationUsagePermission()
        default:
            print("GPS: Default")
        }
    }
}


//
//
//import UIKit
//
//class TabbarController : UITabBarController, UITabBarControllerDelegate {
//    let mainViewController = MainViewController()
//    let mangoPickViewController = MangoPickViewController()
//    let plusViewController = NewPostViewController()
//    let myInfoViewController = UserInfoViewController()
//
//
//    let mainTabBarItem = UITabBarItem(title: "맛집찾기", image: UIImage(systemName: "signpost.right"), tag: 0)
//    let mangoTabBarItem = UITabBarItem(title: "망고픽", image: UIImage(systemName: "bookmark"), tag: 1)
//    let plusTabBarItem = UITabBarItem(title: nil,
//                                      image: UIImage(named: "+")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemOrange),
//                                      tag: 2)
//
//    let myInfoTabBarItem = UITabBarItem(title: "내정보", image: UIImage(systemName: "person.crop.circle"), tag: 4)
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let mainVC = UINavigationController(rootViewController: mainViewController)
//        let mangoPickVC = UINavigationController(rootViewController: mangoPickViewController)
//        let plusVC = UINavigationController(rootViewController: plusViewController)
//
//
//        let myInfoVC = UINavigationController(rootViewController: myInfoViewController)
//
//
//        plusTabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 27, bottom: 0, right: 27)
//
//        mainVC.tabBarItem = mainTabBarItem
//        mangoPickVC.tabBarItem = mangoTabBarItem
//        plusVC.tabBarItem = plusTabBarItem
//        myInfoVC.tabBarItem = myInfoTabBarItem
//            self.viewControllers = [mainVC, mangoPickVC, plusVC, myInfoVC ]
//
//
//
//        self.delegate = self
//        self.tabBar.tintColor = UIColor.systemOrange
//        self.tabBar.unselectedItemTintColor = UIColor.systemGray3
//        self.tabBar.backgroundColor = UIColor.white
//
//    }
//    }
//
