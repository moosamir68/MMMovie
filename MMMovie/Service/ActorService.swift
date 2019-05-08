//
//  ActorService.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

extension HttpManager {
    
    static func getPopularActor(filter:MovieSearchObject, delegate:MovieRequestDelegate){
        var queryParams:[String:PathValue] = [:]
        queryParams["api_key"] = UrlManager.apiKey
        queryParams["language"] = "en-US"
        queryParams["page"] = filter.page
        queryParams["offset"] = filter.offset
        
        let request = HttpManager.createRequest(method: .get, protocoll: .https, baseUrl: UrlManager.baseUrl, path: "person/popular", queryParams: queryParams, header: [:], contentType: .json, content: nil, token: nil, authType: nil, delegate: delegate, keyNameOfValue: "results")
        
        self.sendRequest(request: request, responseType: [Actor].self)
    }
    
    static func getActorDetail(id:Int, delegate:MovieRequestDelegate){
        var queryParams:[String:PathValue] = [:]
        queryParams["api_key"] = UrlManager.apiKey
        queryParams["language"] = "en-US"
        
        let request = HttpManager.createRequest(method: .get, protocoll: .https, baseUrl: UrlManager.baseUrl, path: "person/\(id)", queryParams: queryParams, header: [:], contentType: .json, content: nil, token: nil, authType: nil, delegate: delegate, keyNameOfValue: "results")
        
        self.sendRequest(request: request, responseType: [ActorDetail].self)
    }
}
