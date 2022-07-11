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


class MapVC: UIViewController {
    
    var mapView: GMSMapView!
    var myMarker = GMSMarker()
    let locationManager = CLLocationManager()
//    private var clusterManager: GMUClusterManager!
    private var circle: GMSCircle? = nil
    
    override func loadView() {
        mapView = GMSMapView()
        view = mapView
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        // 사용할때만 위치정보를 사용한다는 팝업이 발생
        locationManager.requestWhenInUseAuthorization()
        
        // 항상 위치정보를 사용한다는 판업이 발생
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
        move(at: locationManager.location?.coordinate)
        
       
        
    }
    
   
}
 
extension MapVC {
    func move(at coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else {
            return
        }
        
        print("move = \(coordinate)")
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14.0)
        mapView.camera = camera
        
        myMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        myMarker.title = "My Position"
        myMarker.snippet = "Known"
        myMarker.map = mapView
    }
}
 
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {
            return
        }
        
        move(at: firstLocation.coordinate)
    }
}

      

