//
//  DefaultMediaRepository.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 02/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation


class DefaultMediaRepository: MediaRepository {
    
    private let dataRemoteService: DataRemoteServiceProtocol
    private let dataLocalService: DataLocalDataServiceProtocol
    init(dataRemoteService: DataRemoteServiceProtocol, dataLocalService: DataLocalDataServiceProtocol) {
        self.dataRemoteService = dataRemoteService
        self.dataLocalService = dataLocalService
    }
    
    func fetchMediaList<T>(cached: @escaping SearchMediaCompletion<T>, completion: @escaping SearchMediaCompletion<T>) {
        
        func getremoteData() {
            dataRemoteService.requestData { (result: Result<T, NetworkResponse>) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let media):
                    do {
                        try self.dataLocalService.save(items: media)
                    } catch {
                        completion(.failure(error))
                    }
                    completion(.success(media))
                }
            }
        }
        
        do {
            let medias: T = try self.dataLocalService.fetch()
            cached(.success(medias))
        } catch {
            cached(.failure(error))
        }
        getremoteData()
    }
    
}
