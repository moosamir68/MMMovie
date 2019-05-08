//
//  MovieList.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

extension HttpManager {
    static func getMovieDetail(id:Int, delegate:MovieRequestDelegate){
        var queryParams:[String:PathValue] = [:]
        queryParams["api_key"] = UrlManager.apiKey
        queryParams["language"] = "en-US"
        
        let request = HttpManager.createRequest(method: .get, protocoll: .https, baseUrl: UrlManager.baseUrl, path: "movie/\(id)", queryParams: queryParams, header: [:], contentType: .json, content: nil, token: nil, authType: nil, delegate: delegate, keyNameOfValue: nil)
        
        self.sendRequest(request: request, responseType: MovieDetail.self)
    }
}
