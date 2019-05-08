//
//  ResponeHandler.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct ResponeHandler {
    static func handleResponse<D:Codable>(data:Data?, response:URLResponse?, error:Error?, responseType:D.Type?, request:MovieRequest){
        guard error == nil else{
            let movieError = MovieError(error: error!)
            HttpManager.sendFaildResponseToDelegate(error: movieError, request: request)
            return;
        }
        
        guard let _ = data else{
            let movieError = MovieError(message: "Error", statusCode: 500)
            HttpManager.sendFaildResponseToDelegate(error: movieError, request: request)
            return;
        }
        
        
        let httpResponse = response as? HTTPURLResponse
        
        guard let _ = httpResponse else{
            let movieError = MovieError(message: "Error", statusCode: 500)
            HttpManager.sendFaildResponseToDelegate(error: movieError, request: request)
            return;
        }
        
        guard httpResponse?.statusCode == 200 else{
            let movieError = MovieError(message: "Error", statusCode: (httpResponse?.statusCode)!)
            HttpManager.sendFaildResponseToDelegate(error: movieError, request: request)
            return;
        }
        
        
        guard let _ = responseType else {
            //            HttpManager.s
            return;
        }
        
        var item:Codable? = nil
        
        if(request.keyNameOfValue != nil){
            item = MovieResponse.getItemFromResponseFromKey(response: data!, responseType: responseType!, key:request.keyNameOfValue!)
        }else{
            item = MovieResponse.getItemFromResponse(response: data!, responseType: responseType!)
        }
        
        guard let _ = item else{
            let movieError = MovieError(message: "Error", statusCode: (httpResponse?.statusCode)!)
            HttpManager.sendFaildResponseToDelegate(error: movieError, request: request)
            return;
        }
        
        HttpManager.sendSucessResponseToDelegate(item: item!, request: request)
        return;
    }
}
