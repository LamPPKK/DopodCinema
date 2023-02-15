//
//  Network.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/15.
//

import Alamofire
import CryptoSwift

enum NetworkError: Error {
    case urlError
    case requestError(errorCode: Int, message: String?)
    case networkError(error: AFError)
    case dataNull
    case parseObjectError
}

class Network {
    
    // MARK: - GET METHOD
    static func get<T: Codable>(_ urlPath: String,
                                parameters: [String: Any] = [:],
                                isEncrypte: Bool = false,
                                responseType: T.Type,
                                completionHandler: @escaping (_ response: T) -> Void,
                                errorHandler: @escaping (_ error: NetworkError) -> Void) {
        
        sendRequest(urlPath,
                    method: .get,
                    parameters: parameters,
                    isEncrypt: isEncrypte,
                    responseType: responseType,
                    completionHandler: completionHandler,
                    errorHandler: errorHandler)
    }
    
    // MARK: - SEND REQUEST
    private static func sendRequest<T: Codable>(_ urlPath: String,
                                                method: HTTPMethod,
                                                parameters: [String: Any] = [:],
                                                isEncrypt: Bool,
                                                responseType: T.Type,
                                                completionHandler: @escaping (_ response: T) -> Void,
                                                errorHandler: @escaping (_ error: NetworkError) -> Void) {
        let request = AF.request(urlPath,
                                 method: method,
                                 parameters: parameters)
        
        request
            .validate(statusCode: 200..<300)
            .responseData { response in
                if isEncrypt {
                    self.handleResponseEncrypt(response: response, completionHandler: completionHandler, errorHandler: errorHandler)
                } else {
                    self.handleResponse(response: response, completionHandler: completionHandler, errorHandler: errorHandler)
                }
            }
    }
    
    // MARK: - HANDLE RESPONSE
    private static func handleResponse<T: Codable>(response: AFDataResponse<Data>,
                                                   completionHandler: (_ response: T) -> Void,
                                                   errorHandler: (_ error: NetworkError) -> Void) {
        switch response.result {
        case .success(let data):
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(decodedData)
            } catch let err {
#if DEBUG
                print(
                    """
                    ===================== RequestError =====================
                    \(String(describing: err))
                    =====================     End      =====================
                    """
                )
#else
#endif
                errorHandler(.parseObjectError)
            }
        case .failure(let error):
            errorHandler(.networkError(error: error))
        }
    }
    
    // MARK: - HANDLE ENCRYPT
    private static func handleResponseEncrypt<T: Codable>(response: AFDataResponse<Data>,
                                                          completionHandler: (_ response: T) -> Void,
                                                          errorHandler: (_ error: NetworkError) -> Void) {
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
                completionHandler(decodedData)
            } catch let err {
#if DEBUG
                print(
                       """
                       ===================== RequestError =====================
                       \(String(describing: err))
                       =====================     End      =====================
                       """
                )
#else
#endif
                errorHandler(.parseObjectError)
            }
        case .failure(let error):
            errorHandler(.networkError(error: error))
        }
    }
}

