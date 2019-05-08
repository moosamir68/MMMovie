//
//  MoviesContainerViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol MoviesViewModel {
    var movies:[Movie]{get set}
    
    func bindMovies(movies:[Movie])
}

class MoviesViewModelImp:MoviesViewModel {
    
    //MARK:- public properties
    var movies: [Movie] = []
    
    //MARK:- init
    init(movies:[Movie]) {
        self.movies = movies
    }
    
    //MARK:- public methods
    func bindMovies(movies: [Movie]) {
        self.movies = movies
    }
}
