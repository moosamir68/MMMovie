//
//  Movie.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var voteAverage:Double? = 0.0
    var voteCount:Int? = 0
    var id:Int = 0
    var video:Bool? = false
    var mediaType:String? = ""
    var title:String? = ""
    var popularity:Double? = 0.0
    var posterPath:String? = ""
    var originalLanguage:String? = ""
    var originalTitle:String? = ""
    var genreIds:[Int]? = []
    private var backdropPath:String? = ""
    var adult:Bool? = false
    var overview:String? = ""
    var releaseDate:String? = ""
    
    private enum CodingKeys:String, CodingKey{
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case id = "id"
        case video = "video"
        case mediaType = "media_type"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    func getBackdropPath() ->String{
        guard let _ = self.backdropPath else {
            return ""
        }
        return self.backdropPath!
    }
}
