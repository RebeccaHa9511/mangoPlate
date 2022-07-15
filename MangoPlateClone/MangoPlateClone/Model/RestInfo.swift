//
//  RestInfo.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/11.
//

import Foundation
import UIKit
import CoreLocation


struct RestInfo {
    
    //추가하는 url
    var urlString: String?

    let detail: Restaurant
    
    func distance(latitude: Double, longitude: Double) -> String {
        let userLocation = CLLocation(latitude: latitude, longitude: longitude)
        let coordinate = CLLocation(latitude: Double(detail.y)!, longitude: Double(detail.x)!)
        
        
        let distanceInMeters = coordinate.distance(from: userLocation)// result is in meters
        let distanceInKiloMeters = distanceInMeters / 100

        return String(format: "%.2f", distanceInKiloMeters)
    }
}
