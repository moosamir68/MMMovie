//
//  MMRequest.swift
//  DonerKabab
//
//  Created by Moosa Mir on 7/4/17.
//  Copyright © 2017 EnoOne. All rights reserved.
//

import Foundation

typealias PathValue = Any
typealias HeaderValue = Any
typealias DictionaryValue = [String:Any]

class MovieRequest{
    var id:TimeInterval
    weak var delegate:MovieRequestDelegate?
    var keyNameOfValue:String?
    
    private var method:RequestType
    private var protocoll:ProtocolType
    private var baseUrl:String
    private var path:String
    private var queryParams:[String:PathValue]
    private var contentType:RequestContentType
    private var header:[String:HeaderValue]
    private var contentParams:DictionaryValue?
    private var body:NSData?
    private var cachePolicy:NSURLRequest.CachePolicy?
    private var token:String?
    private var authType:AthurationType?
    
    //convenience init
    convenience init(method:RequestType = .get, protocoll:ProtocolType = .http, baseUrl:String = "", path:String = "", queryParams:[String:PathValue], header:[String:HeaderValue], contentType:RequestContentType, content:DictionaryValue? = nil, token:String? = nil, authType:AthurationType? = nil, delegate:MovieRequestDelegate, keyNameOfValue:String?) {
        
        //we create id for reqest and set cach poilcy with default
        let cachePolicy = NSURLRequest.CachePolicy(rawValue: 0)
        let id = Date.timeIntervalSinceReferenceDate
        
        self.init(method:method, protocoll:protocoll, baseUrl:baseUrl, path:path, queryParams:queryParams, header:header, contentType:contentType, content:content, token:token, authType:authType, cachePolicy:cachePolicy, delegate:delegate, keyNameOfValue:keyNameOfValue, id:id)

    }
    
    //init with complete variables
    private init(method:RequestType = .get, protocoll:ProtocolType = .http, baseUrl:String = "", path:String = "", queryParams:[String:PathValue], header:[String:HeaderValue], contentType:RequestContentType, content:DictionaryValue? = nil, token:String? = nil, authType:AthurationType? = nil, cachePolicy:NSURLRequest.CachePolicy?, delegate:MovieRequestDelegate, keyNameOfValue:String?, id:TimeInterval) {
        self.method = method
        self.protocoll = protocoll
        self.baseUrl = baseUrl
        self.path = path
        self.queryParams = queryParams
        self.contentType = contentType
        self.contentParams = content
        self.header = header
        self.token = token
        self.authType = authType
        self.cachePolicy = cachePolicy
        self.delegate = delegate
        self.id = id
        self.keyNameOfValue = keyNameOfValue
    }
    
    //this method send request to server
    internal func send<D:Codable>(responseType:D.Type?){
        let session = URLSession.shared
        let url = self.getUrl()
        let error = self.checkUrl(url: url)
        
        guard error == nil else{
            HttpManager.sendFaildResponseToDelegate(error: error!, request: self)
            return;
        }
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            ResponeHandler.handleResponse(data: data, response: response, error: error, responseType: responseType, request: self)
        }
        
        task.resume()
    }
    
    
    //private methods
    private func getUrl() ->URL?{
        let queryParamString = self.getQueryParamString()
        
        let urlString = "\(self.protocoll)://\(baseUrl)/\(self.path)?\(queryParamString)"
        let url = URL(string: urlString)
        
        return url
    }
    
    private func getQueryParamString() ->String{
        return MovieHttp.getQueryParamString(params: self.queryParams)
    }
    
    private func checkUrl(url:URL?) ->MovieError?{
        guard let _ = url else{
            return MovieError(message: "Request is invalid", statusCode: 400)
        }
        
        return nil
    }
}
