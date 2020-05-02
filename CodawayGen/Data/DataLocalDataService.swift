//
//  DataLocalDataService.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 01/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation

protocol DataLocalDataServiceProtocol {
    func fetch<T: Storable>() throws -> T
    func save<T: Storable>(items: T) throws
}

class DataLocalDataService: DataLocalDataServiceProtocol {
    
    func getDocumentsURL() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not retrieve documents directory")
        }
    }
    
    func fetch<T: Storable>() throws -> T {
        let className = String(describing: T.self)
        let url = getDocumentsURL().appendingPathComponent(className + ".json")
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url, options: [])
        let movies = try decoder.decode(T.self, from: data)
        return movies
        
    }
    
    func save<T: Storable>(items: T) throws {
        let className = String(describing: T.self)
        let url = getDocumentsURL().appendingPathComponent(className + ".json")
        // 2. Endcode our [Post] data to JSON Data
        let encoder = JSONEncoder()
        let data = try encoder.encode(items)
        try data.write(to: url, options: [])
    }
}
