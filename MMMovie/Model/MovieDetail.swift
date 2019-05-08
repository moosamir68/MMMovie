//
//  MovieDetail.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    var adult:Bool? = false
    var backdropPath:String? = ""
    var belongsToCollection:Collection?
    var budget:Double? = 0
    var genres:[Genre]? = []
    var homepage:String? = ""
    var id:Int = 0
    var imdbId:String? = ""
    var originalLanguage:String? = ""
    var originalTitle:String? = ""
    var overview:String? = ""
    var popularity:Double? = 0
    var posterPath:String? = ""
    var productionCompanies:[Company]? = []
    var productionCountries:[Country]? = []
    var releaseDate:String? = ""
    var revenue:Double? = 0
    var runtime:Int? = 0
    var spokenLanguages:[Language]? = []
    var status:String? = ""
    var tagline:String? = ""
    var title:String? = ""
    var video:Bool? = false
    var voteAverage:Double? = 0
    var voteCount:Int? = 0
    
    private enum CodingKeys:String, CodingKey{
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
