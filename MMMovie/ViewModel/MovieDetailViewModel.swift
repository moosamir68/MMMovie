//
//  MovieDetailViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol MovieDetailViewModel {
    var movie:Movie{get set}
    var errorDescription:String?{get set}
    
    func getMovieDetail()
    func getImagePath() ->String
}

class MovieDetailViewModelImp: MovieDetailViewModel {
    
    //MARK:- public properties
    var movie: Movie
    var errorDescription: String? = "Fetching data"
    
    //MARK:- private properties
    private weak var delegate:ViewModelDelegate? = nil
    
    //MARK:- init
    init(movie:Movie, delegate:ViewModelDelegate) {
        self.movie = movie
        self.delegate = delegate
    }
    
    //MARK:- public methods
    func getMovieDetail() {
        
    }
    
    func getImagePath() -> String {
        return UrlManager.getMovieImagePath(image: self.movie.backdropPath!)
    }
}

extension MovieDetailViewModelImp:MovieRequestDelegate{
    func sucessGetData(item: Codable, request: MovieRequest) {
        self.delegate?.sucessGetData()
    }
    
    func faildGetData(error: MovieError, request: MovieRequest) {
        self.delegate?.faildGetData()
    }
}
