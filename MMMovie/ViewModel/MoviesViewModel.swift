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
    
    func bindMovies(movies:[Movie], pageIndex:Int)
    func bindPageIndex(pageIndex:Int)
    func getPageIndex() ->Int
    func getCountOfPages() ->Int
}

class MoviesViewModelImp:MoviesViewModel {
    
    //MARK:- public properties
    var movies: [Movie] = []
    
    //MARK:- private properties
    var pageIndex: Int
    
    //MARK:- init
    init(movies:[Movie], pageIndex:Int) {
        self.movies = movies
        self.pageIndex = pageIndex
    }
    
    //MARK:- public methods
    func bindMovies(movies: [Movie], pageIndex:Int) {
        self.movies = movies
        self.pageIndex = pageIndex
    }
    
    func bindPageIndex(pageIndex: Int) {
        self.pageIndex = pageIndex
    }
    
    func getPageIndex() -> Int {
        return self.pageIndex
    }
    
    func getCountOfPages() -> Int {
        return self.movies.count
    }
}
