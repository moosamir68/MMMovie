//
//  Actor.swift
//  MMMovie
//
//  Created by iOS Developer on 5/4/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct Actor: Codable {
    var popularity:Double? = 0.0
    var id:Int = 0
    var profilePath:String? = ""
    var name:String? = ""
    var movies:[Movie]? = []
    var adult:Bool? = false
    
    private enum CodingKeys:String, CodingKey{
        case popularity = "popularity"
        case id = "id"
        case profilePath = "profile_path"
        case name = "name"
        case movies = "known_for"
        case adult = "adult"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            popularity = try container.decode(Double.self, forKey: .popularity)
        }catch{
            
        }
        
        do{
            id = try container.decode(Int.self, forKey: .id)
        }catch{
            
        }
        
        do{
            profilePath = try container.decode(String.self, forKey: .profilePath)
        }catch{
            
        }
        
        do{
            name = try container.decode(String.self, forKey: .name)
        }catch{
            
        }
        
        do{
            adult = try container.decode(Bool.self, forKey: .adult)
        }catch{
            
        }
    }   
}
