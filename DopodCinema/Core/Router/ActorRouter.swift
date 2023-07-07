//
//  ActorRouter.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/07.
//

import Foundation
import Alamofire

enum ActorRouter: APIConfiguration {
    
    case actor(page: Int)
    case actorDetail(id: Int)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .actor(_):
            return "/person/popular"
            
        case .actorDetail(let id):
            return "/person/\(id)"
        }
    }
    
    var parameters: Parameters  {
        switch self {
        case .actor(let page):
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "language": "en-US",
                "page": page
            ]
            return params
            
        case .actorDetail(_):
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "append_to_response": "movie_credits,Cimages,tv_credits,images,recommendations"
            ]
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constant.Network.HOST_URL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        
        let components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
        urlRequest.url = components?.url
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        
        return urlRequest
    }
}
