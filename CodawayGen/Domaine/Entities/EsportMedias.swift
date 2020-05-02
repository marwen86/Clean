//
//  EsportApiResponse.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 01/05/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation
struct EsportMedias {
    let videos: [EsportVideos]
    let stories: [EsportStories]
}

extension EsportMedias: Storable {
    
    enum MovieCodingKeys: String, CodingKey {
        case videos
        case stories
    }
    
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        videos = try movieContainer.decode([EsportVideos].self, forKey: .videos)
        stories = try movieContainer.decode([EsportStories].self, forKey: .stories)
    }
}
