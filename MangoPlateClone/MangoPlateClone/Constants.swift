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

struct Key {
  
    static let kakaoHeaders: HTTPHeaders = [
        "Authorization": "KakaoAK 75978051e0ad2b18aea7c577dabe8040"
    ]
    
    static let naverHeaders: HTTPHeaders = [
        "X-Naver-Client-Id" : "UnEPRBm5dkfZ_8EXRe8I",
        "X-Naver-Client-Secret" : "YlEqSjADOZ"
    ]
    
    
}


struct Constant {
    static let KAKAO_LOCAL_URL = "https://dapi.kakao.com/v2/local/search/keyword.json"
    static let KAKAO_GEO_URL = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json"
    static let NAVER_URL = "https://openapi.naver.com/v1/search/image"
}

