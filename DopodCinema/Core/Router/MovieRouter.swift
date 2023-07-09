//
//  MovieRouter.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/06.
//

import Foundation
import Alamofire

enum MovieRouter: APIConfiguration {

    case topRate(page: Int)
    case comming(page: Int)
    case nowplaying(page: Int)
    case popular(page: Int)
    case category
    case detail(id: Int)
    case link(name: String)
    
    var hostURL: String {
        switch self {
        case .link(_):
            return Constant.Network.HOST_LINK_URL
            
        default:
            return Constant.Network.HOST_URL
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .topRate:
            return "/movie/top_rated"
            
        case .comming:
            return "/movie/upcoming"
            
        case .nowplaying:
            return "/movie/now_playing"
            
        case .popular:
            return "/movie/popular"
            
        case .category:
            return "/genre/movie/list"
            
        case .detail(let id):
            return "/movie/\(id)"
            
        case .link(_):
            return "/encrypt/movie"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .topRate(let page):
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "language": "en-US",
                "page": page
            ]
            return params
            
        case .comming(let page):
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "language": "en-US",
                "page": page
            ]
            return params
            
        case .nowplaying(let page):
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "language": "en-US",
                "page": page
            ]
            return params
            
        case .popular(let page):
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "language": "en-US",
                "page": page
            ]
            return params
            
        case .category:
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "language": "en-US"
            ]
            
            return params
            
        case .detail(_):
            let params: [String: Any] = [
                "api_key": Constant.Network.API_KEY,
                "append_to_response": "videos,credits,recommendations,reviews,images"
            ]
            return params
            
        case .link(let name):
            let params: [String: Any] = [
                "appId": Constant.Network.APP_ID,
                "name": name
            ]
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try hostURL.asURL()
        
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
