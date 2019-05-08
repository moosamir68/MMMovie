//
//  MovieHttp.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

enum RequestType:String {
    case post = "POST"
    case get = "GET"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

enum AthurationType {
    case auth1
    case auth2
}

enum ProtocolType:String{
    case http = "http"
    case https = "https"
}

enum RequestContentType:String {
    case json = "application/json"
    case text = "text/plain"
    case urlencoded = "application/x-www-form-urlencoded"
    case formData = "application/form-data"
    case xml = "application/xml"
    case html = "text/html"
}

protocol MovieRequestDelegate:class {
    func sucessGetData(item:Codable, request:MovieRequest)
    func faildGetData(error:MovieError, request:MovieRequest)
}

struct MovieHttp {
    static func getQueryParamString(params:[String:PathValue]) ->String{
        var paramsWithValueAndKey:[String] = []
        for (key, value) in params{
            paramsWithValueAndKey.append("\(key)=\(value)")
        }
        
        let query = paramsWithValueAndKey.joined(separator: "&")
        let escapedString = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let _ = escapedString else {
            return ""
        }
        
        return escapedString!
    }
}
