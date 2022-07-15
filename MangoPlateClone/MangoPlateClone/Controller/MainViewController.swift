//
//  MainViewController.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/05.
//

import UIKit
import Alamofire
import CoreLocation
import Kingfisher


class MainViewController: UIViewController{
    

    var restInfos: [RestInfo] = []
    var page = 1
    
    var locationManager = CLLocationManager()
    let kakaoLocalDataManager = KakaoLocalDataManager()
    let naverImageDataManager = NaverImageDataManager()
    var refreashControl = UIRefreshControl()
    
    //위치정보
    var currentLocationString: String = "강남구"
    var x = "127.02776284632832"
    var y = "37.498229652849226"
    
    //배너
    var isAvailable = true
    var nowPage : Int = 0
    let bannerImgLst : [String] = ["banner1", "banner2", "banner3"]
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewheight: NSLayoutConstraint!
    let layout = UICollectionViewFlowLayout()
    
    
    @IBOutlet weak var filterView: UIView!
    
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    @objc func pullToRefreash(_ sender: Any) {
        self.restInfos = []
        locationManager.requestLocation()
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            
            self.currentLocationString = locationString
            self.locationButton.titleLabel?.text = self.currentLocationString
        }
        kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: 1, delegate: self)
        self.page = 1
        self.isAvailable = true


    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationButton.titleLabel?.text = currentLocationString
    }

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        NetworkManager.shared.getData()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()

        requestNotificationPermission()
        bannerTimer()
        
        //현재 위도경도에 대한 지역명 요청
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            self.locationButton.titleLabel?.text = locationString
            print("💸💸💸💸   \(locationString)")
        }
        
        self.showIndicator()
        kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: 1, delegate: self)
        
       //배너
        self.bannerCollectionView.delegate = self
        self.bannerCollectionView.dataSource = self
        
        //네비게이션버튼
//        configureButtons()
        
        //컬렉션뷰
        self.bannerCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bannerCell")
        self.collectionView.register(UINib(nibName: "PlacesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlacesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreashControl
        refreashControl.addTarget(self, action: #selector(pullToRefreash(_:)), for: .valueChanged)
        setupCollectionView()

        
        //filter view
        filterView.addSubview(myFilterButton)
        let viewModel = MyCustomButtonViewModel(imageName: "settings", title: "필터", borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        myFilterButton.configure(with: viewModel)
        filterView.addSubview(myLocationButton)
        let viewModel1 = MyCustomButtonViewModel(imageName: "add", title: "내 주변", borderWidth: 0, borderColor: UIColor.systemOrange.cgColor)
        myLocationButton.configure(with: viewModel1)

        
    }


    // MARK: - LIFE CYCLE
//    override func viewDidLayoutSubviews() {
//        self.changeHeight()
//    }

    
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
            let width = collectionView.frame.width
            layout.itemSize = CGSize(width: width, height: width / 19 * 25)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
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
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    func bannerMove() {
       
        if self.nowPage == bannerImgLst.count-1 {
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            self.nowPage = 0
            return
        }
        self.nowPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
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

// MARK: 알림
func requestNotificationPermission(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
        if didAllow {
            
            print("Push: 권한 허용")
        } else {
            
            print("Push: 권한 거부")
        }
    })
}
// MARK: - 네트워크 성공시 실행
extension MainViewController {
    
    // 네트워크 성공시 실행
    func didRetrieveLocal(response: KakaoLocalResponse) {
        
        DispatchQueue.main.async {
           self.collectionView.refreshControl?.endRefreshing()
        }
        
        if response.meta.is_end {
            self.isAvailable = false
        } else {
            self.isAvailable = true
        }
        print("\(response.documents)")
        
        
        for (index, detail) in response.documents.enumerated() {
            //각각의 셀에 대해 이미지 요청
            naverImageDataManager.fetchImage(place_name: detail.place_name, location: currentLocationString) { urlString in
                if urlString != "요청실패" {
                    self.dismissIndicator()
                    
                    //이미지 urlString 을 받아온 경우. 이를 구조체로 묶어 뷰컨트롤러에 추가.
                    self.restInfos.append(RestInfo(urlString: urlString, detail: detail))
                    
                    //사용자 응답성 개선을 위해 main 큐에서 reload
                
                    self.collectionView.reloadData()
                
                    
                } else {
                    
                    self.dismissIndicator()
                    print("\(index)이미지 요청 실패")
                }
            }
        }
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.isAvailable = true
    }
}

 // MARK: - Delegates

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.collectionViewheight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bannerCollectionView {
            return self.bannerImgLst.count
        } else if collectionView == self.collectionView {
            return restInfos.count
        } else {
            return 4
        }
    }
    
    //KingFisher 사용해서 이미지 캐싱 및 다운로드 해보기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
            cell.bannerImgView.image = UIImage(named: self.bannerImgLst[indexPath.row])
            
            return cell
        } else if collectionView == collectionView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCollectionViewCell", for: indexPath) as! PlacesCollectionViewCell
        
        if indexPath.row < restInfos.count {
            let restInfo = restInfos[indexPath.row]
            
          
            let url = URL(string: restInfo.urlString!)
            cell.imageView.kf.setImage(with: url)
            let name = restInfo.detail.place_name
            cell.restTitle.text = name
            cell.places.text = restInfo.distance(latitude: Double(y)!, longitude: Double(x)!) + "km"
        }
        
        return cell
    }
        return UICollectionViewCell()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.bannerCollectionView {
            return CGSize(width: self.bannerCollectionView.bounds.width, height: self.bannerCollectionView.bounds.height)
        }
        
        else if collectionView == self.collectionView {
            return CGSize(width: 200, height: 210)
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

    


extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            
            self.x = String(coordinate.longitude)
            self.y = String(coordinate.latitude)
            print("위치 정보 불러오기 완료")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription + "🗺 ")
    }
}



