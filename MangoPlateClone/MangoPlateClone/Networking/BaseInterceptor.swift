//
//  BaseInterceptor.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/07.
//

import Foundation
import Alamofire

class BaseInterceptor : RequestInterceptor {
    
    
    //Request 호출할때 같이 호출됨.
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("BaseInterceptor - adapt() called")
        
        //header 추가
        var request = urlRequest
        
        request.addValue("application/json; charset=UTF=8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF=8", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
    }
    
    //토큰이 없을때 처리
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("BaseInterceptor - retry() called")
        
        completion(.doNotRetry)
    }
}
