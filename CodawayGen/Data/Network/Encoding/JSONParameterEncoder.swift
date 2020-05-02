//
//  JSONParameterEncoder.swift
//  Imagination
//
//  Created by Youssef Marouane on 06/12/2019.
//  Copyright © 2019 IMG. All rights reserved.
//

import Foundation
struct JSONParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
           let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch  {
            throw NetworkError.encodingFailed
        }
        
    }
    
    
}
