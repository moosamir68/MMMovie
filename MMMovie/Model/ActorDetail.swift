//
//  ActorDetail.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct ActorDetail: Codable {
    var popularity:Double? = 0.0
    var id:Int = 0
    var profilePath:String? = ""
    var name:String? = ""
    var movies:[Movie]? = []
    var adult:Bool? = false
    var birthday:String? = ""
    var knownForDepartment:String? = ""
    var deathday:String? = ""
    var alsoKnownAs:[String]? = []
    var gender:Int? = 0
    var biography:String? = ""
    var placeOfBirth:String? = ""
    var imdbId:String? = ""
    var homepage:String? = ""
    
    private enum CodingKeys:String, CodingKey{
        case popularity
        case id
        case profilePath = "profile_path"
        case name
        case movies = "known_for"
        case adult
        case birthday
        case knownForDepartment = "known_for_department"
        case deathday
        case alsoKnownAs = "also_known_as"
        case gender
        case biography
        case placeOfBirth = "place_of_birth"
        case imdbId = "imdb_id"
        case homepage
    }
}
