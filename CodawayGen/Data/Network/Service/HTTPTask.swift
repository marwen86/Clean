//
//  File.swift
//  Imagination
//
//  Created by Youssef Marouane on 06/12/2019.
//  Copyright © 2019 IMG. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]
enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionsHeaders: HTTPHeaders?)
}
