//
//  FavoretiesViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/9/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

protocol FavoretiesViewModelDelegate:class {
    func sucessGetMovies()
    func faildGetMovies()
}

import Foundation

protocol FavoretiesViewModel {
    var movies:[Movie]{get set}
    var errorDecsription:String?{get set}
    
    func userChangeStatusExistMovieOnCache(movieId:Int)
}

class FavoretiesViewModelImp:FavoretiesViewModel{
    
    //MARK:- public vars
    var movies: [Movie]
    var errorDecsription: String? = "There is no item"
    
    //MARK:- private vars
    private weak var delegate:FavoretiesViewModelDelegate?
    
    init(delegate:FavoretiesViewModelDelegate) {
        self.movies = MovieCacheManager.shared.getMovies()
        self.delegate = delegate
    }
    
    func userChangeStatusExistMovieOnCache(movieId: Int) {
        self.movies = MovieCacheManager.shared.getMovies()
        self.delegate?.sucessGetMovies()
    }
}
