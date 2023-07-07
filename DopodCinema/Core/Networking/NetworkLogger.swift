//
//  NetworkLogger.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/06.
//

import Foundation
import Alamofire

class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.theln.NetworkingRxSwift")
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request<Value>(_ request: DataRequest, didParseReponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
