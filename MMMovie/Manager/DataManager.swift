//
//  DataManager.swift
//  MMMovie
//
//  Created by iOS Developer on 5/9/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

class DataManager {
    
    private let movieKey = "CacheMovieKey"
    
    static let shared:DataManager = DataManager()
    
    private init() {
        
    }
    
    //save faverties movies on userdefault
    func saveFaveritesMovie(movies:[Movie]){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(movies), forKey:self.movieKey)
        UserDefaults.standard.synchronize()
    }
    
    //get faverties movies on userdefault
    func getFavertiesMovie() ->[Movie]{
        if let data = UserDefaults.standard.value(forKey:movieKey) as? Data {
            let movies = try? PropertyListDecoder().decode(Array<Movie>.self, from: data)
            return movies!
        }
        
        return []
    }
}
