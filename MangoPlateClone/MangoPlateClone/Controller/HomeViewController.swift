//
//import UIKit
//import CoreLocation
//import Alamofire
//
//class HomeViewController: UIViewController {
//
//    @IBOutlet weak var scrollView: UIScrollView!
//    
//    
//    @IBOutlet weak var bannerCollectionView: UICollectionView!
//    @IBOutlet weak var itemsListCollectionView: UICollectionView!
//    
//    
//    @IBOutlet weak var distanceButton: UIButton!
//    @IBOutlet weak var filterButton: UIButton!
//    
//    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
//
//    
//    var nowPage : Int = 0
//    let bannerImgLst : [String] = ["banner1", "banner2", "banner3"]
//    
//
//    
//    var itemsList : [Item] = []
//    
//    
//    // MARK: LocationManager Init
//    lazy var locationManager: CLLocationManager = {
//        let manager = CLLocationManager()
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.delegate = self
//        
//        return manager
//    }()
//    
//    
//    // MARK: View Did Load
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // MARK: AF .get
//        NetworkManager.shared.getData(viewController: self)
//        
//        
//        self.scrollView.frame.size.width = view.bounds.width
//        
//        self.locationManager.delegate = self
//        self.locationManager = CLLocationManager()
//        
//        self.bannerCollectionView.delegate = self
//        self.bannerCollectionView.dataSource = self
//        self.itemsListCollectionView.delegate = self
//        self.itemsListCollectionView.dataSource = self
//        
//        // Nib Register
//        self.bannerCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bannerCell")
//        self.itemsListCollectionView.register(UINib(nibName: "StoreLstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "storeLstCell")
//        
//        // 위치 권한 요청 & 알림 요청
//        setupLocation()
//        requestNotificationPermission()
//        bannerTimer()
//        
//        // Button UI
//        setBtn()
//        setRadius()
////
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
////        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        self.itemsListCollectionView.collectionViewLayout = layout
//     
//        
//       
//    }
//    
//    // MARK: View Did Layout Sub Views
//    override func viewDidLayoutSubviews() {
//        self.changeHeight()
//    }
//    
//    
//    // MARK: Navigation Bar Hidden
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    
//    // MARK: Button UI
//    func setBtn() {
//        self.filterButton.layer.borderWidth = 1
//        self.filterButton.layer.borderColor = UIColor.gray.cgColor
//    }
//    func setRadius() {
//        self.filterButton.layer.cornerRadius = 17
//        self.distanceButton.layer.cornerRadius = 17
//    }
//    
//    
//    // MARK: 알림 권한 설정
//    func requestNotificationPermission(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
//            if didAllow {
//                // 허용했을 경우
//                print("Push: 권한 허용")
//            } else {
//                // 거부했을 경우
//                print("Push: 권한 거부")
//            }
//        })
//    }
//    
//    
//    // MARK: 자동 스크롤
//    func bannerTimer() {
//        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
//            self.bannerMove()
//        }
//    }
//    // 배너 움직이는 매서드
//    func bannerMove() {
//        // 현재페이지가 마지막 페이지일 경우
//        if self.nowPage == bannerImgLst.count-1 {
//            // 맨 처음 페이지로 돌아감
//            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
//            self.nowPage = 0
//            return
//        }
//        // 다음 페이지로 전환
//        self.nowPage += 1
//        bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
//    }
//    
//    
//    
//}
//
//
//// MARK: CV Delagate, Data Source
//extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    // MARK: Change Collection View Height
//    func changeHeight() {
//        self.collectionViewHeight.constant = self.itemsListCollectionView.collectionViewLayout.collectionViewContentSize.height
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.bannerCollectionView {
//            return self.bannerImgLst.count
//        } else if collectionView == self.itemsListCollectionView {
//            return self.itemsList.count
//        } else {
//            return 4
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == self.bannerCollectionView {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
//            cell.bannerImgView.image = UIImage(named: self.bannerImgLst[indexPath.row])
//            
//            return cell
//        } else if collectionView == itemsListCollectionView {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeLstCell", for: indexPath) as? PlacesCollectionViewCell else { return UICollectionViewCell() }
//            
//            let list = self.itemsList[indexPath.row]
//            
//            cell.restTitle.text = list.mainTitle
//            cell.places.text = list.addr1
//            cell.imageView.load(url: list.mainImgNormal!)
//
//            
//            return cell
//        } else {
//            return UICollectionViewCell()
//        }
//    }
//    
//    
//    // MARK: Detail View
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == self.bannerCollectionView {
//            
//            
//            // 가게 정보 Detail View 이동
//            let vc = DetailViewController()
//            // 클릭한 해당 가게의 id를 넘겨주기_detailView
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true, completion: nil)
//        }
//        
//    }
//    
//    
//    
//    // MARK: Layout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       
//        if collectionView == self.bannerCollectionView {
//            return CGSize(width: self.bannerCollectionView.bounds.width, height: self.bannerCollectionView.bounds.height)
//        }
//        
//        else if collectionView == self.itemsListCollectionView {
//            return CGSize(width: self.itemsListCollectionView.bounds.width / 2 - 10, height: 210)
//        }
//        
//        else {
//            return CGSize(width: 100, height: 100)
//        }
//        
//    }
//    
//}
//
//
//
//// MARK: 현재 위도 경도
//extension HomeViewController : CLLocationManagerDelegate {
//    
//    func setupLocation() {
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        
////        let coor = locationManager.location?.coordinate
////        self.lat = coor!.latitude
////        self.long = coor!.longitude
//    
////        print("현재 위/경도 -> \(lat),\(long)")
//    }
//    
//    func locationManager(_ manger: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedAlways, .authorizedWhenInUse:
//            print("GPS 권한 설정됨")
////            self.presentAlert(title: "GPS 권한이 설정되었습니다.")
//        case .restricted, .notDetermined:
//            print("GPS 권한 설정되지 않음")
////            self.presentAlert(title: "GPS 권한이 설정되지 않었습니다.")
//            setupLocation()
//        case .denied:
//            print("GPS 권한 요청 거부됨")
////            self.presentAlert(title: "GPS 권한이 거부되었습니다.")
//            setupLocation()
//        default:
//            print("GPS: Default")
//        }
//    }
//    
//    // MARK: 위치 정보
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations[locations.count - 1]
//        let longtitude: CLLocationDegrees = location.coordinate.longitude
//        let latitude:CLLocationDegrees = location.coordinate.latitude
//        
//        print("지역: \(longtitude), \(latitude)")
//    }
//    
//    
//}
//
//extension UIImageView {
//    func load(url : String) {
//        guard let url = URL(string: url) else {
//            return
//        }
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
