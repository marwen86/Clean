//
//  NetworkManger.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 30/04/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case noData
    case unableToDecode
    case error(Error)
    case failed
}

enum ResponseResult<T> {
    case success
    case failure(T)
}

enum NetworkEnvironment {
    case production
    case qa
    case staging
}

protocol DataRemoteServiceProtocol {
     func requestData<T: Storable>(completion: @escaping (Result<T,NetworkResponse>)->Void)
}

struct DataRemoteService<EndPoint: EndPointType>: DataRemoteServiceProtocol {
    let dataRouter = Router<EndPoint>()
    //static let moviePAiKey = "b5d056e7"
    let environment = NetworkEnvironment.staging
    private let endPoint: EndPoint
    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }

    func requestData<T: Storable>(completion: @escaping (Result<T,NetworkResponse>)->Void) {
        dataRouter.request(endPoint) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(T.self, from: data)
                        
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(.error(error)))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> ResponseResult<NetworkResponse> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(.authenticationError)
        case 501...599: return .failure(.badRequest)
        case 600: return .failure(.outdated)
        default: return .failure(.failed)
        }
    }
}
