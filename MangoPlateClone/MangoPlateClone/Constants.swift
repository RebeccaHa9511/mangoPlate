//
//  Constants.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/07.
//

import UIKit
import Alamofire

// 데이터 영역에 저장 (열거형, 구조체 다 가능 / 전역 변수로도 선언 가능)
// 사용하게될 API 문자열 묶음
//public enum Constant {
//    static let BASE_URL = "http://apis.data.go.kr/6260000/FoodService/getFoodKr?"
//    static let mediaParam = "resultType=json"
//}



//}
//
//
//
struct JwtToken {
    static var token: String = ""
}

struct Constant {
    static let BASE_URL = "http://apis.data.go.kr/"
    static let CLIENT_ID =  "MnzknFttYIxmhjWWi0noTUtiWL8Tuk/e2VXnm2ifGdrqNRqM2MD0EdBQFo9yj0LdxP8zeGMyvTnIT82sjTSMzw=="
    static var HEADERS: HTTPHeaders = ["x-access-token": JwtToken.token]
}

public enum MusicApi {
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music"
}


// 사용하게될 Cell 문자열 묶음
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {}
}
