//
//  NetworkInterceptor.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/06.
//

import Foundation
import Alamofire
import RxSwift

class NetworkInterceptor: RequestInterceptor {
    
    let disposable = DisposeBag()
    
    let retryLimit = 5
    let retryDelay: TimeInterval = 10
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let responde = request.task?.response as? HTTPURLResponse
        
        if let status = responde?.statusCode,
           (500...509).contains(status),
           request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else {
            return completion(.doNotRetry)
        }
    }
}
