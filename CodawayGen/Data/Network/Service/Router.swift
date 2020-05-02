//
//  Router.swift
//  Imagination
//
//  Created by Youssef Marouane on 06/12/2019.
//  Copyright © 2019 IMG. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    mutating func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: completion)
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from router: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: router.baseUrl.appendingPathComponent(router.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = router.httpMethode.rawValue
        switch router.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestParameters(bodyParameters: let bodyParameters,
                                urlParameters: let urlParameters):
            try self.configureParameters(bodyParameters: bodyParameters,
                                         urlParameters: urlParameters,
                                         request: &request)
        case .requestParametersAndHeaders(bodyParameters: let bodyParameters,
                                          urlParameters: let urlParameters,
                                          additionsHeaders: let additionsHeaders):
            self.addAdditionsHeader(additionsHeaders: additionsHeaders, request: &request)
            try self.configureParameters(bodyParameters: bodyParameters,
                                         urlParameters: urlParameters,
                                         request: &request)
            
            
        }
        return request
    }
    
    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func addAdditionsHeader(additionsHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionsHeaders else {
            return
        }
        for (key,value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
