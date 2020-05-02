//
//  MediaResponseDTO.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 02/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation
struct MediaResponseDTO {
    let videos: [VideosDTO]
    let stories: [StoriesDTO]
}

extension MediaResponseDTO: Storable {
    struct VideosDTO: Storable {
        let title: String
        let thumb: String
        let date: Double
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case thumb
            case date
            case url
        }
    }
    
    struct StoriesDTO: Storable {
        let title: String
        let teaser: String
        let image: String
        let date: Double
        let author: String
    
        enum CodingKeys: String, CodingKey {
              case title
              case teaser
              case image
              case date
              case author
          }
    }
    
    enum CodingKeys: String, CodingKey {
        case videos
        case stories
    }
}

extension MediaResponseDTO {
//    func toDomain() -> MediaItems {
//        return .init(page: page,
//                     totalPages: totalPages,
//                     movies: movies.map { $0.toDomain() })
//        
//        
//    }
}
