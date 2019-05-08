//
//  Collection.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct Collection: Codable {
    var id:Int = 0
    var name:String? = ""
    var posterPath:String? = ""
    var backdropPath:String? = ""
    
    private enum CodingKeys:String, CodingKey{
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
