//
//  APIClient.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/06.
//

import Foundation
import Alamofire
import RxSwift
import CryptoSwift

class APIClient {
    
    static let sessionManagerAuthenticated: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        let networkLogger = NetworkLogger()
        let interceptor = NetworkInterceptor()
        return Session(configuration: configuration, interceptor: interceptor, eventMonitors: [networkLogger])
    }()
    
    static let sessionManagerWithoutAuthentication: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        let networkLogger = NetworkLogger()
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()
    
    static func authenticate<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            
            sessionManagerAuthenticated.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
                
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 200:
                        observer.onError(APIError.noDecoded)
                    case 204:
                        observer.onError(APIError.noContent)
                    case 400:
                        observer.onError(APIError.badRequest)
                    case 401:
                        observer.onError(APIError.unauthorized)
                    case 403:
                        observer.onError(APIError.forbidden)
                    case 404:
                        observer.onError(APIError.notFound)
                    case 405:
                        observer.onError(APIError.noAllowed)
                    case 409:
                        observer.onError(APIError.conflict)
                    case 500:
                        observer.onError(APIError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {}
        }
    }
    
    // MARK: - Executador de requests
    static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            
            sessionManagerWithoutAuthentication.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    print(error)
                    switch response.response?.statusCode {
                    case 200:
                        observer.onError(APIError.noDecoded)
                    case 204:
                        observer.onError(APIError.noContent)
                    case 400:
                        observer.onError(APIError.badRequest)
                    case 401:
                        observer.onError(APIError.unauthorized)
                    case 403:
                        observer.onError(APIError.forbidden)
                    case 404:
                        observer.onError(APIError.notFound)
                    case 405:
                        observer.onError(APIError.noAllowed)
                    case 409:
                        observer.onError(APIError.conflict)
                    case 500:
                        observer.onError(APIError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {}
        }
    }
    
    static func requestEncrypt<T: Codable>(_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            
            sessionManagerWithoutAuthentication.request(urlConvertible).responseData { (response: AFDataResponse<Data>) in
                switch response.result {
                case .success(let data):
                    do {
                        let aes = try AES(key: Array(Constant.Encrypt.SECRET.utf8),
                                          blockMode: CBC(iv: Array(Constant.Encrypt.IV.utf8)),
                                          padding: .pkcs5)
                        
                        let stringEncoded: String = String(data: data, encoding: .utf8) ?? String.empty
                        let dataEncoded = Data(base64Encoded: stringEncoded)
                        let decryptedData = try aes.decrypt(dataEncoded!.bytes)
                        let dataDecoded = Data(decryptedData)
                        let stringDecoded = String(data: dataDecoded, encoding: .utf8) ?? String.empty
                        
                        let decodedData = try JSONDecoder().decode(T.self, from: Data(stringDecoded.utf8))
                        
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    } catch let error {
                        print(error)
                        observer.onError(APIError.noDecoded)
                    }
                    
                case .failure(let error):
                    print(error)
                    switch response.response?.statusCode {
                    case 200:
                        observer.onError(APIError.noDecoded)
                    case 204:
                        observer.onError(APIError.noContent)
                    case 400:
                        observer.onError(APIError.badRequest)
                    case 401:
                        observer.onError(APIError.unauthorized)
                    case 403:
                        observer.onError(APIError.forbidden)
                    case 404:
                        observer.onError(APIError.notFound)
                    case 405:
                        observer.onError(APIError.noAllowed)
                    case 409:
                        observer.onError(APIError.conflict)
                    case 500:
                        observer.onError(APIError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {}
        }
    }
}
