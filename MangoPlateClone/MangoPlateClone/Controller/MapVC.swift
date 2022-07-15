//
//  MapVC.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/05.
//

import UIKit
import GoogleMaps
import CoreLocation
import AddressBookUI
import MapKit


class MapVC: UIViewController {
//    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    var currentLocationString: String?
    var restInfos: [RestInfo] = []
    var currentLocation: (String, String)?
    
    @IBAction func mapBUtton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }

    
    var currentCoordinate: CLLocationCoordinate2D {

        if let currentLocation = currentLocation {
            return CLLocationCoordinate2D(latitude: Double(currentLocation.1) ?? 37.514322572335935, longitude: Double(currentLocation.0) ??  127.06283102249932)
        } else {
            return CLLocationCoordinate2D(latitude: 37.514322572335935, longitude: 127.06283102249932)
        }

    }
    let distanceSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)


    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationButton.titleLabel?.text = currentLocationString

        let mapCoordinates = MKCoordinateRegion(center: currentCoordinate, span: distanceSpan)
        mapView.setRegion(mapCoordinates, animated: true)
        mapView.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll

        for restInfo in restInfos {
            let name = restInfo.detail.place_name
            let subtitle = restInfo.detail.road_address_name
            let x = Double(restInfo.detail.x)
            let y = Double(restInfo.detail.y)


            let mark = Marker(title: name, subtitle: subtitle, coordinate: CLLocationCoordinate2D(latitude: y!, longitude: x!))
            mapView.addAnnotation(mark)
        }
    }
}



class Marker: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  let subtitle:String?

  init(
    title: String?,
    subtitle: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate

    super.init()
  }
//    var mapView: GMSMapView!
//    var myMarker = GMSMarker()
//    let locationManager = CLLocationManager()
////    private var clusterManager: GMUClusterManager!
//    private var circle: GMSCircle? = nil
//
//    override func loadView() {
//        mapView = GMSMapView()
//        view = mapView
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//
//        // 사용할때만 위치정보를 사용한다는 팝업이 발생
//        locationManager.requestWhenInUseAuthorization()
//
//        // 항상 위치정보를 사용한다는 판업이 발생
//        locationManager.requestAlwaysAuthorization()
//
//        locationManager.startUpdatingLocation()
//
//        move(at: locationManager.location?.coordinate)
//
//
//
//    }
//
//
//}
//
//extension MapVC {
//    func move(at coordinate: CLLocationCoordinate2D?) {
//        guard let coordinate = coordinate else {
//            return
//        }
//
//        print("move = \(coordinate)")
//
//        let latitude = coordinate.latitude
//        let longitude = coordinate.longitude
//
//        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14.0)
//        mapView.camera = camera
//
//        myMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        myMarker.title = "My Position"
//        myMarker.snippet = "Known"
//        myMarker.map = mapView
//    }
//}
//
//extension MapVC: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let firstLocation = locations.first else {
//            return
//        }
//
//        move(at: firstLocation.coordinate)
//    }
}




