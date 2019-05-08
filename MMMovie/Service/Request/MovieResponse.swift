//
//  MovieResponse.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct MovieResponse {
    
    static func getItemFromResponse<D:Codable>(response:Data, responseType:D.Type) ->Codable?{
        guard let dataString = String(data: response, encoding: .utf8) else {
            return nil;
        }
        
        guard let jsonData = dataString.data(using: .utf8) else {
            return nil;
        }
        
        do{
            let object = try JSONDecoder().decode(responseType, from: jsonData)
            return object
        }catch{
            print("Error when decode", error)
        }
        
        return nil
    }
    
    static func getItemFromResponseFromKey<D:Codable>(response:Data, responseType:D.Type, key:String) ->Codable?{
        var json:[String:Any]?
        do{
            json = try JSONSerialization.jsonObject(with: response, options: []) as? [String:Any]
        }catch{
            return nil;
        }
        
        guard let _ = json else{
            
            return nil;
        }
        
        guard let result:[NSDictionary] = json![key] as? [NSDictionary] else{
            return nil
        }
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
            do{
                let object = try JSONDecoder().decode(responseType, from: jsonData)
                return object
                
            }catch{
                print("Error when decode", error)
                return nil
            }
        }catch{
            print("Error when serilization", error)
            return nil
        }
    }
}
