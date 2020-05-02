//
//  File.swift
//  Imagination
//
//  Created by Youssef Marouane on 06/12/2019.
//  Copyright © 2019 IMG. All rights reserved.
//

import Foundation
enum NetworkError: String, Error {
    case paramNil = "paramNil"
    case encodingFailed = "encodingFailed"
    case missingUrl = "missingUrl"
}
