//
//  MovieApi.swift
//  CodawayGen
//
//  Created by Youssef Marouane on 30/04/2020.
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation
enum EuroSportApi {
    case getVideosStories
}

extension EuroSportApi: EndPointType {
    
    var environmentBaseURL : String {
       return "https://extendsclass.com"
    }
    
    var baseUrl: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
            return "/api/json-storage/bin/edccdbb"
    }
    
    var httpMethode: HTTPMethode {
        .get
    }
    
    var task: HTTPTask {
        //return .requestParameters(bodyParameters: nil, urlParameters: ["s": title, "apikey" : NetworkManger.moviePAiKey])
        return .request
        
       
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
