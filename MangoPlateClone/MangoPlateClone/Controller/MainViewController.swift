//
//  MainViewController.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/05.
//

import UIKit
import Alamofire
import CoreLocation


class MainViewController: UIViewController, UIScrollViewDelegate{
    
    var restrauntList: [Item] = []

    
    //배너
    @IBOutlet weak var bannerScrollView: UIScrollView!
    var bannerImages = [UIImage(named: "banner1"), UIImage(named: "banner2"), UIImage(named: "banner3")]
    var imageViews = [UIImageView]()
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewheight: NSLayoutConstraint!
    let layout = UICollectionViewFlowLayout()
    
    
    @IBOutlet weak var filterView: UIView!
    

    
    @IBOutlet weak var bannerPageControl: UIPageControl!
    var nowPage = 0
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        
        return manager
    }()
    
    private let myLocationButton: MyCustomButton = {
        let button = MyCustomButton(frame: CGRect(x: 245, y: 7, width: 80, height: 32))
        button.backgroundColor = .systemGray4
        button.tintColor = .systemOrange
        return button
    }()
    private let myFilterButton: MyCustomButton = {
        let button = MyCustomButton(frame: CGRect(x: 338, y: 7, width: 65, height: 32))
        button.backgroundColor = .white
        button.tintColor = .darkGray
        return button
    }()
    

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.getData(viewController: self)
        
        
        
        self.locationManager.delegate = self
        self.locationManager = CLLocationManager()
        setupLocation()
        requestNotificationPermission()
        
       //배너
        setBannerPageControl()
        bannerScrollView.delegate = self
        addBannerScrollView()
        
        //네비게이션버튼
        configureButtons()
        
        //컬렉션뷰
        self.collectionView.register(UINib(nibName: "PlacesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlacesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCollectionView()

        
        //filter view
        filterView.addSubview(myFilterButton)
        let viewModel = MyCustomButtonViewModel(imageName: "settings", title: "필터", borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        myFilterButton.configure(with: viewModel)
        filterView.addSubview(myLocationButton)
        let viewModel1 = MyCustomButtonViewModel(imageName: "add", title: "내 주변", borderWidth: 0, borderColor: UIColor.systemOrange.cgColor)
        myLocationButton.configure(with: viewModel1)

        
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        showIndicator()
//
//        }
//
//    override func viewDidAppear(_ animated: Bool) {
//        dismissIndicator()
//
//    }
    // MARK: - LIFE CYCLE
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Collection View 설정

    
    func setupCollectionView(){
        layout.scrollDirection = .vertical

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.frame.width / 2 - 15
            layout.itemSize = CGSize(width: width, height: width / 19 * 25)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
       
    }
    
   
  // MARK: - Indicator Setting
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
    // MARK: - Banner설정
     func addBannerScrollView() {
           for i in 0..<bannerImages.count {
               let imageView = UIImageView()
               let xPos = self.view.frame.width * CGFloat(i)
               imageView.frame = CGRect(x: xPos, y: 0, width: bannerScrollView.bounds.width, height: bannerScrollView.bounds.height)
               imageView.image = bannerImages[i]
               bannerScrollView.addSubview(imageView)
               bannerScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
           }
       }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let value = bannerScrollView.contentOffset.x/bannerScrollView.frame.size.width
           bannerPageControlSelectedPage(currentPage: Int(round(value)))
       }
    
    func setBannerPageControl(){
        bannerPageControl.numberOfPages = bannerImages.count
  
    }
    private func bannerPageControlSelectedPage(currentPage:Int) {
          bannerPageControl.currentPage = currentPage
      }
    
  
    
    // MARK: - 맵 버튼
    @IBAction func mapButtonTapped(_ sender: UIButton) {
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
                // 화면 전환 애니메이션 설정
        mapVC.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        mapVC.modalPresentationStyle = .fullScreen
                self.present(mapVC, animated: true, completion: nil)
        
    }
    
    
    
    func configureButtons(){
        mapButton.tintColor = .darkGray
        mapButton.setTitle("", for: .normal)
        mapButton.setImage(UIImage(named: "map"), for: .normal)

        searchButton.tintColor = .darkGray
        searchButton.setTitle("", for: .normal)
        searchButton.setImage(UIImage(named: "magnifyingglass"), for: .normal)

    }
                           }

// MARK: - 알림 권한
func requestNotificationPermission(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
        if didAllow {
            // 허용했을 경우
            print("Push: 권한 허용")
        } else {
            // 거부했을 경우
            print("Push: 권한 거부")
        }
    })
}

// MARK: - Delegates

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.collectionViewheight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restrauntList.count
        }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("here!!!!")

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCollectionViewCell", for: indexPath) as? PlacesCollectionViewCell else { return UICollectionViewCell() }
            
            let storelist = self.restrauntList[indexPath.row]
        
        cell.backgroundColor = UIColor.white
        
        cell.restTitle.text = storelist.mainTitle
        cell.imageView.load(url: storelist.mainImgNormal!)
        cell.places.text = storelist.addr1

            
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

       if collectionView == self.collectionView {
            return CGSize(width: self.collectionView.bounds.width / 2 - 10, height: 210)
        }
        
        else {
            return CGSize(width: 100, height: 100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // 가게 정보 Detail View 이동
            let vc = DetailViewController()
            // 클릭한 해당 가게의 id를 넘겨주기_detailView
//            vc.restaurantId = self.storeLst[indexPath.row].id!
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    


extension MainViewController {
    func didRetrieveRestaurants(_ result: [Item]){
        self.dismissIndicator()
        self.restrauntList = result
        self.collectionView.reloadData()

    }
    
    func failedToRequest(message: String) {
        dismissIndicator()
       
    }
}

extension UIImageView {
    func load(url : String) {
        guard let url = URL(string: url) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension MainViewController : CLLocationManagerDelegate {
    
    func setupLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
//        let coor = locationManager.location?.coordinate
//        self.lat = coor!.latitude
//        self.long = coor!.longitude
    
//        print("현재 위/경도 -> \(lat),\(long)")
    }
    
    func locationManager(_ manger: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
//            self.presentAlert(title: "GPS 권한이 설정되었습니다.")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
//            self.presentAlert(title: "GPS 권한이 설정되지 않었습니다.")
            setupLocation()
        case .denied:
            print("GPS 권한 요청 거부됨")
//            self.presentAlert(title: "GPS 권한이 거부되었습니다.")
            setupLocation()
        default:
            print("GPS: Default")
        }
    }
    
    // MARK: 위치 정보
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count - 1]
        let longtitude: CLLocationDegrees = location.coordinate.longitude
        let latitude:CLLocationDegrees = location.coordinate.latitude
        
        print("지역: \(longtitude), \(latitude)")
    }
    
    
}
