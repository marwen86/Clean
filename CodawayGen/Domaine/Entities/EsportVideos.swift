//
//  EsportVideos.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 01/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation
struct EsportVideos {
    let title: String
    let thumb: String
    let date: Double
    let url: String
}

extension EsportVideos: Storable {
    
    enum MovieCodingKeys: String, CodingKey {
        case title
        case thumb
        case date
        case url
    }
    
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        title = try movieContainer.decode(String.self, forKey: .title)
        thumb = try movieContainer.decode(String.self, forKey: .thumb)
        date = try movieContainer.decode(Double.self, forKey: .date)
        url = try movieContainer.decode(String.self, forKey: .url)
    }
}
