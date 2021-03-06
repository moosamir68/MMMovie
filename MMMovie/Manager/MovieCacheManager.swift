//
//  MovieCacheManager.swift
//  MMMovie
//
//  Created by iOS Developer on 5/9/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

class MovieCacheManager {
    
    static let shared = MovieCacheManager()
    
    var movies:[Movie]
    
    private init(){
        self.movies = DataManager.shared.getFavertiesMovie()
    }
    
    //check if exist will remove or if not exist will added
    func addOrRemoveMovie(movie:Movie){
        let isExist = self.movies.contains(where: {$0.id == movie.id})
        if isExist {
            self.movies.removeAll(where: {$0.id == movie.id})
        }else{
            self.movies.append(movie)
        }
        
        DataManager.shared.saveFaveritesMovie(movies: self.movies)
    }
    
    func removeMoviefromCache(movieId:Int){
        self.movies.removeAll(where: {$0.id == movieId})
        DataManager.shared.saveFaveritesMovie(movies: self.movies)
    }
    
    //this method check for a movie is exist on cache or not exist
    func checkExistMovieOnCache(movie:Movie) ->Bool{
        let isExist = self.movies.contains(where: {$0.id == movie.id})
        return isExist
    }
    
    //get array of movie
    func getMovies() ->[Movie]{
        return self.movies
    }
}
