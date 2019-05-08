//
//  UrlManager.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//


struct UrlManager {
    
    static var baseImageUrl = "http://image.tmdb.org/t/p/"
    static var imageProfileType = "w45"
    static var imageMovieType = "w500"
    static var imageOriginalType = "oroginal"
    
    static var baseUrl = "api.themoviedb.org/3"
    static var apiKey = "bf887a4f799f533b9e5c816ff0fd2089"
    
    static func getProfileImagePath(image:String) ->String{
        let imagePathString = "\(UrlManager.baseImageUrl)/\(UrlManager.imageProfileType)\(image)"
        return imagePathString
    }
    
    static func getMovieImagePath(image:String) ->String{
        let imagePathString = "\(UrlManager.baseImageUrl)/\(UrlManager.imageMovieType)\(image)"
        return imagePathString
    }
    
    static func getOriginalImagePath(image:String) ->String{
        let imagePathString = "\(UrlManager.baseImageUrl)/\(UrlManager.imageOriginalType)\(image)"
        return imagePathString
    }
}
