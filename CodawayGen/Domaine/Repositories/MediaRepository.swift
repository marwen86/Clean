//
//  MediaRepository.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 02/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation
protocol MediaRepository {
    func fetchMediaList<T>(cached: @escaping SearchMediaCompletion<T>,
                         completion: @escaping SearchMediaCompletion<T>)
}
