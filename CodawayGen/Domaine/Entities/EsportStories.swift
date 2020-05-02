//
//  EsportStories.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 01/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation
struct EsportStories {
    let title: String
    let teaser: String
    let image: String
    let date: Double
    let author: String
}

extension EsportStories: Storable {
    
    enum MovieCodingKeys: String, CodingKey {
        case title
        case teaser
        case image
        case date
        case author
    }
    
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        title = try movieContainer.decode(String.self, forKey: .title)
        teaser = try movieContainer.decode(String.self, forKey: .teaser)
        image = try movieContainer.decode(String.self, forKey: .image)
        date = try movieContainer.decode(Double.self, forKey: .date)
        author = try movieContainer.decode(String.self, forKey: .author)
    }
}
