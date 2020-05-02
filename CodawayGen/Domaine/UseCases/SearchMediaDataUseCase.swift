//
//  SearchMediaDataUseCase.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 02/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation

typealias SearchMediaCompletion<T: Storable> = (Result<T, Error>) -> Void
protocol SearchMediaDataUseCaseProtocol {
    func execute<T: Storable>(cached: @escaping SearchMediaCompletion<T>,
                 completion: @escaping SearchMediaCompletion<T>)
}
class SearchMediaDataUseCase: SearchMediaDataUseCaseProtocol {
    
    private let mediaRepository: MediaRepository
    
    init(mediaRepository: MediaRepository) {
        
        self.mediaRepository = mediaRepository
    }
    
    func execute<T>(cached: @escaping SearchMediaCompletion<T>, completion: @escaping SearchMediaCompletion<T>) {
        self.mediaRepository.fetchMediaList(cached: cached, completion: completion)
    }
}
