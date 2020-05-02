//
//  EndPointType.swift
//  Imagination
//
//  Created by Youssef Marouane on 06/12/2019.
//  Copyright © 2019 IMG. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethode: HTTPMethode { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
